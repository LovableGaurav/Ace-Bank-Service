document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('passwordForm');
    const currentPassword = document.getElementById('currentPassword');
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const errorText = document.getElementById('passwordError');
    const successText = document.getElementById('passwordSuccess');
    const strengthText = document.getElementById('passwordStrength');

    const clearStates = () => {
        errorText.classList.add('hidden');
        successText.classList.add('hidden');
        strengthText.textContent = '';
        newPassword.classList.remove('border-red-500');
        confirmPassword.classList.remove('border-red-500');
    };

    const evaluateStrength = (value) => {
        if (!value) return '';

        let score = 0;
        if (value.length >= 8) score++;
        if (/[A-Z]/.test(value)) score++;
        if (/[0-9]/.test(value)) score++;
        if (/[^A-Za-z0-9]/.test(value)) score++;

        if (score <= 1) return 'Strength: weak';
        if (score === 2) return 'Strength: fair';
        if (score === 3) return 'Strength: good';
        return 'Strength: strong';
    };

    if (newPassword && strengthText) {
        newPassword.addEventListener('input', () => {
            const strength = evaluateStrength(newPassword.value.trim());
            strengthText.textContent = strength;
        });
    }

    if (form) {
        form.addEventListener('submit', (event) => {
            clearStates();

            if (!form.checkValidity()) {
                // Let the browser show its native validation UI
                event.preventDefault();
                form.reportValidity();
                return;
            }

            if (newPassword.value !== confirmPassword.value) {
                event.preventDefault();
                errorText.textContent = 'New password and confirmation do not match.';
                errorText.classList.remove('hidden');
                newPassword.classList.add('border-red-500');
                confirmPassword.classList.add('border-red-500');
                confirmPassword.focus();
                return;
            }

            // Demo: prevent actual submit and show success message
            event.preventDefault();
            successText.classList.remove('hidden');
            currentPassword.value = '';
            newPassword.value = '';
            confirmPassword.value = '';
            strengthText.textContent = '';
        });
    }
});

