DELETE FROM public.september_free_warehouses
WHERE warheouse_number IN (
    SELECT warheouse_number
    FROM public."Warhouse"
    WHERE warheouse_manger IS NULL OR TRIM(warheouse_manger) = ''
);

SELECT * FROM public.september_free_warehouses ORDER BY warheouse_number;
