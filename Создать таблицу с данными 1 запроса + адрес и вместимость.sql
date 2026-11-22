DROP TABLE IF EXISTS public.september_free_warehouses;

CREATE TABLE public.september_free_warehouses AS
SELECT w.warheouse_number,
       w.warheouse_addres,
       w.capacity
FROM public."Warhouse" w
WHERE NOT EXISTS (
    SELECT 1
    FROM public.placement p
    WHERE p.warhouse_number = w.warheouse_number
      AND EXTRACT(MONTH FROM p.shipment_date) = 9
);

SELECT * FROM public.september_free_warehouses ORDER BY warheouse_number;
