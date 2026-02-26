package com.acebank.lite.controllers;

import com.acebank.lite.dao.BankUserDao;
import com.acebank.lite.dao.BankUserDaoImpl;
import com.acebank.lite.models.PasswordResetOtp;
import com.acebank.lite.util.MailUtil;
import com.acebank.lite.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.java.Log;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Optional;
import java.security.SecureRandom;

@Log
@WebServlet(name = "ForgotPassword", urlPatterns = "/ForgotPassword")
public class ForgotPassword extends HttpServlet {

    private static final int OTP_LENGTH = 6;
    private static final int OTP_TTL_MINUTES = 10;
    private static final int MAX_OTP_ATTEMPTS = 5;

    private final BankUserDao userDao = new BankUserDaoImpl();
    private final SecureRandom secureRandom = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clear = request.getParameter("clear");
        if ("1".equals(clear)) {
            clearResetSession(request.getSession(false));
            response.sendRedirect(request.getContextPath() + "/ForgotPassword");
            return;
        }
        request.getRequestDispatcher("/ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");
        if (action == null) action = "send";

        switch (action) {
            case "send" -> handleSendOtp(request, response);
            case "verify" -> handleVerifyOtp(request, response);
            case "reset" -> handleResetPassword(request, response);
            default -> {
                flashError(request.getSession(true), "Invalid request.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword");
            }
        }
    }

    private void handleSendOtp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);

        String email = normalizeEmail(request.getParameter("email"));
        if (email == null) {
            flashError(session, "Please enter a valid email address.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword");
            return;
        }

        // Always set session email (prevents email-enumeration via UI state).
        session.setAttribute("pwResetEmail", email);
        session.removeAttribute("pwResetVerified");

        try {
            Optional<Integer> accountNoOpt = userDao.getAccountNoByEmail(email);
            if (accountNoOpt.isPresent()) {
                int accountNo = accountNoOpt.get();
                String otp = generateOtp();
                String otpHash = PasswordUtil.hashPassword(otp);
                Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + OTP_TTL_MINUTES * 60_000L);

                userDao.upsertPasswordResetOtp(email, accountNo, otpHash, expiresAt);

                String subject = "AceBank - Password Reset OTP";
                String body = ""
                        + "You requested to reset your AceBank password.\n\n"
                        + "Your OTP is: " + otp + "\n"
                        + "It expires in " + OTP_TTL_MINUTES + " minutes.\n\n"
                        + "If you did not request this, please ignore this email.\n\n"
                        + "— AceBank Support";

                MailUtil.sendMailAsync(email, subject, body);
            }

            flashInfo(session, "If this email is registered, an OTP has been sent.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
        } catch (Exception e) {
            log.warning("Failed to send reset OTP: " + e.getMessage());
            flashError(session, "Could not send OTP right now. Please try again.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword");
        }
    }

    private void handleVerifyOtp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        String email = (String) session.getAttribute("pwResetEmail");
        String otp = normalizeOtp(request.getParameter("otp"));

        if (email == null) {
            flashError(session, "Please enter your email first.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword");
            return;
        }

        if (otp == null) {
            flashError(session, "Please enter a valid " + OTP_LENGTH + "-digit OTP.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
            return;
        }

        try {
            Optional<PasswordResetOtp> recordOpt = userDao.getPasswordResetOtp(email);
            if (recordOpt.isEmpty()) {
                flashError(session, "Invalid or expired OTP. Please request a new one.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
                return;
            }

            PasswordResetOtp record = recordOpt.get();

            if (record.used()) {
                flashError(session, "This OTP has already been used. Please request a new one.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
                return;
            }

            if (record.attempts() >= MAX_OTP_ATTEMPTS) {
                flashError(session, "Too many incorrect attempts. Please request a new OTP.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
                return;
            }

            if (record.expiresAt() == null || record.expiresAt().before(new Timestamp(System.currentTimeMillis()))) {
                flashError(session, "OTP expired. Please request a new one.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
                return;
            }

            if (PasswordUtil.checkPassword(otp, record.otpHash())) {
                session.setAttribute("pwResetVerified", true);
                flashInfo(session, "OTP verified. Please set a new password.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=reset");
            } else {
                userDao.incrementPasswordResetAttempts(email);
                flashError(session, "Incorrect OTP. Please try again.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
            }
        } catch (Exception e) {
            log.warning("OTP verify failed: " + e.getMessage());
            flashError(session, "Could not verify OTP right now. Please try again.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=otp");
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        String email = (String) session.getAttribute("pwResetEmail");
        Boolean verified = (Boolean) session.getAttribute("pwResetVerified");

        if (email == null || verified == null || !verified) {
            flashError(session, "Please verify OTP first.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword");
            return;
        }

        String newPw = request.getParameter("newPassword");
        String confirmPw = request.getParameter("confirmPassword");

        if (newPw == null || newPw.length() < 8) {
            flashError(session, "Password must be at least 8 characters.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=reset");
            return;
        }

        if (confirmPw == null || !newPw.equals(confirmPw)) {
            flashError(session, "Passwords do not match.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=reset");
            return;
        }

        try {
            Optional<PasswordResetOtp> recordOpt = userDao.getPasswordResetOtp(email);
            if (recordOpt.isEmpty()) {
                flashError(session, "Invalid reset session. Please request a new OTP.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword");
                return;
            }

            PasswordResetOtp record = recordOpt.get();
            if (record.used()) {
                flashError(session, "This OTP has already been used. Please request a new one.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword");
                return;
            }

            if (record.expiresAt() == null || record.expiresAt().before(new Timestamp(System.currentTimeMillis()))) {
                flashError(session, "OTP expired. Please request a new one.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword");
                return;
            }

            String newHash = PasswordUtil.hashPassword(newPw);
            boolean updated = userDao.setPasswordByAccountNo(record.accountNo(), newHash);
            if (updated) {
                userDao.markPasswordResetUsed(email);
                clearResetSession(session);
                response.sendRedirect(request.getContextPath() + "/login.jsp?reset=success");
            } else {
                flashError(session, "Could not reset password. Please try again.");
                response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=reset");
            }
        } catch (Exception e) {
            log.warning("Password reset failed: " + e.getMessage());
            flashError(session, "Could not reset password right now. Please try again.");
            response.sendRedirect(request.getContextPath() + "/ForgotPassword?step=reset");
        }
    }

    private String generateOtp() {
        int bound = (int) Math.pow(10, OTP_LENGTH);
        int value = secureRandom.nextInt(bound);
        return String.format("%0" + OTP_LENGTH + "d", value);
    }

    private static String normalizeEmail(String raw) {
        if (raw == null) return null;
        String email = raw.trim().toLowerCase();
        if (email.isEmpty() || !email.contains("@") || email.length() > 255) return null;
        return email;
    }

    private static String normalizeOtp(String raw) {
        if (raw == null) return null;
        String otp = raw.trim();
        if (otp.length() != OTP_LENGTH) return null;
        for (int i = 0; i < otp.length(); i++) {
            if (!Character.isDigit(otp.charAt(i))) return null;
        }
        return otp;
    }

    private static void flashInfo(HttpSession session, String msg) {
        session.setAttribute("flashInfo", msg);
        session.removeAttribute("flashError");
    }

    private static void flashError(HttpSession session, String msg) {
        session.setAttribute("flashError", msg);
        session.removeAttribute("flashInfo");
    }

    private static void clearResetSession(HttpSession session) {
        if (session == null) return;
        session.removeAttribute("pwResetEmail");
        session.removeAttribute("pwResetVerified");
        session.removeAttribute("flashInfo");
        session.removeAttribute("flashError");
    }
}

