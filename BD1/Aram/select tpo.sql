select itemsfactura.NroFactura
,facturas.total 
,SUM(precio*cantida) as total
from itemsfactura join facturas on facturas.NroFactura=ItemsFactura.NroFactura 
group by itemsfactura.NroFactura, facturas.total
having total <> facturas.total


--1
select descripcion,stock from Ingredientes where stock < puntoRep;
--2
select descripcion,preccomp from Ingredientes where cantComp = 1;
--3
select nombre,apellido from Mozos where nombre like '%p%';
--4
select descripcion from Platos where descripcion like '%p__f%'; 
--5
select * from platos join plaing on platos.IdPlato=plaing.idplato join Ingredientes on PlaIng.IdIngrediente=Ingredientes.IdIngrediente join Rubros on Platos.IdRubro=Rubros.IdRubro join Unidades on Unidades.IdUnidad=ingredientes.cUniCompra where rubros.descripcion like 'Carnes Rojas' AND unidades.descripcion like 'Kilogramo';
--6
select mozos.nombre,mozos.apellido,mesas.Descripcion,Facturas.total from facturas join Mozos on facturas.IdMozo=Mozos.IdMozo join mesas on mesas.IdMesa=Facturas.IdMesa;
--7
select itemsfactura.NroFactura
,facturas.total 
,SUM(precio*cantida) as total
from itemsfactura join facturas on facturas.NroFactura=ItemsFactura.NroFactura 
group by itemsfactura.NroFactura, facturas.total
having total <> facturas.total;
--8
select count(itemsfactura.cantida) as unidades,NroFactura,idmozo from itemsfactura 
group by nrofactura,cantida,unidades,idmozo having unidades < 5
Join 
select 
join Unidades on ingredientes.cUniUso=unidades.idunidad