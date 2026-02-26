<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Cookie logic for "Remember Me"
    String savedAccount = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("rememberedAccount".equals(c.getName())) {
                savedAccount = c.getValue();
                pageContext.setAttribute("savedAccount", savedAccount);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | AceBank</title>
    <!-- Tailwind via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Link to your external CSS -->
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="min-h-screen flex flex-col">

<!-- Navigation Header -->
<header class="w-full py-6 px-8 flex justify-between items-center bg-white border-b border-slate-100">
    <div class="flex items-center space-x-2">
        <div class="w-10 h-10 bank-gradient rounded-lg flex items-center justify-center shadow-lg">
            <svg xmlns="http://www.w3.org/2000/svg" class="text-white w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21h18"/><path d="M3 10h18"/><path d="M5 6l7-3 7 3"/><path d="M4 10v11"/><path d="M20 10v11"/><path d="M8 14v3"/><path d="M12 14v3"/><path d="M16 14v3"/></svg>
        </div>
        <h1 class="text-2xl font-bold text-slate-800">Ace<span class="text-blue-600">Bank</span></h1>
    </div>
    <nav>
        <ul class="flex space-x-8 text-sm font-medium text-slate-600">
            <li><a href="index.jsp" class="hover:text-blue-600 transition-colors">Home</a></li>
            <li>
                <button type="button" class="theme-toggle" data-theme-toggle aria-label="Toggle theme">
                    <span class="theme-toggle__track" aria-hidden="true">
                        <span class="theme-toggle__thumb">
                            <svg class="theme-toggle__icon theme-toggle__icon--sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="12" cy="12" r="4"></circle>
                                <path d="M12 2v2"></path><path d="M12 20v2"></path><path d="M4.93 4.93l1.41 1.41"></path><path d="M17.66 17.66l1.41 1.41"></path><path d="M2 12h2"></path><path d="M20 12h2"></path><path d="M4.93 19.07l1.41-1.41"></path><path d="M17.66 6.34l1.41-1.41"></path>
                            </svg>
                            <svg class="theme-toggle__icon theme-toggle__icon--moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8Z"></path>
                            </svg>
                        </span>
                    </span>
                    <span class="sr-only">Toggle day/night mode</span>
                </button>
            </li>
            <li><a href="sign-up.jsp" class="px-4 py-2 rounded-full border border-blue-600 text-blue-600 hover:bg-blue-50 transition-all">Join Now</a></li>
        </ul>
    </nav>
</header>

<main class="login-main flex-grow bg-slate-50 relative overflow-hidden">
    <div class="absolute top-0 right-0 -mr-24 -mt-24 w-96 h-96 bg-blue-100 rounded-full blur-3xl opacity-50"></div>
    <div class="absolute bottom-0 left-0 -ml-24 -mb-24 w-96 h-96 bg-blue-200 rounded-full blur-3xl opacity-30"></div>

    <div class="login-layout relative z-10">
        <!-- Left: Login form -->
        <section class="login-left">
            <div class="max-w-md w-full glass-card p-8 md:p-10 rounded-3xl shadow-2xl fade-in">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-bold text-slate-800 mb-2">Welcome Back</h2>
                    <p class="text-slate-500">Securely login to your AceBank account</p>
                </div>

                <c:if test="${param.reset == 'success'}">
                    <div class="mb-6 p-3 rounded-xl bg-green-50 text-green-700 text-sm font-medium border border-green-100">
                        Password reset successful. Please login with your new password.
                    </div>
                </c:if>

                <form action="Login" method="POST" id="loginForm" class="space-y-6">
                    <!-- Account Number -->
                    <div class="space-y-2">
                        <label for="accNo" class="text-sm font-semibold text-slate-700 block">Account Number</label>
                        <div class="relative">
                                <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
                                </span>
                            <input type="text" id="accNo" name="accountNumber"
                                   value="${savedAccount}" required
                                   class="w-full pl-12 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all placeholder:text-slate-400"
                                   placeholder="Enter Account Number">
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="space-y-2">
                        <div class="flex justify-between items-center">
                            <label for="pass" class="text-sm font-semibold text-slate-700">Password</label>
                            <a href="ForgotPassword" class="text-xs font-semibold text-blue-600 hover:text-blue-700">Forgot Password?</a>
                        </div>
                        <div class="relative">
                                <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                                </span>
                            <input type="password" id="pass" name="password" required
                                   class="w-full pl-12 pr-12 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all placeholder:text-slate-400"
                                   placeholder="••••••••">
                            <button type="button" id="togglePassBtn" class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600">
                                <svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                            </button>
                        </div>
                    </div>

                    <!-- Remember Me -->
                    <div class="flex items-center">
                        <input type="checkbox" id="remember" name="rememberMe"
                        ${not empty savedAccount ? 'checked' : ''}
                               class="w-4 h-4 text-blue-600 bg-slate-100 border-slate-300 rounded focus:ring-blue-500 cursor-pointer">
                        <label for="remember" class="ml-2 text-sm text-slate-600 cursor-pointer select-none">Remember Me</label>
                    </div>

                    <button type="submit" id="submitBtn"
                            class="w-full bank-gradient text-white font-bold py-3.5 rounded-xl shadow-lg shadow-blue-200 hover:shadow-xl hover:-translate-y-0.5 transition-all active:scale-95 flex items-center justify-center">
                        <span>Login to Account</span>
                        <svg id="loadingSpinner" class="hidden animate-spin ml-2 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                    </button>
                </form>

                <div class="mt-10 pt-6 border-t border-slate-100 text-center">
                    <p class="text-slate-600 text-sm">
                        New to Ace Bank? <a href="sign-up.jsp" class="text-blue-600 font-bold hover:underline">Create an account</a>
                    </p>
                </div>

                <!-- Loan Promotion Card -->
                <div class="mt-8">
                    <section class="loan-promo-card">
                        <p class="loan-promo-label">Special Offer</p>
                        <h3 class="loan-promo-title">Need a Loan?</h3>
                        <p class="loan-promo-text">
                            Check our low interest rates for Home, Car, and Education loans.
                        </p>
                        <a href="new_loan.jsp" class="loan-promo-button">
                            Learn More
                        </a>
                    </section>
                </div>
            </div>
        </section>

        <!-- Right: Decorative / informational long section -->
        <section class="login-right">
            <div class="login-right-inner max-w-xl mx-auto">
                <p class="text-xs font-semibold tracking-[0.2em] uppercase text-blue-100 mb-3">Secure Digital Banking</p>
                <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">Banking, reimagined for your everyday life.</h2>
                <p class="text-blue-50/90 text-sm md:text-base max-w-lg">
                    Manage payments, track spending, and grow your savings with real-time insights and enterprise‑grade security.
                </p>

                <div class="mt-8 space-y-6">
                    <div class="flex items-start space-x-4 feature-row">
                        <div class="flex-shrink-0 w-10 h-10 rounded-2xl bg-white/10 flex items-center justify-center text-blue-100">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" /></svg>
                        </div>
                        <div>
                            <h3 class="text-sm font-semibold text-white mb-1">Instant transfers</h3>
                            <p class="text-xs md:text-sm text-blue-100/80">Move money between your accounts and to other banks in seconds, 24/7.</p>
                        </div>
                    </div>

                    <div class="flex items-start space-x-4 feature-row">
                        <div class="flex-shrink-0 w-10 h-10 rounded-2xl bg-white/10 flex items-center justify-center text-blue-100">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.105.895-2 2-2h4V5a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2h6" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 21h6m-3-3v6" /></svg>
                        </div>
                        <div>
                            <h3 class="text-sm font-semibold text-white mb-1">Smart insights</h3>
                            <p class="text-xs md:text-sm text-blue-100/80">Get categorized spending, trends, and alerts that help you stay on track.</p>
                        </div>
                    </div>

                    <div class="flex items-start space-x-4 feature-row">
                        <div class="flex-shrink-0 w-10 h-10 rounded-2xl bg-white/10 flex items-center justify-center text-blue-100">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c1.657 0 3-1.343 3-3S13.657 5 12 5 9 6.343 9 8s1.343 3 3 3z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21v-2a4 4 0 00-4-4H9a4 4 0 00-4 4v2" /></svg>
                        </div>
                        <div>
                            <h3 class="text-sm font-semibold text-white mb-1">Human support</h3>
                            <p class="text-xs md:text-sm text-blue-100/80">Talk to AceBank specialists whenever you need a real person, not a bot.</p>
                        </div>
                    </div>
                </div>

                <div class="mt-10 grid grid-cols-1 sm:grid-cols-3 gap-4 stats-grid">
                    <div class="rounded-2xl bg-white/5 border border-white/10 p-4">
                        <p class="text-xs text-blue-100/70">Customer satisfaction</p>
                        <p class="mt-1 text-2xl font-bold text-white">4.9<span class="text-sm align-top">/5</span></p>
                    </div>
                    <div class="rounded-2xl bg-white/5 border border-white/10 p-4">
                        <p class="text-xs text-blue-100/70">Active customers</p>
                        <p class="mt-1 text-2xl font-bold text-white">250K+</p>
                    </div>
                    <div class="rounded-2xl bg-white/5 border border-white/10 p-4">
                        <p class="text-xs text-blue-100/70">Fraud prevented</p>
                        <p class="mt-1 text-2xl font-bold text-white">$18M</p>
                    </div>
                </div>

                <div class="mt-10 space-y-4 long-list">
                    <h3 class="text-sm font-semibold tracking-wide text-blue-100/90 uppercase">Designed for how you bank</h3>
                    <ul class="space-y-3 text-xs md:text-sm text-blue-100/85">
                        <li>• Real-time push notifications for every transaction, large or small.</li>
                        <li>• Integrated bill pay that keeps track of due dates and subscriptions.</li>
                        <li>• Virtual cards for safer shopping on your favorite sites and apps.</li>
                        <li>• Shared accounts that make it simple to manage money together.</li>
                        <li>• Built-in savings spaces with customizable goals and progress tracking.</li>
                        <li>• Advanced biometric security and device fingerprinting on every login.</li>
                        <li>• Travel‑ready features like instant card freeze and location controls.</li>
                        <li>• Exportable statements for tax prep and personal finance tools.</li>
                        <li>• Access from any device with a layout that adapts to your screen.</li>
                        <li>• Dedicated support when you need help with big financial moments.</li>
                    </ul>
                </div>
            </div>
        </section>
    </div>
</main>

<footer class="py-6 text-center text-slate-400 text-xs">
    &copy; 2024 AceBank International. All Rights Reserved. Member FDIC.
</footer>

<!-- Link to your external JS -->
<script src="js/theme.js"></script>
<script src="js/login.js"></script>
</body>
</html>