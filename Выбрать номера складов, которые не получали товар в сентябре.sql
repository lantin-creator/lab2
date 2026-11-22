SELECT w.warheouse_number
FROM public."Warhouse" w
WHERE NOT EXISTS (
    SELECT 1
    FROM public.placement p
    WHERE p.warhouse_number = w.warheouse_number
      AND EXTRACT(MONTH FROM p.shipment_date) = 9
)
ORDER BY w.warheouse_number;
