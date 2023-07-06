#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: COURS
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS COURS(
        ID_COURS            Int  Auto_increment  NOT NULL ,
        NOM_C         Varchar (500) NOT NULL ,
        NOMPROFESSEUR Varchar (500) NOT NULL ,
        FILIERE       Varchar (500) NOT NULL ,
        DEPARTEMENT   Varchar (500) NOT NULL
	,CONSTRAINT COURS_PK PRIMARY KEY (ID_COURS)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ANNEE_ACADEMIQUE
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ANNEE_ACADEMIQUE(
        CODE_ANNEE Varchar (500) NOT NULL ,
        DATE_DEBUT Date NOT NULL ,
        DATE_FIN   Date NOT NULL
	,CONSTRAINT ANNEE_ACADEMIQUE_PK PRIMARY KEY (CODE_ANNEE)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: MENTION_DISCIPLINAIRE
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MENTION_DISCIPLINAIRE(
        ID_MENTION   Int  Auto_increment  NOT NULL ,
        MOTIF        Varchar (500) NOT NULL
	,CONSTRAINT MENTION_DISCIPLINAIRE_PK PRIMARY KEY (ID_MENTION)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: SANCTION
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SANCTION(
        ID_SANCTION      Int  Auto_increment  NOT NULL ,
        LIBELLE_SANCTION Varchar (500) NOT NULL
	,CONSTRAINT SANCTION_PK PRIMARY KEY (ID_SANCTION)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: USERS
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS USERS(
        ID_USER   Int  Auto_increment  NOT NULL ,
        MATRICULE Varchar (500) NOT NULL ,
        NOM       Varchar (500) NOT NULL ,
        PRENOM    Varchar (500) NOT NULL ,
        SEXE      Char (1) NOT NULL ,
        FILIERE   Varchar (500) NOT NULL ,
        STATUT    Varchar (500) NOT NULL
	,CONSTRAINT USERS_AK UNIQUE (MATRICULE)
	,CONSTRAINT USERS_PK PRIMARY KEY (ID_USER)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ETUDIANT
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANT(
        ID_USER    Int NOT NULL ,
        MATRICULE Varchar (500) NOT NULL ,
        EMAIL      Varchar (500) NOT NULL ,
        MDP        Varchar (500) NOT NULL ,
        AGE        Int NOT NULL 
	,CONSTRAINT ETUDIANT_AK UNIQUE (MATRICULE)
	,CONSTRAINT ETUDIANT_PK PRIMARY KEY (ID_USER,EMAIL)

	,CONSTRAINT ETUDIANT_USERS_FK FOREIGN KEY (ID_USER) REFERENCES USERS(ID_USER)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ETRE_PRESENT
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETRE_PRESENT(
        ID_COURS      Int NOT NULL ,
        ID_USER Int NOT NULL ,
        EMAIL   Varchar (500) NOT NULL ,
        DATE    Date NOT NULL ,
        PERIODE Varchar (500) NOT NULL 
	,CONSTRAINT ETRE_PRESENT_PK PRIMARY KEY (ID_COURS,ID_USER,EMAIL)

	,CONSTRAINT ETRE_PRESENT_COURS_FK FOREIGN KEY (ID_COURS) REFERENCES COURS(ID_COURS)
	,CONSTRAINT ETRE_PRESENT_ETUDIANT_FK FOREIGN KEY (ID_USER,EMAIL) REFERENCES ETUDIANT(ID_USER,EMAIL)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: SUBIR
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SUBIR(
        ID_SANCTION    Int NOT NULL ,
        ID_USER        Int NOT NULL ,
        EMAIL          Varchar (500) NOT NULL ,
        DATE_SANCTION  Date NOT NULL ,
        MOTIF_SANCTION Varchar (500) NOT NULL
	,CONSTRAINT SUBIR_PK PRIMARY KEY (ID_SANCTION,ID_USER,EMAIL)

	,CONSTRAINT SUBIR_SANCTION_FK FOREIGN KEY (ID_SANCTION) REFERENCES SANCTION(ID_SANCTION)
	,CONSTRAINT SUBIR_ETUDIANT_FK FOREIGN KEY (ID_USER,EMAIL) REFERENCES ETUDIANT(ID_USER,EMAIL)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: AFFECTER
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS AFFECTER(
        CODE_ANNEE Varchar (500) NOT NULL ,
        ID_COURS         Int NOT NULL
	,CONSTRAINT AFFECTER_PK PRIMARY KEY (CODE_ANNEE,ID_COURS)

	,CONSTRAINT AFFECTER_ANNEE_ACADEMIQUE_FK FOREIGN KEY (CODE_ANNEE) REFERENCES ANNEE_ACADEMIQUE(CODE_ANNEE)
	,CONSTRAINT AFFECTER_COURS_FK FOREIGN KEY (ID_COURS) REFERENCES COURS(ID_COURS)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: RECEVOIR
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RECEVOIR(
        ID_USER        Int NOT NULL ,
        ID_MENTION   Int  NOT NULL ,
        EMAIL		Varchar(500) NOT NULL,
        DATE_MENTION Date NOT NULL
	,CONSTRAINT RECEVOIR_PK PRIMARY KEY (ID_USER,ID_MENTION,EMAIL)
	
	,CONSTRAINT RECEVOIR_ETUDIANT_FK FOREIGN KEY (ID_USER,EMAIL) REFERENCES ETUDIANT(ID_USER,EMAIL)
	,CONSTRAINT RECEVOIR_MENTION_FK FOREIGN KEY (ID_MENTION) REFERENCES MENTION_DISCIPLINAIRE(ID_MENTION)
)ENGINE=InnoDB;

