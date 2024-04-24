$PBExportHeader$pro_w_master.srw
$PBExportComments$(PRO) Extension Master Window class
forward
global type pro_w_master from pfc_w_master
end type
end forward

global type pro_w_master from pfc_w_master
end type
global pro_w_master pro_w_master

type variables
u_dw							idw_precedente
string						is_tabpagedesactive[]
end variables

forward prototypes
public subroutine uf_traduction ()
public function integer of_gettabpg (ref u_tabpg atabpg_courant)
public function u_dw of_getlastdwactive ()
public function boolean of_getdroitinsertion ()
public function boolean of_getdroitmodification ()
public function boolean of_getdroitdestruction ()
public function boolean of_droitautres ()
public function boolean of_droitautres (string as_message, string as_msgargs[])
end prototypes

public subroutine uf_traduction ();//Fonction pour la traduction des libellés
end subroutine

public function integer of_gettabpg (ref u_tabpg atabpg_courant);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetTabpg
//
//	Accès:  			Public
//
//	Argument:		u_tabpg - l'onglet courant par référence
//
//	Retourne:  	   1 - Si il y a un tab
//						0 - Si il n'y a pas de tab
//
//	Description:	
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long			ll_NbrControl, ll_Control, ll_nb_ctl, ll_cpt
u_tab 		ltab_Courant	
userobject	luo_object

try
	ll_NbrControl = UpperBound(Control[])
	
	for ll_Control = 1 to ll_NbrControl
		CHOOSE CASE Control[ll_Control].TypeOf()
			CASE tab! 
				ltab_Courant = Control[ll_Control]
				atabpg_Courant = ltab_Courant.Control[ltab_Courant.SelectedTab]
				return 1
			CASE UserObject!
				luo_object = Control[ll_Control]
				ll_nb_ctl = UpperBound(luo_object.Control[])
				FOR ll_cpt = 1 to ll_nb_ctl
					CHOOSE CASE luo_object.Control[ll_cpt].TypeOf()
						CASE Tab!
							ltab_Courant = luo_object.Control[ll_cpt]
							atabpg_Courant = ltab_Courant.Control[ltab_Courant.SelectedTab]
							return 1
					END CHOOSE
				NEXT
				
		end Choose	
	next
	
catch (throwable error)
	
end try

return 0
end function

public function u_dw of_getlastdwactive ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetLastDWActive
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  	   boolean
//
//	Description:	Retourne le dernier dw accédé
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

return idw_active
end function

public function boolean of_getdroitinsertion ();// Retourne vrai si on a le droit d'insertion sur cette fenêtre, faux autrement
string ls_menuitem
integer li_cnt
n_cst_string lnv_strsrv

ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(this.tag), "menu", ";"))
if isNull(ls_menuitem) or ls_menuitem = "" then
	messagebox("Erreur Développement", "L'item de menu n'est pas spécifié dans le tag de " + classname(this))
end if

select count(1)
  into :li_cnt
  from t_droitsusagers
 where (id_user = :gnv_app.il_id_user
		 or id_user in (select id_group
								from t_groupeusager
							  where id_user = :gnv_app.il_id_user))
	and objet = :ls_menuitem
	and isnull(locate(upper(droits), 'I'), 0) > 0;

if li_cnt > 0 then
	return true
end if

return false

end function

public function boolean of_getdroitmodification ();// Retourne vrai si on a le droit de modification sur cette fenêtre, faux autrement
string ls_menuitem
integer li_cnt
n_cst_string lnv_strsrv

ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(this.tag), "menu", ";"))
if isNull(ls_menuitem) or ls_menuitem = "" then
	messagebox("Erreur Développement", "L'item de menu n'est pas spécifié dans le tag de " + classname(this))
end if

select count(1)
  into :li_cnt
  from t_droitsusagers
 where (id_user = :gnv_app.il_id_user
		 or id_user in (select id_group
								from t_groupeusager
							  where id_user = :gnv_app.il_id_user))
	and objet = :ls_menuitem
	and isnull(locate(upper(droits), 'M'), 0) > 0;

