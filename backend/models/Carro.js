const mongoose = require("mongoose");

// ==========================
// Schema de los items del carrito
// ==========================
const ItemSchema = new mongoose.Schema({
    ProductoID: { type: Number, required: true },
    NombreProducto: { type: String, required: true },
    PrecioUnitarioBs: { type: Number, required: true },
    Cantidad: { type: Number, required: true },
    SubtotalBs: { type: Number, required: true }
});

// ==========================
// Schema principal del carrito
// ==========================
const CarroSchema = new mongoose.Schema({
    ClienteID: { type: Number, required: true, unique: true },
    Items: { type: [ItemSchema], default: [] },
    SubtotalTotalBs: { type: Number, default: 0 },
    FechaActualizacion: { type: Date, default: Date.now }
});

// ==========================
// Exportar modelo
// ==========================
module.exports = mongoose.model("Carrito", CarroSchema, "Carritos");
