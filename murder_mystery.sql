select * from sqlite_master;

/*markdown
Murder happened on 15th Jan 2018 in SQL City
*/

select *
from crime_scene_report
where date = 20180115 and type = 'murder' and city = 'SQL City';

/*markdown
First Witness
*/

select *
from person
where address_street_name = 'Northwestern Dr'
order by address_number desc
limit 1;

/*markdown
Second Witness
*/

select *
from person
where name like '%Annabel%' and address_street_name = 'Franklin Ave';

/*markdown
Interview: Witness 1
*/

select * 
from interview 
where person_id = (
    select id
    from person
    where address_street_name = 'Northwestern Dr'
    order by address_number desc
    limit 1
);

/*markdown
Interview: Witness 2
*/

select *
from interview
where person_id = (
    select id
    from person
    where name like 'Annabel%' and address_street_name = 'Franklin Ave'
);

select * from get_fit_now_member where id like '48Z%' and membership_status = 'gold';

select * from drivers_license where plate_number like '%H42W%' and gender = 'male';

select * 
from get_fit_now_member 
where person_id = (
    select id
    from person
    where name like "Annabel%" and address_street_name = 'Franklin Ave'
);

select *
from get_fit_now_check_in
where membership_id = (
    select id
    from get_fit_now_member
    where person_id = (
        select id
        from person
        where name like 'Annabel%' and address_street_name = 'Franklin Ave'
    )
);

select *
from get_fit_now_check_in
where check_in_date = 20180109 and check_out_time >= (
    select check_in_time
    from get_fit_now_check_in
    where membership_id = (
        select id
        from get_fit_now_member
        where person_id = (
            select id
            from person
            where name like 'Annabel%' and address_street_name = 'Franklin Ave'
        )
    )
) and membership_id <> (select id
    from get_fit_now_member
    where person_id = (
        select id
        from person
        where name like 'Annabel%' and address_street_name = 'Franklin Ave'
    )
);

select *
from get_fit_now_member
where id = any(
    select membership_id
    from get_fit_now_check_in
    where check_in_date = 20180109 and check_out_time >= (
        select check_in_time
        from get_fit_now_check_in
        where membership_id = (
            select id
            from get_fit_now_member
            where person_id = (
                select id
                from person
                where name like 'Annabel%' and address_street_name = 'Franklin Ave'
            )
        )
    ) and membership_id <> (select id
        from get_fit_now_member
        where person_id = (
            select id
            from person
            where name like 'Annabel%' and address_street_name = 'Franklin Ave'
        )
    )
);

