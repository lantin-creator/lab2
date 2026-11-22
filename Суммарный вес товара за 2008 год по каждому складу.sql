SELECT w.warheouse_number,
       w.warheouse_addres,
       COALESCE(SUM(p.weight), 0) AS total_weight_2008
FROM public."Warhouse" w
LEFT JOIN public.placement p
       ON p.warhouse_number = w.warheouse_number
      AND EXTRACT(YEAR FROM p.shipment_date) = 2008
GROUP BY w.warheouse_number, w.warheouse_addres
ORDER BY w.warheouse_number;
