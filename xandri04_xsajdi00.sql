-- Retezec Multikin, Peter Andris - xandri04, Michal Sajdik - xsajdi00

DROP TABLE Kino CASCADE CONSTRAINTS;
DROP TABLE Sal CASCADE CONSTRAINTS;
DROP TABLE Projekcia CASCADE CONSTRAINTS;
DROP TABLE Film CASCADE CONSTRAINTS;
DROP TABLE Rezervacie CASCADE CONSTRAINTS;
DROP TABLE Sedadla CASCADE CONSTRAINTS;
DROP TABLE Vip CASCADE CONSTRAINTS;
DROP TABLE Public_ CASCADE CONSTRAINTS;
DROP TABLE Vstupenka CASCADE CONSTRAINTS;
DROP TABLE Zamestnanec CASCADE CONSTRAINTS;
DROP TABLE Prebieha CASCADE CONSTRAINTS;
DROP TABLE Vytvorit CASCADE CONSTRAINTS;
DROP TABLE Znaci CASCADE CONSTRAINTS;
DROP TABLE Rezervovanie CASCADE CONSTRAINTS;
DROP SEQUENCE Id_zamestnanec_auto;

CREATE TABLE Kino (
    Nazov VARCHAR(50) NOT NULL,
    Adresa VARCHAR(50),
    Otvaraci_cas_od VARCHAR(25),
    Otvaraci_cas_do VARCHAR(25),
    Pocet_salov NUMBER
);

CREATE TABLE Sal (
    Id_salu NUMBER NOT NULL,
    Nazov VARCHAR(50) NOT NULL
);



CREATE TABLE Projekcia (
    Id_projekcie NUMBER NOT NULL,
    Cas timestamp,
    Id_filmu NUMBER NOT NULL
);


CREATE TABLE Prebieha (
    Id_salu NUMBER NOT NULL,
    Id_projekcie NUMBER NOT NULL
);

CREATE TABLE Film (
    Id_filmu NUMBER NOT NULL,
    Nazov VARCHAR(50),
    Zaner VARCHAR(25),
    Reziser VARCHAR(50),
    Scenar VARCHAR(250)
);

CREATE TABLE Rezervacie (
    Id_rezervacie NUMBER NOT NULL,
    Meno VARCHAR(50),
    Priezvisko VARCHAR(50),
    Email VARCHAR(50),
    Sal NUMBER
);


CREATE TABLE Vytvorit (
    Id_projekcie NUMBER NOT NULL,
    Id_rezervacie NUMBER NOT NULL
);

CREATE TABLE Sedadla (
    Id_sedadla NUMBER NOT NULL,
    Rada VARCHAR(50),
    Poradove_cislo NUMBER,
    Id_salu NUMBER NOT NULL
);

CREATE TABLE Vip (
    Id_sedadla NUMBER NOT NULL,
    Typ_sedenia VARCHAR(50)
);


CREATE TABLE Public_ (
    Id_sedadla NUMBER NOT NULL,
    Typ_sedenia VARCHAR(50)
);

CREATE TABLE Vstupenka (
    Id_vstupenky NUMBER NOT NULL,
    Cena NUMBER,
    Cas_premietania date,
    Vek_kupujuceho NUMBER,
    Id_zamestnanca NUMBER NOT NULL
);

CREATE TABLE Zamestnanec (
    Id_zamestnanca NUMBER NOT NULL,
    Meno VARCHAR(50),
    Priezvisko VARCHAR(50),
    Email VARCHAR(50),
    Adresa VARCHAR(50),
    Login VARCHAR(50),
    Heslo VARCHAR(50),
    Rodne_cislo VARCHAR(50),
    Typ_zamestnanca VARCHAR(50)
);

CREATE TABLE Znaci (
    Id_sedadla NUMBER NOT NULL,
    Id_vstupenky NUMBER NOT NULL
);

