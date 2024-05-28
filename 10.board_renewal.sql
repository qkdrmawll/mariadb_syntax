CREATE table author (
id int primary key auto_increment, 
name varchar(255),
email varchar(255) not null unique, 
created_time datetime default current_timestamp);

CREATE table post (
id int primary key auto_increment,
title varchar(255) not null,
contents varchar(3000));

CREATE table author_post (
id int primary key auto_increment,
author_id int not null,
post_id int not null,
foreign key(author_id) references author(id) on delete cascade on update cascade,
foreign key(post_id) references post(id) on delete cascade on update cascade) ;

CREATE table author_address (
id int primary key auto_increment,
city varchar(255),
street varchar(255),
author_id int not null unique,
foreign key(author_id) references author(id));