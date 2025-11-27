// carrito.js
const CLIENTE_ID = 1;
const PRECIO_BASE = 450;

const btnCarrito = document.getElementById('btn-carrito');
const cartModal = document.getElementById('cart-modal');
const closeCart = document.getElementById('close-cart');
const cartItems = document.getElementById('cart-items');
const cartTotal = document.getElementById('cart-total');
const cartCount = document.getElementById('cart-count');
const btnVaciarCarrito = document.getElementById('btn-vaciar-carrito');
const btnFinalizarCompra = document.getElementById('btn-finalizar-compra');

btnCarrito.addEventListener('click', () => {
    cartModal.classList.add('active');
    cargarCarrito();
});

closeCart.addEventListener('click', () => cartModal.classList.remove('active'));

cartModal.addEventListener('click', (e) => {
    if (e.target === cartModal) cartModal.classList.remove('active');
});

async function cargarCarrito() {
    try {
        const res = await fetch(`/api/carrito/${CLIENTE_ID}`);
        if (!res.ok) throw new Error();
        const carrito = await res.json();
        renderizarCarrito(carrito);
        actualizarContador(carrito.Items.length);
    } catch (err) {
        cartItems.innerHTML = '<p class="cart-empty">Error al cargar el carrito</p>';
    }
}

function renderizarCarrito(carrito) {
    if (!carrito.Items || carrito.Items.length === 0) {
        cartItems.innerHTML = '<p class="cart-empty">El carrito está vacío</p>';
        cartTotal.textContent = 'Bs 0.00';
        return;
    }

    cartItems.innerHTML = carrito.Items.map(item => `
    <div class="cart-item">
      <div class="cart-item-info">
        <h4>${item.NombreProducto}</h4>
        <p>Bs ${item.PrecioUnitarioBs.toFixed(2)} c/u</p>
      </div>
      <div class="cart-item-quantity">
        <button onclick="cambiarCantidad(${item.ProductoID}, ${item.Cantidad}, -1)">-</button>
        <span>${item.Cantidad}</span>
        <button onclick="cambiarCantidad(${item.ProductoID}, ${item.Cantidad}, 1)">+</button>
      </div>
      <button class="btn-remove-item" onclick="eliminarProducto(${item.ProductoID})">Eliminar</button>
    </div>
  `).join('');

    cartTotal.textContent = `Bs ${carrito.SubtotalTotalBs.toFixed(2)}`;
}

function actualizarContador(cantidad) {
    cartCount.textContent = cantidad;
}

// Funciones globales para onclick
window.agregarAlCarrito = async function (productoID, nombreProducto) {
    try {
        const res = await fetch(`/api/carrito/${CLIENTE_ID}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                ProductoID: productoID,
                NombreProducto: nombreProducto,
                PrecioUnitarioBs: PRECIO_BASE,
                Cantidad: 1
            })
        });
        if (!res.ok) throw new Error();
        const carrito = await res.json();
        actualizarContador(carrito.Items.length);
        alert('Producto agregado al carrito');
    } catch (err) {
        alert('Error al agregar producto');
    }
}

window.cambiarCantidad = async function (productoID, cantidadActual, cambio) {
    if (cantidadActual + cambio < 1) {
        window.eliminarProducto(productoID);
        return;
    }

    try {
        await fetch(`/api/carrito/${CLIENTE_ID}/producto/${productoID}`, { method: 'DELETE' });
        const carrito = await (await fetch(`/api/carrito/${CLIENTE_ID}`)).json();
        const producto = carrito.Items.find(item => item.ProductoID === productoID);

        if (producto) {
            await fetch(`/api/carrito/${CLIENTE_ID}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    ProductoID: productoID,
                    NombreProducto: producto.NombreProducto,
                    PrecioUnitarioBs: producto.PrecioUnitarioBs,
                    Cantidad: cantidadActual + cambio
                })
            });
        }
        cargarCarrito();
    } catch (err) {
        console.error('Error:', err);
    }
}

window.eliminarProducto = async function (productoID) {
    try {
        await fetch(`/api/carrito/${CLIENTE_ID}/producto/${productoID}`, { method: 'DELETE' });
        cargarCarrito();
    } catch (err) {
        console.error('Error:', err);
    }
}

btnVaciarCarrito.addEventListener('click', async () => {
    if (!confirm('¿Seguro que deseas vaciar el carrito?')) return;
    try {
        await fetch(`/api/carrito/${CLIENTE_ID}`, { method: 'DELETE' });
        cargarCarrito();
    } catch (err) {
        console.error('Error:', err);
    }
});

btnFinalizarCompra.addEventListener('click', () => {
    alert('Función de compra no implementada aún');
});

cargarCarrito();
