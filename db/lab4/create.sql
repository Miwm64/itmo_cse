-- we don't know how to generate root <with-no-name> (class Root) :(

comment on database postgres is 'default administrative connection database';

create table "Н_ВЕДОМОСТИ"
(
    "ИД"              integer,
    "ЧЛВК_ИД"         integer,
    "НОМЕР_ДОКУМЕНТА" varchar(40),
    "ОЦЕНКА"          varchar(8),
    "СРОК_СДАЧИ"      timestamp,
    "ДАТА"            timestamp,
    "СЭС_ИД"          integer,
    "ТВ_ИД"           integer,
    "КТО_СОЗДАЛ"      varchar(40),
    "КОГДА_СОЗДАЛ"    timestamp,
    "КТО_ИЗМЕНИЛ"     varchar(40),
    "КОГДА_ИЗМЕНИЛ"   timestamp,
    "ВЕД_ИД"          integer,
    "СОСТОЯНИЕ"       varchar(12),
    "ОТД_ИД"          integer,
    "БУКВА"           varchar(8),
    "ПРИМЕЧАНИЕ"      varchar(200),
    "БАЛЛЫ"           numeric(5, 2)
);

comment on column "Н_ВЕДОМОСТИ"."ИД" is 'Уникальный идентификатор';

comment on column "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" is 'Внешний ключ к таблице Н_ЛЮДИ';

comment on column "Н_ВЕДОМОСТИ"."ОЦЕНКА" is 'Оценка успеваемости';

comment on column "Н_ВЕДОМОСТИ"."СРОК_СДАЧИ" is 'Дата, до которой должен быть сдан (экзамен,зачет)';

comment on column "Н_ВЕДОМОСТИ"."СЭС_ИД" is 'Внешний ключ к таблице Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК';

comment on column "Н_ВЕДОМОСТИ"."ТВ_ИД" is 'Внешний ключ к таблице Н_ТИПЫ_ВЕДОМОСТЕЙ';

alter table "Н_ВЕДОМОСТИ"
    owner to postgres;

create unique index "ВЕД_PK"
    on "Н_ВЕДОМОСТИ" ("ИД");

create index "ВЕД_ДАТА_I"
    on "Н_ВЕДОМОСТИ" ("ДАТА");

create index "ВЕД_ИП_FK_I"
    on "Н_ВЕДОМОСТИ" ("СЭС_ИД");

create index "ВЕД_ОТД_I"
    on "Н_ВЕДОМОСТИ" ("ОТД_ИД");

create index "ВЕД_ОЦЕНКА_I"
    on "Н_ВЕДОМОСТИ" ("ОЦЕНКА");

create index "ВЕД_ТВ_FK_I"
    on "Н_ВЕДОМОСТИ" ("ТВ_ИД");

create index "ВЕД_ЧЛВК_FK_IFK"
    on "Н_ВЕДОМОСТИ" ("ЧЛВК_ИД");

grant select on "Н_ВЕДОМОСТИ" to public;