CREATE TABLE Rezervovanie (
    Id_sedadla NUMBER NOT NULL,
    Id_rezervacie NUMBER NOT NULL
);

ALTER TABLE Kino ADD CONSTRAINT PK_kino PRIMARY KEY (Nazov);
ALTER TABLE Sal ADD CONSTRAINTS PK_sal PRIMARY KEY (Id_salu);
ALTER TABLE Projekcia ADD CONSTRAINTS PK_projekcia PRIMARY KEY (Id_projekcie);
ALTER TABLE Film ADD CONSTRAINTS PK_film PRIMARY KEY (Id_filmu);
ALTER TABLE Rezervacie ADD CONSTRAINTS PK_rezervacie PRIMARY KEY (Id_rezervacie);
ALTER TABLE Sedadla ADD CONSTRAINTS PK_sedadla PRIMARY KEY (Id_sedadla);
ALTER TABLE Vip ADD CONSTRAINTS PK_vip PRIMARY KEY (Id_sedadla);
ALTER TABLE Public_ ADD CONSTRAINTS PK_public PRIMARY KEY (Id_sedadla);
ALTER TABLE Vstupenka ADD CONSTRAINTS PK_vstupenka PRIMARY KEY (Id_vstupenky);
ALTER TABLE Zamestnanec ADD CONSTRAINTS PK_zamestanec PRIMARY KEY (Id_zamestnanca);

ALTER TABLE Prebieha ADD CONSTRAINTS PK_prebieha PRIMARY KEY (Id_salu, Id_projekcie);
ALTER TABLE Vytvorit ADD CONSTRAINTS PK_vytvorit PRIMARY KEY (Id_projekcie, Id_rezervacie);
ALTER TABLE Znaci ADD CONSTRAINTS PK_znaci PRIMARY KEY (Id_sedadla, Id_vstupenky);
ALTER TABLE Rezervovanie ADD CONSTRAINTS PK_rezervovanie PRIMARY KEY (Id_sedadla, Id_rezervacie);
---------------------------------------------------------------------------------------------------
ALTER TABLE Prebieha ADD CONSTRAINTS FK_salu FOREIGN KEY (Id_salu) REFERENCES Sal ON DELETE CASCADE;
ALTER TABLE Prebieha ADD CONSTRAINTS FK_projekcie FOREIGN KEY (Id_projekcie) REFERENCES Projekcia ON DELETE CASCADE;

ALTER TABLE Vytvorit ADD CONSTRAINTS FK_projekciu FOREIGN KEY (Id_projekcie) REFERENCES Projekcia ON DELETE CASCADE;
ALTER TABLE Vytvorit ADD CONSTRAINTS FK_rezervacie FOREIGN KEY (Id_rezervacie) REFERENCES Rezervacie ON DELETE CASCADE;

ALTER TABLE Znaci ADD CONSTRAINTS FK_sedadla FOREIGN KEY (Id_sedadla) REFERENCES Sedadla ON DELETE CASCADE;
ALTER TABLE Znaci ADD CONSTRAINTS FK_vstupenky FOREIGN KEY (Id_vstupenky) REFERENCES Vstupenka ON DELETE CASCADE;

ALTER TABLE Rezervovanie ADD CONSTRAINTS FK_rezervujeme_sedadlo FOREIGN KEY (Id_sedadla) REFERENCES Sedadla ON DELETE CASCADE;
ALTER TABLE Rezervovanie ADD CONSTRAINTS FK_rezervujeme_rezervaciu FOREIGN KEY (Id_rezervacie) REFERENCES Rezervacie ON DELETE CASCADE;

ALTER TABLE Vip ADD CONSTRAINTS FK_typ_vip FOREIGN KEY (Id_sedadla) REFERENCES Sedadla;
ALTER TABLE Public_ ADD CONSTRAINTS FK_typ_public FOREIGN KEY (Id_sedadla) REFERENCES Sedadla;

