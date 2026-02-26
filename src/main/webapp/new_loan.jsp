<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AceBank | Loan Offers</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/theme.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: var(--color-bg);
            color: var(--color-text);
        }

        .loan-page {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: var(--color-surface);
            border-bottom: 1px solid var(--color-border);
            padding: 1rem 5%;
        }

        .nav-container {
            max-width: 1120px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1.5rem;
        }

        .logo {
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: -0.03em;
        }

        .logo span {
            color: var(--color-primary);
        }

        nav ul {
            list-style: none;
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        nav a {
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--color-muted);
            transition: color var(--theme-transition);
        }

        nav a:hover {
            color: var(--color-primary);
        }

        .loan-main {
            flex: 1;
            padding: 2rem 5%;
            display: flex;
            justify-content: center;
        }

        .loan-shell {
            width: 100%;
            max-width: 1120px;
            display: grid;
            grid-template-columns: minmax(0, 3fr) minmax(0, 2fr);
            gap: 2rem;
            align-items: flex-start;
        }

        @media (max-width: 900px) {
            .loan-shell {
                grid-template-columns: minmax(0, 1fr);
            }
        }

        .loan-card,
        .loan-form-card {
            background: var(--color-surface);
            border-radius: 18px;
            border: 1px solid var(--color-border);
            box-shadow: var(--shadow-sm);
            padding: 1.75rem 1.5rem;
        }

        .loan-card-header {
            margin-bottom: 1rem;
        }

        .loan-card-eyebrow {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.15em;
            color: var(--color-muted);
            margin-bottom: 0.3rem;
        }

        .loan-card-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.35rem;
        }

        .loan-card-subtitle {
            font-size: 0.9rem;
            color: var(--color-muted);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.25rem;
            font-size: 0.9rem;
        }

        thead {
            background: var(--color-surface-2);
        }

        th, td {
            padding: 0.75rem 0.9rem;
            text-align: left;
            border-bottom: 1px solid var(--color-border);
        }

        th {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            color: var(--color-muted);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .rate-pill {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.55rem;
            border-radius: 999px;
            background: rgba(34, 197, 94, 0.08);
            color: #16a34a;
            font-size: 0.8rem;
            font-weight: 600;
        }

        body.dark-theme .rate-pill {
            background: rgba(22, 163, 74, 0.18);
            color: #bbf7d0;
        }

        .tenure-text {
            font-size: 0.9rem;
            color: var(--color-muted);
        }

        .loan-form-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .loan-form-hint {
            font-size: 0.85rem;
            color: var(--color-muted);
            margin-bottom: 1.25rem;
        }

        .field-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 0.35rem;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 0.65rem 0.75rem;
            border-radius: 10px;
            border: 1px solid var(--color-border);
            background: var(--color-surface);
            color: var(--color-text);
            font-size: 0.9rem;
            outline: none;
            transition: border-color 150ms ease, box-shadow 150ms ease, background-color 150ms ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus {
            border-color: var(--color-primary);
            box-shadow: 0 0 0 1px rgba(37, 99, 235, 0.35);
        }

        .error-text {
            margin-top: 0.2rem;
            font-size: 0.8rem;
            color: #ef4444;
        }

        .loan-submit {
            margin-top: 0.5rem;
            width: 100%;
            padding: 0.75rem;
            border-radius: 999px;
            border: none;
            background: var(--color-primary);
            color: var(--color-primary-contrast);
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            box-shadow: 0 12px 30px rgba(37, 99, 235, 0.35);
            transition: transform 140ms ease, box-shadow 140ms ease, filter 140ms ease;
        }

        .loan-submit:hover {
            filter: brightness(1.02);
            transform: translateY(-1px);
            box-shadow: 0 16px 40px rgba(37, 99, 235, 0.45);
        }

        .loan-submit:active {
            transform: translateY(0);
            box-shadow: 0 6px 18px rgba(37, 99, 235, 0.4);
        }

        footer {
            padding: 1rem 5%;
            font-size: 0.8rem;
            text-align: center;
            color: var(--color-muted);
        }
    </style>
</head>
<body>
<div class="loan-page">
    <header>
        <div class="nav-container">
            <div class="logo">
                Ace<span>Bank</span>
            </div>
            <nav>
                <ul>
                    <li>
                        <button type="button" class="theme-toggle" data-theme-toggle aria-label="Toggle theme">
                            <span class="theme-toggle__track" aria-hidden="true">
                                <span class="theme-toggle__thumb">
                                    <svg class="theme-toggle__icon theme-toggle__icon--sun" viewBox="0 0 24 24" fill="none"
                                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                         aria-hidden="true">
                                        <circle cx="12" cy="12" r="4"></circle>
                                        <path d="M12 2v2"></path><path d="M12 20v2"></path>
                                        <path d="M4.93 4.93l1.41 1.41"></path><path d="M17.66 17.66l1.41 1.41"></path>
                                        <path d="M2 12h2"></path><path d="M20 12h2"></path>
                                        <path d="M4.93 19.07l1.41-1.41"></path><path d="M17.66 6.34l1.41-1.41"></path>
                                    </svg>
                                    <svg class="theme-toggle__icon theme-toggle__icon--moon" viewBox="0 0 24 24" fill="none"
                                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                         aria-hidden="true">
                                        <path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8Z"></path>
                                    </svg>
                                </span>
                            </span>
                            <span class="sr-only">Toggle day/night mode</span>
                        </button>
                    </li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="login.jsp">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="loan-main">
        <div class="loan-shell">
            <section class="loan-card">
                <div class="loan-card-header">
                    <p class="loan-card-eyebrow">Loan Options</p>
                    <h1 class="loan-card-title">Choose the right loan for you</h1>
                    <p class="loan-card-subtitle">
                        Transparent rates and flexible tenures for your biggest goals.
                    </p>
                </div>

                <table aria-label="AceBank loan options">
                    <thead>
                    <tr>
                        <th scope="col">Loan Type</th>
                        <th scope="col">Interest Rate</th>
                        <th scope="col">Max Tenure</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Home Loan</td>
                        <td><span class="rate-pill">8.5%</span></td>
                        <td><span class="tenure-text">Up to 30 years</span></td>
                    </tr>
                    <tr>
                        <td>Car Loan</td>
                        <td><span class="rate-pill">10.2%</span></td>
                        <td><span class="tenure-text">Up to 7 years</span></td>
                    </tr>
                    <tr>
                        <td>Education Loan</td>
                        <td><span class="rate-pill">7.5%</span></td>
                        <td><span class="tenure-text">Up to 15 years</span></td>
                    </tr>
                    </tbody>
                </table>
            </section>

            <section class="loan-form-card">
                <h2 class="loan-form-title">Tell us where to send your offer</h2>
                <p class="loan-form-hint">
                    Share a few details and we’ll email you the loan information you asked for.
                </p>

                <form id="loanForm" action="LoanInquiry" method="post" novalidate>
                    <div class="field-group">
                        <label for="fullName">Name</label>
                        <input type="text" id="fullName" name="fullName" placeholder="Enter your full name"/>
                    </div>

                    <div class="field-group">
                        <label for="email">Email ID</label>
                        <input type="email" id="email" name="email" placeholder="you@example.com" required/>
                        <span id="emailError" class="error-text"></span>
                    </div>

                    <div class="field-group">
                        <label for="loanType">Loan Type</label>
                        <select id="loanType" name="loanType" required>
                            <option value="" disabled selected>Select a loan</option>
                            <option value="Home Loan">Home Loan</option>
                            <option value="Car Loan">Car Loan</option>
                            <option value="Education Loan">Education Loan</option>
                        </select>
                    </div>

                    <button type="submit" class="loan-submit">Apply Now</button>
                </form>
            </section>
        </div>
    </main>

    <footer>
        &copy; 2024 AceBank International. All Rights Reserved.
    </footer>
</div>

<script src="js/theme.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.getElementById('loanForm');
        const emailInput = document.getElementById('email');
        const emailError = document.getElementById('emailError');

        form.addEventListener('submit', function (event) {
            const value = emailInput.value.trim();
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(value)) {
                event.preventDefault();
                emailError.textContent = 'Please enter a valid Email ID.';
                emailInput.focus();
            } else {
                emailError.textContent = '';
            }
        });
    });
</script>
</body>
</html>

