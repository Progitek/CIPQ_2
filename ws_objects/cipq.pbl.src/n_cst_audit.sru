$PBExportHeader$n_cst_audit.sru
forward
global type n_cst_audit from n_base
end type
end forward

global type n_cst_audit from n_base autoinstantiate
end type

forward prototypes
public function boolean of_runsql_audit (string as_sql, string as_table, string as_type, string as_fenetre)
end prototypes

public function boolean of_runsql_audit (string as_sql, string as_table, string as_type, string as_fenetre);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_runsql_audit
//
//	Accès:  			Public
//
//	Argument:		as_sql 		- SQL à rouler
//						as_table 	- quelle table
//						as_type		- Type de update
//						as_fenetre	- Fenêtre qui a lancé le update
//
//	Retourne:  		TRUE si le run a bien roulé
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
// 2007-09-07	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_login, ls_null, ls_message
datetime	ldt_date_maj
boolean	lb_retour

setnull(ls_null)
//Run

EXECUTE IMMEDIATE :as_sql USING SQLCA;
lb_retour = gnv_app.inv_error.of_sqlerror()

IF lb_retour = TRUE THEN

	//Committer
	COMMIT USING SQLCA;
	lb_retour = gnv_app.inv_error.of_sqlerror()
	
	IF lb_retour = TRUE THEN
		//Audit
		
		ls_message = "Par traitement"
		ls_login = gnv_app.inv_entrepotglobal.of_retournedonnee("Login usager", FALSE)
		ldt_date_maj = datetime(today(),now())
		
		//Stocker l'information dans la base de données d'audit
		INSERT INTO t_audit (login_usager, type_maj, sql_maj, date_maj, dataobject, primarykey, nom_table, nom_fenetre)
		VALUES 		(:ls_login, :as_type, :as_sql, :ldt_date_maj, :ls_message, :ls_null, :as_table, :as_fenetre) USING SQLCA;
		
		Commit USING SQLCA;
		
	ELSE
		RETURN FALSE
		
	END IF
	
ELSE
	RETURN FALSE
END IF

RETURN TRUE
end function

on n_cst_audit.create
call super::create
end on

on n_cst_audit.destroy
call super::destroy
end on

