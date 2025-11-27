// public/js/login.js

const loginForm = document.getElementById('loginForm');
const submitBtn = loginForm.querySelector('button[type="submit"]');

// Sistema de notificaciones moderno
function showNotification(message, type = 'info') {
  const notification = document.createElement('div');
  notification.style.cssText = `
    position: fixed;
    top: 100px;
    right: 30px;
    background: ${type === 'error' ? 'linear-gradient(135deg, #ef4444, #dc2626)' : 
                 type === 'success' ? 'linear-gradient(135deg, #10b981, #059669)' : 
                 'linear-gradient(135deg, #6366f1, #4f46e5)'};
    color: white;
    padding: 1.25rem 1.75rem;
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.3);
    font-weight: 600;
    z-index: 10000;
    animation: slideInRight 0.4s ease;
    backdrop-filter: blur(10px);
    max-width: 350px;
    border: 1px solid rgba(255, 255, 255, 0.2);
  `;
  
  notification.textContent = message;
  document.body.appendChild(notification);
  
  setTimeout(() => {
    notification.style.animation = 'slideOutRight 0.4s ease';
    setTimeout(() => notification.remove(), 400);
  }, 4000);
}

// Agregar animaciones CSS
const style = document.createElement('style');
style.textContent = `
  @keyframes slideInRight {
    from { opacity: 0; transform: translateX(100px); }
    to { opacity: 1; transform: translateX(0); }
  }
  
  @keyframes slideOutRight {
    from { opacity: 1; transform: translateX(0); }
    to { opacity: 0; transform: translateX(100px); }
  }
  
  @keyframes spin {
    to { transform: rotate(360deg); }
  }
  
  .loading-btn {
    position: relative;
    pointer-events: none;
    opacity: 0.7;
  }
  
  .loading-btn::after {
    content: '';
    position: absolute;
    width: 20px;
    height: 20px;
    top: 50%;
    left: 50%;
    margin-left: -10px;
    margin-top: -10px;
    border: 3px solid rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    border-top-color: white;
    animation: spin 0.8s linear infinite;
  }
`;
document.head.appendChild(style);

loginForm.addEventListener('submit', async (e) => {
  e.preventDefault();

  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;

  // Validación básica
  if (!email || !password) {
    showNotification('⚠️ Por favor completa todos los campos', 'error');
    return;
  }

  // Mostrar estado de carga
  const originalText = submitBtn.textContent;
  submitBtn.classList.add('loading-btn');
  submitBtn.textContent = '';

  try {
    const res = await fetch('/api/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password })
    });

    const data = await res.json();

    if (!res.ok) {
      showNotification('❌ ' + (data.error || 'Credenciales incorrectas'), 'error');
      return;
    }

    // Login exitoso
    showNotification('✅ ¡Inicio de sesión exitoso! Redirigiendo...', 'success');
    
    // Redirigir después de 1.5 segundos
    setTimeout(() => {
      window.location.href = './index.html';
    }, 1500);
    
  } catch (err) {
    console.error('Error de conexión:', err);
    showNotification('🔌 No se pudo conectar con el servidor. Verifica tu conexión.', 'error');
  } finally {
    // Restaurar botón
    submitBtn.classList.remove('loading-btn');
    submitBtn.textContent = originalText;
  }
});