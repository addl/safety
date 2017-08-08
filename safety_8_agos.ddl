CREATE SEQUENCE seq_safety_user;
CREATE SEQUENCE seq_role;
CREATE SEQUENCE seq_privilege;
CREATE SEQUENCE seq_charge;
CREATE SEQUENCE seq_business_line;
CREATE SEQUENCE seq_insurance_company;
CREATE SEQUENCE seq_insurance_broker;
CREATE SEQUENCE seq_executive;
CREATE SEQUENCE seq_phone;
CREATE SEQUENCE seq_sinister;
CREATE SEQUENCE seq_insured_person;
CREATE SEQUENCE seq_process_state_type;
CREATE SEQUENCE seq_insurance_type;
CREATE SEQUENCE seq_document;
CREATE SEQUENCE seq_affair;
CREATE SEQUENCE seq_state_changed;
CREATE SEQUENCE seq_department;
CREATE SEQUENCE seq_province;
CREATE SEQUENCE seq_district;
CREATE SEQUENCE seq_Log;
CREATE SEQUENCE seq_general_config;
CREATE SEQUENCE seq_password_reset_token;
CREATE SEQUENCE seq_safety_file;
CREATE SEQUENCE seq_assignment;
CREATE SEQUENCE seq_interaction;
CREATE TABLE safety_user (
  id              int4 NOT NULL, 
  business_lineid int4 NOT NULL, 
  dni             varchar(255) NOT NULL UNIQUE, 
  username        varchar(255) NOT NULL UNIQUE, 
  password        varchar(255) NOT NULL, 
  firstname       varchar(255) NOT NULL, 
  lastname        varchar(255) NOT NULL, 
  email           varchar(255) NOT NULL UNIQUE, 
  tariff_per_hour int4 NOT NULL, 
  enabled         bool NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE role (
  id          int4 NOT NULL, 
  name        varchar(255) NOT NULL UNIQUE, 
  description varchar(255), 
  PRIMARY KEY (id));
CREATE TABLE privilege (
  id   int4 NOT NULL, 
  name varchar(255) NOT NULL UNIQUE, 
  PRIMARY KEY (id));
CREATE TABLE role_privilege (
  roleid      int4 NOT NULL, 
  privilegeid int4 NOT NULL, 
  PRIMARY KEY (roleid, 
  privilegeid));
CREATE TABLE charge (
  id     int4 NOT NULL, 
  name   varchar(255) NOT NULL, 
  enable bool, 
  PRIMARY KEY (id));
CREATE TABLE business_line (
  id            int4 NOT NULL, 
  name          varchar(255) NOT NULL, 
  contact       varchar(255) NOT NULL, 
  contact_email varchar(255) NOT NULL, 
  enabled       bool NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE insurance_company (
  id            int4 NOT NULL, 
  code          varchar(255) NOT NULL UNIQUE, 
  name          varchar(255) NOT NULL, 
  ruc           varchar(255) NOT NULL, 
  social_reason varchar(255), 
  enabled       bool, 
  PRIMARY KEY (id));
CREATE TABLE insurance_broker (
  id            int4 NOT NULL, 
  code          varchar(255) NOT NULL, 
  name          varchar(255) NOT NULL, 
  ruc           varchar(255) NOT NULL, 
  social_reason varchar(255), 
  enabled       bool, 
  PRIMARY KEY (id));
CREATE TABLE executive (
  id                  int4 NOT NULL, 
  insurance_companyid int4 NOT NULL, 
  firstname           varchar(255) NOT NULL, 
  lastname            varchar(255), 
  email               varchar(255) NOT NULL, 
  phone               varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE phone (
  id     int4 NOT NULL, 
  number varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE sinister (
  id                             int4 NOT NULL, 
  internal_code                  varchar(255) NOT NULL, 
  insurance_companyid            int4 NOT NULL, 
  company_reference_number       varchar(255) NOT NULL UNIQUE, 
  insurance_brokerid             int4 NOT NULL, 
  broker_reference_number        varchar(255) NOT NULL, 
  bussines_line_reference_number varchar(255) NOT NULL, 
  insured_personid               int4 NOT NULL, 
  description                    varchar(255), 
  "date"                         timestamp NOT NULL, 
  cause                          varchar(255) NOT NULL, 
  well_affected                  varchar(255), 
  place                          varchar(255) NOT NULL, 
  reserve                        int4 NOT NULL, 
  observation                    varchar(255), 
  districtid                     int4 NOT NULL, 
  contact_name                   varchar(255) NOT NULL, 
  contact_email                  varchar(255) NOT NULL, 
  contact_phone                  varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE insured_person (
  id                     int4 NOT NULL, 
  insurance_companyid    int4 NOT NULL, 
  insurance_brokerid     int4 NOT NULL, 
  insurance_typeid       numeric(19, 0) NOT NULL, 
  dni                    varchar(255) NOT NULL UNIQUE, 
  firstname              varchar(255) NOT NULL, 
  lastname               varchar(255), 
  insurance_company_code varchar(255) NOT NULL, 
  insurance_number       varchar(255) NOT NULL UNIQUE, 
  policy                 varchar(255) NOT NULL, 
  enabled                bool, 
  PRIMARY KEY (id));
CREATE TABLE process_state_type (
  id   int4 NOT NULL, 
  name varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE insurance_type (
  id   numeric(19, 0) NOT NULL, 
  name varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE document (
  id             numeric(19, 0) NOT NULL, 
  sinisterid     int4 NOT NULL, 
  description    varchar(255), 
  receiving_date date NOT NULL, 
  required       bool NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE affair (
  id                   int4 NOT NULL, 
  business_lineid      int4 NOT NULL, 
  safety_userid        int4 NOT NULL, 
  sinisterid           int4 NOT NULL, 
  registred_date       date NOT NULL, 
  observation          varchar(255), 
  consumed_hours       int4 NOT NULL, 
  process_state_typeid int4 NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE state_changed (
  id          int4 NOT NULL, 
  affairid    int4 NOT NULL, 
  description varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE department (
  id   int4 NOT NULL, 
  name varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE province (
  id           int4 NOT NULL, 
  departmentid int4 NOT NULL, 
  name         varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE district (
  id         int4 NOT NULL, 
  provinceid int4 NOT NULL, 
  name       varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE safety_user_role (
  safety_userid int4 NOT NULL, 
  roleid        int4 NOT NULL, 
  PRIMARY KEY (safety_userid, 
  roleid));
CREATE TABLE Log (
  id               numeric(19, 0) NOT NULL, 
  "date"           timestamp NOT NULL, 
  user_id          numeric(19, 0) NOT NULL, 
  action           varchar(255) NOT NULL, 
  acceded_resource varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE general_config (
  id                numeric(19, 0) NOT NULL, 
  save_logs_into_db bool NOT NULL, 
  smtp_server       varchar(255) NOT NULL, 
  smtp_user         varchar(255) NOT NULL, 
  smtp_password     varchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE password_reset_token (
  id            numeric(19, 0) NOT NULL, 
  safety_userid int4 NOT NULL, 
  token         text NOT NULL, 
  expiryDate    date NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE safety_file (
  id            numeric(19, 0) NOT NULL, 
  documentid    numeric(19, 0), 
  path          text, 
  interactionid numeric(19, 0), 
  PRIMARY KEY (id));
CREATE TABLE assignment (
  id          numeric(19, 0) NOT NULL, 
  affairid    int4 NOT NULL, 
  executiveid int4 NOT NULL, 
  "date"      date NOT NULL, 
  observation text NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE interaction (
  id          numeric(19, 0) NOT NULL, 
  sinisterid  int4 NOT NULL, 
  type        varchar(255) NOT NULL, 
  description varchar(255) NOT NULL, 
  "date"      timestamp NOT NULL, 
  PRIMARY KEY (id));
ALTER TABLE role_privilege ADD CONSTRAINT FKrole_privi226758 FOREIGN KEY (roleid) REFERENCES role (id);
ALTER TABLE role_privilege ADD CONSTRAINT FKrole_privi14742 FOREIGN KEY (privilegeid) REFERENCES privilege (id);
ALTER TABLE sinister ADD CONSTRAINT FKsinister359425 FOREIGN KEY (insurance_companyid) REFERENCES insurance_company (id);
ALTER TABLE insured_person ADD CONSTRAINT FKinsured_pe198703 FOREIGN KEY (insurance_companyid) REFERENCES insurance_company (id);
ALTER TABLE document ADD CONSTRAINT FKdocument784262 FOREIGN KEY (sinisterid) REFERENCES sinister (id);
ALTER TABLE affair ADD CONSTRAINT FKaffair858947 FOREIGN KEY (sinisterid) REFERENCES sinister (id);
ALTER TABLE state_changed ADD CONSTRAINT FKstate_chan974178 FOREIGN KEY (affairid) REFERENCES affair (id);
ALTER TABLE insured_person ADD CONSTRAINT FKinsured_pe166602 FOREIGN KEY (insurance_brokerid) REFERENCES insurance_broker (id);
ALTER TABLE executive ADD CONSTRAINT FKexecutive587215 FOREIGN KEY (insurance_companyid) REFERENCES insurance_company (id);
ALTER TABLE insured_person ADD CONSTRAINT FKinsured_pe318466 FOREIGN KEY (insurance_typeid) REFERENCES insurance_type (id);
ALTER TABLE affair ADD CONSTRAINT FKaffair921160 FOREIGN KEY (process_state_typeid) REFERENCES process_state_type (id);
ALTER TABLE sinister ADD CONSTRAINT FKsinister672675 FOREIGN KEY (insurance_brokerid) REFERENCES insurance_broker (id);
ALTER TABLE sinister ADD CONSTRAINT FKsinister879454 FOREIGN KEY (insured_personid) REFERENCES insured_person (id);
ALTER TABLE province ADD CONSTRAINT FKprovince117548 FOREIGN KEY (departmentid) REFERENCES department (id);
ALTER TABLE district ADD CONSTRAINT FKdistrict207040 FOREIGN KEY (provinceid) REFERENCES province (id);
ALTER TABLE sinister ADD CONSTRAINT FKsinister931642 FOREIGN KEY (districtid) REFERENCES district (id);
ALTER TABLE safety_user_role ADD CONSTRAINT FKsafety_use988633 FOREIGN KEY (safety_userid) REFERENCES safety_user (id);
ALTER TABLE safety_user_role ADD CONSTRAINT FKsafety_use958432 FOREIGN KEY (roleid) REFERENCES role (id);
ALTER TABLE password_reset_token ADD CONSTRAINT FKpassword_r738859 FOREIGN KEY (safety_userid) REFERENCES safety_user (id);
ALTER TABLE affair ADD CONSTRAINT FKaffair428050 FOREIGN KEY (safety_userid) REFERENCES safety_user (id);
ALTER TABLE safety_file ADD CONSTRAINT FKsafety_fil509310 FOREIGN KEY (documentid) REFERENCES document (id) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE assignment ADD CONSTRAINT FKassignment629856 FOREIGN KEY (affairid) REFERENCES affair (id);
ALTER TABLE assignment ADD CONSTRAINT FKassignment414580 FOREIGN KEY (executiveid) REFERENCES executive (id);
ALTER TABLE safety_file ADD CONSTRAINT FKsafety_fil980556 FOREIGN KEY (interactionid) REFERENCES interaction (id) ON UPDATE Cascade ON DELETE Cascade;
ALTER TABLE interaction ADD CONSTRAINT FKinteractio600582 FOREIGN KEY (sinisterid) REFERENCES sinister (id);
ALTER TABLE safety_user ADD CONSTRAINT FKsafety_use109765 FOREIGN KEY (business_lineid) REFERENCES business_line (id);
ALTER TABLE affair ADD CONSTRAINT FKaffair677489 FOREIGN KEY (business_lineid) REFERENCES business_line (id);
