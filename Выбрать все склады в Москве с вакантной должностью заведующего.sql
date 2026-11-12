SELECT *
FROM public."Warhouse"
WHERE warheouse_addres ILIKE '%Москва%'
  AND (warheouse_manger IS NULL OR TRIM(warheouse_manger) = '');