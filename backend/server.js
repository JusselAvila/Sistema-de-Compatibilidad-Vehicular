// backend/server.js
require('dotenv').config({ path: '../.env' });

const app = require('./app.js');
const { conectarMongo, conectarSQL, sql } = require('./config/db.js');

const PORT = process.env.PORT || 3000;

// ===========================
// CONEXIONES BASE DE DATOS
// ===========================
conectarMongo(); // MongoDB

let sqlPool;
const initSQL = async () => {
  sqlPool = await conectarSQL();
  
  // ✅ Hacer disponible el pool en toda la app
  app.locals.sqlPool = sqlPool;
};
initSQL();

// ===========================
// RUTAS SQL SERVER (Personas y Empresas)
// ===========================
app.post('/api/empresa', async (req, res) => {
  const { email, password, numeroDocumento, telefono, razonSocial, nombreComercial } = req.body;
  if (!email || !password || !numeroDocumento || !razonSocial) {
    return res.status(400).json({ error: 'Faltan datos obligatorios' });
  }

  try {
    const bcrypt = require('bcrypt');
    const passwordHash = await bcrypt.hash(password, 10);

    await sqlPool.request()
      .input('Email', sql.NVarChar(100), email)
      .input('PasswordHash', sql.NVarChar(255), passwordHash)
      .input('NumeroDocumento', sql.NVarChar(20), numeroDocumento)
      .input('Telefono', sql.NVarChar(20), telefono || null)
      .input('RazonSocial', sql.NVarChar(255), razonSocial)
      .input('NombreComercial', sql.NVarChar(255), nombreComercial || null)
      .execute('SP_CrearEmpresa');

    res.status(201).json({ message: 'Empresa creada correctamente' });
  } catch (err) {
    console.error("❌ Error al crear empresa:", err.message);
    res.status(500).json({ error: 'Error al crear empresa', detalle: err.message });
  }
});

app.post('/api/personas', async (req, res) => {
  const { email, password, numeroDocumento, telefono, nombres, apellidoPaterno, apellidoMaterno, fechaNacimiento } = req.body;
  if (!email || !password || !numeroDocumento || !nombres || !apellidoPaterno) {
    return res.status(400).json({ error: 'Faltan datos obligatorios' });
  }

  try {
    const bcrypt = require('bcrypt');
    const passwordHash = await bcrypt.hash(password, 10);

    await sqlPool.request()
      .input('Email', sql.NVarChar(100), email)
      .input('PasswordHash', sql.NVarChar(255), passwordHash)
      .input('NumeroDocumento', sql.NVarChar(20), numeroDocumento)
      .input('Telefono', sql.NVarChar(20), telefono || null)
      .input('Nombres', sql.NVarChar(100), nombres)
      .input('ApellidoPaterno', sql.NVarChar(100), apellidoPaterno)
      .input('ApellidoMaterno', sql.NVarChar(100), apellidoMaterno || null)
      .input('FechaNacimiento', sql.Date, fechaNacimiento || null)
      .execute('SP_CrearPersona');

    res.status(201).json({ message: 'Persona creada correctamente' });
  } catch (err) {
    console.error('❌ Error al crear persona:', err.message);
    if (err.number === 2627) {
      res.status(409).json({ error: 'El correo ya está registrado', detalle: err.message });
    } else {
      res.status(500).json({ error: 'Error al crear la persona', detalle: err.message });
    }
  }
});

// ===========================
// INICIAR SERVIDOR
// ===========================
app.listen(PORT, () => console.log(`🚀 API corriendo en http://localhost:${PORT}`));