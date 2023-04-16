--Посчитать балланс счета в рублях. 
--В таблице account есть поле current_balance в котором хранится текущей 
--баланс счета в валюте счета. 
--Так же есть поле currency_id, которое хранит ссылку на таблицу 
--currency, то есть валюту счета. 
--Необходимо используя таблицу currency_rate посчитать текущий 
--балланс счета в рублях
select account.current_balance * currency_rate.rate as баланс_в_рублях, account.current_balance, account.client_id, currency.name, currency_rate.rate from account
join currency on account.currency_id = currency.id
join currency_rate on account.currency_id = currency_rate.cur_one

--Посчитать отношение курса одной валюты к другой.
--В таблице currency_rate хранятся курсы всех валют по отношению к рублю. Необходимо написать
запрос, который будет рассчитывать курс, к примеру, Евро к Доллару.
select c.name, currency_rate.rate, currency_rate_2.rate, currency_rate.rate / currency_rate_2.rate as doll_euro
from currency c
left join currency_rate on c.id = currency_rate.cur_two and currency_rate.cur_one = 114533
left join currency_rate as currency_rate_2 on c.id = currency_rate_2.cur_two and currency_rate_2.cur_one = 114534
where c.id = 114532

--Вывести текущий статус договора.
--В таблице contract хранятся договора, в таблице status хранятся статусы 
--договоров. В таблице contract_status хрянятся связи договоров со статусами
--с указанием периода, в течении которого действовал или действует статус. 
--Необходимо вывести статус, активный на текущую дату.
select s.name, s.comment as текущий_статус, contract_status.contract_id  from status s
inner join contract_status on s.id = contract_status.status_id
where contract_status.date_end > clock_timestamp() and contract_status.date_begin < clock_timestamp() and contract_status.contract_id = 1004567 

--Отсортировать статусы договора (указать любой в where) по дате 
--окончания их действия. Первым вывести актуальный.
select s.name, s.comment, contract_status.contract_id, contract_status.date_end  from status s 
inner join contract_status on s.id = contract_status.status_id
where contract_status.contract_id = 1004567 
order by contract_status.date_end DESC
