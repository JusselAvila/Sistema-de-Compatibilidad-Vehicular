const registroPersonaForm = document.getElementById('registroPersonaForm');

registroPersonaForm.addEventListener('submit', async (e) => {
  e.preventDefault();

  const data = {
    email: document.getElementById('email').value,
    password: document.getElementById('password').value,
    numeroDocumento: document.getElementById('numeroDocumento').value,
    telefono: document.getElementById('telefono').value,
    nombres: document.getElementById('nombres').value,
    apellidoPaterno: document.getElementById('apellidoPaterno').value,
    apellidoMaterno: document.getElementById('apellidoMaterno').value,
    fechaNacimiento: document.getElementById('fechaNacimiento').value || null
  };

  try {
    const res = await fetch('/api/personas', {
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

    alert('Persona registrada correctamente');
    registroPersonaForm.reset();
  } catch (err) {
    console.error('Error de conexión:', err);
    alert('No se pudo conectar con el servidor');
  }
});