ALTER TABLE Projekcia ADD CONSTRAINTS FK_projekcia FOREIGN KEY (Id_filmu) REFERENCES Film;

ALTER TABLE Sal ADD CONSTRAINTS FK_sal FOREIGN KEY (Nazov) REFERENCES Kino;

ALTER TABLE Sedadla ADD CONSTRAINTS FK_sedadla_pro_sal FOREIGN KEY (Id_salu) REFERENCES Sal;

ALTER TABLE Vstupenka ADD CONSTRAINTS FK_vstupenka FOREIGN KEY (Id_zamestnanca) REFERENCES Zamestnanec;

--vkladanie do tabuliek--
--1 OK
INSERT INTO Kino
 (Nazov, Adresa, Otvaraci_cas_od, Otvaraci_cas_do, Pocet_salov) VALUES('Sal_A','Bratislava, 45','8:00', '23:00', '6');
INSERT INTO Kino
 (Nazov, Adresa, Otvaraci_cas_od, Otvaraci_cas_do, Pocet_salov) VALUES('Sal_B','Ko?ice, 852','10:00', '23:00', '3');
INSERT INTO Kino
 (Nazov, Adresa, Otvaraci_cas_od, Otvaraci_cas_do, Pocet_salov) VALUES('Sal_C','Brno, 666','8:00', '23:00', '5');
INSERT INTO Kino
 (Nazov, Adresa, Otvaraci_cas_od, Otvaraci_cas_do, Pocet_salov) VALUES('Sal_D','Praha, 173','8:00', '23:00', '8');
INSERT INTO Kino
 (Nazov, Adresa, Otvaraci_cas_od, Otvaraci_cas_do, Pocet_salov) VALUES('Sal_E','Myjava, 10','11:00', '22:00', '1');
--2 OK
INSERT INTO Sal (Id_salu, Nazov) VALUES('00001', 'Sal_A');
INSERT INTO Sal (Id_salu, Nazov) VALUES('00002', 'Sal_B');
INSERT INTO Sal (Id_salu, Nazov) VALUES('00003', 'Sal_C');
INSERT INTO Sal (Id_salu, Nazov) VALUES('00004', 'Sal_D');
--3 OK

INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00001','Deadpool','Ak?n?','Tim Miller','Rhett Reese,Paul Wernick');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00002', 'Batman sa vracia', 'Ak?n?', 'Tim Burton', 'Daniel Waters');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00003', 'Pir?ti z Karibiku: Prekliatie ?iernej perly', 'Dobrodru?n?', 'Gore Verbinski', 'Ted Elliott, Terry Rossio');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00004', 'Nehanebn? bastardi', 'V?le?n?', 'Quentin Tarantino', 'Quentin Tarantino');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00005', 'Divok? Django', 'Western', 'Quentin Tarantino', 'Quentin Tarantino');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00006', 'Na hrane zajtraj?ka', 'Sci-Fi', 'Doug Liman', 'Christopher McQuarrie, Jez Butterworth, John-Henry Butterworth');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00007','AAAAAAAA','Akcny','Miller','Rhett Reese,Paul Wernick');
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00008', 'BBBBBBBB', 'Akcny', 'Miller', 'Daniel Waters');
--6

INSERT INTO Projekcia (Id_projekcie, Cas, Id_filmu) VALUES('00001', TO_TIMESTAMP ('10-Sep 14:10', 'DD-Mon HH24:MI'), '00001');
INSERT INTO Projekcia (Id_projekcie, Cas, Id_filmu) VALUES('00002', TO_TIMESTAMP ('10-Sep 14:10', 'DD-Mon HH24:MI'), '00002');
INSERT INTO Projekcia (Id_projekcie, Cas, Id_filmu) VALUES('00003', TO_TIMESTAMP ('10-Sep 14:10', 'DD-Mon HH24:MI'), '00003');
INSERT INTO Projekcia (Id_projekcie, Cas, Id_filmu) VALUES('00004', TO_TIMESTAMP ('10-Sep 14:10', 'DD-Mon HH24:MI'), '00004');
--5

