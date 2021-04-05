-- lista todos os parâmetros escondidos

SELECT
    ksppinm,
    ksppstvl
FROM
    x$ksppi   a,
    x$ksppsv  b
WHERE
        a.indx = b.indx
    AND substr(ksppinm, 1, 1) = '_'    
ORDER BY
    ksppinm;
