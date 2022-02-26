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
		[IDParqueo] [dbo].[Name],
		[IDConsecutivoDistrito] [dbo].[Name],
		[NombreDistrito] [dbo].[Name],
		[NombreCanton] [dbo].[Name],
		[NombreProvincia] [dbo].[Name]
)
GO


-- LISTA --
-- CREO LA TABLA DE DimVehiculo--
use DWExamenAnalisis
CREATE TABLE [dbo].[DimVehiculo](
	[IDVehiculo] [dbo].[Name],
	[IDFabricante] [dbo].[Name],
	[IDTipoVehiculo] [dbo].[Name],
	[Placa] [dbo].[Name],
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
		[IDParqueo] [dbo].[Name],
		[IDVehiculo] [dbo].[Name],
		--Estacionamiento--
		[TarifaBase] [money],
		[Ganancia] [money],
		[Mantenimiento] [money],
		[ImpVentas] [money],
		[TotalACobrar] [money],
		--Estacionamiento--
		[IndicadorAutomovilEntrada] [nvarchar](50),
		[IndicadorAutomovilSalida] [nvarchar](50),
		--DiasFeriadosAnuales--
		[IndicadorAutomovilDiaFeriadoEntrada] [nvarchar](50),
		[IndicadorAutomovilDiaFeriadoSalida] [nvarchar](50),
		--Estacionamiento (FECHAIngreso - FECHASalida)--
		[CantidadMinutosAutomovilEstacionado] [datetime],
		--VEHICULO (PLACA TAL NUMERO)--
		[IndicadorIngresoDiaRestriccion] [nvarchar](50),
		[IndicadorSalioDiaRestriccion] [nvarchar](50),
		--Estacionamiento--
		[IndicadorEstratoCantidadMinutosAutomovilEstacionado] [nvarchar](50),
		[IndicadorEstratoHoraEntroAutomovilAlEstacionamiento] [nvarchar](50),
		[IndicadorEstratoHoraSalioAutomovilAlEstacionamiento] [nvarchar](50),
		[IndicadorEstratoGananciaObtenidaColones] [nvarchar](50),
		[MontoRealCobrado] [money],
		[DiferenciaDeMontos] [money],
		[PorcentajeGanancia] [money]
)
GO

-- LISTA --
-- CREO LA TABLA DE DimVehiculo--
use DWExamenAnalisis
CREATE TABLE [dbo].[DimDiaFeriado](
	[DiaFeriado] [nvarchar](20),
	[MesFeriado] [nvarchar](20),
	[DiaMesFeriado] [nvarchar](20),
	--[DiaFeriado] [nvarchar](20),
	--[MesFeriado] [nvarchar](20),
	--[NombreFeriado] [nvarchar](70)
)
GO


-- LISTA --
-- CREO LA TABLA DE DimVehiculo--
--use DWExamenAnalisis
--CREATE TABLE [dbo].[FactMontosPagos](
--	[MontoRealCobrado] [money],
--	[DiferenciaDeMontos] [money],
--	[TotalACobrar] [money],
--)
--GO