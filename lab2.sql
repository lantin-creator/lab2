INSERT INTO public."Warhouse"
    (warheouse_number, capacity, warheouse_addres, warheouse_manger)
VALUES
    (12, 400, 'г. Москва, ул. Складская, 7', ''),
    (13, 350, 'г. Казань, ул. Складская, 2', '')
ON CONFLICT DO NOTHING;

INSERT INTO public.placement
    (warhouse_number, producrt_code, numver_of_packages, shipment_date, weight, receipt_acknowledgment)
VALUES
    (1, 201, 5, '2025-09-12', 40.0, TRUE),
    (3, 202, 7, '2025-09-20', 55.5, TRUE),
    (2, 203, 9, '2008-03-15', 70.0, TRUE),
    (4, 204, 4, '2008-11-02', 30.5, TRUE)
ON CONFLICT DO NOTHING;

SELECT setval(pg_get_serial_sequence('public."Warhouse"', 'warheouse_number'),
              (SELECT MAX(warheouse_number) FROM public."Warhouse"));


№1
SELECT w.warheouse_number
FROM public."Warhouse" w
WHERE NOT EXISTS (
    SELECT 1
    FROM public.placement p
    WHERE p.warhouse_number = w.warheouse_number
      AND EXTRACT(MONTH FROM p.shipment_date) = 9
)
ORDER BY w.warheouse_number;


№2
SELECT *
FROM public."Warhouse"
WHERE warheouse_addres ILIKE '%Москва%'
  AND (warheouse_manger IS NULL OR TRIM(warheouse_manger) = '');


№3
DROP TABLE IF EXISTS public.september_free_warehouses;

SELECT w.warheouse_number,
       w.warheouse_addres,
       w.capacity
INTO public.september_free_warehouses
FROM public."Warhouse" w
WHERE NOT EXISTS (
    SELECT 1
    FROM public.placement p
    WHERE p.warhouse_number = w.warheouse_number
      AND EXTRACT(MONTH FROM p.shipment_date) = 9
);

SELECT * FROM public.september_free_warehouses ORDER BY warheouse_number;


№4
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


№5
UPDATE public.september_free_warehouses
SET capacity = capacity * 3
WHERE MOD(warheouse_number, 2) = 0;

SELECT * FROM public.september_free_warehouses ORDER BY warheouse_number;


№6
DELETE FROM public.september_free_warehouses
WHERE warheouse_number IN (
    SELECT warheouse_number
    FROM public."Warhouse"
    WHERE warheouse_manger IS NULL OR TRIM(warheouse_manger) = ''
);

SELECT * FROM public.september_free_warehouses ORDER BY warheouse_number;


№7
SELECT w.warheouse_number,
       w.warheouse_addres,
       COALESCE(SUM(p.weight), 0) AS total_weight_2008
FROM public."Warhouse" w
LEFT JOIN public.placement p
       ON p.warhouse_number = w.warheouse_number
      AND EXTRACT(YEAR FROM p.shipment_date) = 2008
GROUP BY w.warheouse_number, w.warheouse_addres
ORDER BY w.warheouse_number;
