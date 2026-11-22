INSERT INTO public.september_free_warehouses
    (warheouse_number, warheouse_addres, capacity)
SELECT w.warheouse_number, w.warheouse_addres, w.capacity
FROM public."Warhouse" w
WHERE w.warheouse_addres NOT ILIKE '%Москва%'
  AND NOT EXISTS (
      SELECT 1
      FROM public.september_free_warehouses s
      WHERE s.warheouse_number = w.warheouse_number
  );

SELECT * FROM public.september_free_warehouses ORDER BY warheouse_number;