if li_cnt > 0 then
	return true
end if

return false

end function

public function boolean of_getdroitdestruction ();// Retourne vrai si on a le droit de destruction sur cette fenêtre, faux autrement
string ls_menuitem
integer li_cnt
n_cst_string lnv_strsrv

ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(this.tag), "menu", ";"))
if isNull(ls_menuitem) or ls_menuitem = "" then
	messagebox("Erreur Développement", "L'item de menu n'est pas spécifié dans le tag de " + classname(this))
end if

select count(1)
  into :li_cnt
  from t_droitsusagers
 where (id_user = :gnv_app.il_id_user
		 or id_user in (select id_group
								from t_groupeusager
							  where id_user = :gnv_app.il_id_user))
	and objet = :ls_menuitem
	and isnull(locate(upper(droits), 'D'), 0) > 0;

if li_cnt > 0 then
	return true
end if

return false

end function

public function boolean of_droitautres ();// Gère le droit "Autre(s)" en affichant le message par défaut le cas échéant
// Retourne vrai si on a le droit, faux autrement
string ls_vide[]

return of_droitautres("PRO0015", ls_vide)

end function

public function boolean of_droitautres (string as_message, string as_msgargs[]);// Gère le droit "Autre(s)" en affichant le message le cas échéant
// Retourne vrai si on a le droit, faux autrement
string ls_menuitem
integer li_cnt
n_cst_string lnv_strsrv

ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(this.tag), "menu", ";"))
if isNull(ls_menuitem) or ls_menuitem = "" then
	messagebox("Erreur Développement", "L'item de menu n'est pas spécifié dans le tag de " + classname(this))
end if

select count(1)
  into :li_cnt
  from t_droitsusagers
 where (id_user = :gnv_app.il_id_user
		 or id_user in (select id_group
								from t_groupeusager
							  where id_user = :gnv_app.il_id_user))
	and objet = :ls_menuitem
	and isnull(locate(upper(droits), 'A'), 0) > 0;

if li_cnt = 0 then
	if as_message <> '' then gnv_app.inv_error.of_message(as_message, as_msgargs[])
	return false
end if

return true

end function

on pro_w_master.create
call super::create
end on

on pro_w_master.destroy
call super::destroy
end on

event open;call super::open;//pro_resize luo_size
//luo_size.uf_resizew(this,1,1)
uf_traduction()

end event

event pfc_dberror;//override de l'ancêtre pour régler le problème du deuxième message lorsqu'il y a
// une erreur de base de données ou de validation dans pfc_preupdate.
end event

event pfc_postopen;call super::pfc_postopen;menu lm_tmpmenu
n_cst_menu lnv_menusrv

if isValid(THIS.menuID) then
	if lnv_menusrv.of_getmenureference(THIS.menuID, "m_formulaires", lm_tmpmenu) = 1 then
		gnv_app.of_appdroits(lm_tmpmenu)
	end if
	if lnv_menusrv.of_getmenureference(THIS.menuID, "m_pilotage", lm_tmpmenu) = 1 then
		gnv_app.of_appdroits(lm_tmpmenu)
	end if
	if lnv_menusrv.of_getmenureference(THIS.menuID, "m_rapports", lm_tmpmenu) = 1 then
		gnv_app.of_appdroits(lm_tmpmenu)
	end if
end if

end event

event pfc_preopen;call super::pfc_preopen;string ls_menutag
n_cst_string lnv_strsrv

ls_menutag = gnv_app.inv_entrepotglobal.of_retournedonnee("Sécurité Menu Tag", true)
if not isNull(ls_menutag) and ls_menutag <> "" then
	if pos(this.tag, 'menu') > 0 then
		lnv_strsrv.of_setkeyvalue(this.tag, "menu", ls_menutag, ";")
	else
		if this.tag <> '' then this.tag = this.tag + ';'
		this.tag = this.tag + 'menu=' + ls_menutag
	end if
end if

end event

