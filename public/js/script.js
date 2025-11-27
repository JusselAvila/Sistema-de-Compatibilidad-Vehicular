// script.js
const marcasSelect = document.getElementById('marcas');
const modelosSelect = document.getElementById('modelos');
const versionesSelect = document.getElementById('versiones');
const productosList = document.getElementById('productos');

function setLoadingState(element, isLoading, loadingText = 'Cargando...') {
  if (isLoading) {
    element.disabled = true;
    element.innerHTML = `<option value="">${loadingText}</option>`;
  }
}

function showError(element, errorMessage) {
  element.innerHTML = `<option value="">${errorMessage}</option>`;
  element.disabled = false;
}

async function fetchMarcas() {
  try {
    setLoadingState(marcasSelect, true, 'Cargando marcas...');
    const res = await fetch('/api/marcas');
    if (!res.ok) throw new Error();
    const data = await res.json();

    marcasSelect.innerHTML = '<option value="">Seleccione una marca</option>' +
      data.map(m => `<option value="${m.MarcaVehiculoID}">${m.Nombre}</option>`).join('');
    marcasSelect.disabled = false;

    modelosSelect.innerHTML = '<option value="">Seleccione una marca primero</option>';
    modelosSelect.disabled = true;
    versionesSelect.innerHTML = '<option value="">Seleccione un modelo primero</option>';
    versionesSelect.disabled = true;
    productosList.innerHTML = '<li>Seleccione un vehículo para ver productos compatibles</li>';
  } catch (err) {
    showError(marcasSelect, 'Error al cargar marcas');
  }
}

async function fetchModelos() {
  const marcaID = marcasSelect.value;
  if (!marcaID) {
    modelosSelect.innerHTML = '<option value="">Seleccione una marca primero</option>';
    modelosSelect.disabled = true;
    return;
  }

  try {
    setLoadingState(modelosSelect, true, 'Cargando modelos...');
    const res = await fetch(`/api/modelos?marcaID=${marcaID}`);
    if (!res.ok) throw new Error();
    const data = await res.json();

    if (data.length === 0) {
      modelosSelect.innerHTML = '<option value="">No hay modelos disponibles</option>';
    } else {
      modelosSelect.innerHTML = '<option value="">Seleccione un modelo</option>' +
        data.map(m => `<option value="${m.ModeloVehiculoID}">${m.NombreModelo}</option>`).join('');
    }
    modelosSelect.disabled = false;

    versionesSelect.innerHTML = '<option value="">Seleccione un modelo primero</option>';
    versionesSelect.disabled = true;
    productosList.innerHTML = '<li>Seleccione un vehículo para ver productos compatibles</li>';
  } catch (err) {
    showError(modelosSelect, 'Error al cargar modelos');
  }
}

async function fetchVersiones() {
  const modeloID = modelosSelect.value;
  if (!modeloID) {
    versionesSelect.innerHTML = '<option value="">Seleccione un modelo primero</option>';
    versionesSelect.disabled = true;
    return;
  }

  try {
    setLoadingState(versionesSelect, true, 'Cargando versiones...');
    const res = await fetch(`/api/versiones?modeloID=${modeloID}`);
    if (!res.ok) throw new Error();
    const data = await res.json();

    if (data.length === 0) {
      versionesSelect.innerHTML = '<option value="">No hay versiones disponibles</option>';
    } else {
      versionesSelect.innerHTML = '<option value="">Seleccione una versión</option>' +
        data.map(v => `<option value="${v.VersionVehiculoID}">${v.NombreVersion} (${v.Anio})</option>`).join('');
    }
    versionesSelect.disabled = false;
    productosList.innerHTML = '<li>Seleccione una versión para ver productos</li>';
  } catch (err) {
    showError(versionesSelect, 'Error al cargar versiones');
  }
}

async function fetchProductos() {
  const versionID = versionesSelect.value;
  if (!versionID) {
    productosList.innerHTML = '<li>Seleccione una versión para ver productos</li>';
    return;
  }

  try {
    productosList.innerHTML = '<li>Cargando productos...</li>';
    const res = await fetch(`/api/productos?versionID=${versionID}`);
    if (!res.ok) throw new Error();
    const data = await res.json();

    if (data.length === 0) {
      productosList.innerHTML = '<li>No hay productos compatibles para este vehículo</li>';
      return;
    }

    productosList.innerHTML = data.map(p => `
      <li class="producto-item">
        <h3>${p.Llanta}</h3>
        <p><strong>Medida:</strong> ${p.Medida}</p>
        <p><strong>Carga:</strong> ${p.IndiceCarga} | <strong>Velocidad:</strong> ${p.IndiceVelocidad}</p>
        <p><strong>Categoría:</strong> ${p.Categoria}</p>
        <p><strong>Posición:</strong> ${p.Posicion || 'N/A'}</p>
        ${p.Observacion ? `<p><strong>Nota:</strong> ${p.Observacion}</p>` : ''}
        <button class="btn-add-cart" onclick="agregarAlCarrito(${p.LlantaID}, '${p.Llanta.replace(/'/g, "\\'")}')">Agregar al Carrito</button>
      </li>
    `).join('');
  } catch (err) {
    productosList.innerHTML = '<li>Error al cargar productos</li>';
  }
}

marcasSelect.addEventListener('change', fetchModelos);
modelosSelect.addEventListener('change', fetchVersiones);
versionesSelect.addEventListener('change', fetchProductos);

fetchMarcas();