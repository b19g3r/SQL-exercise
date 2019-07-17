-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person).
-- i.e., the joined table should have the same number of rows as table PEOPLE
select *
from PEOPLE P
         join ADDRESS A on A.id = P.id
group by P.id;

SELECT PEOPLE.id,
       PEOPLE.name,
       TEMP.address
FROM PEOPLE
         LEFT JOIN
     (
         SELECT id, MAX(address) as address
         FROM ADDRESS
         GROUP BY id
     )
         AS TEMP
     ON PEOPLE.id = TEMP.id;


-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person.
-- i.e., the joined table should have the same number of rows as table PEOPLE

select P.id,
       P.name,
       A.address
from PEOPLE P
         join (
    select *
    from ADDRESS t1
             join (select max(updatedate) as date, id t2_id from ADDRESS group by id) t2
                  on t1.id = t2.t2_id and t1.updatedate = t2.date
) A on A.id = P.id
group by P.id;