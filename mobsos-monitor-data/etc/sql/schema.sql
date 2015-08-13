drop schema if exists MM_DB_NAME;
create schema if not exists MM_DB_NAME default character set utf8 collate utf8_general_ci;
use MM_DB_NAME;

grant usage on MM_DB_NAME.* to 'MM_DB_USER'@'%' identified by 'MM_DB_PASS'; 
grant all privileges on MM_DB_NAME.* to 'MM_DB_USER'@'%';
grant all on MM_DB_NAME.* to 'MM_DB_USER'@'%';
grant select on OIDC_DB_NAME.* to 'MM_DB_USER'@'%';

create table log (
    id bigint not null auto_increment,
	time datetime not null,
	ip varchar(32) not null,
	user_id varchar(64),
	client_id varchar(64),
	scheme varchar(5) not null,
	host varchar(64) not null,
	method varchar(8) not null,
    uri varchar(256) not null,
    status smallint not null,
    referer varchar(512),
	useragent varchar(512),
	accept varchar(128),
	received_content varchar(64),
	sent_content varchar(64),
	request_length int not null,
	response_length int not null,
	request_time float not null,
    constraint log_pk primary key(id)
);

create table log_header (
    id bigint not null,
    name varchar(64) not null,
    value varchar(512) not null,
    constraint log_header_pk primary key(id,name),
    constraint log_header_fk foreign key(id) references log(id)
);

create table log_query (
    id bigint not null,
    name varchar(64) not null,
    value varchar(512) not null,
    constraint log_query_pk primary key(id,name),
    constraint log_query_fk foreign key(id) references log(id)
);

create table log_ipgeo (
  ip char(17) not null,
  country_code varchar(5) not null,
  country_name varchar(80) not null,
  region_name varchar(80) not null,
  city_name varchar(80) not null,
  zip_code varchar(10) not null,
  lat float(8,5) not null,
  lon float(8,5) not null,
  timezone varchar(10) not null,
  primary key  (ip)
);
