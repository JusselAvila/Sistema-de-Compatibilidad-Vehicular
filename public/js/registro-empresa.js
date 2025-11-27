const registroEmpresaForm = document.getElementById('registroEmpresaForm');

registroEmpresaForm.addEventListener('submit', async (e) => {
  e.preventDefault();

  const data = {
    email: document.getElementById('email').value,
    password: document.getElementById('password').value,
    numeroDocumento: document.getElementById('numeroDocumento').value,
    telefono: document.getElementById('telefono').value,
    razonSocial: document.getElementById('razonSocial').value,
    nombreComercial: document.getElementById('nombreComercial').value
  };

  try {
    const res = await fetch('/api/empresa', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });

    if (!res.ok) {
      const errorData = await res.json();
      console.error('ERROR DEL SERVIDOR:', errorData);

      // Show specific message based on error type
      if (res.status === 409) {
        alert(errorData.error + '\n\nPor favor, usa un correo electrónico diferente.');
      } else if (res.status === 400) {
        alert('Datos incompletos: ' + errorData.error);
      } else {
        alert('Error al registrar: ' + (errorData.error || 'Error desconocido'));
      }
      return;
    }

    alert('Empresa registrada correctamente');
    registroEmpresaForm.reset();
  } catch (err) {
    console.error('Error de conexión:', err);
    alert('No se pudo conectar con el servidor');
  }
});