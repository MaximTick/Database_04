USE master;
CREATE DATABASE TMPT_UNIVER;

USE TMPT_UNIVER
GO

DROP DATABASE TMPT_UNIVEER;
DROP DATABASE TICK_UNIVER;
use master;
go
CREATE DATABASE TICK_UNIVER;

--on primary
--(name= N'UNIVER_mdf', filename = N'C:\UNIVER\UNIVER_mdf.mdf', 
--   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
--filegroup G1
--(name= 'X_UNIVER11_ndf',filename=N'C:\UNIVER\Х_UNIVER11.ndf', size=10Mb,maxsize=15Mb,filegrowth=1Mb),
--(name= 'X_UNIVER12_ndf',filename=N'C:\UNIVER\Х_UNIVER12.ndf', size=2Mb,maxsize=5Mb,filegrowth=1Mb),
--filegroup G2
--(name= 'X_UNIVER21_ndf',filename=N'C:\UNIVER\Х_UNIVER21.ndf', size=5Mb,maxsize=10Mb,filegrowth=1Mb),
--(name= 'X_UNIVER22_ndf',filename=N'C:\UNIVER\Х_UNIVER22.ndf', size=2Mb,maxsize=5Mb,filegrowth=1Mb)
--log on
--( name = N'UNIVER_log', filename=N'C:\UNIVER\X_UNIVER.ldf',       
--   size=5Mb,  maxsize=UNLIMITED, filegrowth=1Mb)
--    go




CREATE TABLE [FACULTY] (FACULTY nvarchar(10) not null constraint FACULTY_PK primary key,
						FACULTY_NAME nvarchar(50) default '???');
GO

CREATE TABLE [PROFESSION] (PROFESSION nvarchar(20) not null constraint PROFESSION_PK primary key,
						   FACULTY nvarchar(10) not null,
						   PROFESSION_NAME nvarchar(100) null,
						   QUALIFICATION nvarchar(50) null);
GO

CREATE TABLE [PULPIT](PULPIT nvarchar(20) not null constraint PULPIT_PK primary key,
					  PULPIT_NAME nvarchar(100) null,
					  FACULTY nvarchar(10) not null constraint FACULTY_FK foreign key references FACULTY(FACULTY));
GO

CREATE TABLE [TEACHER](TEACHER nvarchar(10) not null constraint TEACHER_PK primary key,
					   TEACHER_NAME nvarchar(100) null,
					   GENDER  nvarchar(1) check (GENDER in('м','ж')),
					   PULPIT nvarchar(20) not null constraint PULPIT_FK foreign key references PULPIT(PULPIT));
GO

CREATE TABLE [SUBJECT] ([SUBJECT] nvarchar(10) not null constraint SUBJECT_PK primary key,
						SUBJECT_NAME nvarchar(100) not null unique,
						PULPIT nvarchar(20) not null  constraint PULPIT_FK2 foreign key references PULPIT(PULPIT));
GO	

CREATE TABLE [AUDITORIUM_TYPE](AUDITORIUM_TYPE nvarchar(10) not null constraint AUDITORIUM_TYPE_PK primary key,
							   AUDITORIUM_TYPENAME nvarchar(30) null)
GO

CREATE TABLE [AUDITORIUM](AUDITORIUM nvarchar(20) constraint AUDITORIUM_PK primary key,
						  AUDITORIUM_TYPE nvarchar(10) not null  
						  constraint AUDITORIUM_TYPE_FK foreign key references AUDITORIUM_TYPE(AUDITORIUM_TYPE),
						  AUDITORIUM_CAPACITY int default 1 check (AUDITORIUM_CAPACITY between 1 and 300),
						  AUDITORIUM_NAME nvarchar(50) null);
GO

create table GROUPS 
( IDGROUP     integer  identity(1,1) constraint GROUP_PK  primary key,              
 FACULTY     NVARCHAR(10) constraint  GROUPS_FACULTY_FK foreign key         
                      references FACULTY(FACULTY), 
 PROFESSION  NVARCHAR(20) constraint  GROUPS_PROFESSION_FK foreign key         
                      references PROFESSION(PROFESSION),
 YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  );


INSERT INTO AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )   
     VALUES ('ЛК', 'Лекционная'),
			('ЛБ-К', 'Компьютерный класс'),
			('ЛК-К', 'Лекционная с уст. проектором'),
			('ЛБ-X','Химическая лаборатория'),
			('ЛБ-СК',   'Спец. компьютерный класс')
