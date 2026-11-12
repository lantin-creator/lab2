UPDATE public.september_free_warehouses
SET capacity = capacity * 3
WHERE MOD(warheouse_number, 2) = 0;