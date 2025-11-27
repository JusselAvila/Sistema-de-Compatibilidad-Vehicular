USE [Avila's Tyre Company];
GO

-- =============================================
-- INSERTS PARA VEHÍCULOS (Marcas, Modelos, Versiones)
-- =============================================

-- 1. Marcas de Vehículos
INSERT INTO Vehiculo_Marcas (Nombre) VALUES 
('Toyota'),
('Nissan'),
('Chevrolet'),
('Ford'),
('Hyundai'),
('Kia'),
('Mazda'),
('Honda'),
('Suzuki');
GO

-- 2. Modelos de Vehículos
INSERT INTO Vehiculo_Modelos (MarcaVehiculoID, NombreModelo) VALUES
(1, 'Corolla'),
(1, 'Hilux'),
(1, 'RAV4'),
(1, 'Camry'),
(2, 'Sentra'),
(2, 'Frontier'),
(2, 'X-Trail'),
(3, 'Cruze'),
(3, 'Silverado'),
(3, 'Tracker'),
(3, 'Blazer'),
(4, 'Ranger'),
(4, 'F-150'),
(4, 'Escape'),
(5, 'Accent'),
(5, 'Tucson'),
(5, 'Santa Fe'),
(6, 'Rio'),
(6, 'Sportage'),
(6, 'Sorento'),
(7, 'Mazda3'),
(7, 'CX-5'),
(7, 'CX-9'),
(8, 'Civic'),
(8, 'CR-V'),
(8, 'Accord'),
(9, 'Swift'),
(9, 'Vitara'),
(9, 'Jimny');
GO

DECLARE @ModeloID INT = 1;
WHILE @ModeloID <= (SELECT MAX(ModeloVehiculoID) FROM Vehiculo_Modelos)
BEGIN
    INSERT INTO Vehiculo_Versiones (ModeloVehiculoID, Anio, NombreVersion) VALUES 
    (@ModeloID, 2023, 'Standard'),
    (@ModeloID, 2022, 'Standard'),
    (@ModeloID, 2021, 'Standard'),
    (@ModeloID, 2020, 'Standard'),
    (@ModeloID, 2019, 'Standard'),
    (@ModeloID, 2018, 'Standard');
    
    SET @ModeloID = @ModeloID + 1;
END
GO

INSERT INTO Marcas (NombreMarca, PaisOrigen, LogoUrl) 
VALUES
('Bridgestone', 'Japón', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Bridgestone.png'),
('Michelin', 'Francia','C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Michelin.png'),
('Goodyear', 'Estados Unidos', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Goodyear.png'),
('Pirelli', 'Italia', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Pirelli.png'),
('Continental', 'Alemania', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Continental.png'),
('Yokohama', 'Japón', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Yokohama.png'),
('Hankook', 'Corea del Sur', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Hankook.png'),
('Firestone', 'Estados Unidos', 'C:\Users\jusse\Desktop\Proyectos\Eccomerce RepuestosScz\Tyre\Photos\Firestone.png');


INSERT INTO Categorias(NombreCategoria, Descripcion, ImagenURL) 
VALUES 
('P/HT', 'Turismo / Highway Terrain: Confort, silencio y larga vida útil.', NULL),
('HP/UHP', 'High Performance / Ultra High Performance: Máximo agarre y velocidad para autos deportivos.', NULL),
('AT', 'All Terrain: Balance 50/50 para uso en carretera y todoterreno moderado.', NULL),
('MT', 'Mud Terrain: Llantas agresivas, uso principal fuera de carretera (barro, rocas).', NULL),
('LT/Carga', 'Light Truck / Comercial: Diseñadas para soportar cargas pesadas en vehículos de trabajo.', NULL);
GO

-- =============================================
-- ROLES Y PERMISOS
-- =============================================

INSERT INTO Roles (NombreRol, Descripcion) VALUES
('Administrador', 'Acceso total al sistema'),
('Cliente', 'Usuario cliente del e-commerce');
GO

INSERT INTO Permisos (NombrePermiso, CodigoInterno) VALUES
('Gestión Completa', 'ADMIN_ALL'),
('Realizar Compras', 'CUSTOMER_BUY');
GO

-- Asignación de permisos a roles
INSERT INTO RolPermisos (RolID, PermisoID) VALUES
-- Administrador
(1, 1),
-- Cliente
(2, 2);
GO

-- =============================================
-- USUARIOS Y CLIENTES
-- =============================================

INSERT INTO Usuarios (Email, PasswordHash, RolID, Activo) VALUES
-- Administradores
('admin@avilastyre.com', 'hash_admin_123', 1, 1),
-- Clientes
('juan.perez@gmail.com', 'hash_jp_001', 2, 1),
('maria.lopez@hotmail.com', 'hash_ml_002', 2, 1),
('carlos.rodriguez@yahoo.com', 'hash_cr_003', 2, 1),
('empresa.transporte@gmail.com', 'hash_et_004', 2, 1),
('sofia.martinez@outlook.com', 'hash_sm_005', 2, 1),
('distribuidora.scz@gmail.com', 'hash_ds_006', 2, 1);
GO

INSERT INTO Clientes (UsuarioID, NumeroDocumento, TipoDocumento, TipoCliente, Telefono) VALUES
-- Personas
(2, '9876543', 'CI', 'Persona', '71234567'),
(3, '8765432', 'CI', 'Persona', '72345678'),
(4, '7654321', 'CI', 'Persona', '73456789'),
(6, '6543210', 'CI', 'Persona', '74567890'),
-- Empresas
(5, '1234567890', 'NIT', 'Empresa', '33445566'),
(7, '0987654321', 'NIT', 'Empresa', '33778899');
GO

INSERT INTO Personas (ClienteID, Nombres, ApellidoPaterno, ApellidoMaterno, FechaNacimiento) VALUES
(1, 'Juan Carlos', 'Pérez', 'García', '1985-05-15'),
(2, 'María Fernanda', 'López', 'Sánchez', '1990-08-22'),
(3, 'Carlos Alberto', 'Rodríguez', 'Martínez', '1988-12-10'),
(4, 'Sofía Elena', 'Martínez', 'Flores', '1992-03-18');
GO

INSERT INTO Empresas (ClienteID, RazonSocial, NombreComercial) VALUES
(5, 'Transportes Rápidos S.R.L.', 'Transportes Rápidos'),
(6, 'Distribuidora Santa Cruz Ltda.', 'Distri-SCZ');
GO

-- =============================================
-- GEOGRAFÍA
-- =============================================

INSERT INTO Departamentos (NombreDepartamento) VALUES
('Santa Cruz'),
('La Paz'),
('Cochabamba'),
('Tarija'),
('Beni'),
('Pando'),
('Oruro'),
('Potosí'),
('Chuquisaca');
GO

INSERT INTO Ciudades (DepartamentoID, NombreCiudad) VALUES
-- Santa Cruz
(1, 'Santa Cruz de la Sierra'),
(1, 'Montero'),
(1, 'Warnes'),
-- La Paz
(2, 'La Paz'),
(2, 'El Alto'),
-- Cochabamba
(3, 'Cochabamba'),
(3, 'Quillacollo'),
-- Tarija
(4, 'Tarija'),
-- Beni
(5, 'Trinidad'),
-- Pando
(6, 'Cobija'),
-- Oruro
(7, 'Oruro'),
-- Potosí
(8, 'Potosí'),
-- Chuquisaca
(9, 'Sucre');
GO

INSERT INTO Direcciones (ClienteID, NombreDireccion, Calle, Zona, CiudadID, Referencia, EsPrincipal, Activo) VALUES
(1, 'Casa', 'Av. Cristo Redentor #456', 'Equipetrol', 1, 'Frente al parque central', 1, 1),
(2, 'Casa', 'Calle Libertad #789', 'Centro', 1, 'Al lado del mercado', 1, 1),
(3, 'Trabajo', '4to Anillo y Av. Alemana', 'Plan 3000', 1, 'Edificio azul 2do piso', 1, 1),
(4, 'Casa', 'Av. Banzer #234', 'Barrio Hamacas', 1, 'Casa verde con portón negro', 1, 1),
(5, 'Depósito Principal', 'Parque Industrial Mz. 15', 'Parque Industrial', 1, 'Galpón con letrero Transportes Rápidos', 1, 1),
(6, 'Oficina Central', 'Av. Roca y Coronado #567', 'Centro', 1, 'Edificio comercial 3er piso', 1, 1);
GO

-- =============================================
-- PRODUCTOS
-- =============================================

INSERT INTO Productos (CodigoProducto, NombreProducto, Descripcion, CategoriaID, MarcaID, Ancho, Perfil, DiametroRin, IndiceCarga, IndiceVelocidad, PrecioCompraBs, PrecioVentaBs, StockMinimo, StockActual, ImagenPrincipalURL, Activo, Destacado) VALUES
-- Categoría P/HT (Turismo)
('BRG-195-65-15', 'Bridgestone Turanza ER300', 'Llanta de turismo con excelente agarre en húmedo y seco', 1, 1, 195, 65, 15, '91', 'H', 450.00, 650.00, 8, 25, NULL, 1, 1),
('MCH-205-55-16', 'Michelin Primacy 4', 'Máximo rendimiento y seguridad para sedanes', 1, 2, 205, 55, 16, '94', 'V', 550.00, 780.00, 6, 18, NULL, 1, 1),
('GDY-185-60-15', 'Goodyear Assurance', 'Confort y durabilidad para uso diario', 1, 3, 185, 60, 15, '88', 'H', 380.00, 550.00, 10, 30, NULL, 1, 0),
('CNT-215-60-17', 'Continental ContiComfortContact', 'Confort superior y bajo ruido', 1, 5, 215, 60, 17, '96', 'H', 620.00, 870.00, 5, 15, NULL, 1, 1),

-- Categoría HP/UHP (Alto Rendimiento)
('PIR-225-45-17', 'Pirelli P Zero', 'Llanta deportiva de máximo rendimiento', 2, 4, 225, 45, 17, '94', 'W', 780.00, 1100.00, 4, 12, NULL, 1, 1),
('YKH-245-40-18', 'Yokohama Advan Sport', 'Tecnología japonesa para máxima velocidad', 2, 6, 245, 40, 18, '97', 'Y', 920.00, 1280.00, 3, 8, NULL, 1, 1),
('MCH-235-45-18', 'Michelin Pilot Sport 4', 'Control preciso y frenado corto', 2, 2, 235, 45, 18, '98', 'Y', 850.00, 1200.00, 4, 10, NULL, 1, 0),

-- Categoría AT (All Terrain)
('BRG-265-70-17', 'Bridgestone Dueler AT', 'Todo terreno versátil para SUVs', 3, 1, 265, 70, 17, '115', 'T', 720.00, 980.00, 6, 20, NULL, 1, 1),
('GDY-235-75-15', 'Goodyear Wrangler AT Adventure', 'Aventura sin límites on/off road', 3, 3, 235, 75, 15, '109', 'T', 650.00, 890.00, 8, 22, NULL, 1, 1),
('HNK-255-65-17', 'Hankook Dynapro AT2', 'Durabilidad extrema en cualquier terreno', 3, 7, 255, 65, 17, '110', 'T', 580.00, 820.00, 7, 18, NULL, 1, 0),

-- Categoría MT (Mud Terrain)
('BRG-285-75-16', 'Bridgestone Dueler MT', 'Agresivo diseño para barro y rocas', 4, 1, 285, 75, 16, '126', 'Q', 880.00, 1250.00, 4, 10, NULL, 1, 1),
('GDY-33-12.5-15', 'Goodyear Wrangler MT/R', 'Máxima tracción en terrenos extremos', 4, 3, 330, 125, 15, '108', 'Q', 950.00, 1350.00, 3, 8, NULL, 1, 0),

-- Categoría LT/Carga (Camionetas de Trabajo)
('FRS-215-85-16', 'Firestone Transforce HT2', 'Resistencia y carga para trabajo pesado', 5, 8, 215, 85, 16, '115', 'R', 520.00, 740.00, 10, 28, NULL, 1, 1),
('CNT-225-70-15', 'Continental Vanco 2', 'Confiabilidad para vehículos comerciales', 5, 5, 225, 70, 15, '112', 'R', 480.00, 680.00, 12, 35, NULL, 1, 0),
('BRG-195-80-14', 'Bridgestone Duravis', 'Larga vida útil para flotas comerciales', 5, 1, 195, 80, 14, '106', 'R', 420.00, 600.00, 15, 40, NULL, 1, 1),

-- NUEVOS PRODUCTOS - Ampliación de catálogo

-- Más opciones de Turismo/Highway
('PIR-195-55-16', 'Pirelli Cinturato P7', 'Eco-friendly con bajo consumo', 1, 4, 195, 55, 16, '91', 'V', 480.00, 690.00, 7, 20, NULL, 1, 1),
('YKH-205-60-16', 'Yokohama BluEarth ES32', 'Tecnología verde para sedanes', 1, 6, 205, 60, 16, '92', 'H', 420.00, 600.00, 9, 28, NULL, 1, 0),
('HNK-185-65-15', 'Hankook Kinergy Eco', 'Económica y eficiente', 1, 7, 185, 65, 15, '88', 'T', 350.00, 510.00, 10, 35, NULL, 1, 0),
('FRS-205-65-15', 'Firestone Firehawk', 'Balance entre precio y rendimiento', 1, 8, 205, 65, 15, '94', 'H', 390.00, 560.00, 8, 22, NULL, 1, 0),

-- Más opciones Alto Rendimiento
('CNT-245-45-18', 'Continental SportContact 6', 'Máxima precisión deportiva', 2, 5, 245, 45, 18, '100', 'Y', 980.00, 1380.00, 3, 6, NULL, 1, 1),
('BRG-215-45-17', 'Bridgestone Potenza RE003', 'Agarre superior en pista y calle', 2, 1, 215, 45, 17, '91', 'W', 720.00, 1020.00, 4, 9, NULL, 1, 0),
('GDY-225-50-17', 'Goodyear Eagle F1 Asymmetric', 'Tecnología de F1 para la calle', 2, 3, 225, 50, 17, '98', 'Y', 850.00, 1190.00, 4, 11, NULL, 1, 1),

-- Más opciones Todo Terreno
('YKH-245-70-16', 'Yokohama Geolandar AT G015', 'Silent todo terreno', 3, 6, 245, 70, 16, '111', 'T', 680.00, 940.00, 6, 16, NULL, 1, 1),
('CNT-235-65-17', 'Continental CrossContact ATR', 'SUV todo uso', 3, 5, 235, 65, 17, '108', 'H', 620.00, 880.00, 7, 19, NULL, 1, 0),
('FRS-265-65-17', 'Firestone Destination AT', 'Aventura accesible', 3, 8, 265, 65, 17, '112', 'T', 590.00, 830.00, 6, 17, NULL, 1, 0),

-- Más opciones Mud Terrain
('MCH-265-75-16', 'Michelin LTX M/T', 'Premium mud terrain', 4, 2, 265, 75, 16, '123', 'Q', 920.00, 1300.00, 3, 7, NULL, 1, 1),

-- Más opciones Comercial/Carga
('HNK-195-75-16', 'Hankook Vantra LT', 'Comercial ligero económico', 5, 7, 195, 75, 16, '107', 'R', 440.00, 630.00, 12, 30, NULL, 1, 0);
GO

-- =============================================
-- PROMOCIONES Y CUPONES
-- =============================================

INSERT INTO Promociones (NombrePromocion, Descripcion, TipoDescuento, ValorDescuento, FechaInicio, FechaFin, Activa) VALUES
('Black Friday 2024', 'Descuento especial para el Black Friday', 'PORCENTAJE', 25.00, '2024-11-25', '2024-11-30', 1),
('Compra 4 Paga 3', 'Lleva 4 llantas y paga solo 3', '4X3', 0.00, '2024-11-01', '2024-12-31', 1),
('Navidad 2024', 'Descuento navideño en llantas seleccionadas', 'PORCENTAJE', 15.00, '2024-12-15', '2024-12-31', 1),
('Descuento Deportivas', 'Bs 200 de descuento en llantas de alto rendimiento', 'MONTO_FIJO', 200.00, '2024-11-01', '2024-12-15', 1);
GO

INSERT INTO ProductosEnPromocion (PromocionID, ProductoID) VALUES
-- Black Friday aplica a productos destacados
(1, 1), (1, 2), (1, 4), (1, 5), (1, 8), (1, 9), (1, 16), (1, 20), (1, 22), (1, 23), (1, 24), (1, 26),
-- 4X3 aplica a llantas de turismo
(2, 1), (2, 2), (2, 3), (2, 4), (2, 16), (2, 17), (2, 18), (2, 19),
-- Navidad en All Terrain
(3, 8), (3, 9), (3, 10), (3, 23), (3, 24), (3, 25),
-- Descuento deportivas
(4, 5), (4, 6), (4, 7), (4, 20), (4, 21), (4, 22);
GO

INSERT INTO Cupones (CodigoCupon, Descripcion, TipoDescuento, ValorDescuento, MontoMinCompra, UsosMaximos, UsosActuales, FechaInicio, FechaExpiracion, Activo) VALUES
('BIENVENIDO10', 'Cupón de bienvenida para nuevos clientes', 'PORCENTAJE', 10.00, 500.00, 100, 5, '2024-11-01', '2025-01-31', 1),
('CLIENTE-VIP', 'Descuento exclusivo para clientes VIP', 'PORCENTAJE', 20.00, 1000.00, 50, 2, '2024-11-01', '2025-12-31', 1),
('FLETE-GRATIS', 'Envío gratuito en compras mayores', 'MONTO_FIJO', 50.00, 800.00, NULL, 12, '2024-11-01', '2024-12-31', 1),
('NAVIDAD100', 'Cupón especial de navidad', 'MONTO_FIJO', 100.00, 1200.00, 200, 8, '2024-12-01', '2024-12-31', 1);
GO

-- =============================================
-- ESTADOS Y MÉTODOS DE PAGO
-- =============================================

INSERT INTO EstadosPedido (NombreEstado, Descripcion, Orden) VALUES
('Pendiente', 'Pedido recibido, esperando confirmación de pago', 1),
('Pagado', 'Pago confirmado, preparando para envío', 2),
('En Preparación', 'Pedido siendo preparado en almacén', 3),
('Enviado', 'Pedido en camino al cliente', 4),
('Entregado', 'Pedido entregado al cliente', 5),
('Cancelado', 'Pedido cancelado por el cliente o sistema', 6);
GO

INSERT INTO MetodosPago (NombreMetodo, Descripcion, Activo) VALUES
('Transferencia Bancaria', 'Transferencia a cuenta del Banco Nacional de Bolivia', 1),
('QR Bancario', 'Pago mediante código QR', 1),
('Tarjeta de Crédito/Débito', 'Pago con tarjeta mediante pasarela de pago', 1);
GO

-- =============================================
-- PROVEEDORES Y ESTADOS DE COMPRA
-- =============================================

INSERT INTO Proveedores (NombreProveedor, NIT, Telefono, Email, Direccion, CiudadID, ContactoNombre, ContactoTelefono, Activo) VALUES
('Importadora Global de Llantas', '1023456789', '33221100', 'importadora@global.com', 'Av. Industrial Km 8', 1, 'Roberto Gutiérrez', '77889900', 1),
('Distribuidora Nacional de Neumáticos', '2034567890', '33445577', 'ventas@distrineuma.com', 'Zona Industrial Norte', 1, 'Patricia Fernández', '76543210', 1),
('Comercial Llantas del Sur', '3045678901', '33667788', 'comercial@llantassur.com', 'Av. Doble Vía La Guardia', 1, 'Jorge Mendoza', '75432109', 1);
GO

INSERT INTO EstadosCompra (NombreEstado, Descripcion, Orden) VALUES
('Solicitada', 'Orden de compra generada', 1),
('Aprobada', 'Compra aprobada por gerencia', 2),
('En Tránsito', 'Mercadería en camino', 3),
('Recibida', 'Productos recibidos en almacén', 4),
('Cancelada', 'Compra cancelada', 5);
GO

-- =============================================
-- ESTADOS DE DEVOLUCIÓN
-- =============================================

INSERT INTO EstadosDevolucion (NombreEstado, Descripcion, Orden) VALUES
('Solicitada', 'Cliente ha solicitado devolución', 1),
('En Revisión', 'Equipo está revisando la solicitud', 2),
('Aprobada', 'Devolución aprobada', 3),
('Rechazada', 'Devolución rechazada', 4),
('Reembolsada', 'Dinero devuelto al cliente', 5);
GO

-- =============================================
-- TIPOS DE MOVIMIENTO DE INVENTARIO
-- =============================================

INSERT INTO TiposMovimiento (NombreTipo, AfectaStock, Descripcion) VALUES
('Entrada por Compra', 'AUMENTA', 'Ingreso de productos por compra a proveedor'),
('Salida por Venta', 'DISMINUYE', 'Salida de productos por venta a cliente'),
('Ajuste Positivo', 'AUMENTA', 'Corrección de inventario al alza'),
('Ajuste Negativo', 'DISMINUYE', 'Corrección de inventario a la baja'),
('Devolución de Cliente', 'AUMENTA', 'Retorno de producto por devolución'),
('Devolución a Proveedor', 'DISMINUYE', 'Devolución de producto defectuoso a proveedor'),
('Producto Dañado', 'DISMINUYE', 'Baja de producto por daño o deterioro');
GO

-- =============================================
-- COMPATIBILIDAD DE LLANTAS CON VEHÍCULOS
-- =============================================

INSERT INTO Llantas_Compatibilidad (ProductoID, VersionVehiculoID, Posicion, Observacion) VALUES
(1, 1, 'Todas', 'Medida original para versión Standard'),
(1, 2, 'Todas', 'Compatible con modelo 2022'),
(1, 3, 'Todas', 'Excelente opción para uso diario'),
(1, 25, 'Todas', 'Opción recomendada para confort'),
(1, 26, 'Todas', 'Medida alternativa disponible'),
(1, 109, 'Todas', 'Compatible con versiones base'),
(1, 110, 'Todas', 'Buen rendimiento en ciudad'),
(2, 1, 'Todas', 'Upgrade recomendado para mejor agarre'),
(2, 2, 'Todas', 'Mayor seguridad en lluvia'),
(2, 25, 'Todas', 'Medida original versión SE'),
(2, 26, 'Todas', 'Excelente durabilidad'),
(2, 37, 'Todas', 'Medida original de fábrica'),
(2, 38, 'Todas', 'Reduce ruido de rodadura'),
(2, 97, 'Todas', 'Compatible con aros de 16 pulgadas'),
(2, 98, 'Todas', 'Mejora eficiencia de combustible'),
(3, 73, 'Todas', 'Medida original para Accent'),
(3, 74, 'Todas', 'Económica y durable'),
(3, 91, 'Todas', 'Perfecta para uso urbano'),
(3, 92, 'Todas', 'Buen precio-rendimiento'),
(3, 127, 'Todas', 'Ideal para ciudad'),
(3, 128, 'Todas', 'Larga vida útil'),
(4, 13, 'Todas', 'Medida original RAV4'),
(4, 14, 'Todas', 'Máximo confort y silencio'),
(4, 31, 'Todas', 'Compatible con todas las versiones'),
(4, 32, 'Todas', 'Recomendada para viajes largos'),
(4, 103, 'Todas', 'Excelente para uso familiar'),
(4, 104, 'Todas', 'Bajo consumo de combustible'),
(4, 115, 'Todas', 'Medida estándar CR-V'),
(4, 116, 'Todas', 'Mejora estabilidad'),
(5, 19, 'Todas', 'Upgrade deportivo para Camry'),
(5, 20, 'Todas', 'Mayor agarre en curvas'),
(5, 97, 'Todas', 'Versión sport recomendada'),
(5, 98, 'Todas', 'Mejora respuesta de manejo'),
(5, 121, 'Todas', 'Opción deportiva Accord'),
(5, 122, 'Todas', 'Frenado más corto'),
(6, 109, 'Todas', 'Performance premium'),
(6, 110, 'Todas', 'Máxima velocidad segura'),
(7, 19, 'Todas', 'Versión premium deportiva'),
(7, 20, 'Todas', 'Control total en altas velocidades'),
(7, 121, 'Todas', 'Tecnología de competición'),
(7, 122, 'Todas', 'Agarre en mojado excepcional'),
(8, 7, 'Todas', 'Medida original para Hilux 4x4'),
(8, 8, 'Todas', 'Perfecta para ciudad y tierra'),
(8, 9, 'Todas', 'Versátil todo terreno'),
(8, 55, 'Todas', 'Compatible Ranger 4x4'),
(8, 56, 'Todas', 'Excelente tracción'),
(8, 49, 'Todas', 'Ideal para aventuras'),
(8, 50, 'Todas', 'Balance perfecto on/off road'),
(9, 139, 'Todas', 'Medida recomendada para Jimny'),
(9, 140, 'Todas', 'Mejora capacidad off-road'),
(9, 141, 'Todas', 'Diseño agresivo'),
(9, 133, 'Todas', 'Compatible con Vitara 4x4'),
(9, 134, 'Todas', 'Aventura sin límites'),
(10, 13, 'Todas', 'Upgrade todo terreno'),
(10, 14, 'Todas', 'Más agresiva que la original'),
(10, 85, 'Todas', 'Medida original Santa Fe'),
(10, 86, 'Todas', 'Durabilidad extrema'),
(10, 97, 'Todas', 'Compatible Sorento AWD'),
(10, 98, 'Todas', 'Excelente en barro y nieve'),
(11, 7, 'Todas', 'Preparación extrema off-road'),
(11, 8, 'Todas', 'Requiere modificación de suspensión'),
(11, 55, 'Todas', 'Para uso extremo'),
(11, 56, 'Todas', 'Máxima tracción en barro'),
(11, 43, 'Todas', 'Medida original Silverado HD'),
(11, 44, 'Todas', 'Diseño agresivo para rocas'),
(12, 61, 'Todas', 'Requiere lift kit'),
(12, 62, 'Todas', 'Medida extrema para competición'),
(12, 43, 'Todas', 'Para uso profesional off-road'),
(12, 44, 'Todas', 'No apta para uso urbano frecuente'),
(13, 55, 'Todas', 'Ideal para uso comercial'),
(13, 56, 'Todas', 'Alta capacidad de carga'),
(13, 25, 'Todas', 'Recomendada para flotas'),
(13, 26, 'Todas', 'Larga durabilidad'),
(13, 7, 'Todas', 'Versión trabajo pesado'),
(13, 8, 'Todas', 'Económica para kilometraje alto'),
(14, 49, 'Todas', 'Uso comercial ligero'),
(14, 50, 'Todas', 'Resistente a sobrecarga'),
(14, 97, 'Todas', 'Opción comercial'),
(14, 98, 'Todas', 'Para empresas de delivery'),
(2, 109, 'Todas', 'Upgrade a 16 pulgadas para Civic'),
(2, 110, 'Todas', 'Mejor agarre y estabilidad'),
(3, 109, 'Todas', 'Opción económica para Civic'),
(3, 110, 'Todas', 'Ideal para uso urbano diario'),
(1, 37, 'Todas', 'Alternativa más económica'),
(1, 38, 'Todas', 'Buena relación precio-calidad'),
(5, 37, 'Todas', 'Upgrade deportivo para Cruze'),
(5, 38, 'Todas', 'Mejora significativa en manejo'),
(1, 73, 'Todas', 'Opción premium para Accent'),
(1, 74, 'Todas', 'Mayor confort y durabilidad'),
(15, 73, 'Todas', 'Económica para alto kilometraje'),
(15, 74, 'Todas', 'Ideal para uso comercial'),
(2, 31, 'Todas', 'Alternativa para uso urbano'),
(2, 32, 'Todas', 'Mayor eficiencia en ciudad'),
(10, 31, 'Todas', 'Para uso mixto ciudad/tierra'),
(10, 32, 'Todas', 'Mayor versatilidad off-road'),
(2, 103, 'Todas', 'Opción más deportiva'),
(2, 104, 'Todas', 'Reduce consumo de combustible'),
(10, 103, 'Todas', 'Para aventuras de fin de semana'),
(10, 104, 'Todas', 'Mejora tracción en caminos difíciles'),
(2, 115, 'Todas', 'Uso exclusivo en ciudad'),
(2, 116, 'Todas', 'Mayor ahorro de combustible'),
(10, 115, 'Todas', 'Para terrenos mixtos'),
(10, 116, 'Todas', 'Aumenta capacidad todo terreno'),
(4, 109, 'Todas', 'Opción de confort premium'),
(4, 110, 'Todas', 'Viajes largos silenciosos'),
(7, 109, 'Todas', 'Balance entre confort y deporte'),
(7, 110, 'Todas', 'Excelente en curvas'),
(4, 49, 'Todas', 'Para uso principalmente urbano'),
(4, 50, 'Todas', 'Confort en carretera'),
(10, 49, 'Todas', 'Versatilidad on/off road'),
(10, 50, 'Todas', 'Mayor agresividad'),
(8, 139, 'Todas', 'Opción más agresiva'),
(8, 140, 'Todas', 'Mejor para terrenos extremos'),
(8, 141, 'Todas', 'Aumenta capacidad off-road'),
(11, 139, 'Todas', 'Preparación extrema 4x4'),
(11, 140, 'Todas', 'Para uso profesional off-road'),
(11, 141, 'Todas', 'Máxima tracción'),
(8, 133, 'Todas', 'Todo terreno balanceado'),
(8, 134, 'Todas', 'Uso 60% ciudad 40% tierra'),
(10, 133, 'Todas', 'Opción intermedia AT'),
(10, 134, 'Todas', 'Durabilidad excepcional'),
(4, 85, 'Todas', 'Para uso urbano premium'),
(4, 86, 'Todas', 'Confort de lujo'),
(8, 85, 'Todas', 'Capacidad todo terreno'),
(8, 86, 'Todas', 'Aventuras familiares'),
(4, 97, 'Todas', 'Uso diario confortable'),
(4, 98, 'Todas', 'Silencioso y eficiente'),
(8, 97, 'Todas', 'Opción todo terreno'),
(8, 98, 'Todas', 'Para viajes de aventura'),
(8, 61, 'Todas', 'Uso mixto ciudad/tierra'),
(8, 62, 'Todas', 'Balance perfecto'),
(11, 61, 'Todas', 'Off-road severo'),
(11, 62, 'Todas', 'Preparación profesional'),
(13, 61, 'Todas', 'Para trabajo pesado'),
(13, 62, 'Todas', 'Alta capacidad de carga'),
(8, 25, 'Todas', 'Todo terreno balanceado'),
(8, 26, 'Todas', 'Uso mixto recomendado'),
(11, 25, 'Todas', 'Preparación off-road'),
(11, 26, 'Todas', 'Para terrenos extremos'),
(2, 49, 'Todas', 'Uso urbano eficiente'),
(2, 50, 'Todas', 'Ahorro de combustible'),
(4, 49, 'Todas', 'Confort mejorado'),
(4, 50, 'Todas', 'Viajes largos'),
(2, 97, 'Todas', 'Opción económica urbana'),
(2, 98, 'Todas', 'Bajo consumo'),
(4, 97, 'Todas', 'Confort SUV premium'),
(4, 98, 'Todas', 'Silencioso y cómodo'),
(10, 97, 'Todas', 'Aventura todo terreno'),
(10, 98, 'Todas', 'Capacidad off-road');
GO
(4, 50, 'Todas', 'Viajes largos');

-- Completando Kia Sportage (actualmente solo tiene Producto 14)
INSERT INTO Llantas_Compatibilidad (ProductoID, VersionVehiculoID, Posicion, Observacion) VALUES
(2, 97, 'Todas', 'Opción económica urbana'),
(2, 98, 'Todas', 'Bajo consumo'),
(4, 97, 'Todas', 'Confort SUV premium'),
(4, 98, 'Todas', 'Silencioso y cómodo'),
(10, 97, 'Todas', 'Aventura todo terreno'),
(10, 98, 'Todas', 'Capacidad off-road');
GO


select * from Vehiculo_Marcas as VMA
inner join Vehiculo_Modelos as VMO
ON VMA.MarcaVehiculoID = VMO.MarcaVehiculoID
inner join Vehiculo_Versiones as VV
ON VMO.ModeloVehiculoID = VV.ModeloVehiculoID


select * from Personas

EXEC SP_CrearPersona 
  @Email='test@test.com',
  @PasswordHash='123',
  @NumeroDocumento='111',
  @Telefono='123',
  @Nombres='Jussel',
  @ApellidoPaterno='Avila',
  @ApellidoMaterno='Sandoval',
  @FechaNacimiento='2001-08-31';