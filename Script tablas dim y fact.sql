
--use DWExamenAnalisis
--select * from [DWExamenAnalisis].[dbo].[FactEstacionamiento]
---------------------------------------------------------------
-- PARA INGRESO DE DATA --


use ExamenAnalisis
--INSERT INTO [DWExamenAnalisis].[dbo].[FactEstacionamiento]
-- CARGAR DATOS EN FactEstacionamiento --
--use ExamenAnalisis

SELECT TOP(1000)



	--Estacionamiento LISTO--
		Estacionamiento.TarifaBase,
		Estacionamiento.Ganancia,
		Estacionamiento.Mantenimiento,
		Estacionamiento.ImpVentas,
		Estacionamiento.TotalACobrar,
		--Estacionamiento LISTO--
		--'',
		FORMAT(CAST(Estacionamiento.FechaHoraIngreso as datetime2), N'tt')  as IndicadorAutomovilEntrada,
		--'',
		FORMAT(CAST(Estacionamiento.FechaHoraSalida as datetime2), N'tt')  as IndicadorAutomovilSalida,
		


		--Date('12','12','12')as date

		--CAST(DATEPART(month, DiasFeriadosAnuales.MesFeriado )+'-'+DATEPART(day,DiasFeriadosAnuales.DiaFeriado) as smalldatetime),

		--DiasFeriadosAnuales CON CASE--
		--DimDiaFeriado.NombreFeriado as IndicadorAutomovilDiaFeriadoEntrada,
		CASE
		WHEN
		(Estacionamiento.FechaHoraIngreso) =  DWExamenAnalisis.dbo.DimDiaFeriado.DiaMesFeriado
		
		THEN 'DIA NO FERIADO'
		END 
		AS IndicadorAutomovilDiaFeriadoEntrada,

		--Estacionamiento (FECHAIngreso - FECHASalida) Listo--
		'',
		--datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida) as CantidadMinutosAutomovilEstacionado,
		
		
		--VEHICULO (PLACA TAL NUMERO)  CASE--
		--Vehiculo.placa, 
		'',

		--Estacionamiento CASE Cantidad minutos--
		--(datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida)) as CantidadMinutosAutomovilEstacionado,
		'',
		
		--Estacionamiento INDICADOR CASE HORA INGRESO--
		--(datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida)) as CantidadMinutosAutomovilEstacionado,
		'',
		--Estacionamiento INDICADOR CASE HORA SALIDA--
		--(datediff(MINUTE, Estacionamiento.FechaHoraIngreso, Estacionamiento.FechaHoraSalida)) as CantidadMinutosAutomovilEstacionado,
		'',

		--INDICADOR GANANCIA EN COlONES
		''

		--REFERENCIAS
		
		--Estacionamiento--
		

FROM Estacionamiento 
--VENGA DE Vehiculo la placa--
left outer JOIN DWExamenAnalisis.dbo.DimDiaFeriado
on Estacionamiento.FechaHoraIngreso = DWExamenAnalisis.dbo.DimDiaFeriado.DiaMesFeriado
--on Estacionamiento.FechaHoraIngreso = DWExamenAnalisis.dbo.DimDiaFeriado.DiaMesFeriado
--AND IndicadorAutomovilDiaFeriadoEntrada = DWExamenAnalisis.dbo.DimDiaFeriado.MesFeriado

--INNER JOIN Pais on Pais.NombrePais = Pais.NombrePais AND Pais.AbreviaturaPais = Pais.AbreviaturaPais



--inner join DimDiaFeriado as d1 on d2.FechaHoraIngreso = d1.DiaMesFeriado