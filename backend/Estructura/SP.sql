USE [Avila's Tyre Company]


CREATE PROCEDURE SP_ObtenerMarcas
AS
BEGIN
    SELECT MarcaVehiculoID, Nombre 
    FROM Vehiculo_Marcas
    ORDER BY Nombre;
END
GO

CREATE PROCEDURE SP_ObtenerModelosPorMarca
    @MarcaID INT
AS
BEGIN
    SELECT 
        ModeloVehiculoID, 
        NombreModelo
    FROM Vehiculo_Modelos
    WHERE MarcaVehiculoID = @MarcaID
    ORDER BY NombreModelo;
END
GO


CREATE PROCEDURE SP_ObtenerVersionesPorModelo
    @ModeloID INT
AS
BEGIN
    SELECT 
        VersionVehiculoID, 
        NombreVersion, 
        Anio
    FROM Vehiculo_Versiones
    WHERE ModeloVehiculoID = @ModeloID
    ORDER BY Anio DESC, NombreVersion;
END
GO


CREATE PROCEDURE SP_BuscarLlantasPorVersion
    @VersionID INT
AS
BEGIN
    SELECT
        P.NombreProducto AS Llanta,
        CONCAT(P.Ancho, '/', P.Perfil, ' R', P.DiametroRin) AS Medida,
        P.IndiceCarga,
        P.IndiceVelocidad,
        C.NombreCategoria AS Categoria,
        LC.Posicion,
        LC.Observacion
    FROM Llantas_Compatibilidad LC
    INNER JOIN Productos P ON LC.ProductoID = P.ProductoID
    INNER JOIN Categorias C ON P.CategoriaID = C.CategoriaID
    WHERE LC.VersionVehiculoID = @VersionID
    ORDER BY C.NombreCategoria, Llanta;
END
GO

CREATE PROCEDURE SP_CrearPersona
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(255),
    @NumeroDocumento NVARCHAR(20),
    @Telefono NVARCHAR(20) = NULL,
    @Nombres NVARCHAR(100),
    @ApellidoPaterno NVARCHAR(100),
    @ApellidoMaterno NVARCHAR(100) = NULL,
    @FechaNacimiento DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar usuario
        DECLARE @UsuarioID INT;
        INSERT INTO Usuarios (Email, PasswordHash, RolID)
        VALUES (@Email, @PasswordHash, 2); -- suponiendo que RolID=2 es 'Cliente'
        
        SET @UsuarioID = SCOPE_IDENTITY();

        -- 2. Insertar cliente
        DECLARE @ClienteID INT;
        INSERT INTO Clientes (UsuarioID, NumeroDocumento, TipoDocumento, Telefono)
        VALUES (@UsuarioID, @NumeroDocumento, 'CI', @Telefono);

        SET @ClienteID = SCOPE_IDENTITY();

        -- 3. Insertar persona
        INSERT INTO Personas (ClienteID, Nombres, ApellidoPaterno, ApellidoMaterno, FechaNacimiento)
        VALUES (@ClienteID, @Nombres, @ApellidoPaterno, @ApellidoMaterno, @FechaNacimiento);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE PROCEDURE SP_CrearEmpresa
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(255),
    @NumeroDocumento NVARCHAR(20),
    @Telefono NVARCHAR(20) = NULL,
    @RazonSocial NVARCHAR(255),
    @NombreComercial NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar usuario
        DECLARE @UsuarioID INT;
        INSERT INTO Usuarios (Email, PasswordHash, RolID)
        VALUES (@Email, @PasswordHash, 2); -- suponiendo que RolID=2 es 'Cliente'
        
        SET @UsuarioID = SCOPE_IDENTITY();

        -- 2. Insertar cliente
        DECLARE @ClienteID INT;
        INSERT INTO Clientes (UsuarioID, NumeroDocumento, TipoDocumento, Telefono)
        VALUES (@UsuarioID, @NumeroDocumento, 'NIT', @Telefono);

        SET @ClienteID = SCOPE_IDENTITY();

        -- 3. Insertar empresa
        INSERT INTO Empresas (ClienteID, RazonSocial, NombreComercial)
        VALUES (@ClienteID, @RazonSocial, @NombreComercial);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
