create schema project_gp15_new;
use project_gp15_new;
# first data table
create table global_food_consumption(
entry_code varchar(150) not null primary key,
country varchar(100), 
year int,
population double,
beef_kg_capita double,
pig_kg_capita double,
poultry_kg_capita double,
sheep_kg_capita double,
maize_1000_tonnes double,
rice_1000_tonnes double,
soy_1000_tonnes double,
wheat_1000_tonnes double);
select * from global_food_consumption;
# after data insertion via import wizard
select * from global_food_consumption;
# second data table
create table obesity_prevalence_data(
entry_no int not null primary key,
entry_code varchar(150),
Country varchar(100),
year int,
Obesity double,
sex varchar(50));
select * from obesity_prevalence_data;
# creating RDB
create table country(
select entry_code,
country, 
year,
population
from global_food_consumption);
select * from country;
ALTER TABLE `project_gp15_new`.`country` 
ADD PRIMARY KEY (`entry_code`);
select * from country;
# Segregate meat items in one table
create table global_meat_consumption(
select entry_code,
beef_kg_capita,
pig_kg_capita,
poultry_kg_capita,
sheep_kg_capita
from global_food_consumption);
select * from global_meat_consumption;
# for primary key we inserted GMC_NO in the table
alter table global_meat_consumption
add column gmc_no int not null auto_increment primary key first;
ALTER TABLE `project_gp15_new`.`global_meat_consumption` 
ADD INDEX `entry_code_idx` (`entry_code` ASC) VISIBLE;
;
ALTER TABLE `project_gp15_new`.`global_meat_consumption` 
ADD CONSTRAINT `entry_code`
  FOREIGN KEY (`entry_code`)
  REFERENCES `project_gp15_new`.`country` (`entry_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
select * from global_meat_consumption;
# segregate grain items
create table global_grain_consumption(
select entry_code, 
maize_1000_tonnes,
rice_1000_tonnes,
soy_1000_tonnes,
wheat_1000_tonnes
from global_food_consumption);
select * from global_grain_consumption;
alter table global_grain_consumption
add column ggc_no int not null auto_increment primary key first;
ALTER TABLE `project_gp15_new`.`global_grain_consumption` 
ADD INDEX `entry_code_idx` (`entry_code` ASC) VISIBLE;
;
ALTER TABLE `project_gp15_new`.`global_grain_consumption` 
ADD CONSTRAINT `fk_entry_code`
  FOREIGN KEY (`entry_code`)
  REFERENCES `project_gp15_new`.`country` (`entry_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
select * from global_grain_consumption;
# segregate obesity value for both sex in new table first create view
create or replace view view_both_sex as
select entry_no as both_sex_entry_no,
entry_code,
country,
Obesity,
sex
from obesity_prevalence_data
where sex = 'Both sexes' and year > 1989 and year < 2017;
select * from view_both_sex;
# from view selected common data from both table and created a new RDBMS table
create table obesity_prevalence_data_both_sex(
select both_sex_entry_no,
entry_code,
Obesity,
sex
from view_both_sex
where country = 'Argentina' or country = 'Australia' or country = 'Brazil' or country = 'Canada' or country = 'Chile' or country = 'China' or country = 'Colombia' or country = 'Egypt' or country = 'Ethiopia' or country = 'Indonesia' 
or country = 'India' or country = 'Iran (Islamic Republic of)' or country = 'Israel' or country = 'Japan' or 
country = 'Kazakhstan' or country = 'Republic of Korea' or country = 'Mexico' or country = 'Malaysia' or
 country = 'Nigeria' or country = 'New Zealand' or country = 'Pakistan' or country = 'Peru' or 
 country = 'Philippines'  or country = 'Paraguay' or country = 'Russian Federation' or country = 'Saudi Arabia' 
 or country = 'Thailand' or country = 'Turkey'  or country = 'Ukraine' or country = 'United States of America' 
 or country = 'Viet Nam' or country = 'WLD' or country = 'South Africa');
select * from obesity_prevalence_data_both_sex;
ALTER TABLE `project_gp15_new`.`obesity_prevalence_data_both_sex` 
ADD PRIMARY KEY (`both_sex_entry_no`),
ADD INDEX `entry_code_idx` (`entry_code` ASC) VISIBLE;
;
ALTER TABLE `project_gp15_new`.`obesity_prevalence_data_both_sex` 
ADD CONSTRAINT `fk1_entry_code`
  FOREIGN KEY (`entry_code`)
  REFERENCES `project_gp15_new`.`country` (`entry_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
# segregate obesity value for male in new table first create view
create or replace view view_male as
select entry_no as male_entry_no,
entry_code,
country,
Obesity,
sex
from obesity_prevalence_data
where sex = 'Male' and year > 1989 and year < 2017;
select * from view_male;
# from view selected common data from both table and created a new RDBMS table
create table obesity_prevalence_data_male(
select male_entry_no,
entry_code,
Obesity,
sex
from view_male
where country = 'Argentina' or country = 'Australia' or country = 'Brazil' or country = 'Canada' or country = 'Chile' or country = 'China' or country = 'Colombia' or country = 'Egypt' or country = 'Ethiopia' or country = 'Indonesia' 
or country = 'India' or country = 'Iran (Islamic Republic of)' or country = 'Israel' or country = 'Japan' or 
country = 'Kazakhstan' or country = 'Republic of Korea' or country = 'Mexico' or country = 'Malaysia' or
 country = 'Nigeria' or country = 'New Zealand' or country = 'Pakistan' or country = 'Peru' or 
 country = 'Philippines'  or country = 'Paraguay' or country = 'Russian Federation' or country = 'Saudi Arabia' 
 or country = 'Thailand' or country = 'Turkey'  or country = 'Ukraine' or country = 'United States of America' 
 or country = 'Viet Nam' or country = 'WLD' or country = 'South Africa');
select * from obesity_prevalence_data_male;
ALTER TABLE `project_gp15_new`.`obesity_prevalence_data_male` 
ADD PRIMARY KEY (`male_entry_no`),
ADD INDEX `entry_code_idx` (`entry_code` ASC) VISIBLE;
;
ALTER TABLE `project_gp15_new`.`obesity_prevalence_data_male` 
ADD CONSTRAINT `fk2_entry_code`
  FOREIGN KEY (`entry_code`)
  REFERENCES `project_gp15_new`.`country` (`entry_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
# segregate obesity value for female in new table first create view
create or replace view view_female as
select entry_no as female_entry_no,
entry_code,
country,
Obesity,
sex
from obesity_prevalence_data
where sex = 'Female' and year > 1989 and year < 2017;
select * from view_female;
# from view selected common data from both table and created a new RDBMS table
create table obesity_prevalence_data_female(
select female_entry_no,
entry_code,
Obesity,
sex
from view_female
where country = 'Argentina' or country = 'Australia' or country = 'Brazil' or country = 'Canada' or country = 'Chile' or country = 'China' or country = 'Colombia' or country = 'Egypt' or country = 'Ethiopia' or country = 'Indonesia' 
or country = 'India' or country = 'Iran (Islamic Republic of)' or country = 'Israel' or country = 'Japan' or 
country = 'Kazakhstan' or country = 'Republic of Korea' or country = 'Mexico' or country = 'Malaysia' or
 country = 'Nigeria' or country = 'New Zealand' or country = 'Pakistan' or country = 'Peru' or 
 country = 'Philippines'  or country = 'Paraguay' or country = 'Russian Federation' or country = 'Saudi Arabia' 
 or country = 'Thailand' or country = 'Turkey'  or country = 'Ukraine' or country = 'United States of America' 
 or country = 'Viet Nam' or country = 'WLD' or country = 'South Africa');
select * from obesity_prevalence_data_female;
ALTER TABLE `project_gp15_new`.`obesity_prevalence_data_female` 
ADD PRIMARY KEY (`female_entry_no`),
ADD INDEX `entry_code_idx` (`entry_code` ASC) VISIBLE;
;
ALTER TABLE `project_gp15_new`.`obesity_prevalence_data_female` 
ADD CONSTRAINT `fk3_entry_code`
  FOREIGN KEY (`entry_code`)
  REFERENCES `project_gp15_new`.`country` (`entry_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
# created test view for visualization
CREATE or replace VIEW test_view AS
SELECT global_meat_consumption.entry_code, global_meat_consumption.beef_kg_capita, obesity
FROM obesity_prevalence_data_female
JOIN  global_meat_consumption ON obesity_prevalence_data_female.entry_code = global_meat_consumption.entry_code;
select * from 
country;

CREATE or replace VIEW grain_view AS
SELECT 
    ggc.entry_code,
    (ggc.maize_1000_tonnes + ggc.rice_1000_tonnes + ggc.soy_1000_tonnes) * 1000000 / (c.population * 1000000) AS total_grain
FROM 
    global_grain_consumption ggc
JOIN 
    country c ON ggc.entry_code = c.entry_code;
    
select * from meat_consumption;
CREATE or replace VIEW final_view AS
SELECT m.entry_code, m.total_meat, g.total_grain, f.Obesity AS obesity_female, male.Obesity AS obesity_male
FROM meat_consumption AS m , grain_view as g
JOIN view_female AS f ON m.entry_code = f.entry_code
JOIN view_male AS male ON m.entry_code = male.entry_code;


CREATE OR REPLACE VIEW final_view AS
SELECT m.entry_code, m.total_meat, g.total_grain, f.Obesity AS obesity_female, male.Obesity AS obesity_male
FROM meat_consumption AS m 
JOIN grain_view AS g ON m.entry_code = g.entry_code
JOIN view_female AS f ON m.entry_code = f.entry_code
JOIN view_male AS male ON m.entry_code = male.entry_code
ORDER BY m.entry_code ASC;

select * from final_viewfinal_viewfinal_viewfinal_viewfinal_view;


