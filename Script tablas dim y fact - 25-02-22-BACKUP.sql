--creo la base de datos DWExamenAnalisis--
create database DWExamenAnalisis;


-- REFERENCIAS PARA CONSULTAS --
--https://www.w3schools.com/sql/sql_and_or.asp --
--https://www.udb.edu.sv/udb_files/recursos_guias/informatica-ingenieria/base-de-datos-i/2019/i/guia-5.pdf --
--Para la fecha AM o PM--
--https://stackoverflow.com/questions/15020865/how-to-display-the-date-as-mm-dd-yyyy-hhmm-am-pm-using-sql-server-2008-r2--
--https://docs.microsoft.com/en-us/sql/t-sql/functions/format-transact-sql?view=sql-server-ver15--

-- Uso la base de datos --
use [ExamenAnalisis];
GO
-- CONSULTAS RAPIDAS DE TABLAS ExamenAnalisis--
SELECT * from [dbo].[parqueo];
SELECT * from [dbo].[distrito];
SELECT * from [dbo].[canton];
SELECT * from [dbo].[provincia];
SELECT * from [dbo].[Vehiculo];
SELECT * from [dbo].[Fabricante];
SELECT * from [dbo].[Estacionamiento];
SELECT * from [dbo].[Pais];
SELECT * from [dbo].[Continente];
SELECT * from [dbo].[RegionContinente];
SELECT * from [dbo].[DiasFeriadosAnuales];
-----------------------------------------------


--Uso la base de datos--
use [DWExamenAnalisis];
GO
-- CONSULTAS RAPIDAS DE TABLAS DWExamenAnalisis--
SELECT * from [dbo].[DimParqueo];
SELECT TOP (100) * from [dbo].[DimVehiculo];
SELECT * from [dbo].[FactEstacionamiento];
-----------------------------------------------
----
DROP DATABASE DWExamenAnalisis;
COMMIT
--borro tabla
use DWExamenAnalisis
DROP TABLE DBO.DimVehiculo

-----------------------------------------------------------------------------------------








-- PARA INGRESO DE DATA --
use ExamenAnalisis;
---------------------------------------------------------------
-- CARGAR DATOS EN DimParqueo --
use ExamenAnalisis
INSERT INTO DWExamenAnalisis.dbo.DimParqueo
SELECT TOP (2000)
	Distrito.Descripcion as NombreDistrito,
	canton.Descripcion as NombreCanton,
	provincia.Descripcion  as NombreProvincia
FROM Distrito
--VENGA DE CANTON--
INNER JOIN Canton on Distrito.IDCanton = Canton.IDCanton
--VENGA DE PROVINCIA--
INNER JOIN Provincia on Distrito.IDProvincia= Provincia.IDProvincia

---------------------------------------------------------------

--borro tabla
use DWExamenAnalisis
DROP TABLE DBO.DimVehiculo

--BORRAR DATA--
use DWExamenAnalisis
DELETE FROM DimIndicador;
use DWExamenAnalisis
DELETE FROM DimVehiculo;

---------------------------------------------------------------
-- CARGAR DATOS EN DimVehiculo --
use ExamenAnalisis
INSERT INTO DWExamenAnalisis.dbo.DimVehiculo
--to test--
SELECT top (10000) 
--SELECT 	
	
	TipoVehiculo.Descripcion as NombreTipoVehiculo,
	Fabricante.NombreFabricante as NombreFabricante,
	Pais.NombrePais as NombrePaisFabricante,
	Pais.AbreviaturaPais as AbreviaturaProcedenciaFabricante,
	RegionContinente.Descripcion as NombreRegionContinentePPFV,
	Continente.Descripcion NombreContinenteRegionPFV,
	--Vehiculo.Ano as IndicadorEAFA
	CASE 
	WHEN (IndicadorEAFA) < ('1985') 
		THEN 'Antes de 1985'
	WHEN (IndicadorEAFA) between ('1985') and ('1994') 
		THEN 'De 1985 a antes de 1994'
	WHEN (IndicadorEAFA) between ('1994') and ('2003') 
		THEN 'De 1994 a antes de 2003'
	WHEN (IndicadorEAFA) between ('2003') and ('2010') 
		THEN 'De 2003 a antes de 2010'
	WHEN (IndicadorEAFA) > ('2010')
		THEN 'De 2010 en adelante'
		--To test
		--END AS IndicadorEAFA2
		END AS IndicadorEAFA
		
	--Vehiculo.Ano as IndicadorEAFA
	

FROM Vehiculo
--VENGA DE TipoVehiculo--
INNER JOIN TipoVehiculo on Vehiculo.IDTipoVehiculo = TipoVehiculo.IDTipoVehiculo
--VENGA DE Fabricante--
INNER JOIN Fabricante on Vehiculo.IDFabricante = Fabricante.IDFabricante
--VENGA DE Pais--
INNER JOIN Pais on Pais.NombrePais = Pais.NombrePais AND Pais.AbreviaturaPais = Pais.AbreviaturaPais
--VENGA DE RegionContinente--
INNER JOIN RegionContinente on RegionContinente.Descripcion = RegionContinente.Descripcion
--VENGA DE Continente--
INNER JOIN Continente on Continente.Descripcion = Continente.Descripcion
--VENGA DE Vehiculo YA LE TIENE MI CONSULTA--
INNER JOIN DWExamenAnalisis.dbo.DimIndicador on IndicadorEAFA = DWExamenAnalisis.dbo.DimIndicador.IndicadorEAFA


---------------------------------------------------------------

