const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

const vehiculosRoutes = require('./backend/routes/vehiculos');

app.use(express.json());

app.use('/api', vehiculosRoutes);

app.use(express.static(path.join(__dirname, 'frontend')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});


app.listen(port, () => {
    console.log(`🚀 Servidor iniciado y escuchando en http://localhost:${port}`);
    console.log("¡Recuerda iniciar tu base de datos y ejecutar los scripts SQL!");
});