package com.acebank.lite.controllers;

import com.acebank.lite.util.MailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.java.Log;

import java.io.IOException;

@Log
@WebServlet(name = "LoanInquiry", urlPatterns = "/LoanInquiry")
public class LoanInquiry extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String loanType = request.getParameter("loanType");

        if (email == null || email.isBlank() || loanType == null || loanType.isBlank()) {
            log.warning("Invalid loan inquiry input.");
            response.sendRedirect("new_loan.jsp?error=invalidInput");
            return;
        }

        String interestRate;
        switch (loanType) {
            case "Home Loan":
                interestRate = "8.5%";
                break;
            case "Car Loan":
                interestRate = "10.2%";
                break;
            case "Education Loan":
                interestRate = "7.5%";
                break;
            default:
                interestRate = "N/A";
        }

        String safeName = (fullName == null || fullName.isBlank()) ? "Customer" : fullName.trim();

        String subject = "Your Requested Loan Details";
        String body = "Hello " + safeName + ", you inquired about a " + loanType +
                " at " + interestRate + " interest. Our executive will contact you shortly.";

        boolean sent = MailUtil.sendMail(email, subject, body);
        if (!sent) {
            log.severe("Failed to send loan inquiry email to " + email);
        }

        response.sendRedirect(request.getContextPath() + "/home?loanSuccess=true");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect("new_loan.jsp");
    }
}

