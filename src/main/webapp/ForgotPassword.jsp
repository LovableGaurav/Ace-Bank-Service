<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password | AceBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>

<body class="min-h-screen flex flex-col">

<header class="w-full py-6 px-8 flex justify-between items-center bg-white border-b border-slate-100">
    <div class="flex items-center space-x-2">
        <div class="w-10 h-10 bank-gradient rounded-lg flex items-center justify-center shadow-lg">
            <svg xmlns="http://www.w3.org/2000/svg" class="text-white w-6 h-6" viewBox="0 0 24 24" fill="none"
                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M3 21h18"/>
                <path d="M3 10h18"/>
                <path d="M5 6l7-3 7 3"/>
                <path d="M4 10v11"/>
                <path d="M20 10v11"/>
                <path d="M8 14v3"/>
                <path d="M12 14v3"/>
                <path d="M16 14v3"/>
            </svg>
        </div>
        <h1 class="text-2xl font-bold text-slate-800">Ace<span class="text-blue-600">Bank</span></h1>
    </div>
    <nav>
        <a href="login.jsp" class="text-sm font-semibold text-slate-600 hover:text-blue-600 transition-colors">Back to
            Login</a>
    </nav>
</header>

<main class="flex-grow flex items-center justify-center p-6 bg-slate-50 relative overflow-hidden">
    <div class="absolute top-0 right-0 -mr-24 -mt-24 w-96 h-96 bg-blue-100 rounded-full blur-3xl opacity-50"></div>
    <div class="absolute bottom-0 left-0 -ml-24 -mb-24 w-96 h-96 bg-blue-200 rounded-full blur-3xl opacity-30"></div>

    <div class="max-w-md w-full glass-card p-10 rounded-3xl shadow-2xl relative z-10 fade-in">
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold text-slate-800 mb-2">Reset Password</h2>
            <p class="text-slate-500">We’ll send an OTP to your email to reset your password.</p>
        </div>

        <c:if test="${not empty sessionScope.flashInfo}">
            <div class="mb-6 p-3 rounded-xl bg-blue-50 text-blue-700 text-sm font-medium border border-blue-100">
                    ${sessionScope.flashInfo}
            </div>
            <c:remove var="flashInfo" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.flashError}">
            <div class="mb-6 p-3 rounded-xl bg-red-50 text-red-700 text-sm font-medium border border-red-100">
                    ${sessionScope.flashError}
            </div>
            <c:remove var="flashError" scope="session"/>
        </c:if>

        <c:choose>
            <c:when test="${sessionScope.pwResetVerified == true}">
                <form action="ForgotPassword" method="POST" class="space-y-6">
                    <input type="hidden" name="action" value="reset"/>

                    <div class="space-y-2">
                        <label for="newPassword" class="text-sm font-semibold text-slate-700 block">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" required minlength="8"
                               class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                               placeholder="Minimum 8 characters">
                    </div>

                    <div class="space-y-2">
                        <label for="confirmPassword" class="text-sm font-semibold text-slate-700 block">Confirm
                            Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8"
                               class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                               placeholder="Re-enter new password">
                    </div>

                    <button type="submit"
                            class="w-full bank-gradient text-white font-bold py-3.5 rounded-xl shadow-lg shadow-blue-200 hover:shadow-xl hover:-translate-y-0.5 transition-all active:scale-95">
                        Set New Password
                    </button>
                </form>

                <div class="mt-6 text-center">
                    <a href="ForgotPassword?clear=1" class="text-xs font-semibold text-slate-500 hover:text-slate-700">
                        Start over
                    </a>
                </div>
            </c:when>

            <c:when test="${not empty sessionScope.pwResetEmail}">
                <form action="ForgotPassword" method="POST" class="space-y-6">
                    <input type="hidden" name="action" value="verify"/>

                    <div class="text-sm text-slate-600 bg-slate-50 border border-slate-200 rounded-xl p-3">
                        OTP sent to <span class="font-semibold text-slate-800">${sessionScope.pwResetEmail}</span>
                    </div>

                    <div class="space-y-2">
                        <label for="otp" class="text-sm font-semibold text-slate-700 block">Email OTP</label>
                        <input type="text" id="otp" name="otp" inputmode="numeric" autocomplete="one-time-code"
                               pattern="[0-9]{6}" maxlength="6" required
                               class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all tracking-widest text-center text-lg"
                               placeholder="••••••">
                        <p class="text-xs text-slate-500">Enter the 6-digit code (valid for 10 minutes).</p>
                    </div>

                    <button type="submit"
                            class="w-full bank-gradient text-white font-bold py-3.5 rounded-xl shadow-lg shadow-blue-200 hover:shadow-xl hover:-translate-y-0.5 transition-all active:scale-95">
                        Verify OTP
                    </button>
                </form>

                <div class="mt-6 flex items-center justify-between text-xs font-semibold">
                    <form action="ForgotPassword" method="POST">
                        <input type="hidden" name="action" value="send"/>
                        <input type="hidden" name="email" value="${sessionScope.pwResetEmail}"/>
                        <button type="submit" class="text-blue-600 hover:text-blue-700">Resend OTP</button>
                    </form>

                    <a href="ForgotPassword?clear=1" class="text-slate-500 hover:text-slate-700">Change email</a>
                </div>
            </c:when>

            <c:otherwise>
                <form action="ForgotPassword" method="POST" class="space-y-6">
                    <input type="hidden" name="action" value="send"/>

                    <div class="space-y-2">
                        <label for="email" class="text-sm font-semibold text-slate-700 block">Email Address</label>
                        <input type="email" id="email" name="email" required autocomplete="email"
                               class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                               placeholder="you@example.com">
                    </div>

                    <button type="submit"
                            class="w-full bank-gradient text-white font-bold py-3.5 rounded-xl shadow-lg shadow-blue-200 hover:shadow-xl hover:-translate-y-0.5 transition-all active:scale-95">
                        Send OTP
                    </button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<footer class="py-6 text-center text-slate-400 text-xs">
    &copy; 2024 AceBank International. All Rights Reserved. Member FDIC.
</footer>

</body>
</html>
