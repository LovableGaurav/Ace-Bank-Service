<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ace Bank | Secure Digital Banking</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<div class="wrapper">
    <header class="navbar">
        <div class="logo">
            <h1>Ace<span>Bank</span></h1>
        </div>

        <nav>
            <ul class="nav-links">
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
                <li><a href="login.jsp" class="login-link">Login</a></li>
                <li><a href="sign-up.jsp" class="btn-primary">Sign Up</a></li>
            </ul>
        </nav>
    </header>

    <main class="hero-container">
        <section class="hero-content">
            <span class="badge">Trusted by 2M+ Users</span>
            <h1 class="main-title">Banking Made <span class="highlight">Easy</span></h1>
            <p class="description">
                Join over 40,000 people who open an Ace Bank account every week.
                Manage, spend, and save your money with ease.
            </p>

            <div class="cta-group">
                <a href="sign-up.jsp" class="btn-primary lg">Open Account</a>
                <a href="#" class="btn-secondary lg" id="featuresBtn">View Features</a>
            </div>
        </section>

        <figure class="hero-image">
            <img src="assets/images/bank_hero.svg" alt="Ace Bank Illustration" onerror="this.src='https://illustrations.popsy.co/amber/banking.svg'">
        </figure>
    </main>
</div>

<script src="js/theme.js"></script>
<script src="js/index.js"></script>
</body>
</html>