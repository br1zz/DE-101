# Модуль 3: Визуализация данных, дашборды и отчетность - Business Intelligence.
## 3.8 Знакомство с клиентом BI Tableau Desktop
### Практика
 Superstore Dashboard в Tableu Public - [ссылка на отчет](https://public.tableau.com/shared/BJY2H9J3X?:display_count=n&:origin=viz_share_link)
## 3.9 Знакомство с BI Сервером (обзор Tableau Server)
### Практика
Конфигурация стенда:
 - Платформа - Oracle VM
 - OS - Windows Server 2019 Standart
 - BI Server - Tableau Server 2018.3.29
## 3.11 BI опросы или как управлять клиентским опытом BI пользователей
### Практика
В отчете из примера часть заданий уже сделана. Я делал только последний пункт с пересчетом продаж в евро согласно курсу.  
Чтобы было интереснее, сделал новый источник данных, в котором динамически получаю последний утвержденный ЦБ курс Евро.

Файл отчета с продажами в Евро - [ссылка на отчет](https://github.com/br1zz/DE-101/tree/main/Module03/files/DataLearn_EURO.pbix)

Метод для получения актуального курса евро с Московской биржи: https://iss.moex.com/iss/statistics/engines/currency/markets/selt/rates.json?iss.meta=off&cbrf.columns=CBRF_EUR_LAST

*p.s. Я не переделывал все показатели на продажи в евро, только часть, т.к. в отчете, у некоторых объектов, есть границы, для составления которых используются запросы на языке PBI. Разобраться можно, но долговато.