INSERT INTO Prebieha (Id_salu, Id_projekcie) VALUES('00001', '00001');
INSERT INTO Prebieha (Id_salu, Id_projekcie) VALUES('00002', '00002');
INSERT INTO Prebieha (Id_salu, Id_projekcie) VALUES('00003', '00003');
INSERT INTO Prebieha (Id_salu, Id_projekcie) VALUES('00004', '00004');
--4 OK

INSERT INTO Rezervacie (Id_rezervacie, Meno, Priezvisko, Email, Sal) VALUES('00001', 'Peter', 'Andris', 'peter_andris@gmail.com', '00001');
INSERT INTO Rezervacie (Id_rezervacie, Meno, Priezvisko, Email, Sal) VALUES('00002', 'Richard', 'Smol?k', 'richard_smol?k@gmail.com', '00001');
INSERT INTO Rezervacie (Id_rezervacie, Meno, Priezvisko, Email, Sal) VALUES('00003', 'Roberto', 'Fico', 'roberto_fico@gmail.com', '00002');
--8 OK

INSERT INTO Vytvorit (Id_projekcie, Id_rezervacie) VALUES('00001', '00001');
INSERT INTO Vytvorit (Id_projekcie, Id_rezervacie) VALUES('00001', '00002');
--7


INSERT INTO Sedadla (Id_sedadla, Rada, Poradove_cislo, Id_salu) VALUES('00001', '5', '12', '00001');
INSERT INTO Sedadla (Id_sedadla, Rada, Poradove_cislo, Id_salu) VALUES('00003', '1', '1', '00001');
INSERT INTO Sedadla (Id_sedadla, Rada, Poradove_cislo, Id_salu) VALUES('00002', '5', '2', '00003');
INSERT INTO Sedadla (Id_sedadla, Rada, Poradove_cislo, Id_salu) VALUES('00004', '8', '8', '00003');
INSERT INTO Sedadla (Id_sedadla, Rada, Poradove_cislo, Id_salu) VALUES('00005', '7', '8', '00003');
--10 OK

INSERT INTO Rezervovanie (Id_sedadla, Id_rezervacie) VALUES('00001', '00001');
INSERT INTO Rezervovanie (Id_sedadla, Id_rezervacie) VALUES('00002', '00002');
INSERT INTO Rezervovanie (Id_sedadla, Id_rezervacie) VALUES('00003', '00003');
--9 OK
INSERT INTO Public_ (Id_sedadla, Typ_sedenia) VALUES('00001', 'jednomiestne');
INSERT INTO Public_ (Id_sedadla, Typ_sedenia) VALUES('00002', 'dvojmiestne');
INSERT INTO Public_ (Id_sedadla, Typ_sedenia) VALUES('00003', 'dvojmiestne');
INSERT INTO Public_ (Id_sedadla, Typ_sedenia) VALUES('00004', 'jednomiestne');
--11 OK
INSERT INTO Vip (Id_sedadla, Typ_sedenia) VALUES('00005', 'jednomiestne');
--12 OK

