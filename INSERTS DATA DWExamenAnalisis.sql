--

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















----------------------------------------------------------------
--INSERT TABL INDICADOR
--use analisis--
use ExamenAnalisis
INSERT INTO DWExamenAnalisis.dbo.DimIndicador
SELECT top (3000) 
	Vehiculo.Ano as IndicadorEAFA
	
FROM Vehiculo

---------------------------------------------------------------








----------------------------------------------------------------
--INSERT TABLA DIA FERIADO
--use analisis--


use ExamenAnalisis
INSERT INTO DWExamenAnalisis.dbo.DimDiaFeriado
SELECT top (3000) 
	DiaFeriado,
	MesFeriado,
	(convert(varchar, 2010) +'/'+convert(varchar, MesFeriado) +'/'+convert(VARCHAR, DiaFeriado)) AS FULLDATE
FROM DiasFeriadosAnuales

---------------------------------------------------------------








