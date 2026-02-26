<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | AceBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/css/dashboard.css">
</head>
<body class="min-h-screen flex flex-col bg-slate-50">

<header class="w-full py-4 px-6 md:px-10 flex items-center justify-between bg-white border-b border-slate-100">
    <div class="flex items-center space-x-2">
        <div class="w-9 h-9 bank-gradient rounded-lg flex items-center justify-center shadow-lg">
            <svg xmlns="http://www.w3.org/2000/svg" class="text-white w-5 h-5" viewBox="0 0 24 24" fill="none"
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
        <span class="text-lg md:text-xl font-bold text-slate-800">Ace<span class="text-blue-600">Bank</span></span>
    </div>

    <div class="flex items-center space-x-4">
        <button class="hidden sm:inline-flex items-center text-xs font-semibold text-slate-600 hover:text-blue-600 transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-1" fill="none" viewBox="0 0 24 24"
                 stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5"/>
            </svg>
            Notifications
        </button>
        <div class="flex items-center space-x-2 rounded-full bg-slate-100 px-2 py-1">
            <div class="w-7 h-7 rounded-full bg-blue-600 text-white flex items-center justify-center text-xs font-semibold">
                <span>A</span>
            </div>
            <div class="hidden sm:flex flex-col">
                <span class="text-xs font-semibold text-slate-800">Alex Carter</span>
                <span class="text-[10px] text-slate-500">Personal Banking</span>
            </div>
        </div>
    </div>
</header>

