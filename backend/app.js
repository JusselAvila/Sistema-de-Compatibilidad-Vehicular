const express = require('express');
const cors = require('cors');
const path = require('path');

// Rutas
const carritoRoutes = require("./routes/carritoRoutes.js");
const productosRoutes = require("./routes/productosRoutes.js");

const app = express();

// ===========================
// MIDDLEWARES
// ===========================
app.use(cors());
app.use(express.json());

// ===========================
// RUTAS
// ===========================
app.use('/api/carrito', carritoRoutes);
app.use('/api', productosRoutes);

// ===========================
// ARCHIVOS ESTÁTICOS
// ===========================
app.use(express.static(path.join(__dirname, '..', 'public')));

// Ruta principal
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '..', 'index.html'));
});

module.exports = app;