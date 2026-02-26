document.addEventListener('DOMContentLoaded', () => {
    const featuresBtn = document.getElementById('featuresBtn');

    // Smooth scroll or alert for demo
    featuresBtn.addEventListener('click', (e) => {
        e.preventDefault();
        alert("Redirecting to Ace Bank Premium Features...");
    });

    // Simple scroll animation for the header
    window.addEventListener('scroll', () => {
        const header = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            header.style.background = "rgba(255, 255, 255, 0.9)";
            header.style.backdropFilter = "blur(10px)";
        } else {
            header.style.background = "transparent";
        }
    });
});