<main class="flex-grow flex flex-col lg:flex-row overflow-hidden">
    <!-- Sidebar -->
    <aside class="dashboard-sidebar w-full lg:w-64 bg-white border-b lg:border-b-0 lg:border-r border-slate-100">
        <nav class="px-4 py-3 space-y-1 text-sm">
            <p class="px-2 pt-1 pb-2 text-[11px] font-semibold text-slate-400 uppercase tracking-[0.15em]">Overview</p>
            <a href="${ctx}/home" class="nav-item block w-full text-left">
                <span class="nav-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0h6"/>
                    </svg>
                </span>
                <span>Dashboard</span>
            </a>
            <button class="nav-item">
                <span class="nav-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M17 9V7a5 5 0 00-10 0v2M5 9h14l-1 11H6L5 9z"/>
                    </svg>
                </span>
                <span>Payments</span>
            </button>

            <p class="px-2 pt-5 pb-2 text-[11px] font-semibold text-slate-400 uppercase tracking-[0.15em]">Account</p>
            <span class="nav-item nav-item-active block">
                <span class="nav-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M5.121 17.804A13.937 13.937 0 0112 15c2.5 0 4.847.655 6.879 1.804M15 11a3 3 0 10-6 0 3 3 0 006 0z"/>
                    </svg>
                </span>
                <span>Profile &amp; Settings</span>
            </span>
            <a href="${ctx}/Logout" class="nav-item block w-full text-left">
                <span class="nav-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                    </svg>
                </span>
                <span>Log out</span>
            </a>
        </nav>
    </aside>

    <!-- Main content -->
    <section class="flex-1 overflow-y-auto px-5 py-6 md:px-10 md:py-8">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
            <div>
                <h1 class="text-2xl md:text-3xl font-semibold text-slate-900">Profile &amp; Settings</h1>
                <p class="mt-1 text-sm text-slate-500">
                    Manage your personal details, security preferences, and password.
                </p>
            </div>
            <div class="flex items-center space-x-2 text-xs text-slate-500">
                <span class="inline-flex items-center px-2.5 py-1 rounded-full bg-emerald-50 text-emerald-700 font-medium">
                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-1.5"></span>
                    Secure session
                </span>
            </div>
        </div>

        <div class="grid gap-6 lg:grid-cols-[minmax(0,2fr)_minmax(0,1.2fr)]">
            <!-- Change password card -->
            <section class="bg-white rounded-2xl shadow-sm border border-slate-100 p-6 md:p-7">
                <h2 class="text-lg font-semibold text-slate-900">Change password</h2>
                <p class="mt-1 text-sm text-slate-500">
                    For your security, choose a strong password you don't reuse on other sites.
                </p>

                <form id="passwordForm" class="mt-6 space-y-5" novalidate>
                    <div class="space-y-1.5">
                        <label for="currentPassword" class="text-sm font-medium text-slate-700">Current password</label>
                        <input
                                type="password"
                                id="currentPassword"
                                name="currentPassword"
                                required
                                autocomplete="current-password"
                                class="w-full rounded-xl border border-slate-200 bg-slate-50 px-3.5 py-2.5 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="••••••••"
                        >
                    </div>

                    <div class="space-y-1.5">
                        <label for="newPassword" class="text-sm font-medium text-slate-700">New password</label>
                        <input
                                type="password"
                                id="newPassword"
                                name="newPassword"
                                required
                                minlength="8"
                                autocomplete="new-password"
                                class="w-full rounded-xl border border-slate-200 bg-slate-50 px-3.5 py-2.5 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="At least 8 characters"
                        >
                        <p class="text-xs text-slate-400">
                            Use at least 8 characters, including a mix of letters, numbers, and symbols.
                        </p>
                    </div>

                    <div class="space-y-1.5">
                        <label for="confirmPassword" class="text-sm font-medium text-slate-700">Confirm new password</label>
                        <input
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                required
                                autocomplete="new-password"
                                class="w-full rounded-xl border border-slate-200 bg-slate-50 px-3.5 py-2.5 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="Re-enter new password"
                        >
                        <p id="passwordError" class="mt-1 text-xs text-red-600 hidden">
                            New password and confirmation do not match.
                        </p>
                        <p id="passwordStrength" class="mt-1 text-xs text-slate-500"></p>
                    </div>

                    <div class="pt-2 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                        <button
                                type="submit"
                                id="updatePasswordBtn"
                                class="inline-flex items-center justify-center rounded-xl bank-gradient text-white text-sm font-semibold px-5 py-2.5 shadow-lg shadow-blue-200 hover:shadow-xl hover:-translate-y-0.5 active:scale-95 transition-transform transition-shadow"
                        >
                            Update password
                        </button>
                        <p id="passwordSuccess" class="text-xs text-emerald-600 hidden">
                            Your password has been updated successfully (demo validation only).
                        </p>
                    </div>
                </form>
            </section>

            <!-- Security overview -->
            <aside class="space-y-4">
                <section class="bg-slate-900 rounded-2xl text-slate-50 p-5 md:p-6 relative overflow-hidden">
                    <div class="absolute inset-y-0 right-[-40%] w-2/3 opacity-20 pointer-events-none">
                        <div class="w-full h-full rounded-full bank-gradient blur-3xl"></div>
                    </div>
                    <div class="relative z-10">
                        <p class="text-[11px] font-semibold uppercase tracking-[0.18em] text-blue-200 mb-2">
                            Security center
                        </p>
                        <h2 class="text-lg font-semibold mb-1">Protecting your account</h2>
                        <p class="text-xs text-slate-200 mb-4">
                            Every login, transfer, and setting change is monitored in real time with advanced security signals.
                        </p>
                        <ul class="space-y-1.5 text-xs text-slate-200/90">
                            <li>• Device and location checks on every sign-in.</li>
                            <li>• Instant alerts for new logins and profile changes.</li>
                            <li>• Biometric support on compatible devices.</li>
                        </ul>
                    </div>
                </section>

                <section class="bg-white rounded-2xl border border-slate-100 p-5 md:p-6 text-sm space-y-3">
                    <div class="flex items-start space-x-3">
                        <div class="mt-1 w-6 h-6 rounded-full bg-amber-100 text-amber-700 flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24"
                                 stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M12 9v2m0 4h.01M5.07 19h13.86L12 5 5.07 19z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="font-medium text-slate-900 mb-0.5">Tip: Review your security settings regularly</p>
                            <p class="text-xs text-slate-500">
                                Make a habit of updating your password and reviewing recent activity at least every few months.
                            </p>
                        </div>
                    </div>
                </section>
            </aside>
        </div>
    </section>
</main>

<footer class="py-4 text-center text-slate-400 text-[11px]">
    &copy; 2024 AceBank International. All Rights Reserved. Member FDIC.
</footer>

<script src="${ctx}/js/dashboard.js"></script>
</body>
</html>
