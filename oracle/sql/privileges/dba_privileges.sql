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

/

/*
 * Funciona em Oracle 12c
 * Lista a diferença de privilégios de sistema outorgados diretamente a role dba e os privilégios de sistema
 * das roles outorgadas a role dba
 */
 
with dbaroles as (
    select distinct granted_role
    from dba_role_privs
    connect by grantee = prior granted_role
    start with grantee = 'DBA')
select privilege 
from dba_sys_privs
where grantee = 'DBA'
minus    
select distinct p.privilege 
from dbaroles r 
inner join dba_sys_privs p on r.granted_role = p.grantee

/

/*
 * Funciona em Oracle 12c
 * Cria uma role própria de dba sem o privilégio UNLIMITED TABLESPACE
 */


create role mydba;

/

select 'grant '|| granted_role || ' to mydba;'  
from (
    select distinct granted_role
    from dba_role_privs
    connect by grantee = prior granted_role
    start with grantee = 'DBA'
    order by 1)
    
/    
    
select 'grant '|| privilege || ' to mydba;'
from dba_sys_privs
where grantee = 'DBA'