create table "Н_ВИДЫ_ОБУЧЕНИЯ"
(
    "ИД"            integer,
    "АББРЕВИАТУРА"  varchar(8),
    "НАИМЕНОВАНИЕ"  varchar(200),
    "ПРИМЕЧАНИЕ"    varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ВИДЫ_ОБУЧЕНИЯ"."ИД" is 'Уникальный идентификатор';

comment on column "Н_ВИДЫ_ОБУЧЕНИЯ"."НАИМЕНОВАНИЕ" is 'Наименование вида обучения';

comment on column "Н_ВИДЫ_ОБУЧЕНИЯ"."ПРИМЕЧАНИЕ" is 'Текст примечания';

alter table "Н_ВИДЫ_ОБУЧЕНИЯ"
    owner to postgres;

create unique index "ВО_PK"
    on "Н_ВИДЫ_ОБУЧЕНИЯ" ("ИД");

grant select on "Н_ВИДЫ_ОБУЧЕНИЯ" to public;

create table "Н_ВИДЫ_РАБОТ"
(
    "ИД"                integer,
    "ПОРЯДОК"           integer,
    "АББРЕВИАТУРА"      varchar(8),
    "НАИМЕНОВАНИЕ"      varchar(200),
    "ЕДИНИЦА_ИЗМЕРЕНИЯ" varchar(20),
    "КТО_СОЗДАЛ"        varchar(40),
    "КОГДА_СОЗДАЛ"      timestamp,
    "КТО_ИЗМЕНИЛ"       varchar(40),
    "КОГДА_ИЗМЕНИЛ"     timestamp
);

comment on column "Н_ВИДЫ_РАБОТ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ВИДЫ_РАБОТ"."ПОРЯДОК" is 'Используется для сортировки видов работ';

alter table "Н_ВИДЫ_РАБОТ"
    owner to postgres;

create unique index "ВР_PK"
    on "Н_ВИДЫ_РАБОТ" ("ИД");

grant select on "Н_ВИДЫ_РАБОТ" to public;

create table "Н_ГРУППЫ_ПЛАНОВ"
(
    "ГРУППА"        varchar(4),
    "ПЛАН_ИД"       integer,
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ГРУППЫ_ПЛАНОВ"."ГРУППА" is 'Номер студенческой группы';

comment on column "Н_ГРУППЫ_ПЛАНОВ"."ПЛАН_ИД" is 'Внешний ключ к таблице Н_ПЛАНЫ';

alter table "Н_ГРУППЫ_ПЛАНОВ"
    owner to postgres;

create unique index "ГП_PK"
    on "Н_ГРУППЫ_ПЛАНОВ" ("ПЛАН_ИД", "ГРУППА");

create index "ГП_ПЛАН_FK_I"
    on "Н_ГРУППЫ_ПЛАНОВ" ("ПЛАН_ИД");

create index "ГР_ПЛАН_ГРУППА"
    on "Н_ГРУППЫ_ПЛАНОВ" ("ГРУППА");

grant select on "Н_ГРУППЫ_ПЛАНОВ" to public;

create table "Н_ДИСЦИПЛИНЫ"
(
    "ИД"            integer,
    "КОРОТКОЕ_ИМЯ"  varchar(20),
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ДИСЦИПЛИНЫ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ДИСЦИПЛИНЫ"."КОРОТКОЕ_ИМЯ" is 'Короткое имя дисциплины';

comment on column "Н_ДИСЦИПЛИНЫ"."НАИМЕНОВАНИЕ" is 'Наименование имени дисциплины';

alter table "Н_ДИСЦИПЛИНЫ"
    owner to postgres;

create unique index "ДИС_PK"
    on "Н_ДИСЦИПЛИНЫ" ("ИД");

create unique index "ДИС_UK"
    on "Н_ДИСЦИПЛИНЫ" ("КОРОТКОЕ_ИМЯ");

grant select on "Н_ДИСЦИПЛИНЫ" to public;

create table "Н_ИЗМ_ЛЮДИ"
(
    "ЧЛВК_ИД"       integer,
    "ДАТА"          timestamp,
    "ФАМИЛИЯ"       varchar(25),
    "ИМЯ"           varchar(20),
    "ОТЧЕСТВО"      varchar(20),
    "ДАТА_РОЖДЕНИЯ" timestamp,
    "ПОЛ"           char,
    "ПИН"           varchar(20),
    "ИНН"           varchar(20),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ИЗМ_ЛЮДИ"."ЧЛВК_ИД" is 'Внешний ключ к таблице Н_ЛЮДИ';

comment on column "Н_ИЗМ_ЛЮДИ"."ДАТА" is 'Дата изменения фамилии (имени, отчества, ПИН или ИНН)';

comment on column "Н_ИЗМ_ЛЮДИ"."ПИН" is 'Номер страхового свидетельства ГПС';

comment on column "Н_ИЗМ_ЛЮДИ"."ИНН" is 'Идентификационный номер налогоплательщика';

alter table "Н_ИЗМ_ЛЮДИ"
    owner to postgres;

create unique index "ИЗМЛ_PK"
    on "Н_ИЗМ_ЛЮДИ" ("ЧЛВК_ИД", "ДАТА");

create index "ИЗЧЕЛ_ЧЛВК_FK_I"
    on "Н_ИЗМ_ЛЮДИ" ("ЧЛВК_ИД");

grant select on "Н_ИЗМ_ЛЮДИ" to public;

create table "Н_КВАЛИФИКАЦИИ"
(
    "ИД"            integer,
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp,
    "КОД"           integer
);

comment on column "Н_КВАЛИФИКАЦИИ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_КВАЛИФИКАЦИИ"."НАИМЕНОВАНИЕ" is 'Наименования квалификаций и академических  степеней';

alter table "Н_КВАЛИФИКАЦИИ"
    owner to postgres;

create unique index "КВЛ_PK"
    on "Н_КВАЛИФИКАЦИИ" ("ИД");

grant select on "Н_КВАЛИФИКАЦИИ" to public;

create table "Н_КОМПОНЕНТЫ"
(
    "ИД"            integer,
    "АББРЕВИАТУРА"  varchar(8),
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_КОМПОНЕНТЫ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_КОМПОНЕНТЫ"."АББРЕВИАТУРА" is 'Содержит аббревиатуру компонента (Ф - федеральный, Р - региональный, В - по выбору студента)';

comment on column "Н_КОМПОНЕНТЫ"."НАИМЕНОВАНИЕ" is 'Содержит наименование компонента: Федеральный, Региональный (вузовский), по Выбору студента';

alter table "Н_КОМПОНЕНТЫ"
    owner to postgres;

create unique index "КОМ_PK"
    on "Н_КОМПОНЕНТЫ" ("ИД");

grant select on "Н_КОМПОНЕНТЫ" to public;

create table "Н_ЛЮДИ"
(
    "ИД"             integer,
    "ФАМИЛИЯ"        varchar(25),
    "ИМЯ"            varchar(15),
    "ОТЧЕСТВО"       varchar(20),
    "ПИН"            varchar(20),
    "ИНН"            varchar(20),
    "ДАТА_РОЖДЕНИЯ"  timestamp,
    "ПОЛ"            char,
    "МЕСТО_РОЖДЕНИЯ" varchar(200),
    "ИНОСТРАН"       varchar(3),
    "КТО_СОЗДАЛ"     varchar(40),
    "КОГДА_СОЗДАЛ"   timestamp,
    "КТО_ИЗМЕНИЛ"    varchar(40),
    "КОГДА_ИЗМЕНИЛ"  timestamp,
    "ДАТА_СМЕРТИ"    timestamp,
    "ФИО"            varchar(80)
);

comment on column "Н_ЛЮДИ"."ИД" is 'Уникальный номер человека';

comment on column "Н_ЛЮДИ"."ФАМИЛИЯ" is 'Фамилия человека';

comment on column "Н_ЛЮДИ"."ИМЯ" is 'Имя человека';

comment on column "Н_ЛЮДИ"."ОТЧЕСТВО" is 'Отчество человека';

comment on column "Н_ЛЮДИ"."ПИН" is 'Номер страхового свидетельства ГПС';

comment on column "Н_ЛЮДИ"."ИНН" is 'Идентификационный номер налогоплательщика';

comment on column "Н_ЛЮДИ"."ДАТА_РОЖДЕНИЯ" is 'Дата рождения человека';

comment on column "Н_ЛЮДИ"."ПОЛ" is 'Пол человека';

comment on column "Н_ЛЮДИ"."МЕСТО_РОЖДЕНИЯ" is 'Сведения из паспорта';

alter table "Н_ЛЮДИ"
    owner to postgres;

create unique index "ИНН_UK"
    on "Н_ЛЮДИ" ("ИНН");

create unique index "ПИН_UK"
    on "Н_ЛЮДИ" ("ПИН");

create index "ФАМ_ЛЮД"
    on "Н_ЛЮДИ" ("ФАМИЛИЯ");

create unique index "ЧЛВК_PK"
    on "Н_ЛЮДИ" ("ИД");

grant select on "Н_ЛЮДИ" to public;

create table "Н_ЛЮДИ_ПО_ПАДЕЖАМ"
(
    "ЧЛВК_ИД"       integer,
    "ПАДЕЖ"         varchar(1) default 'И'::character varying,
    "ФАМИЛИЯ"       varchar(25),
    "ИМЯ"           varchar(25),
    "ОТЧЕСТВО"      varchar(20),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ЛЮДИ_ПО_ПАДЕЖАМ"."ПАДЕЖ" is 'ВСЕ ТОЛЬКО ЗАГЛАВНЫМИ БУКВАМИ !!!';

alter table "Н_ЛЮДИ_ПО_ПАДЕЖАМ"
    owner to postgres;

create index "ЧЛВК_ПАДЕЖ_FK_IFK"
    on "Н_ЛЮДИ_ПО_ПАДЕЖАМ" ("ЧЛВК_ИД");

create unique index "ЧЛВК_ПАДЕЖ_U"
    on "Н_ЛЮДИ_ПО_ПАДЕЖАМ" ("ЧЛВК_ИД", "ПАДЕЖ");

grant select on "Н_ЛЮДИ_ПО_ПАДЕЖАМ" to public;

create table "Н_НАПР_СПЕЦ"
(
    "ИД"            integer,
    "КОД_НАПРСПЕЦ"  varchar(8),
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_НАПР_СПЕЦ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_НАПР_СПЕЦ"."КОД_НАПРСПЕЦ" is 'Код направления, специальности или специализации';

comment on column "Н_НАПР_СПЕЦ"."НАИМЕНОВАНИЕ" is 'Наименования направлений, специальностей и специализаций';

alter table "Н_НАПР_СПЕЦ"
    owner to postgres;

create unique index "НС_PK"
    on "Н_НАПР_СПЕЦ" ("ИД");

grant select on "Н_НАПР_СПЕЦ" to public;

create table "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"
(
    "ИД"            integer,
    "УРОВЕНЬ"       integer,
    "ДАТА_ГОС"      timestamp,
    "КВАЛ_ИД"       integer,
    "НС_ИД"         integer,
    "ТС_ИД"         integer,
    "НАПС_ИД"       integer,
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp,
    "ПРИМЕЧАНИЕ"    varchar(200)
);

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."УРОВЕНЬ" is 'Номер уровня (код ступени) высшего профессионального образования';

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."ДАТА_ГОС" is 'Дата утверждения ГОС';

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."КВАЛ_ИД" is 'Внешний ключ к таблице Н_КВАЛИФИКАЦИИ';

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."НС_ИД" is 'Внешний ключ к таблице Н_НАПР_СПЕЦ';

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."ТС_ИД" is 'Внешний ключ к таблице Н_ТИПЫ_СТАНДАРТОВ';

comment on column "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."НАПС_ИД" is 'Внешний ключ к таблице Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ';

alter table "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"
    owner to postgres;

create unique index "НАПС_PK"
    on "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ("ИД");

create index "НАПС_КВАЛ_FK_I"
    on "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ("КВАЛ_ИД");

create index "НАПС_НАПС_FK_I"
    on "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ("НАПС_ИД");

create index "НАПС_НС_FK_I"
    on "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ("НС_ИД");

create index "НАПС_ТС_FK_I"
    on "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ("ТС_ИД");

grant select on "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" to public;

create table "Н_ОБУЧЕНИЯ"
(
    "НЗК"           varchar(8),
    "ЧЛВК_ИД"       integer,
    "ВИД_ОБУЧ_ИД"   integer,
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ОБУЧЕНИЯ"."НЗК" is 'Номер зачетной книжки';

comment on column "Н_ОБУЧЕНИЯ"."ЧЛВК_ИД" is 'Внешний ключ к таблице Н_ЛЮДИ';

comment on column "Н_ОБУЧЕНИЯ"."ВИД_ОБУЧ_ИД" is 'Внешний ключ к таблице Н_ВИДЫ_ОБУЧЕНИЯ';

alter table "Н_ОБУЧЕНИЯ"
    owner to postgres;

create unique index "ОБУЧ_PK"
    on "Н_ОБУЧЕНИЯ" ("ВИД_ОБУЧ_ИД", "ЧЛВК_ИД");

create index "ОБУЧ_ВО_FK_I"
    on "Н_ОБУЧЕНИЯ" ("ВИД_ОБУЧ_ИД");

create index "ОБУЧ_ЧЛВК_FK_I"
    on "Н_ОБУЧЕНИЯ" ("ЧЛВК_ИД");

grant select on "Н_ОБУЧЕНИЯ" to public;

create table "Н_ОТДЕЛЫ"
(
    "ИД"                integer,
    "КОРОТКОЕ_ИМЯ"      varchar(20),
    "ИМЯ_В_ИМИН_ПАДЕЖЕ" varchar(200),
    "ИМЯ_В_РОД_ПАДЕЖЕ"  varchar(200),
    "ИМЯ_В_ДАТ_ПАДЕЖЕ"  varchar(200),
    "ИМЯ_В_ВИН_ПАДЕЖЕ"  varchar(200),
    "ИМЯ_В_ТВОР_ПАДЕЖЕ" varchar(200),
    "ИМЯ_В_ПРЕД_ПАДЕЖЕ" varchar(200),
    "ОТД_ИД"            integer,
    "ДАТА_СОЗДАНИЯ"     timestamp,
    "ДАТА_ЛИКВИДАЦИИ"   timestamp,
    "КТО_СОЗДАЛ"        varchar(40),
    "КОГДА_СОЗДАЛ"      timestamp,
    "КТО_ИЗМЕНИЛ"       varchar(40),
    "КОГДА_ИЗМЕНИЛ"     timestamp
);

comment on column "Н_ОТДЕЛЫ"."ИД" is 'Идентификатор структурного подразделения, являющийся первичным ключом';

comment on column "Н_ОТДЕЛЫ"."ОТД_ИД" is 'Внешний ключ к таблице Н_ОТДЕЛЫ';

comment on column "Н_ОТДЕЛЫ"."ДАТА_СОЗДАНИЯ" is 'Дата создания подразделения';

comment on column "Н_ОТДЕЛЫ"."ДАТА_ЛИКВИДАЦИИ" is 'Дата ликвидации подразделения';

alter table "Н_ОТДЕЛЫ"
    owner to postgres;

create unique index "ОТД_PK"
    on "Н_ОТДЕЛЫ" ("ИД");

create index "ОТД_ОТД_FK_I"
    on "Н_ОТДЕЛЫ" ("ОТД_ИД");

create unique index "ОТД_УОТД_UK"
    on "Н_ОТДЕЛЫ" ("КОРОТКОЕ_ИМЯ");

grant select on "Н_ОТДЕЛЫ" to public;

create table "Н_ОЦЕНКИ"
(
    "КОД"        varchar(8),
    "ПРИМЕЧАНИЕ" varchar(200),
    "СОРТ"       integer
);

alter table "Н_ОЦЕНКИ"
    owner to postgres;

create unique index "ОЦ_PK"
    on "Н_ОЦЕНКИ" ("КОД");

grant select on "Н_ОЦЕНКИ" to public;

create table "Н_ПЛАНЫ"
(
    "ИД"                         integer,
    "ТПЛ_ИД"                     integer,
    "УЧЕБНЫЙ_ГОД"                char(9),
    "ОТД_ИД"                     integer,
    "ОТД_ИД_ЗАКРЕПЛЕН_ЗА"        integer,
    "НАПС_ИД"                    integer,
    "КУРС"                       integer,
    "ФО_ИД"                      integer,
    "СРОК_ОБУЧЕНИЯ"              varchar(10),
    "ДАТА_УТВЕРЖДЕНИЯ"           timestamp,
    "ПЛАН_ПРИЕМА_ПРОЧИЙ"         integer,
    "ПЛАН_ИД"                    integer,
    "ПЛАН_ИД_ОСНОВ_НА"           integer,
    "ПЛАН_ПРИЕМА_БЮДЖЕТ"         integer,
    "ПРОХОДНОЙ_БАЛЛ"             integer,
    "ПОЛУПРОХОДНОЙ_БАЛЛ"         integer,
    "СПЕЦИАЛЬНЫЙ_ПРОХОДНОЙ_БАЛЛ" integer,
    "КТО_СОЗДАЛ"                 varchar(40),
    "КОГДА_СОЗДАЛ"               timestamp,
    "КТО_ИЗМЕНИЛ"                varchar(40),
    "КОГДА_ИЗМЕНИЛ"              timestamp,
    "ПРИМЕЧАНИЕ"                 varchar(200),
    "НОМЕР"                      integer
);

comment on column "Н_ПЛАНЫ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ПЛАНЫ"."ТПЛ_ИД" is 'Уникальный идентификатор';

comment on column "Н_ПЛАНЫ"."УЧЕБНЫЙ_ГОД" is 'Определяет период действия рабочего учебного плана (например, 1999/2000, 2000/2001)';

comment on column "Н_ПЛАНЫ"."ОТД_ИД" is 'Идентификатор структурного подразделения, являющийся первичным ключом';

comment on column "Н_ПЛАНЫ"."ОТД_ИД_ЗАКРЕПЛЕН_ЗА" is 'Идентификатор структурного подразделения, являющийся первичным ключом';

comment on column "Н_ПЛАНЫ"."НАПС_ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ПЛАНЫ"."КУРС" is 'Номер курса';

comment on column "Н_ПЛАНЫ"."ФО_ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ПЛАНЫ"."СРОК_ОБУЧЕНИЯ" is 'Продолжительность обучения в годах (могут быть составлены планы для ускоренного обучения лиц, уровень образования или способности которых являются для этого достаточным основанием)';

comment on column "Н_ПЛАНЫ"."ДАТА_УТВЕРЖДЕНИЯ" is 'Дата ввода в действие';

comment on column "Н_ПЛАНЫ"."ПЛАН_ПРИЕМА_ПРОЧИЙ" is 'Количество платных мест на год приема';

comment on column "Н_ПЛАНЫ"."ПЛАН_ИД" is 'Внешний ключ к таблице Н_ПЛАНЫ';

comment on column "Н_ПЛАНЫ"."ПЛАН_ИД_ОСНОВ_НА" is 'Внешний ключ к таблице Н_ПЛАНЫ';

comment on column "Н_ПЛАНЫ"."ПЛАН_ПРИЕМА_БЮДЖЕТ" is 'Количество бюджетных мест на год приема';

comment on column "Н_ПЛАНЫ"."ПРОХОДНОЙ_БАЛЛ" is 'Проходной балл для зачисления';

comment on column "Н_ПЛАНЫ"."ПОЛУПРОХОДНОЙ_БАЛЛ" is 'Полупроходной балл для зачисления';

comment on column "Н_ПЛАНЫ"."СПЕЦИАЛЬНЫЙ_ПРОХОДНОЙ_БАЛЛ" is 'Специальный проходной балл для зачисления';

alter table "Н_ПЛАНЫ"
    owner to postgres;

create unique index "ПЛАН_PK"
    on "Н_ПЛАНЫ" ("ИД");

create index "ПЛАН_КУРС_FK_I"
    on "Н_ПЛАНЫ" ("КУРС");

create index "ПЛАН_НАПС_FK_I"
    on "Н_ПЛАНЫ" ("НАПС_ИД");

create index "ПЛАН_ОТД_FK_I"
    on "Н_ПЛАНЫ" ("ОТД_ИД");

create index "ПЛАН_ОТД_ЗАКРЕП_ЗА_FK_I"
    on "Н_ПЛАНЫ" ("ОТД_ИД_ЗАКРЕПЛЕН_ЗА");

create index "ПЛАН_ПЛАН_FK_I"
    on "Н_ПЛАНЫ" ("ПЛАН_ИД");

create index "ПЛАН_ПЛАН_ОСНОВ_НА_FK_I"
    on "Н_ПЛАНЫ" ("ПЛАН_ИД_ОСНОВ_НА");

create index "ПЛАН_ТПЛ_FK_I"
    on "Н_ПЛАНЫ" ("ТПЛ_ИД");

create index "ПЛАН_УГОД_I"
    on "Н_ПЛАНЫ" ("УЧЕБНЫЙ_ГОД");

create unique index "ПЛАН_УПЛ_UK"
    on "Н_ПЛАНЫ" ("КУРС", "СРОК_ОБУЧЕНИЯ", "УЧЕБНЫЙ_ГОД", "ТПЛ_ИД", "ДАТА_УТВЕРЖДЕНИЯ", "ОТД_ИД", "ОТД_ИД_ЗАКРЕПЛЕН_ЗА",
                  "ФО_ИД", "НАПС_ИД", "НОМЕР");

create index "ПЛАН_ФО_FK_I"
    on "Н_ПЛАНЫ" ("ФО_ИД");

grant select on "Н_ПЛАНЫ" to public;

create table "Н_СВОЙСТВА_ВР"
(
    "ИД"            integer,
    "НАИМЕНОВАНИЕ"  varchar(200),
    "ПРИМЕЧАНИЕ"    varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_СВОЙСТВА_ВР"."ИД" is 'Уникальный идентификатор';

comment on column "Н_СВОЙСТВА_ВР"."ПРИМЕЧАНИЕ" is 'Назначение, применение данного свойства';

alter table "Н_СВОЙСТВА_ВР"
    owner to postgres;

create unique index "СВР_PK"
    on "Н_СВОЙСТВА_ВР" ("ИД");

grant select on "Н_СВОЙСТВА_ВР" to public;

create table "Н_СВОЙСТВА_ОТДЕЛОВ"
(
    "ИД"            integer,
    "НАИМЕНОВАНИЕ"  varchar(200),
    "ПРИМЕЧАНИЕ"    varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_СВОЙСТВА_ОТДЕЛОВ"."ИД" is 'Уникальный идентификатор';

comment on column "Н_СВОЙСТВА_ОТДЕЛОВ"."НАИМЕНОВАНИЕ" is 'Наименование свойства';

comment on column "Н_СВОЙСТВА_ОТДЕЛОВ"."ПРИМЕЧАНИЕ" is 'Текст примечания';

alter table "Н_СВОЙСТВА_ОТДЕЛОВ"
    owner to postgres;

create unique index "СВОТД_PK"
    on "Н_СВОЙСТВА_ОТДЕЛОВ" ("ИД");

create unique index "СВОТД_УСВОТД_UK"
    on "Н_СВОЙСТВА_ОТДЕЛОВ" ("НАИМЕНОВАНИЕ");

grant select on "Н_СВОЙСТВА_ОТДЕЛОВ" to public;

create table "Н_СЕССИЯ"
(
    "ИД"            integer,
    "СЭС_ИД"        integer,
    "ЧЛВК_ИД"       integer,
    "ДАТА"          timestamp,
    "ВРЕМЯ"         timestamp,
    "АУДИТОРИЯ"     varchar(8),
    "ДАТА_К"        timestamp,
    "ВРЕМЯ_К"       timestamp,
    "АУДИТОРИЯ_К"   varchar(8),
    "УЧГОД"         varchar(9),
    "ГРУППА"        integer,
    "СЕМЕСТР"       integer,
    "КТО_СОЗДАЛ"    varchar(20),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(20),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

alter table "Н_СЕССИЯ"
    owner to postgres;

create index "SYS_C003500_IFK"
    on "Н_СЕССИЯ" ("ЧЛВК_ИД");

create index "СЕС_СЭС_FK"
    on "Н_СЕССИЯ" ("СЭС_ИД");

grant select on "Н_СЕССИЯ" to public;

create table "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"
(
    "ИД"             integer,
    "ВР_ИД"          integer,
    "ОБЪЕМ"          numeric(6, 2),
    "НОМЕР_КОНТРОЛЯ" integer,
    "ЭСТ_ИД"         integer,
    "КТО_СОЗДАЛ"     varchar(40),
    "КОГДА_СОЗДАЛ"   timestamp,
    "КТО_ИЗМЕНИЛ"    varchar(40),
    "КОГДА_ИЗМЕНИЛ"  timestamp
);

comment on column "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"."ВР_ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"."ОБЪЕМ" is 'Количество единиц измерения вида работы (количество часов, недель и т.п.)';

comment on column "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"."НОМЕР_КОНТРОЛЯ" is 'Номер контроля, позволяющий отличить друг от друга несколько одинаковых форм контроля (например, контрольных работ), запланированных в одном семестре';

comment on column "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"."ЭСТ_ИД" is 'Внешний ключ к таблице Н_ЭЛЕМЕНТЫ_СТРОК';

alter table "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК"
    owner to postgres;

create unique index "СЭС_PK"
    on "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК" ("ИД");

create index "СЭС_ВР_FK_I"
    on "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК" ("ВР_ИД");

create index "СЭС_ЭСТ_FK_I"
    on "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК" ("ЭСТ_ИД");

grant select on "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК" to public;

create table "Н_СТРОКИ_ПЛАНОВ"
(
    "ИД"                         integer,
    "КОМ_ИД"                     integer,
    "ЦД_ИД"                      integer,
    "НОМЕР_В_ЦИКЛЕ"              varchar(8),
    "ДИС_ИД"                     integer,
    "НОМЕР_ДИСЦИПЛИНЫ_ПО_ВЫБОРУ" integer,
    "ПЛАН_ИД"                    integer,
    "КТО_СОЗДАЛ"                 varchar(40),
    "КОГДА_СОЗДАЛ"               timestamp,
    "КТО_ИЗМЕНИЛ"                varchar(40),
    "КОГДА_ИЗМЕНИЛ"              timestamp
);

comment on column "Н_СТРОКИ_ПЛАНОВ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_СТРОКИ_ПЛАНОВ"."КОМ_ИД" is 'Внешний ключ к таблице Н_КОМПОНЕНТЫ';

comment on column "Н_СТРОКИ_ПЛАНОВ"."ЦД_ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_СТРОКИ_ПЛАНОВ"."НОМЕР_В_ЦИКЛЕ" is 'Номер десятичной классификации (01, 02, 02.01)';

comment on column "Н_СТРОКИ_ПЛАНОВ"."ДИС_ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_СТРОКИ_ПЛАНОВ"."НОМЕР_ДИСЦИПЛИНЫ_ПО_ВЫБОРУ" is 'Номер дисциплины в предлагаемой группе выбора';

comment on column "Н_СТРОКИ_ПЛАНОВ"."ПЛАН_ИД" is 'Внешний ключ к таблице Н_ПЛАНЫ';

alter table "Н_СТРОКИ_ПЛАНОВ"
    owner to postgres;

create unique index "СПЛ_PK"
    on "Н_СТРОКИ_ПЛАНОВ" ("ИД");

create unique index "СПЛ_UK"
    on "Н_СТРОКИ_ПЛАНОВ" ("НОМЕР_В_ЦИКЛЕ", "КОМ_ИД", "ЦД_ИД", "ПЛАН_ИД");

create index "СПЛ_ДИС_FK_I"
    on "Н_СТРОКИ_ПЛАНОВ" ("ДИС_ИД");

create index "СПЛ_КОМ_FK_I"
    on "Н_СТРОКИ_ПЛАНОВ" ("КОМ_ИД");

create index "СПЛ_ПЛАН_FK_I"
    on "Н_СТРОКИ_ПЛАНОВ" ("ПЛАН_ИД");

create index "СПЛ_ЦД_FK_I"
    on "Н_СТРОКИ_ПЛАНОВ" ("ЦД_ИД");

grant select on "Н_СТРОКИ_ПЛАНОВ" to public;

create table "Н_ТИПЫ_ВЕДОМОСТЕЙ"
(
    "ИД"            integer,
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ТИПЫ_ВЕДОМОСТЕЙ"."ИД" is 'Уникальный идентификатор';

alter table "Н_ТИПЫ_ВЕДОМОСТЕЙ"
    owner to postgres;

create unique index "ТВ_PK"
    on "Н_ТИПЫ_ВЕДОМОСТЕЙ" ("ИД");

grant select on "Н_ТИПЫ_ВЕДОМОСТЕЙ" to public;

create table "Н_ТИПЫ_ПЛАНОВ"
(
    "ИД"            integer,
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp,
    "КОРОТКОЕ_ИМЯ"  varchar(4)
);

comment on column "Н_ТИПЫ_ПЛАНОВ"."ИД" is 'Уникальный идентификатор';

alter table "Н_ТИПЫ_ПЛАНОВ"
    owner to postgres;

create unique index "ТПЛ_PK"
    on "Н_ТИПЫ_ПЛАНОВ" ("ИД");

grant select on "Н_ТИПЫ_ПЛАНОВ" to public;

create table "Н_ТИПЫ_СТАНДАРТОВ"
(
    "ИД"            integer,
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ТИПЫ_СТАНДАРТОВ"."ИД" is 'Искусственный первичный уникальный идентификатор';

alter table "Н_ТИПЫ_СТАНДАРТОВ"
    owner to postgres;

create unique index "ТС_PK"
    on "Н_ТИПЫ_СТАНДАРТОВ" ("ИД");

grant select on "Н_ТИПЫ_СТАНДАРТОВ" to public;

create table "Н_УЧЕБНЫЕ_ГОДА"
(
    "УЧЕБНЫЙ_ГОД" char(9),
    "НАЧАЛО"      timestamp,
    "КОНЕЦ"       timestamp
);

alter table "Н_УЧЕБНЫЕ_ГОДА"
    owner to postgres;

create unique index "УЧ_ГОД_PK"
    on "Н_УЧЕБНЫЕ_ГОДА" ("УЧЕБНЫЙ_ГОД");

grant select on "Н_УЧЕБНЫЕ_ГОДА" to public;

create table "Н_УЧЕНИКИ"
(
    "ИД"               integer,
    "ЧЛВК_ИД"          integer,
    "ПРИЗНАК"          varchar(10),
    "СОСТОЯНИЕ"        varchar(9),
    "НАЧАЛО"           timestamp,
    "КОНЕЦ"            timestamp,
    "ПЛАН_ИД"          integer,
    "ГРУППА"           varchar(4),
    "П_ПРКОК_ИД"       integer,
    "ВИД_ОБУЧ_ИД"      integer,
    "ПРИМЕЧАНИЕ"       varchar(200),
    "КТО_СОЗДАЛ"       varchar(40),
    "КОГДА_СОЗДАЛ"     timestamp,
    "КТО_ИЗМЕНИЛ"      varchar(40),
    "КОГДА_ИЗМЕНИЛ"    timestamp,
    "КОНЕЦ_ПО_ПРИКАЗУ" timestamp,
    "ВМЕСТО"           integer,
    "В_СВЯЗИ_С"        integer,
    "ТЕКСТ"            varchar(200)
);

comment on column "Н_УЧЕНИКИ"."ИД" is 'Уникальный идентификатор';

comment on column "Н_УЧЕНИКИ"."ЧЛВК_ИД" is 'Внешний ключ к таблице Н_ОБУЧЕНИЯ';

comment on column "Н_УЧЕНИКИ"."ПРИЗНАК" is '(обучен,отчисл,академ,диплом)';

comment on column "Н_УЧЕНИКИ"."СОСТОЯНИЕ" is 'Состояние (проект, утвержден, отменен)';

comment on column "Н_УЧЕНИКИ"."ПЛАН_ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_УЧЕНИКИ"."ГРУППА" is 'Номер студенческой группы';

comment on column "Н_УЧЕНИКИ"."П_ПРКОК_ИД" is 'Внешний ключ к таблице Н_ПУНКТЫ_ПРИКАЗОВ_ОК';

comment on column "Н_УЧЕНИКИ"."ВИД_ОБУЧ_ИД" is 'Внешний ключ к таблице Н_ОБУЧЕНИЯ';

comment on column "Н_УЧЕНИКИ"."ПРИМЕЧАНИЕ" is 'Текст примечания';

comment on column "Н_УЧЕНИКИ"."КОНЕЦ_ПО_ПРИКАЗУ" is 'конец периода действия строки по приказу';

comment on column "Н_УЧЕНИКИ"."ВМЕСТО" is 'ссылка на строку, вместо которой введена текущая';

comment on column "Н_УЧЕНИКИ"."В_СВЯЗИ_С" is 'ид начисления, вызвавшего изменение текущего атрибута конец';

alter table "Н_УЧЕНИКИ"
    owner to postgres;

create unique index "УЧЕН_PK"
    on "Н_УЧЕНИКИ" ("ИД");

create index "УЧЕН_В_СВЯЗИ_С_I"
    on "Н_УЧЕНИКИ" ("В_СВЯЗИ_С");

create index "УЧЕН_ГП_FK_I"
    on "Н_УЧЕНИКИ" ("ГРУППА", "ПЛАН_ИД");

create index "УЧЕН_КОН_I"
    on "Н_УЧЕНИКИ" ("КОНЕЦ");

create index "УЧЕН_НАЧ_I"
    on "Н_УЧЕНИКИ" ("НАЧАЛО");

create index "УЧЕН_ОБУЧ_FK_I"
    on "Н_УЧЕНИКИ" ("ЧЛВК_ИД", "ВИД_ОБУЧ_ИД");

create index "УЧЕН_П_ПРКОК_FK_I"
    on "Н_УЧЕНИКИ" ("П_ПРКОК_ИД");

create index "УЧЕН_ПЛАН_FK_I"
    on "Н_УЧЕНИКИ" ("ПЛАН_ИД");

create index "УЧЕН_ПРИЗНАК_I"
    on "Н_УЧЕНИКИ" ("ПРИЗНАК");

create index "УЧЕН_СОСТОЯНИЕ_I"
    on "Н_УЧЕНИКИ" ("СОСТОЯНИЕ");

grant select on "Н_УЧЕНИКИ" to public;

create table "Н_ФОРМЫ_ОБУЧЕНИЯ"
(
    "ИД"                integer,
    "НАИМЕНОВАНИЕ"      varchar(200),
    "КТО_СОЗДАЛ"        varchar(40),
    "КОГДА_СОЗДАЛ"      timestamp,
    "КТО_ИЗМЕНИЛ"       varchar(40),
    "КОГДА_ИЗМЕНИЛ"     timestamp,
    "ИМЯ_В_ИМИН_ПАДЕЖЕ" varchar(200),
    "ИМЯ_В_РОД_ПАДЕЖЕ"  varchar(200),
    "ИМЯ_В_ДАТ_ПАДЕЖЕ"  varchar(200),
    "ИМЯ_В_ВИН_ПАДЕЖЕ"  varchar(200),
    "ИМЯ_В_ТВОР_ПАДЕЖЕ" varchar(200),
    "ИМЯ_В_ПРЕД_ПАДЕЖЕ" varchar(200)
);

comment on column "Н_ФОРМЫ_ОБУЧЕНИЯ"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ФОРМЫ_ОБУЧЕНИЯ"."НАИМЕНОВАНИЕ" is 'Содержит наименование формы обучения. Например: очная, очно-заочная (вечерняя), заочная и т.п.';

alter table "Н_ФОРМЫ_ОБУЧЕНИЯ"
    owner to postgres;

create unique index "ФО_PK"
    on "Н_ФОРМЫ_ОБУЧЕНИЯ" ("ИД");

grant select on "Н_ФОРМЫ_ОБУЧЕНИЯ" to public;

create table "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ"
(
    "СВР_ИД"        integer,
    "ВР_ИД"         integer,
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ"."СВР_ИД" is 'Внешний ключ к таблице Н_СВОЙСТВА_ВР';

comment on column "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ"."ВР_ИД" is 'Внешний ключ к таблице Н_ВИДЫ_РАБОТ';

alter table "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ"
    owner to postgres;

create unique index "ХВР_PK"
    on "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ" ("СВР_ИД", "ВР_ИД");

create index "ХВР_ВР_FK_I"
    on "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ" ("ВР_ИД");

create index "ХВР_СВР_FK_I"
    on "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ" ("СВР_ИД");

grant select on "Н_ХАРАКТЕРИСТИКИ_ВИДОВ_РАБОТ" to public;

create table "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ"
(
    "ЗНАЧЕНИЕ"      varchar(30),
    "ПРИМЕЧАНИЕ"    varchar(200),
    "СВОТД_ИД"      integer,
    "ОТД_ИД"        integer,
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ"."ПРИМЕЧАНИЕ" is 'Текст примечания';

comment on column "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ"."СВОТД_ИД" is 'Внешний ключ к таблице Н_СВОЙСТВА_ОТДЕЛОВ';

comment on column "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ"."ОТД_ИД" is 'Внешний ключ к таблице Н_ОТДЕЛЫ';

alter table "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ"
    owner to postgres;

create unique index "ХОТД_PK"
    on "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ" ("СВОТД_ИД", "ОТД_ИД");

create index "ХОТД_ОТД_FK_I"
    on "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ" ("ОТД_ИД");

create index "ХОТД_СВОТД_FK_I"
    on "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ" ("СВОТД_ИД");

grant select on "Н_ХАРАКТЕРИСТИКИ_ОТДЕЛОВ" to public;

create table "Н_ЦИКЛЫ_ДИСЦИПЛИН"
(
    "ИД"            integer,
    "АББРЕВИАТУРА"  varchar(8),
    "НАИМЕНОВАНИЕ"  varchar(200),
    "КТО_СОЗДАЛ"    varchar(40),
    "КОГДА_СОЗДАЛ"  timestamp,
    "КТО_ИЗМЕНИЛ"   varchar(40),
    "КОГДА_ИЗМЕНИЛ" timestamp
);

comment on column "Н_ЦИКЛЫ_ДИСЦИПЛИН"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ЦИКЛЫ_ДИСЦИПЛИН"."АББРЕВИАТУРА" is 'АББРЕВИАТУРА цикла дисциплин';

comment on column "Н_ЦИКЛЫ_ДИСЦИПЛИН"."НАИМЕНОВАНИЕ" is 'НАИМЕНОВАНИЕ цикла дисциплин';

alter table "Н_ЦИКЛЫ_ДИСЦИПЛИН"
    owner to postgres;

create unique index "ЦД_PK"
    on "Н_ЦИКЛЫ_ДИСЦИПЛИН" ("ИД");

grant select on "Н_ЦИКЛЫ_ДИСЦИПЛИН" to public;

create table "Н_ЭЛЕМЕНТЫ_СТРОК"
(
    "ИД"             integer,
    "ОТД_ИД"         integer,
    "НОМЕР_СЕМЕСТРА" integer,
    "СПЛ_ИД"         integer,
    "НЕДЕЛЬ"         integer,
    "КТО_СОЗДАЛ"     varchar(40),
    "КОГДА_СОЗДАЛ"   timestamp,
    "КТО_ИЗМЕНИЛ"    varchar(40),
    "КОГДА_ИЗМЕНИЛ"  timestamp
);

comment on column "Н_ЭЛЕМЕНТЫ_СТРОК"."ИД" is 'Искусственный первичный уникальный идентификатор';

comment on column "Н_ЭЛЕМЕНТЫ_СТРОК"."НОМЕР_СЕМЕСТРА" is 'Номер семестра';

comment on column "Н_ЭЛЕМЕНТЫ_СТРОК"."СПЛ_ИД" is 'Внешний ключ к таблице Н_СТРОКИ_ПЛАНОВ';

comment on column "Н_ЭЛЕМЕНТЫ_СТРОК"."НЕДЕЛЬ" is 'Количество недель, отведенное в семестре на теоретическое изучение дисциплины (например, 17)';

alter table "Н_ЭЛЕМЕНТЫ_СТРОК"
    owner to postgres;

create unique index "ЭСТ_PK"
    on "Н_ЭЛЕМЕНТЫ_СТРОК" ("ИД");

create unique index "ЭСТ_UK"
    on "Н_ЭЛЕМЕНТЫ_СТРОК" ("ОТД_ИД", "НОМЕР_СЕМЕСТРА", "СПЛ_ИД", "НЕДЕЛЬ");

create index "ЭСТ_ОТД_FK_I"
    on "Н_ЭЛЕМЕНТЫ_СТРОК" ("ОТД_ИД");

create index "ЭСТ_СЕМЕСТР_I"
    on "Н_ЭЛЕМЕНТЫ_СТРОК" ("НОМЕР_СЕМЕСТРА");

create index "ЭСТ_СПЛ_FK_I"
    on "Н_ЭЛЕМЕНТЫ_СТРОК" ("СПЛ_ИД");

grant select on "Н_ЭЛЕМЕНТЫ_СТРОК" to public;

create function group_average_age(gr_id integer) returns integer
    language plpgsql
as
$$
Begin
    return (
        with ages as (select (date_part('year', age("Н_ЛЮДИ"."ДАТА_РОЖДЕНИЯ"))::int) as age from "Н_УЧЕНИКИ" inner join "Н_ЛЮДИ" on "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД" where "Н_УЧЕНИКИ"."ГРУППА" = gr_id)
        select avg(age) from ages);
End;
$$;

alter function group_average_age(integer) owner to s311769;

create function group_average_age(gr_id character varying) returns integer
    language plpgsql
as
$$
Begin
    return (
        with ages as (select (date_part('year', age("Н_ЛЮДИ"."ДАТА_РОЖДЕНИЯ"))::int) as age from "Н_УЧЕНИКИ" inner join "Н_ЛЮДИ" on "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД" where "Н_УЧЕНИКИ"."ГРУППА" = gr_id)
        select avg(age) from ages);
End;
$$;

alter function group_average_age(varchar) owner to s311769;

create function group_max_age(gr_id integer) returns integer
    language plpgsql
as
$$
Begin
    return (select max(date_part('year', age("Н_ЛЮДИ"."ДАТА_РОЖДЕНИЯ"))::int) from "Н_УЧЕНИКИ" inner join "Н_ЛЮДИ" on "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД" where "Н_УЧЕНИКИ"."ЧЛВК_ИД" = gr_id);
End;
$$;

alter function group_max_age(integer) owner to s311769;

create function group_max_age(gr_id character varying) returns integer
    language plpgsql
as
$$
Begin
    return (
        with ages as (select (date_part('year', age("Н_ЛЮДИ"."ДАТА_РОЖДЕНИЯ"))::int) as age from "Н_УЧЕНИКИ" inner join "Н_ЛЮДИ" on "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД" where "Н_УЧЕНИКИ"."ГРУППА" = gr_id)
        select max(age) from ages);
End;
$$;

alter function group_max_age(varchar) owner to s311769;

create function plan_count(id integer) returns integer
    language plpgsql
as
$$
Begin
    return (select count(*) from "Н_ГРУППЫ_ПЛАНОВ" where "ПЛАН_ИД" = id);
End;
$$;

alter function plan_count(integer) owner to s311769;