--13 OK
INSERT INTO Zamestnanec (Id_zamestnanca, Meno, Priezvisko, Email, Adresa, Login, Heslo, Rodne_cislo, Typ_zamestnanca) VALUES('00001', 'Peter', 'Andris', 'peter_ondris55@gmail.com','123 6th St.
Melbourne, FL 32904','peter01','heslo1','8802012131','predajca na pokladni');
INSERT INTO Zamestnanec (Id_zamestnanca, Meno, Priezvisko, Email, Adresa, Login, Heslo, Rodne_cislo, Typ_zamestnanca) VALUES('00002', 'Martin', 'Chlebk', 'martin_chlebik12@gmail.com','4 Goldfield Rd.
Honolulu, HI 96815','martin02','heslo2','8802012131','predajca na pokladni');
INSERT INTO Zamestnanec (Id_zamestnanca, Meno, Priezvisko, Email, Adresa, Login, Heslo, Rodne_cislo, Typ_zamestnanca) VALUES('00003', 'Dominik', 'Kukuka', 'dominik_kukucka45@gmail.com','4 Goldfield Rd.
Honolulu, HI 96814','login12','heslo2','8802012131','predajca online');
INSERT INTO Zamestnanec (Id_zamestnanca, Meno, Priezvisko, Email, Adresa, Login, Heslo, Rodne_cislo, Typ_zamestnanca) VALUES('00004', 'Peter', 'Huhu', 'hu@hu.hu','12d3 6th St.
Melbourne, FL 32954','peter01','heslo5','8802012131','predajca online');

INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00001', '10', TO_TIMESTAMP ('15-Sep 14:00', 'DD-Mon HH24:MI'), '15', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00002', '19', TO_TIMESTAMP ('10-Jan 10:00', 'DD-Mon HH24:MI'), '35', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00003', '15', TO_TIMESTAMP ('20-Sep 20:00', 'DD-Mon HH24:MI'), '16', '00002');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00004', '10', TO_TIMESTAMP ('15-Sep 14:00', 'DD-Mon HH24:MI'), '15', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00005', '19', TO_TIMESTAMP ('10-Jan 10:00', 'DD-Mon HH24:MI'), '35', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00006', '15', TO_TIMESTAMP ('20-Sep 20:00', 'DD-Mon HH24:MI'), '16', '00002');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00007', '10', TO_TIMESTAMP ('15-Sep 14:00', 'DD-Mon HH24:MI'), '15', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00008', '19', TO_TIMESTAMP ('10-Jan 10:00', 'DD-Mon HH24:MI'), '35', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00009', '15', TO_TIMESTAMP ('20-Sep 20:00', 'DD-Mon HH24:MI'), '16', '00002');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00010', '10', TO_TIMESTAMP ('15-Sep 14:00', 'DD-Mon HH24:MI'), '15', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00011', '19', TO_TIMESTAMP ('10-Jan 10:00', 'DD-Mon HH24:MI'), '35', '00001');
INSERT INTO Vstupenka (Id_vstupenky, Cena, Cas_premietania, Vek_kupujuceho, Id_zamestnanca) VALUES('00012', '15', TO_TIMESTAMP ('20-Sep 20:00', 'DD-Mon HH24:MI'), '16', '00002');
--14 OK

INSERT INTO Znaci (Id_sedadla, Id_vstupenky) VALUES('00001', '00001');
INSERT INTO Znaci (Id_sedadla, Id_vstupenky) VALUES('00002', '00002');
INSERT INTO Znaci (Id_sedadla, Id_vstupenky) VALUES('00003', '00003');

-------------------------------------------------------------------------------
----------------------------SELECTY---------------------------------------------
-------------------------------------------------------------------------------

-- 2 tabulky spojene
-- vypise zoznam kin podla nazvu a k nim ukaze, ake sali maju
SELECT K.nazov, S.Id_salu
    FROM KINO K, SAL S
    WHERE K.nazov = S.nazov;

-- 2 tabulky spojene
-- vypisanie, ktore sedadlo patri, ktorej vstupenke
SELECT V.Id_vstupenky, Z.Id_sedadla
    FROM ZNACI Z, VSTUPENKA V
    WHERE Z.Id_vstupenky = V.Id_vstupenky;

-- 3 tabulky spojene
-- pre koho je sedadlo rezervovane, a vsetky udaje k tomu
SELECT *
    FROM SEDADLA S, REZERVOVANIE R, REZERVACIE P
    WHERE S.Id_sedadla = R.Id_sedadla AND R.Id_rezervacie = P.Id_rezervacie;

-- COUNT - GROUP BY
-- pocet sedadiel v danom sale
SELECT Id_salu, COUNT(Id_sedadla) AS Pocet_Sedadiel
    FROM SEDADLA
    GROUP BY Id_salu;

-- AVG - GROUP BY
-- priemerna cena vstupenky podla predaja zamestnanca
SELECT Id_zamestnanca, AVG(cena) AS Priemerna_cena
    FROM VSTUPENKA
    GROUP BY Id_zamestnanca;

-- EXISTS
-- informacie o zamestnancoch, ktory predali listok osobe mladsej ako 18
SELECT *
    FROM ZAMESTNANEC
    WHERE EXISTS (SELECT vek_kupujuceho FROM VSTUPENKA WHERE ZAMESTNANEC.ID_ZAMESTNANCA = ID_ZAMESTNANCA AND vek_kupujuceho < 18 );

-- IN
-- vypise zamestnancou, ktory maju rezervaciu
-- rozhoduje podla mena a priezviska
SELECT *
    FROM ZAMESTNANEC
    WHERE priezvisko IN (SELECT priezvisko FROM REZERVACIE) AND meno IN (SELECT meno FROM REZERVACIE);

--- Pokrocile databazove objekty
SET serveroutput ON;

--- Trigger na kontrolu rodneho cisla
CREATE OR REPLACE TRIGGER Kontrola_rodneho_cisla
	BEFORE INSERT OR UPDATE OF Rodne_cislo ON Zamestnanec
  FOR EACH ROW
DECLARE
    Rodne_cislo Zamestnanec.Rodne_cislo%TYPE;
    Rok VARCHAR2(2); 
    Mesiac VARCHAR2(2);
    Den VARCHAR2(2);
BEGIN
    Rodne_cislo := :NEW.Rodne_cislo;

    IF (LENGTH(Rodne_cislo) < 9 OR LENGTH(Rodne_cislo) > 10) THEN 
        raise_application_error(-20001, 'Rodne cislo neobsahuje spravny pocet cisiel!');
    END IF;

    -- Prvých šes èísel popisuje dátum narodenia vo formáte "rrmmdd" 
    Rok := SUBSTR(Rodne_cislo, 1, 2); -- rr
    Mesiac := SUBSTR(Rodne_cislo, 3, 2); -- mm
    Den := SUBSTR(Rodne_cislo, 5, 2); -- dd

    IF (mesiac > 50) THEN -- ženy neni èo doda :D
          mesiac := mesiac - 50;
    ELSE IF (mesiac > 20) THEN
          mesiac := mesiac - 20;
    END IF;
    END IF;

    IF (mesiac <= 0 OR mesiac > 12) THEN  -- Kontrola mesiacu
         raise_application_error(-20002, 'Neplatny datum v rodnom cisle');
    END IF;

    IF (den <= 0) THEN -- Kontrola dna... ostatne sa kontroluju v zavislosti na mesiaci
         raise_application_error(-20002, 'Neplatny datum v rodnom cisle');
    END IF;

    IF (mesiac = 2 AND MOD(rok, 4) = 0 AND (den > 29)) THEN -- Kontrola februara podla toho ci je prestupny rok
         raise_application_error(-20002, 'Neplatny datum  v rodnom cisle');
    END IF;

    IF (mesiac = 2 AND MOD(rok, 4) != 0 AND (den > 28)) THEN -- Kontrola februara podla toho ci nie je prestupny rok 
         raise_application_error(-20002, 'Neplatny datum  v rodnom cisle');
    END IF;

    IF ((mesiac = 1 OR mesiac = 3 OR mesiac = 5 OR mesiac = 7 OR mesiac = 8 OR mesiac = 10 OR mesiac = 12) AND den > 31) THEN 
         raise_application_error(-20002, 'Neplatny datum  v rodnom cisle');
    END IF;

    IF ((mesiac = 4 OR mesiac = 6 OR mesiac = 9 OR mesiac = 11) AND den > 30) THEN 
         raise_application_error(-20002, 'Neplatny datum v rodnom cisle');
    END IF;

    IF (LENGTH(Rodne_cislo) = 9 AND SUBSTR(Rodne_cislo, 7, 3) = '000') THEN 
         raise_application_error(-20003, 'Nespravna koncovka 000 v rodnom cisle');
    END IF;

    IF (MOD(Rodne_cislo, 11) != 0) THEN  -- Kontrola delitelnosti 11
         raise_application_error(-20004, 'Nespravne rodne cislo, nie je delitelne 11');
    END IF;
END;
/
--- Test kontroly rodneho cisla
/* INSERT INTO Zamestnanec (Id_zamestnanca, Meno, Priezvisko, Email, Adresa, Login, Heslo, Rodne_cislo, Typ_zamestnanca) VALUES('00005', 'Pekter', 'Andrjis', 'pketer_ondris55@gmail.com','123 6th St.
Meblbourne, FL 32504','pe5er01','he5lo1','9704302917','predajca na pokladni'); */

-----------------Triger na autoinkrementaciu idciek---------------
CREATE SEQUENCE Id_zamestnanec_auto; --uchovava posledne id
CREATE OR REPLACE TRIGGER Autoincrement
  BEFORE INSERT ON Zamestnanec
  FOR EACH ROW
BEGIN
  :new.Id_zamestnanca := Id_zamestnanec_auto.nextval; --dame do idcka hodnotu z sequencie +1
END;
/

--------------------- Procedury -------------------
CREATE OR REPLACE PROCEDURE Filmy_reziser(Reziser IN VARCHAR2)
IS
   CURSOR Film IS SELECT * FROM film;
   zaznam Film%ROWTYPE;
   Pocet_film NUMBER;
BEGIN
  Pocet_film := 0;
  OPEN Film;
  LOOP
    FETCH Film into zaznam;
    EXIT WHEN Film%NOTFOUND;
      IF (TRIM(zaznam.Reziser) = Reziser) THEN
          Pocet_film := pocet_film + 1;
      END IF;
  END LOOP;
  CLOSE Film;
    DBMS_OUTPUT.put_line('V databaze je od rezisera ' || Reziser || ' celkovo ' ||  pocet_film);
  EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.put_line('V databaze nie je ziaden film s tymto reziserom!');
  WHEN OTHERS THEN
    raise_application_error(-20005, 'Chyba: Procedura zlyhala');
END;
/

CREATE OR REPLACE PROCEDURE Procedure_zamestnanec(Typ_zamestnanca IN VARCHAR2, Meno IN VARCHAR2)
IS
   CURSOR Zamestnanec IS SELECT * FROM Zamestnanec;
   zaznam Zamestnanec%ROWTYPE;
   Pocet_vsetko NUMBER;
   Pocet_meno NUMBER;
   Pocet_typ_zam NUMBER;
   Dokopy NUMBER;
BEGIN
  Pocet_vsetko := 0;
  Pocet_meno := 0;
  Pocet_typ_zam := 0;
  Dokopy := 0;
  
  OPEN Zamestnanec;
  LOOP
    FETCH Zamestnanec into zaznam;
    EXIT WHEN Zamestnanec%NOTFOUND;
      Pocet_vsetko := Pocet_vsetko + 1;
      
      IF (TRIM(zaznam.Meno) = Meno) THEN
          Pocet_meno := Pocet_meno + 1;
          
          IF (TRIM(zaznam.Typ_zamestnanca) = Typ_zamestnanca) THEN
              Dokopy := Dokopy + 1;
          END IF;
      END IF;
      
      IF (TRIM(zaznam.Typ_zamestnanca) = Typ_zamestnanca) THEN
          Pocet_typ_zam := Pocet_typ_zam + 1;
      END IF;
      
  END LOOP;
  CLOSE Zamestnanec;
    DBMS_OUTPUT.put_line('Celkovy pocet zamestnancou: ' || Pocet_vsetko);
    DBMS_OUTPUT.put_line('Zamestnancov typu "' || Typ_zamestnanca || '" je celkovo: ' ||  Pocet_typ_zam);
    DBMS_OUTPUT.put_line('Zamestnancov z menom "' || Meno || '" je celkovo: ' ||  Pocet_meno);
    DBMS_OUTPUT.put_line('A s ich kombinaciou je: ' || Dokopy);
    
  EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.put_line('V databaze nie je ziaden film s tymto reziserom!');
  WHEN OTHERS THEN
    raise_application_error(-20005, 'Chyba: Procedura zlyhala');
END;
/

CREATE OR REPLACE PROCEDURE Vypis_kina
IS
   CURSOR Kino IS SELECT * FROM Kino;
   zaznam Kino%ROWTYPE;
BEGIN
 
  OPEN Kino;
  LOOP
    FETCH Kino into zaznam;
    EXIT WHEN Kino%NOTFOUND;
    DBMS_OUTPUT.put_line('Názov kina  "' || zaznam.Nazov || '" adresa "' || zaznam.Adresa || '" pocet salov: ' || zaznam.Pocet_salov);
  END LOOP;
  CLOSE Kino;
   
  EXCEPTION
  WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('V databaze nie je ziadne kino!');
  WHEN OTHERS THEN
    raise_application_error(-20005, 'Chyba: Procedura zlyhala');
END;
/
--------Zavolanie procedur na test---------------
 exec Filmy_reziser('Miller');
 exec Procedure_zamestnanec('predajca na pokladni','Peter');
 exec Vypis_kina();
-------------Udelenie prav xandri04----------------
GRANT ALL ON Kino TO xandri04;
GRANT ALL ON Sal TO xandri04;
GRANT ALL ON Projekcia TO xandri04;
GRANT ALL ON Film TO xandri04;
GRANT ALL ON Rezervacie TO xandri04;
GRANT ALL ON Sedadla TO xandri04;
GRANT ALL ON Vip TO xandri04;
GRANT ALL ON Public_ TO xandri04;
GRANT ALL ON Vstupenka TO xandri04;
GRANT ALL ON Prebieha TO xandri04;
GRANT ALL ON Vytvorit TO xandri04;
GRANT ALL ON Znaci TO xandri04;
GRANT ALL ON Rezervovanie TO xandri04;

-- Udelenie prav pre spustanie procedur
GRANT EXECUTE ON Filmy_reziser TO xandri04;
GRANT EXECUTE ON Vypis_kina TO xandri04;

-------------Explain plan a index------------------
EXPLAIN PLAN FOR SELECT Typ_zamestnanca, Cena
FROM Zamestnanec NATURAL JOIN Vstupenka
GROUP BY Typ_zamestnanca, Cena;
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.display());

CREATE INDEX index_n ON Zamestnanec (Typ_zamestnanca);

EXPLAIN PLAN FOR SELECT Typ_zamestnanca, AVG(Cena)
FROM Zamestnanec NATURAL JOIN Vstupenka
GROUP BY Typ_zamestnanca, Cena;
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.display());

-------------Materializovany pohlad----------------
DROP MATERIALIZED VIEW VypisFilm1;
CREATE MATERIALIZED VIEW LOG ON Film WITH PRIMARY KEY,ROWID(Zaner)INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW VypisFilm1
CACHE
BUILD IMMEDIATE
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS SELECT F.Zaner, count(F.Zaner) as Helpme
FROM Film F
GROUP BY F.Zaner;

GRANT ALL ON VypisFilm1 TO xandri04;
-- Test funkcnosti
SELECT * from VypisFilm1;
INSERT INTO Film (Id_filmu, Nazov, Zaner, Reziser, Scenar)  VALUES('00009', 'TESTX', 'Horor', 'Miller X', 'Daniel Waters');
COMMIT;
SELECT * from VypisFilm1;