GO

INSERT INTO  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
VALUES  ('206-1', '206-1','ЛБ-К', 15),
		('301-1',   '301-1', 'ЛБ-К', 15),
		('236-1',   '236-1', 'ЛК',   60),
		('313-1',   '313-1', 'ЛК-К',   60),
		('324-1',   '324-1', 'ЛК-К',   50),
		('413-1',   '413-1', 'ЛБ-К', 15),
		('423-1',   '423-1', 'ЛБ-К', 90),
		('408-2',   '408-2', 'ЛК',  90),
		('103-4',   '103-4', 'ЛК',  90),
		('105-4',   '105-4', 'ЛК',  90),
		('107-4',   '107-4', 'ЛК',  90),
		('110-4',   '110-4', 'ЛК',  30),
		('111-4',   '111-4', 'ЛК',  30),
		('114-4',   '114-4', 'ЛК-К',  90 )
GO

INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
             VALUES  ('ИДиП',   'Издателькое дело и полиграфия');
INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
            VALUES  ('ХТиТ',   'Химическая технология и техника');
INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
            VALUES  ('ЛХФ',     'Лесохозяйственный факультет');
INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
            VALUES  ('ИЭФ',     'Инженерно-экономический факультет');
INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
            VALUES  ('ТТЛП',    'Технология и техника лесной промышленности');
INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
            VALUES  ('ТОВ',     'Технология органических веществ');
INSERT INTO FACULTY   (FACULTY,   FACULTY_NAME )
            VALUES  ('ИТ',     'Факультет информационных технологий');
go

insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    
 values    ('ИДиП',  '1-40 01 02',   'Информационные системы и техноло-гии', 
			'инженер-программист-системотехник' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    
 values    ('ИДиП',  '1-47 01 01', 'Издательское дело', 'редактор-технолог' );

 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    
 values    ('ИДиП',  '1-36 06 01',  'Полиграфическое оборудование и си-стемы обработки информации', 'инженер-электромеханик' );                     

 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  
 values    ('ХТиТ',  '1-36 01 08',    
			'Конструирование и производство из-делий из композиционных материалов', 'инженер-механик' );

 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      
 values    ('ХТиТ',  '1-36 07 01',  
 'Машины и аппараты химических производств и предприятий строительных материалов', 'инженер-механик' );

 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ЛХФ',  '1-75 01 01',      'Лесное хозяйство', 'инженер лесного хозяйства' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-75 02 01',   'Садово-парковое строительство', 'инже-нер садово-паркового строительства' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-89 02 02',     'Туризм и природопользование', 'специ-алист в сфере туризма' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ИЭФ',  '1-25 01 07',  'Экономика и управление на предприятии', 'экономист-менеджер' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ИЭФ',  '1-25 01 08',    'Бухгалтерский учет, анализ и аудит', 'экономист' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('ТТЛП',  '1-36 05 01',   'Машины и оборудование лесного ком-плекса', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('ТТЛП',  '1-46 01 01',      'Лесоинженерное дело', 'инженер-технолог' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('ТОВ',  '1-48 01 02',  'Химическая технология органических веществ, материалов и изделий', 'инженер-химик-технолог' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('ТОВ',  '1-48 01 05',    'Химическая технология переработки древесины', 'инженер-химик-технолог' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-54 01 03',   'Физико-химические методы и приборы контроля качества продукции', 'инженер по сертификации' );
 GO

 insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('ИСиТ', 'Информационных систем и технологий ','ИДиП'  )
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY )
values  ('ПОиСОИ','Полиграфического оборудования и систем обработки инфор-мации ', 'ИДиП'  )
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY )
  values  ('БФ', 'Белорусской филологии','ИДиП'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
   values  ('РИТ', 'Редакционно-издательских тенологий', 'ИДиП'  )            
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY )
   values  ('ПП', 'Полиграфических производств','ИДиП'  )                              
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
    values  ('ЛВ', 'Лесоводства','ЛХФ')          
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
  values  ('ОВ', 'Охотоведения','ЛХФ')    
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
   values  ('ЛУ', 'Лесоустройства','ЛХФ')           
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
  values  ('ЛЗиДВ', 'Лесозащиты и древесиноведения','ЛХФ')                
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY)
   values  ('ЛКиП', 'Лесных культур и почвоведения','ЛХФ') 
