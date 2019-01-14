# 1. Quantitat de registres de la taula de vols: 
SELECT COUNT(*) FROM usairlineflights2.flights;

# 2. Retard promig de sortida i arribada segons l’aeroport origen. 
SELECT Origin, AVG(DepDelay), AVG(ArrDelay) FROM usairlineflights2.flights GROUP BY Origin;

# 3. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. 
SELECT Origin, colYear, colMonth, AVG(ArrDelay) FROM usairlineflights2.flights 
GROUP BY Origin, colYear, colMonth ORDER BY Origin;

/* 4. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen
(mateixa consulta que abans i amb el mateix ordre). 
 Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat. */
SELECT City, colYear, colMonth, AVG(ArrDelay) FROM usairlineflights2.flights
INNER JOIN usairlineflights2.usairports ON usairlineflights2.flights.Origin = usairlineflights2.usairports.IATA
GROUP BY colMonth, colYear, City
ORDER BY City, colYear, colMonth;

/* 5. Les companyies amb més vols cancelats. 
A més, han d’estar ordenades de forma que les companyies amb més cancelacions apareguin les primeres. */
SELECT usairlineflights2.carriers.Description, COUNT(Cancelled) FROM usairlineflights2.carriers
LEFT JOIN usairlineflights2.flights ON usairlineflights2.flights.UniqueCarrier=usairlineflights2.carriers.CarrierCode
WHERE Cancelled=1
group by Description
ORDER BY count(Cancelled) DESC;

# 6. L’identificador dels 10 avions que més distància han recorregut fent vols.
SELECT usairlineflights2.flights.FlightNum FROM usairlineflights2.flights
GROUP BY FlightNum
ORDER BY SUM(usairlineflights2.flights.Distance) DESC
LIMIT 10;

# 7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí amb un retràs promig major de 10 minuts. 
SELECT usairlineflights2.flights.UniqueCarrier, AVG(usairlineflights2.flights.ArrDelay) FROM usairlineflights2.flights
GROUP BY usairlineflights2.flights.UniqueCarrier
HAVING AVG(usairlineflights2.flights.ArrDelay) > 10;
