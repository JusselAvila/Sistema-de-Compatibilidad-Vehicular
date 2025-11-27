const express = require("express");
const router = express.Router();
const carritoController = require("../controllers/CarroController.js");


// ==========================
// Rutas del carrito
// ==========================

// Obtener carrito de un cliente
router.get("/:clienteId", carritoController.obtenerCarrito);

// Agregar producto al carrito
router.post("/:clienteId", carritoController.agregarProducto);

// Eliminar un producto del carrito
router.delete("/:clienteId/producto/:productoId", carritoController.eliminarProducto);

// Vaciar todo el carrito
router.delete("/:clienteId", carritoController.vaciarCarrito);

module.exports = router;
