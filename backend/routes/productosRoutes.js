// backend/routes/productosRoutes.js
const express = require('express');
const router = express.Router();

// Estas rutas necesitan acceso a SQL Server
let sqlPool;

// Middleware para inyectar sqlPool
router.use((req, res, next) => {
  if (!req.app.locals.sqlPool) {
    return res.status(500).json({ error: 'Conexión SQL no disponible' });
  }
  sqlPool = req.app.locals.sqlPool;
  next();
});

// ===========================
// RUTAS DE MARCAS DE VEHÍCULOS
// ===========================
router.get('/marcas', async (req, res) => {
  try {
    const result = await sqlPool.request()
      .execute('SP_ObtenerMarcas');
    res.json(result.recordset);
  } catch (err) {
    console.error('❌ Error al obtener marcas:', err);
    res.status(500).json({ error: err.message });
  }
});

// ===========================
// RUTAS DE MODELOS DE VEHÍCULOS
// ===========================
router.get('/modelos', async (req, res) => {
  const { marcaID } = req.query;
  
  if (!marcaID) {
    return res.status(400).json({ error: 'marcaID es requerido' });
  }

  try {
    const result = await sqlPool.request()
      .input('MarcaID', marcaID)
      .execute('SP_ObtenerModelosPorMarca');
    res.json(result.recordset);
  } catch (err) {
    console.error('❌ Error al obtener modelos:', err);
    res.status(500).json({ error: err.message });
  }
});

// ===========================
// RUTAS DE VERSIONES DE VEHÍCULOS
// ===========================
router.get('/versiones', async (req, res) => {
  const { modeloID } = req.query;
  
  if (!modeloID) {
    return res.status(400).json({ error: 'modeloID es requerido' });
  }

  try {
    const result = await sqlPool.request()
      .input('ModeloID', modeloID)
      .execute('SP_ObtenerVersionesPorModelo');
    res.json(result.recordset);
  } catch (err) {
    console.error('❌ Error al obtener versiones:', err);
    res.status(500).json({ error: err.message });
  }
});

// ===========================
// RUTAS DE PRODUCTOS COMPATIBLES
// ===========================
router.get('/productos', async (req, res) => {
  const { versionID } = req.query;
  
  if (!versionID) {
    return res.status(400).json({ error: 'versionID es requerido' });
  }

  try {
    const result = await sqlPool.request()
      .input('VersionID', versionID)
      .execute('SP_BuscarLlantasPorVersion');
    res.json(result.recordset);
  } catch (err) {
    console.error('❌ Error al obtener productos:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;