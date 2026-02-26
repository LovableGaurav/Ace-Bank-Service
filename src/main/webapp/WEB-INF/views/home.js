document.addEventListener('DOMContentLoaded', () => {
    // 1. Animated Balance Counter
    const balanceElement = document.getElementById('balance-counter');
    if (balanceElement) {
        const targetValue = parseFloat(balanceElement.getAttribute('data-target'));
        let startValue = 0;
        const duration = 1500; // 1.5 seconds
        const startTime = performance.now();

        function updateCounter(currentTime) {
            const elapsedTime = currentTime - startTime;
            const progress = Math.min(elapsedTime / duration, 1);

            // Ease out cubic function
            const easeProgress = 1 - Math.pow(1 - progress, 3);
            const currentValue = startValue + (targetValue - startValue) * easeProgress;

            balanceElement.textContent = currentValue.toLocaleString('en-IN', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });

            if (progress < 1) {
                requestAnimationFrame(updateCounter);
            }
        }
        requestAnimationFrame(updateCounter);
    }

    // 2. Transaction List Highlighting
    const tableRows = document.querySelectorAll('#transactionTable tbody tr');
    tableRows.forEach(row => {
        row.addEventListener('mouseenter', () => {
            row.style.backgroundColor = '#f8fafd';
            row.style.transition = 'background 0.2s';
        });
        row.addEventListener('mouseleave', () => {
            row.style.backgroundColor = 'transparent';
        });
    });

    // 3. Form Validation Polish
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', (e) => {
            const submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.innerHTML = '<i class="ri-loader-4-line spin"></i> Processing...';
                submitBtn.style.opacity = '0.7';
                submitBtn.style.pointerEvents = 'none';
            }
        });
    });

    // 4. Notification Demo (Visual feedback)
    const notifyBtn = document.querySelector('.notification-btn');
    if (notifyBtn) {
        notifyBtn.addEventListener('click', () => {
            const originalIcon = notifyBtn.innerHTML;
            notifyBtn.innerHTML = '<i class="ri-check-line" style="color: #4cc9f0"></i>';
            setTimeout(() => {
                notifyBtn.innerHTML = originalIcon;
            }, 2000);
        });
    }
});

// CSS Injection for the loader icon in JS
const style = document.createElement('style');
style.textContent = `
    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
    .spin {
        display: inline-block;
        animation: spin 1s linear infinite;
    }
`;
document.head.appendChild(style);