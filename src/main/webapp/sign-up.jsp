<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get Started | AceBank</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/signup.css">
</head>
<body>

<div class="signup-card">
    <button type="button" class="theme-toggle theme-toggle--corner" data-theme-toggle aria-label="Toggle theme">
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
    <header>
        <div class="logo">
            <i data-lucide="landmark"></i>
            Ace<span>Bank</span>
        </div>
        <nav>
            <a href="login.jsp" class="nav-link">Already have an account? Login</a>
        </nav>
    </header>

    <main>
        <div class="intro">
            <h2>Create Account</h2>
            <p>Join thousands of users managing money smarter.</p>
        </div>

        <form action="SignUp" method="POST" id="signup-form">
            <div class="input-row">
                <div class="form-group">
                    <input type="text" name="firstName" id="firstName" placeholder="First Name" required autocomplete="given-name" autocapitalize="words">
                    <span class="error-text" id="firstName-error">Required</span>
                </div>
                <div class="form-group">
                    <input type="text" name="lastName" id="lastName" placeholder="Last Name" required autocomplete="family-name" autocapitalize="words">
                    <span class="error-text" id="lastName-error">Required</span>
                </div>
            </div>

            <div class="form-group">
                <input type="text" name="aadharNumber" id="aadharNumber" placeholder="Aadhaar Number (12 digits)" minlength="12" maxlength="12" required inputmode="numeric" pattern="[0-9]{12}" title="Enter a 12-digit Aadhaar number" autocomplete="off">
                <span class="error-text" id="aadhar-error">Enter 12-digit Aadhaar</span>
            </div>

            <div class="form-group">
                <input type="email" name="email" id="email" placeholder="Email Address" required autocomplete="email">
                <span class="error-text" id="email-error">Enter a valid email</span>
            </div>

            <div class="form-group">
                <input type="password" name="password" id="password" placeholder="Password (Min. 10 chars)" required minlength="10" autocomplete="new-password">
                <span class="error-text" id="password-error">Minimum 10 characters</span>
            </div>

            <button type="submit" id="submit-btn">
                Create Account
                <i data-lucide="arrow-right" size="18"></i>
            </button>

            <div id="status-msg" class="status-message"></div>
        </form>
    </main>
</div>

<script src="js/theme.js"></script>
<script src="js/signup.js"></script>

</body>
</html>