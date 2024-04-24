$PBExportHeader$n_cst_dernier_acces.sru
forward
global type n_cst_dernier_acces from n_base
end type
end forward

global type n_cst_dernier_acces from n_base
end type
global n_cst_dernier_acces n_cst_dernier_acces

type variables
string	is_dernier_acces[]
string	is_dernier_acces_nom[]

string	is_acces_a_ajouter[]
string	is_acces_a_ajouter_nom[]
end variables

forward prototypes
public subroutine of_chargerdernieracces ()
public subroutine of_ajouterdernieracces (string as_menu, string as_nom)
public subroutine of_enregistrerdernieracces ()
end prototypes

public subroutine of_chargerdernieracces ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ChargerDernierAcces
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
//	Description:	Charge de la bd sécurité les derniers accès
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
//
//////////////////////////////////////////////////////////////////////////////

n_ds		lds_derniere_acces
string	ls_login, ls_string_html = "", ls_file[], ls_ecrit, ls_nomfichier, ls_fichiertemp, &
			ls_string_texte = ""
long		ll_nbrangees, ll_cpt, ll_upper


ls_login = gnv_app.of_GetUserId()

lds_derniere_acces = create n_ds
lds_derniere_acces.dataobject = "ds_dernier_acces"
lds_derniere_acces.SetTransObject( SQLCA )


ll_nbrangees = lds_derniere_acces.Retrieve(ls_login)
IF ll_nbrangees > 0 THEN
	FOR ll_cpt = 1 TO ll_nbrangees
		ll_upper = UpperBound(is_dernier_acces) + 1
		is_dernier_acces[ll_upper] = lds_derniere_acces.Object.item_menu[ll_cpt]
		is_dernier_acces_nom[ll_upper] = lds_derniere_acces.Object.nom_affiche[ll_cpt]
		ls_string_html = ls_string_html + '<li>&nbsp;&nbsp;<A HREF="' + is_dernier_acces[ll_upper] + &
			'">' + is_dernier_acces_nom[ll_upper] + '</A>'
	END FOR
END IF


IF IsValid(lds_derniere_acces) THEN Destroy lds_derniere_acces

ls_nomfichier = string(gnv_app.inv_entrepotglobal.of_retournedonnee("path", FALSE)) + "Navigation.htm"
ls_fichiertemp = LEFT(ls_nomfichier, LEN(ls_nomfichier) - 4) + "_temp.htm"

IF FileExists(ls_nomfichier) AND FileExists(ls_fichiertemp) THEN
	gnv_app.inv_filesrv.of_FileCopy ( ls_nomfichier, ls_fichiertemp, FALSE)
	
	gnv_app.inv_filesrv.of_FileRead (ls_fichiertemp, ls_file )
	
	ls_ecrit = gnv_app.inv_string.of_GlobalReplace(ls_file[1], "[%INSERTION_MENU_RECENT%]", ls_string_html)
	
	//ls_string_texte = "Mettre ici les liens vers les fenêtres principales"
	ls_ecrit = gnv_app.inv_string.of_GlobalReplace(ls_ecrit, "[%INSERTION_NAVIGATEUR_TEXTE%]", ls_string_texte)
	
	gnv_app.inv_filesrv.of_FileWrite (ls_fichiertemp, ls_ecrit, FALSE )
END IF
end subroutine

public subroutine of_ajouterdernieracces (string as_menu, string as_nom);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_AjouterDernierAcces
//
//	Accès:  			Public
//
//	Argument:		as_menu	- 	Nom de l'item de menu
//						as_nom	-	Nom affiché (texte de l'item de menu)
//
//	Retourne:  		Rien
//
//	Description:	Place dans un variable les dernier acces à ajouter 
//						éventuellement dans la bd
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
//
//////////////////////////////////////////////////////////////////////////////

long			ll_upper
n_cst_array	lnv_array
any			la_transfert[]

