create table estadoclimatologico(
    id int AUTO_INCREMENT,
    fecha varchar(20),
    nubosidad varchar(20),
    pluviometria int,
    observaciones nvarchar(2000),
    idresponsable int,
    primary key(id)
);




create table rotacion(
    id int AUTO_INCREMENT,
    nombre varchar(50),
    cantvacas int,
    idresponsable int,
    primary key(id)
);



create table potrero(
    id int AUTO_INCREMENT,
    numero int,
    area int,
    observacion varchar(2000),
    idrotacion int,
    idresponsable int,
    primary key(id),
    foreign key (idrotacion) references rotacion(id)
);




create table aforo(
    id int AUTO_INCREMENT,
    fecha varchar(20),
    idpotrero int,
    pastoalto double,
    pastobajo double,
    pastomedio int,
    lancealto int,
    lancemedio int,
    lancebajo int,
    cantlances int,
    pesopastoalto int,
    pesopastobajo int,
    pesopastomedio int,
    cantpasto int,
    porcentajealtro int,
    porcentajemedio int,
    porcentajebajo int,
    totalmetrocuadrado int,
    cantpastopotrero int,
    tiempopotrero int,
    observaciones varchar(2000),
    idresponsable int,
    primary key(id),
    foreign key (idpotrero) references potrero(id)
);



create table sexo_vaca(
    id int AUTO_INCREMENT,
    nombre nvarchar(20),
    observaciones nvarchar(2000),
    primary key(id)
);

insert into sexo_vaca(nombre,observaciones) values ('Hembra','');
insert into sexo_vaca(nombre,observaciones) values ('Macho','');


create table raza_vaca(
    id int AUTO_INCREMENT,
    nombre nvarchar(20),
    observaciones nvarchar(2000),
    primary key(id)
);


insert into raza_vaca(nombre,observaciones) values ('Gyrolando','');
insert into raza_vaca(nombre,observaciones) values ('Sueca Roja-y-Blanca','');


create table tipo_animal(
    id int AUTO_INCREMENT,
    nombre nvarchar(20),
    observaciones nvarchar(2000),
    primary key(id)
);


insert into tipo_animal(nombre,observaciones) values ('Vaca','');
insert into tipo_animal(nombre,observaciones) values ('Novilla','');
insert into tipo_animal(nombre,observaciones) values ('Becerro macho','');
insert into tipo_animal(nombre,observaciones) values ('Ternera','');
insert into tipo_animal(nombre,observaciones) values ('Toro reproductor','');


select * 
from sexo_vaca;


update vaca
set sexo = '2'
where sexo = 'Macho'


select distinct raza 
from vaca;


update vaca
set raza = '2'
where raza = 'Sueca Roja-y-Blanca'



select distinct tipoanimal 
from vaca;


update vaca
set tipoanimal = '5'
where tipoanimal = 'Toro reproductor'


ALTER TABLE vaca
ADD CONSTRAINT vaca_raza_fk
FOREIGN KEY (raza) REFERENCES raza_vaca(id);


ALTER TABLE vaca
ADD CONSTRAINT vaca_sexo_fk
FOREIGN KEY (sexo) REFERENCES sexo_vaca(id);


ALTER TABLE vaca
ADD CONSTRAINT vaca_tipoanimal_fk
FOREIGN KEY (tipoanimal) REFERENCES tipo_animal(id);





DELIMITER //
CREATE PROCEDURE listvaca(iduser int)
    COMMENT 'Procedimiento que lista las vacas'
BEGIN
   select id,numero,nombre,idrotacion,sexo,raza,tipoanimal,edad,idresponsable
   from vaca
   order by id;
END//

DELIMITER ;




DELIMITER //
CREATE PROCEDURE listrotacion(iduser int)
    COMMENT 'Procedimiento que lista las rotaciones'
BEGIN
   select id,nombre,cantvacas,idresponsable
   from rotacion
   order by id;
END//

DELIMITER ;