const Carrito = require("../models/Carro.js");

// ==========================
// Obtener carrito de un cliente
// ==========================
exports.obtenerCarrito = async (req, res) => {
    const { clienteId } = req.params;

    try {
        let carrito = await Carrito.findOne({ ClienteID: clienteId });
        if (!carrito) {
            carrito = await Carrito.create({ ClienteID: clienteId });
        }
        res.json(carrito);
    } catch (err) {
        console.error("❌ Error al obtener carrito:", err);
        res.status(500).json({ error: err.message });
    }
};

// ==========================
// Agregar producto al carrito
// ==========================
exports.agregarProducto = async (req, res) => {
    const { clienteId } = req.params;
    const { ProductoID, NombreProducto, PrecioUnitarioBs, Cantidad } = req.body;

    try {
        const carrito = await Carrito.findOne({ ClienteID: clienteId });
        if (!carrito) return res.status(404).json({ msg: "Carrito no encontrado" });

        const itemExistente = carrito.Items.find(item => item.ProductoID === ProductoID);

        if (itemExistente) {
            itemExistente.Cantidad += Cantidad;
            itemExistente.SubtotalBs += PrecioUnitarioBs * Cantidad;
        } else {
            carrito.Items.push({
                ProductoID,
                NombreProducto,
                PrecioUnitarioBs,
                Cantidad,
                SubtotalBs: PrecioUnitarioBs * Cantidad
            });
        }

        carrito.SubtotalTotalBs = carrito.Items.reduce((acc, item) => acc + item.SubtotalBs, 0);
        carrito.FechaActualizacion = new Date();

        await carrito.save();
        res.json(carrito);
    } catch (err) {
        console.error("❌ Error al agregar producto:", err);
        res.status(500).json({ error: err.message });
    }
};

// ==========================
// Eliminar producto del carrito
// ==========================
exports.eliminarProducto = async (req, res) => {
    const { clienteId, productoId } = req.params;

    try {
        const carrito = await Carrito.findOne({ ClienteID: clienteId });
        if (!carrito) return res.status(404).json({ msg: "Carrito no encontrado" });

        carrito.Items = carrito.Items.filter(item => item.ProductoID != productoId);
        carrito.SubtotalTotalBs = carrito.Items.reduce((acc, item) => acc + item.SubtotalBs, 0);
        carrito.FechaActualizacion = new Date();

        await carrito.save();
        res.json(carrito);
    } catch (err) {
        console.error("❌ Error al eliminar producto:", err);
        res.status(500).json({ error: err.message });
    }
};

// ==========================
// Vaciar carrito
// ==========================
exports.vaciarCarrito = async (req, res) => {
    const { clienteId } = req.params;

    try {
        const carrito = await Carrito.findOne({ ClienteID: clienteId });
        if (!carrito) return res.status(404).json({ msg: "Carrito no encontrado" });

        carrito.Items = [];
        carrito.SubtotalTotalBs = 0;
        carrito.FechaActualizacion = new Date();

        await carrito.save();
        res.json(carrito);
    } catch (err) {
        console.error("❌ Error al vaciar carrito:", err);
        res.status(500).json({ error: err.message });
    }
};