ll_upper = UpperBound(is_acces_a_ajouter) + 1

IF ll_upper < 15 THEN
	//Vérifier si l'item n'y est pas déjà
	la_transfert = is_acces_a_ajouter
	IF lnv_array.of_Find(la_transfert, as_menu) = 0 OR ll_upper = 1 THEN
		is_acces_a_ajouter[ll_upper] = as_menu
		is_acces_a_ajouter_nom[ll_upper] = as_nom
	END IF
END IF

of_EnregistrerDernierAcces()
end subroutine

public subroutine of_enregistrerdernieracces ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_EnregistrerDernierAcces
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
//	Description:	Enregistre dans la bd sécurité les derniers accès 
//						(18 accès max)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
// 2006-04-08	Mathieu Gendron		Correction pour quand le nom D'item de menu était vide
//
//////////////////////////////////////////////////////////////////////////////

string		ls_a_enregistrer[], ls_a_enregistrer_nom[], ls_code_syst, ls_login, &
				ls_sql, ls_enreg, ls_enreg_nom 
long			ll_cpt, ll_upperdepart, ll_upper, ll_rendu = 1, ll_cpt_rev, &
				ll_rendu_rev = 1
n_cst_array	lnv_array
any			la_transfert[]


ls_login = gnv_app.of_GetUserId()

//Mettre les item les plus récents en premier
FOR ll_cpt_rev = UpperBound(is_acces_a_ajouter) TO 1 STEP -1
	ls_a_enregistrer[ll_rendu_rev] = is_acces_a_ajouter[ll_cpt_rev]
	ls_a_enregistrer_nom[ll_rendu_rev] = is_acces_a_ajouter_nom[ll_cpt_rev]
	ll_rendu_rev ++
END FOR

ll_upperdepart = Upperbound(ls_a_enregistrer)
la_transfert = ls_a_enregistrer

FOR ll_cpt = ll_upperdepart TO 15 //15 lignes affichées max
	
	//Vérifier si l'item n'est pas déjà inséré dans le tableau
	IF ll_rendu > UpperBound(is_dernier_acces) THEN
		Exit
	ELSE
		//Vérifier si le nom d'item de menu est vide
		IF is_dernier_acces_nom[ll_rendu] <> "" AND IsNull(is_dernier_acces_nom[ll_rendu]) = FALSE THEN
			IF lnv_array.of_Find(la_transfert, is_dernier_acces[ll_rendu]) = 0 OR UpperBound(la_transfert) = 0 THEN
				//Pas trouvé, ajouter
				ll_upper = Upperbound(ls_a_enregistrer) + 1
				ls_a_enregistrer[ll_upper] = is_dernier_acces[ll_rendu]
				ls_a_enregistrer_nom[ll_upper] = is_dernier_acces_nom[ll_rendu]
			END IF
		END IF
	END IF
	
	ll_rendu ++
	
END FOR

ls_sql = "DELETE FROM t_DernierAcces WHERE lower(login_usager) = '" + lower(ls_login) + "'"

EXECUTE IMMEDIATE :ls_sql USING SQLCA;
Commit USING SQLCA;

FOR ll_cpt = 1 TO UpperBound(ls_a_enregistrer)

	ls_enreg = ls_a_enregistrer[ll_cpt]
	ls_enreg_nom = ls_a_enregistrer_nom[ll_cpt]
	
	INSERT INTO T_DernierAcces(item_menu,nom_affiche,ordre,login_usager)
	VALUES (:ls_enreg, :ls_enreg_nom, :ll_cpt, :ls_login ) USING SQLCA ;
	
	Commit USING SQLCA;
END FOR
end subroutine

on n_cst_dernier_acces.create
call super::create
end on

on n_cst_dernier_acces.destroy
call super::destroy
end on

event constructor;call super::constructor;THIS.of_ChargerDernierAcces()
end event

event destructor;call super::destructor;//THIS.of_EnregistrerDernierAcces()
end event