insert into PULPIT   (PULPIT,  PULPIT_NAME,FACULTY)
   values  ('ТиП', 'Туризма и природопользования','ЛХФ')              
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
   values  ('ЛПиСПС','Ландшафтного проектирования и садово-паркового строи-тельства','ЛХФ')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТЛ', 'Транспорта леса', 'ТТЛП')                          
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
   values  ('ЛМиЛЗ','Лесных машин и технологии лесозаготовок','ТТЛП')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТДП','Технологий деревообрабатывающих производств', 'ТТЛП')   
insert into PULPIT   (PULPIT,PULPIT_NAME, FACULTY)
values  ('ТиДИД','Технологии и дизайна изделий из древесины','ТТЛП')    
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
values  ('ОХ', 'Органической химии','ТОВ') 
insert into PULPIT   (PULPIT,PULPIT_NAME,FACULTY)
values  ('ТНХСиППМ','Технологии нефтехимического синтеза и переработки по-лимерных материалов','ТОВ')
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
 values  ('ХПД','Химической переработки древесины','ТОВ')             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии ','ХТиТ') 
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
 values  ('ХТЭПиМЭЕ','Химии, технологии электрохимических производств и мате-риалов электронной техники',  'ХТиТ')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('МиАХиСП','Машин и аппаратов химических и силикатных произ-водств', 'ХТиТ')               
insert into PULPIT   (PULPIT, PULPIT_NAME,FACULTY)
    values  ('ПиАХП','Процессов и аппаратов химических производств','ХТиТ')                                               
insert into PULPIT   (PULPIT,    PULPIT_NAME,FACULTY)
values  ('ЭТиМ',    'Экономической теории и маркетинга','ИЭФ')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('МиЭП',   'Менеджмента и экономики природопользования','ИЭФ')   
insert into PULPIT   (PULPIT,    PULPIT_NAME,FACULTY)
   values  ('СБУАиА', 'Статистики, бухгалтерского учета, анализа и аудита', 'ИЭФ') 
   GO  

insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('СМЛВ',    'Смелов Владимир Владиславович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('АКНВЧ',    'Акунович Станислав Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('КЛСНВ',    'Колесников Виталий Леонидович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('БРКВЧ',    'Бракович Андрей Игоревич', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('ДТК',     'Дятко Александр Аркадьевич', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('УРБ',     'Урбанович Павел Павлович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                      values  ('ГРН',     'Гурин Николай Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('ЖЛК',     'Жиляк Надежда Александровна',  'ж', 'ИСиТ');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('МРЗ',     'Мороз Елена Станиславовна',  'ж',   'ИСиТ');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
             values  ('БРТШВЧ',   'Барташевич Святослав Александрович', 'м','ПОиСОИ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('АРС',     'Арсентьев Виталий Арсентьевич', 'м', 'ПОиСОИ');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('БРНВСК',   'Барановский Станислав Иванович', 'м', 'ЭТиМ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER,PULPIT )
                       values  ('НВРВ',   'Неверов Александр Васильевич', 'м', 'МиЭП');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('РВКЧ',   'Ровкач Андрей Иванович', 'м', 'ОВ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('ДМДК', 'Демидко Марина Николаевна',  'ж',  'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('БРГ',     'Бурганская Татьяна Минаевна', 'ж', 'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('МШКВСК',   'Машковский Владимир Петрович', 'м', 'ЛУ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER,PULPIT )
                       values  ('АТР',      'Атрощенко Олег Александрович', 'м', 'ЛУ');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('РЖК',   'Рожков Леонид Николаевич ', 'м', 'ЛВ');                      
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('ЗВГЦВ',   'Звягинцев Вячеслав Борисович', 'м', 'ЛЗиДВ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('БЗБРДВ',   'Безбородов Владимир Степанович', 'м', 'ОХ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER,PULPIT )
                       values  ('НСКВЦ',   'Насковец Михаил Трофимович', 'м', 'ТЛ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('МХВ',   'Мохов Сергей Петрович', 'м', 'ЛМиЛЗ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('ЕЩНК',   'Ещенко Людмила Семеновна',  'ж', 'ТНВиОХТ');                       

GO
 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('СУБД',   'Системы управления базами данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('БД',     'Базы данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ИНФ',    'Информационные технологии','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПСП',    'Программирование сетевых приложений','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('МСОИ',  'Моделирование систем обработки информации', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПИС',     'Проектирование информационных систем','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КГ',      'Компьютерная геометрия ','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
           values ('ПМАПЛ',   'Полиграф. машины, автоматы и поточные линии', 'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КМС',     'Компьютерные мультимедийные системы', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОПП',     'Организация полиграф. производства', 'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('ДМ',   'Дискретная математика', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('МП',   'Математическое программирование','ИСиТ');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('ЛЭВМ', 'Логические основы ЭВМ',  'ИСиТ');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('ООП',  'Объектно-ориентированное программирование', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭП', 'Экономика природопользования','МиЭП')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭТ', 'Экономическая теория','ЭТиМ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('БЛЗиПсOO','Биология лесных зверей и птиц с осн. охотов.','ОВ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОСПиЛПХ','Основы садово-паркового и лесопаркового хозяйства',  'ЛПиСПС')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ИГ', 'Инженерная геодезия ','ЛУ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ЛВ',    'Лесоводство', 'ЛЗиДВ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОХ',    'Органическая химия', 'ОХ')   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТРИ',    'Технология резиновых изделий','ТНХСиППМ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ВТЛ',    'Водный транспорт леса','ТЛ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТиОЛ',   'Технология и оборудование лесозаготовок', 'ЛМиЛЗ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТОПИ',   'Технология обогащения полезных ископаемых ','ТНВиОХТ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ПЭХ',    'Прикладная электрохимия','ХТЭПиМЭЕ')   
GO

insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ИДиП','1-40 01 02', 2013), --1
                ('ИДиП','1-40 01 02', 2012),
                ('ИДиП','1-40 01 02', 2011),
                ('ИДиП','1-40 01 02', 2010),
                ('ИДиП','1-47 01 01', 2013),---5 гр
                ('ИДиП','1-47 01 01', 2012),
                ('ИДиП','1-47 01 01', 2011),
                ('ИДиП','1-36 06 01', 2010),-----8 гр
                ('ИДиП','1-36 06 01', 2013),
                ('ИДиП','1-36 06 01', 2012),
                ('ИДиП','1-36 06 01', 2011),
                ('ХТиТ','1-36 01 08', 2013),---12 гр                                                  
                ('ХТиТ','1-36 01 08', 2012),
                ('ХТиТ','1-36 07 01', 2011),
                ('ХТиТ','1-36 07 01', 2010),
                ('ТОВ','1-48 01 02', 2012), ---16 гр 
                ('ТОВ','1-48 01 02', 2011),
                ('ТОВ','1-48 01 05', 2013),
                ('ТОВ','1-54 01 03', 2012),
                ('ЛХФ','1-75 01 01', 2013),--20 гр      
                ('ЛХФ','1-75 02 01', 2012),
                ('ЛХФ','1-75 02 01', 2011),
                ('ЛХФ','1-89 02 02', 2012),
                ('ЛХФ','1-89 02 02', 2011),  
                ('ТТЛП','1-36 05 01', 2013),
                ('ТТЛП','1-36 05 01', 2012),
                ('ТТЛП','1-46 01 01', 2012),--27 гр
                ('ИЭФ','1-25 01 07', 2013), 
                ('ИЭФ','1-25 01 07', 2012),     
                ('ИЭФ','1-25 01 07', 2010),
                ('ИЭФ','1-25 01 08', 2013),
                ('ИЭФ','1-25 01 08', 2012) ---32 гр    
GO
-----------------------------------------------------------
------Создание и заполнение таблицы STUDENT
create table STUDENT 
( IDSTUDENT   integer  identity(1000,1) constraint STUDENT_PK  primary key,
 IDGROUP     integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
 NAME     nvarchar(100), 
 BDAY     date,
 STAMP    timestamp,
 INFO     xml,
 FOTO     varbinary
 ) 
insert into STUDENT (IDGROUP,NAME, BDAY)
        values (1, 'Хартанович Екатерина Александровна','11.03.1995'),        
          (1, 'Горбач Елизавета Юрьевна',    '07.12.1995'),
           (1, 'Зыкова Кристина Дмитриевна',  '12.10.1995'),
           (1, 'Борисевич Ольга Анатольевна', '09.11.1995'),
           (1, 'Медведева Мария Андреевна',   '04.07.1995'),
           (1, 'Шенец Екатерина Сергеевна',   '08.01.1995'),
           (1, 'Шитик Алина Игоревна',        '02.08.1995')       
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (2, 'Силюк Валерия Ивановна',         '12.07.1994'),
           (2, 'Сергель Виолетта Николаевна',    '06.03.1994'),
           (2, 'Добродей Ольга Анатольевна',     '09.11.1994'),
           (2, 'Подоляк Мария Сергеевна',        '04.10.1994'),
           (2, 'Никитенко Екатерина Дмитриевна', '08.01.1994'),
           (3, 'Яцкевич Галина Иосифовна',       '02.08.1993'),
           (3, 'Осадчая Эла Васильевна',         '07.12.1993'),
           (3, 'Акулова Елена Геннадьевна',      '02.12.1993'),
           (3, 'Муковозчик Надежда Вячеславовна','09.11.1993'),
           (3, 'Войтко Елена Андреевна',         '04.07.1993'),
           (4, 'Плешкун Милана Анатольевна',     '08.03.1992'),
           (4, 'Буянова Мария Александровна',    '02.06.1992'),
           (4, 'Харченко Елена Геннадьевна',     '11.12.1992'),
           (4, 'Крученок Евгений Александрович', '11.05.1992'),
           (4, 'Бороховский Виталий Петрович',   '09.11.1992'),
           (4, 'Мацкевич Надежда Валерьевна',    '01.11.1992'),
           (5, 'Логинова Мария Вячеславовна',    '08.07.1995'),
           (5, 'Белько Наталья Николаевна',      '02.11.1995'),
           (5, 'Селило Екатерина Геннадьевна',   '07.05.1995'),
           (5, 'Свирский Михаил Марьянович',     '04.06.1995'),
           (5, 'Шамко Дмитрий Дмитриевич',       '09.09.1995'),
           (5, 'Дрозд Анастасия Андреевна',      '04.08.1995'),
           (6, 'Козловская Елена Евгеньевна',    '08.11.1994'),
           (6, 'Потапнин Кирилл Олегович',       '02.03.1994'),
           (6, 'Равковская Ольга Николаевна',    '04.06.1994'),
           (6, 'Ходоронок Александра Вадимовна', '09.11.1994'),
           (6, 'Рамук Владислав Юрьевич',        '04.07.1994'),
           (7, 'Неруганенок Мария Владимировна', '03.01.1993'),
           (7, 'Цыганок Анна Петровна',          '12.09.1993'),
           (7, 'Масилевич Оксана Игоревна',      '12.06.1993'),
           (7, 'Алексиевич Елизавета Викторовна','09.02.1993'),
           (7, 'Ватолин Максим Андреевич',       '04.07.1993'),
           (8, 'Синица Валерия Андреевна',       '08.01.1992'),
           (8, 'Кудряшова Алина Николаевна',     '12.05.1992'),
           (8, 'Мигулина Елена Леонидовна',      '08.11.1992'),
           (8, 'Шпиленя Алексей Сергеевич',      '12.03.1992'),
           (8, 'Ребко Светлана Сергеевна',       '10.01.1992'),
           (8, 'Ершов Юрий Олегович',            '12.07.1992'),
           (9, 'Астафьев Игорь Александрович',   '10.08.1995'),
           (9, 'Гайтюкевич Андрей Игоревич',     '02.05.1995'),
           (9, 'Рученя Наталья Александровна',   '08.01.1995'),
           (9, 'Тарасевич Анастасия Ивановна',   '11.09.1995'),
           (9, 'Скурат Наталья Ивановна',        '08.04.1995'),
           (9, 'Волосюк Николай Александрович',  '09.06.1995'),
           (10, 'Жоглин Николай Владимирович',   '08.01.1994'),
           (10, 'Санько Андрей Дмитриевич',      '11.09.1994'),
           (10, 'Пещур Анна Александровна',      '06.04.1994'),
           (10, 'Бучалис Никита Леонидович',     '12.08.1994'),
           (10, 'Трацевский Виктор Сергеевич',   '05.01.1994'),
           (10, 'Гамеза Денис Валерьевич',       '11.02.1994')           
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (11, 'Лавренчук Владислав Николаевич','07.11.1993'),
           (11, 'Власик Евгения Викторовна',     '04.06.1993'),
           (11, 'Абрамов Денис Дмитриевич',      '10.12.1993'),
           (11, 'Оленчик Сергей Николаевич',     '04.07.1993'),
           (11, 'Савинко Павел Андреевич',       '08.01.1993'),
           (11, 'Бакун Алексей Викторович',      '02.09.1993'),
           (12, 'Бань Сергей Анатольевич',       '11.12.1995'),
           (12, 'Сечейко Илья Александрович',    '10.06.1995'),
           (12, 'Кузмичева Анна Андреевна',      '09.08.1995'),
           (12, 'Бурко Диана Францевна',         '04.07.1995'),
           (12, 'Даниленко Максим Васильевич',   '08.03.1995'),
           (12, 'Зизюк Ольга Олеговна',          '12.09.1995'),
           (13, 'Шарапо Мария Владимировна',     '08.10.1994'),
           (13, 'Касперович Вадим Викторович',   '10.02.1994'),
           (13, 'Чупрыгин Арсений Александрович','11.11.1994'),
           (13, 'Воеводская Ольга Леонидовна',   '10.02.1994'),
           (13, 'Метушевский Денис Игоревич',    '12.01.1994'),
           (14, 'Ловецкая Валерия Александровна','11.09.1993'),
           (14, 'Дворак Антонина Николаевна',    '01.12.1993'),
           (14, 'Щука Татьяна Николаевна',       '09.06.1993'),
           (14, 'Коблинец Александра Евгеньевна','05.01.1993'),
           (14, 'Фомичевская Елена Эрнестовна',  '01.07.1993'),
           (15, 'Бесараб Маргарита Вадимовна',   '07.04.1992'),
           (15, 'Бадуро Виктория Сергеевна',     '10.12.1992'),
           (15, 'Тарасенко Ольга Викторовна',    '05.05.1992'),
           (15, 'Афанасенко Ольга Владимировна', '11.01.1992'),
           (15, 'Чуйкевич Ирина Дмитриевна',     '04.06.1992'),
           (16, 'Брель Алеся Алексеевна',        '08.01.1994'),
           (16, 'Кузнецова Анастасия Андреевна', '07.02.1994'),
           (16, 'Томина Карина Геннадьевна',     '12.06.1994'),
           (16, 'Дуброва Павел Игоревич',        '03.07.1994'),
           (16, 'Шпаков Виктор Андреевич',       '04.07.1994'),
           (17, 'Шнейдер Анастасия Дмитриевна',  '08.11.1993'),
           (17, 'Шыгина Елена Викторовна',       '02.04.1993'),
           (17, 'Клюева Анна Ивановна',          '03.06.1993'),
           (17, 'Доморад Марина Андреевна',      '05.11.1993'),
           (17, 'Линчук Михаил Александрович',   '03.07.1993'),
           (18, 'Васильева Дарья Олеговна',      '08.01.1995'),
           (18, 'Щигельская Екатерина Андреевна','06.09.1995'),
           (18, 'Сазонова Екатерина Дмитриевна', '08.03.1995'),
           (18, 'Бакунович Алина Олеговна',      '07.08.1995'),
           (18, 'Тарасова Дарья Николаевна',     '08.01.1995'),
           (18, 'Матиевская Анна Сергеевна',     '02.05.1995'),
           (19, 'Урбан Наталья Евгеньевна',      '08.06.1994'),
           (19, 'Никитенко Диана Валерьевна',    '08.07.1994'),
           (19, 'Черканович Дарья Леонидовна',   '03.10.1994'),
           (19, 'Торговцева Елена Михайловна',   '02.10.1994'),
           (19, 'Прокопчук Юлия Васильевна',     '01.10.1994'),
           (20, 'Протосюк Вероника Николаевна',  '07.03.1995'),
           (20, 'Нагорский Алексей Олегович',    '03.09.1995'),
           (20, 'Архипова Янина Игоревна',       '07.04.1995'),
           (20, 'Воробей Елена Сергеевна',       '08.06.1995')


------Создание и заполнение таблицы PROGRESS
create table PROGRESS
 ( [SUBJECT]   NVARCHAR(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
 IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
 PDATE    date, 
 NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('ОАиП', 1000,  '01.10.2013',6),
           ('ОАиП', 1001,  '01.10.2013',8),
           ('ОАиП', 1002,  '01.10.2013',7),
           ('ОАиП', 1003,  '01.10.2013',5),
           ('ОАиП', 1005,  '01.10.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values   ('СУБД', 1014,  '01.12.2013',5),
           ('СУБД', 1015,  '01.12.2013',9),
           ('СУБД', 1016,  '01.12.2013',5),
           ('СУБД', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('КГ',   1018,  '06.5.2013',4),
           ('КГ',   1019,  '06.05.2013',7),
           ('КГ',   1020,  '06.05.2013',7),
           ('КГ',   1021,  '06.05.2013',9),
           ('КГ',   1022,  '06.05.2013',5),
           ('КГ',   1023,  '06.05.2013',6)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('ОХ',   1064,  '01.1.2013',6),
           ('ОХ',   1065,  '01.1.2013',4),
           ('ОХ',   1066,  '01.1.2013',9),
           ('ОХ',   1067,  '01.1.2013',5),
           ('ОХ',   1068,  '01.1.2013',8),
           ('ОХ',   1069,  '01.1.2013',4)
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('ЭТ',   1055,  '01.1.2013',7),
           ('ЭТ',   1056,  '01.1.2013',8),
           ('ЭТ',   1057,  '01.1.2013',9),
           ('ЭТ',   1058,  '01.1.2013',4),
           ('ЭТ',   1059,  '01.1.2013',5)