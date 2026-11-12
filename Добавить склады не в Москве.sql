INSERT INTO public.september_free_warehouses (warheouse_number, warheouse_addres, capacity)
SELECT w.warheouse_number, w.warheouse_addres, w.capacity
FROM public."Warhouse" w
WHERE w.warheouse_addres NOT ILIKE '%Москва%';