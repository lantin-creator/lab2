CREATE TABLE public.september_free_warehouses AS
SELECT w.warheouse_number,
       w.warheouse_addres,
       w.capacity
FROM public."Warhouse" w
WHERE w.warheouse_number NOT IN (
    SELECT p.warhouse_number
    FROM public.placement p
    WHERE EXTRACT(MONTH FROM p.shipment_date) = 9
);