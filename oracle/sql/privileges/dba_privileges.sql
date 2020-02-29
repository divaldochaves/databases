/*
 * Funciona em Oracle 12c
 * Lista a informação de todas as roles contidas da role DBA
 */
select level, grantee, granted_role
from dba_role_privs
connect by grantee = prior granted_role
start with grantee = 'DBA'
order by 1,2,3

/


/*
 * Funciona em Oracle 12c
 * Lista a informação de todas as roles contidas da role DBA e os respectivos privilégios de sistema
 */

with dbaroles as (
    select distinct granted_role
    from dba_role_privs
    connect by grantee = prior granted_role
    start with grantee = 'DBA')
select p.* 
from dbaroles r 
    inner join dba_sys_privs p on r.granted_role = p.grantee
order by 1,2   