---------------------------------------------------------------


--BORRAR DATA--
use DWExamenAnalisis
DELETE FROM DimIndicador;



--use analisis--
use ExamenAnalisis
INSERT INTO DWExamenAnalisis.dbo.DimIndicador
SELECT top (3000) 
	Vehiculo.Ano as IndicadorEAFA
	
FROM Vehiculo

---------------------------------------------------------



---------------------------------------------------------------
-- PARA INGRESO DE DATA --
use ExamenAnalisis;
-- CARGAR DATOS EN FactEstacionamiento --
--use ExamenAnalisis
--INSERT INTO DWExamenAnalisis.dbo.DimVehiculo
SELECT TOP(1000)

	--Estacionamiento--
		Estacionamiento.TarifaBase,
		Estacionamiento.Ganancia,
		Estacionamiento.Mantenimiento,
		Estacionamiento.ImpVentas,
		Estacionamiento.TotalACobrar,
		--Estacionamiento--
		FORMAT(CAST(Estacionamiento.FechaHoraIngreso as datetime2), N'tt')  as IndicadorAutomovilEntrada,
		FORMAT(CAST(Estacionamiento.FechaHoraSalida as datetime2), N'tt')  as IndicadorAutomovilSalida,
		
		--DiasFeriadosAnuales CON CASE--
		Estacionamiento.FechaHoraIngreso,
		Estacionamiento.FechaHoraSalida,

		--Estacionamiento (FECHAIngreso - FECHASalida)--
		datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida) as CantidadMinutosAutomovilEstacionado,
		
		
		--VEHICULO (PLACA TAL NUMERO)  CASE--
		Vehiculo.placa, 
		
		--Estacionamiento CASE Cantidad minutos--
		(datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida)) as CantidadMinutosAutomovilEstacionado,
		
		--Estacionamiento INDICADOR CASE HORA INGRESO--
		(datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida)) as CantidadMinutosAutomovilEstacionado,
		--Estacionamiento INDICADOR CASE HORA SALIDA--
		(datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida)) as CantidadMinutosAutomovilEstacionado,

		--INDICADOR GANANCIA EN COlONES
		Vehiculo.placa



		--REFERENCIAS
		
		--Estacionamiento--
		

FROM Estacionamiento

--VENGA DE Vehiculo la placa--
INNER JOIN Vehiculo on Vehiculo.Placa = Vehiculo.Placa


---------------------------------------------------------------

























---------------------------------------------------------------
--CONDICION SI EL TIPO DE DATO Name YA EXISTE, ELIMINELO--
if TYPE_ID(N'Name') IS NOT NULL
	drop type [dbo].[Name]

--Creo el tipo de alias en la base de datos--
	CREATE TYPE [dbo].[Name] FROM VARCHAR(100) NULL;



-- LISTA --
-- CREO LA TABLA DE DimParqueo--
use DWExamenAnalisis
CREATE TABLE [dbo].[DimParqueo](
		
		[NombreDistrito] [dbo].[Name],
		[NombreCanton] [dbo].[Name],
		[NombreProvincia] [dbo].[Name]
)
GO


-- LISTA --
-- CREO LA TABLA DE DimVehiculo--
use DWExamenAnalisis
CREATE TABLE [dbo].[DimVehiculo](
--	[IndicadorEAFA] [nvarchar](50),
	[NombreTipoVehiculo] [dbo].[Name],
	[NombreFabricante] [dbo].[Name],
	[NombrePaisFabricante] [dbo].[Name],
	[AbreviaturaProcedenciaFabricante] [nvarchar](03),
	[NombreRegionContinentePPFV] [dbo].[Name],
	[NombreContinenteRegionPFV] [dbo].[Name],
	--to test
	--[IndicadorEAFA2] [nvarchar](50)
	[IndicadorEAFA] [nvarchar](50)
)
GO


-- LISTA --
-- CREO LA TABLA DE DimVehiculo--
use DWExamenAnalisis
CREATE TABLE [dbo].[DimIndicador](
	[IndicadorEAFA] [nvarchar](50),
)
GO



-- LISTA --
-- CREO LA TABLA FactEstacionamiento --
use DWExamenAnalisis
CREATE TABLE [dbo].[FactEstacionamiento](
		--Estacionamiento--
		[TarifaBase] [money],
		[Ganancia] [money],
		[Mantenimiento] [money],
		[ImpVentas] [money],
		[TotalACobrar] [money],
		--Estacionamiento--
		[IndicadorAutomovilEntrada] [datetime],
		[IndicadorAutomovilSalida] [datetime],
		--DiasFeriadosAnuales--
		[IndicadorAutomovilDiaFeriadoEntrada] [datetime],
		[IndicadorAutomovilDiaFeriadoSalida] [datetime],
		--Estacionamiento (FECHAIngreso - FECHASalida)--
		[CantidadMinutosAutomovilEstacionado] [datetime],
		--VEHICULO (PLACA TAL NUMERO)--
		[IndicadorIngresoDiaRestriccion] [nvarchar](20),
		[IndicadorSalioDiaRestriccion] [nvarchar](20),
		--Estacionamiento--
		[IndicadorEstratoCantidadMinutosAutomovilEstacionado] [nvarchar](50),
		[IndicadorEstratoHoraEntroAutomovilAlEstacionamiento] [nvarchar](50),
		[IndicadorEstratoHoraSalioAutomovilAlEstacionamiento] [nvarchar](50),
		[IndicadorEstratoGananciaObtenidaColones] [nvarchar](50),

)
GO

