// Initialize Lucide Icons (if loaded)
if (window.lucide && typeof window.lucide.createIcons === 'function') {
  window.lucide.createIcons();
}

const form = document.getElementById('signup-form');
const statusMsg = document.getElementById('status-msg');

// Mock "database" for duplicate checks (simulate API lookup)
const mockUsers = [
  { email: 'demo@acebank.com', aadharNumber: '123456789012' },
  { email: 'existing.user@example.com', aadharNumber: '999988887777' }
];

const mockCheckDuplicates = ({ email, aadharNumber }) =>
  new Promise((resolve) => {
    window.setTimeout(() => {
      const normalizedEmail = String(email || '').trim().toLowerCase();
      const normalizedAadhaar = String(aadharNumber || '').trim();

      const emailExists = mockUsers.some((u) => String(u.email).toLowerCase() === normalizedEmail);
      const aadhaarExists = mockUsers.some((u) => String(u.aadharNumber) === normalizedAadhaar);

      resolve({ emailExists, aadhaarExists });
    }, 450);
  });

const closeActiveModal = () => {
  const existing = document.getElementById('acebank-modal-backdrop');
  if (existing) existing.remove();
};

const showErrorModal = ({ title, message, duplicateFields = [] }) => {
  closeActiveModal();

  const backdrop = document.createElement('div');
  backdrop.className = 'modal-backdrop';
  backdrop.id = 'acebank-modal-backdrop';
  backdrop.setAttribute('role', 'dialog');
  backdrop.setAttribute('aria-modal', 'true');
  backdrop.setAttribute('aria-label', title || 'Error');

  const modal = document.createElement('div');
  modal.className = 'modal';

  const header = document.createElement('div');
  header.className = 'modal__header';

  const h = document.createElement('h3');
  h.className = 'modal__title';
  h.textContent = title || 'Signup error';

  const closeBtn = document.createElement('button');
  closeBtn.type = 'button';
  closeBtn.className = 'modal__close';
  closeBtn.setAttribute('aria-label', 'Close');
  closeBtn.innerHTML = '✕';

  header.appendChild(h);
  header.appendChild(closeBtn);

  const body = document.createElement('div');
  body.className = 'modal__body';

  const p = document.createElement('p');
  p.textContent = message || 'Something went wrong.';
  body.appendChild(p);

  if (duplicateFields.length > 0) {
    const label = document.createElement('p');
    label.style.marginTop = '10px';
    label.style.fontWeight = '700';
    label.style.color = 'var(--color-text)';
    label.textContent = 'Duplicate field(s) detected:';

    const ul = document.createElement('ul');
    ul.style.marginTop = '8px';
    ul.style.paddingLeft = '18px';
    ul.style.listStyle = 'disc';

    duplicateFields.forEach((f) => {
      const li = document.createElement('li');
      li.textContent = f;
      ul.appendChild(li);
    });

    body.appendChild(label);
    body.appendChild(ul);
  }

  const footer = document.createElement('div');
  footer.className = 'modal__footer';

  const okBtn = document.createElement('button');
  okBtn.type = 'button';
  okBtn.className = 'modal__btn modal__btn--primary';
  okBtn.textContent = 'OK';

  footer.appendChild(okBtn);

  modal.appendChild(header);
  modal.appendChild(body);
  modal.appendChild(footer);
  backdrop.appendChild(modal);
  document.body.appendChild(backdrop);

  const close = () => closeActiveModal();

  okBtn.addEventListener('click', close);
  closeBtn.addEventListener('click', close);
  backdrop.addEventListener('click', (e) => {
    if (e.target === backdrop) close();
  });

  const onKeyDown = (e) => {
    if (e.key === 'Escape') close();
  };
  document.addEventListener('keydown', onKeyDown, { once: true });

  okBtn.focus();
};

const validators = {
  firstName: (val) => val.trim().length > 0,
  lastName: (val) => val.trim().length > 0,
  aadharNumber: (val) => /^\d{12}$/.test(val),
  email: (val) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val),
  password: (val) => val.length >= 10
};

const errorIds = {
  firstName: 'firstName-error',
  lastName: 'lastName-error',
  aadharNumber: 'aadhar-error',
  email: 'email-error',
  password: 'password-error'
};

const validateField = (field) => {
  const input = document.getElementById(field);
  if (!input) return false;

  if (field === 'aadharNumber') {
    const digitsOnly = input.value.replace(/\D/g, '').slice(0, 12);
    if (input.value !== digitsOnly) input.value = digitsOnly;
  }

  const isValid = validators[field](input.value);
  const errorSpan = document.getElementById(errorIds[field]);

  if (!isValid) {
    input.classList.add('error');
    errorSpan.classList.add('visible');
    return false;
  }

  input.classList.remove('error');
  errorSpan.classList.remove('visible');
  return true;
};

// Real-time validation on input
Object.keys(validators).forEach((field) => {
  const el = document.getElementById(field);
  if (!el) return;
  el.addEventListener('input', () => validateField(field));
});

form?.addEventListener('submit', (e) => {
  // We'll optionally proceed with a programmatic submit after async checks.
  let isFormValid = true;
  Object.keys(validators).forEach((field) => {
    if (!validateField(field)) isFormValid = false;
  });

  if (!isFormValid) {
    e.preventDefault();
    if (statusMsg) {
      statusMsg.style.display = 'block';
      statusMsg.style.backgroundColor = '#fee2e2';
      statusMsg.style.color = '#991b1b';
      statusMsg.innerText = 'Please fix the errors above.';
    }
    return;
  }

  e.preventDefault();

  const btn = document.getElementById('submit-btn');
  const originalBtnHtml = btn?.innerHTML;
  if (btn) {
    btn.disabled = true;
    btn.textContent = 'Checking details...';
  }

  if (statusMsg) statusMsg.style.display = 'none';

  const email = document.getElementById('email')?.value || '';
  const aadharNumber = document.getElementById('aadharNumber')?.value || '';

  mockCheckDuplicates({ email, aadharNumber })
    .then(({ emailExists, aadhaarExists }) => {
      const dupFields = [];
      if (emailExists) dupFields.push('Email');
      if (aadhaarExists) dupFields.push('Aadhaar Card Number');

      // Show field-level errors too (keeps it obvious even after closing modal)
      if (emailExists) {
        const input = document.getElementById('email');
        const err = document.getElementById(errorIds.email);
        if (input) input.classList.add('error');
        if (err) {
          err.textContent = 'Email already exists';
          err.classList.add('visible');
        }
      }

      if (aadhaarExists) {
        const input = document.getElementById('aadharNumber');
        const err = document.getElementById(errorIds.aadharNumber);
        if (input) input.classList.add('error');
        if (err) {
          err.textContent = 'Aadhaar already exists';
          err.classList.add('visible');
        }
      }

      if (dupFields.length > 0) {
        showErrorModal({
          title: 'Duplicate account details',
          message: 'An account already exists with the information you entered. Please use different details or login.',
          duplicateFields: dupFields
        });

        if (btn) {
          btn.disabled = false;
          if (typeof originalBtnHtml === 'string') btn.innerHTML = originalBtnHtml;
        }
        return;
      }

      // No duplicates: proceed to the SignUp servlet
      if (btn) {
        btn.disabled = true;
        btn.textContent = 'Creating account...';
      }
      form?.submit();
    })
    .catch(() => {
      showErrorModal({
        title: 'Unable to sign up',
        message: 'We could not verify your details right now. Please try again in a moment.'
      });

      if (btn) {
        btn.disabled = false;
        if (typeof originalBtnHtml === 'string') btn.innerHTML = originalBtnHtml;
      }
    });
});
