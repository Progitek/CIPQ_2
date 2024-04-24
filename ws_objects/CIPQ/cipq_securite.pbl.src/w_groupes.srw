﻿$PBExportHeader$w_groupes.srw
forward
global type w_groupes from w_sheet_frame
end type
type gb_infousager from groupbox within w_groupes
end type
type tv_groupes from u_tv within w_groupes
end type
type tv_users from u_tv within w_groupes
end type
type uo_toolbar from u_cst_toolbarstrip within w_groupes
end type
type uo_toolbar_group from u_cst_toolbarstrip within w_groupes
end type
type uo_toolbar_user from u_cst_toolbarstrip within w_groupes
end type
type dw_detailsusager from u_dw within w_groupes
end type
type gb_groupes from groupbox within w_groupes
end type
type gb_usagers from groupbox within w_groupes
end type
type rr_1 from roundrectangle within w_groupes
end type
end forward

global type w_groupes from w_sheet_frame
string tag = "menu=m_administration"
gb_infousager gb_infousager
tv_groupes tv_groupes
tv_users tv_users
uo_toolbar uo_toolbar
uo_toolbar_group uo_toolbar_group
uo_toolbar_user uo_toolbar_user
dw_detailsusager dw_detailsusager
gb_groupes gb_groupes
gb_usagers gb_usagers
rr_1 rr_1
end type
global w_groupes w_groupes

type variables
Private:

long il_userid
long il_groupid
long il_currhandle = 0
long il_userhandle = 0
long il_type = 0
boolean ib_insertion = false
boolean ib_update = false
boolean ib_premiere_modif = true
boolean ib_change = false
end variables

forward prototypes
private function integer of_ajoutergroupe ()
private function integer of_supprimergroupe ()
private function integer of_supprimeruser ()
public function long of_recupererprochainiduser ()
private subroutine of_droitsgroupe ()
end prototypes

private function integer of_ajoutergroupe ();//////////////////////////////////////////////////////////////////////////////
//
// Méthode:		of_AjouterGroupe
//
// Accès:		Private
//
// Argument:	Aucun
//
// Retourne:	Integer - Retourne 0 si succès,
//											-1 s'il y a erreur de nom,
//											-2 s'il y a erreur lors de l'insertion (SQL)
//
//////////////////////////////////////////////////////////////////////////////
//
// Historique
//
// Date			Programmeur				Description
//	2008-04-16	Sébastien Tremblay	Cette fonction ajoute un groupe utilisateur
//////////////////////////////////////////////////////////////////////////////

n_ds l_ds
long ll_row, ll_new, ll_cnt
string ls_nom

if not this.of_getdroitinsertion() then
	gnv_app.inv_error.of_message("PRO0012")
	return -2
end if

do
	ls_nom = inputbox("Nouveau groupe utilisateur", "Entrez le nom du nouveau groupe")
	
	if isNull(ls_nom) or ls_nom = "" then return -1
	select count(*) into :ll_cnt from t_users where typepass = 'groupe' and nom = :ls_nom;
	if ll_cnt > 0 then
		// Le nom existe déjà !
		gnv_app.inv_error.of_message("CIPQ0014", {"Nom de groupe"})
	end if
loop while ll_cnt > 0

tv_groupes.of_GetDatastore(1,l_ds)

ll_new = this.of_recupererprochainiduser()
// copy the data to the datastore
ll_row = l_ds.insertrow(0)
l_ds.object.id_user[ll_row] = ll_new
l_ds.object.nom[ll_row] = ls_nom
l_ds.object.typepass[ll_row] = 'groupe'

if not gnv_app.inv_audit.of_runsql_audit("insert into t_users(id_user, nom, typepass) values (" + string(ll_new) + ", '" + ls_nom + "', 'groupe')", "T_Users", "Insertion", this.Title) then return -2

tv_groupes.of_insertItem(0, l_ds, ll_row, 'Sort')

l_ds.setItemStatus(ll_row, 0, Primary!, DataModified!)

end function

private function integer of_supprimergroupe ();//////////////////////////////////////////////////////////////////////////////
//
// Méthode:		of_SupprimerGroupe
//
// Accès:		Private
//
// Argument:	Aucun
//
// Retourne:	Integer - Retourne 0 si succès,
//											-1 si rien n'est sélectionné,
//											-2 s'il y a erreur lors de la supression (SQL)
//
//////////////////////////////////////////////////////////////////////////////
//
// Historique
//
// Date			Programmeur				Description
//	2008-04-16	Sébastien Tremblay	Cette fonction supprime un groupe utilisateur
//////////////////////////////////////////////////////////////////////////////

long ll_hdl, ll_row, ll_id
n_ds l_ds

if not this.of_getdroitdestruction() then
	gnv_app.inv_error.of_message("PRO0014")
	return -2
end if

if il_currhandle = 0 or il_type > 2 then
	// Aucune sélection
	gnv_app.inv_error.of_message("PRO0006")
	return -1
end if

choose case il_type
	case 1 // Groupe dans tv_groupes
		tv_groupes.of_getDataRow(il_currhandle, l_ds, ll_row)
		
		// Demander confirmation
		if gnv_app.inv_error.of_message("CIPQ0021") = 2 then return 0
		
		tv_groupes.of_update(1)
		tv_users.of_update(2)
		
		ll_id = l_ds.object.id_user[ll_row]
		if not gnv_app.inv_audit.of_runsql_audit("delete from t_droitsusagers where id_user = " + string(ll_id), "T_DroitsUsagers", "Suppression", this.Title) then return -2

		tv_groupes.of_deleteItem(il_currhandle)
		
		tv_groupes.of_update(1)
		tv_users.of_update(2)
		
		tv_users.of_refreshLevel(1)
	case 2 // Usager dans tv_groupes
		tv_groupes.of_update()

		tv_groupes.of_deleteItem(il_currhandle)
		
		tv_groupes.of_update()

		tv_users.of_refreshLevel(1)
end choose

return 0
end function

private function integer of_supprimeruser ();//////////////////////////////////////////////////////////////////////////////
//
// Méthode:		of_SupprimerUser
//
// Accès:		Private
//
// Argument:	Aucun
//
// Retourne:	Integer - Retourne 0 si succès,
//											-1 si rien n'est sélectionné,
//											-2 s'il y a erreur lors de la supression (SQL)
//
//////////////////////////////////////////////////////////////////////////////
//
// Historique
//
// Date			Programmeur				Description
//	2008-04-16	Sébastien Tremblay	Cette fonction supprime un groupe utilisateur
//////////////////////////////////////////////////////////////////////////////

if not this.of_getdroitdestruction() then
	gnv_app.inv_error.of_message("PRO0014")
	return -2
end if

if il_type = 4 and il_currhandle > 0 then // Groupe dans tv_users, un groupe est sélectionné
	tv_groupes.of_update(1)
	tv_users.of_update(2)

	tv_users.of_deleteItem(il_currhandle)
	
	tv_groupes.of_update(1)
	tv_users.of_update(2)
	
	tv_groupes.of_refreshLevel(1)
else
	// Aucune sélection
	gnv_app.inv_error.of_message("PRO0006")
	return -1
end if

return 0
end function

public function long of_recupererprochainiduser ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainiduser
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Numéro 
//
// Description:	Fonction pour trouver la valeur du prochain numéro d'usager
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
//	2008-04-18	Sébastien Tremblay	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	isNull(max(id_user), 0) + 1
INTO		:ll_no
FROM		t_users
USING 	SQLCA;

RETURN ll_no
end function

private subroutine of_droitsgroupe ();//////////////////////////////////////////////////////////////////////////////
//
// Méthode:		of_DroitsGroupe
//
// Accès:		Private
//
// Argument:	Aucun
//
// Retourne:	Rien
//
//////////////////////////////////////////////////////////////////////////////
//
// Historique
//
// Date			Programmeur				Description
//	2008-04-28	Sébastien Tremblay	Cette fonction ouvre la fenêtre de
//												modification des droits
//////////////////////////////////////////////////////////////////////////////

if il_groupid <= 0 or il_type > 2 then
	gnv_app.inv_error.of_message("CIPQ0020", {"Aucun groupe sélectionné."})
	return
end if

// ouvrir w_editpwd
w_droitsgroupes lw_wind

gnv_app.inv_entrepotglobal.of_ajoutedonnee("Droits groupe", string(il_groupid))

OpenSheet(lw_wind, gnv_app.of_getFrame(), 6, layered!)

end subroutine

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_group.of_settheme("classic")
uo_toolbar_group.of_DisplayBorder(true)
uo_toolbar_group.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_group.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_group.of_AddItem("Droits", "Custom016!")
uo_toolbar_group.of_displaytext(true)

uo_toolbar_user.of_settheme("classic")
uo_toolbar_user.of_DisplayBorder(true)
uo_toolbar_user.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajout_personne.ico")
uo_toolbar_user.of_AddItem("Retirer de ce groupe", "C:\ii4net\CIPQ\images\suppr_personne.ico")
uo_toolbar_user.of_AddItem("Changer mot de passe", "C:\ii4net\CIPQ\images\lock.jpg")
uo_toolbar_user.of_displaytext(true)

end event

on w_groupes.create
int iCurrent
call super::create
this.gb_infousager=create gb_infousager
this.tv_groupes=create tv_groupes
this.tv_users=create tv_users
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_group=create uo_toolbar_group
this.uo_toolbar_user=create uo_toolbar_user
this.dw_detailsusager=create dw_detailsusager
this.gb_groupes=create gb_groupes
this.gb_usagers=create gb_usagers
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_infousager
this.Control[iCurrent+2]=this.tv_groupes
this.Control[iCurrent+3]=this.tv_users
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.uo_toolbar_group
this.Control[iCurrent+6]=this.uo_toolbar_user
this.Control[iCurrent+7]=this.dw_detailsusager
this.Control[iCurrent+8]=this.gb_groupes
this.Control[iCurrent+9]=this.gb_usagers
this.Control[iCurrent+10]=this.rr_1
end on

on w_groupes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_infousager)
destroy(this.tv_groupes)
destroy(this.tv_users)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_group)
destroy(this.uo_toolbar_user)
destroy(this.dw_detailsusager)
destroy(this.gb_groupes)
destroy(this.gb_usagers)
destroy(this.rr_1)
end on

event pfc_endtran;call super::pfc_endtran;// commit the transaction
commit using SQLCA;
if SQLCA.sqlcode = 0 then 
	return 1
else
	return  -1
end if

end event

event pfc_update;call super::pfc_update;gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_users", TRUE)
gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_groupeusager", TRUE)

if tv_groupes.of_update(1) = 1 then
	if tv_users.of_update(2) = 1 then
		commit;
		
		return 1
	end if
end if

return ancestorReturnValue
end event

event pfc_updatespendingref;call super::pfc_updatespendingref;// determine if any of the treeviews have updates pending
// and return 1 if they do
integer li_cnt
TreeViewItem	ltvi_This
n_ds l_ds

if ancestorReturnValue >= 0 then
	tv_groupes.of_GetDatastore(1,l_ds) // check groups
	li_cnt = l_ds.modifiedcount() + l_ds.deletedcount()
	if li_cnt > 0 then
		apo_pending[upperbound(apo_pending) + 1] = tv_groupes
		return 1
	end if
	
	tv_users.of_GetDatastore(2,l_ds) // check user/group combinations
	li_cnt = l_ds.modifiedcount() + l_ds.deletedcount()
	if li_cnt > 0 then
		apo_pending[upperbound(apo_pending) + 1] = tv_users
		return 1
	end if
end if

return ancestorReturnValue

end event

event pfc_postopen;call super::pfc_postopen;// 2009-03-19 - Sébastien Tremblay - Éliminer les usagers invalides
delete from t_users where typepass = 'user' and login_user is null and nom is null;
commit using sqlca;

end event

type st_title from w_sheet_frame`st_title within w_groupes
integer x = 210
string text = "Administration de la sécurité"
end type

type p_8 from w_sheet_frame`p_8 within w_groupes
integer x = 37
integer y = 40
integer width = 155
integer height = 100
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\lock2.jpg"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_groupes
integer width = 4631
end type

type gb_infousager from groupbox within w_groupes
integer x = 3822
integer y = 180
integer width = 800
integer height = 764
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Détails"
end type

type tv_groupes from u_tv within w_groupes
integer x = 78
integer y = 256
integer width = 1833
integer height = 1828
integer taborder = 10
string dragicon = "C:\ii4net\CIPQ\images\famille.ico"
boolean dragauto = true
long backcolor = 15793151
boolean border = false
borderstyle borderstyle = stylebox!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
end type

event constructor;call super::constructor;integer li_rc

li_rc = AddPicture("C:\ii4net\CIPQ\images\user.jpg")
li_rc = of_SetDatasource(1, "d_groupes", SQLCA, "nom", "", False, li_rc, li_rc)
li_rc = AddPicture("C:\ii4net\CIPQ\images\boss.gif")
li_rc = of_SetDatasource(2, "d_usergroupe", SQLCA, "cp_desc", ":level.1.id_user", False, li_rc, li_rc)

of_InitialRetrieve()

end event

event selectionchanged;call super::selectionchanged;TreeViewItem ltvi_This
n_ds l_ds
long ll_row, ll_handle

this.GetItem(newhandle, ltvi_This)

il_currhandle = newhandle

if ltvi_this.level = 2 then
	ll_handle = this.findItem(ParentTreeItem!, newhandle)
	il_type = 2
else
	ll_handle = newhandle
	il_type = 1
end if

if ll_handle > 0 then
	this.of_GetDataRow(ll_handle,l_ds,ll_row)
	il_groupid = l_ds.object.id_user[ll_row]
end if

end event

event getfocus;call super::getfocus;TreeViewItem ltvi_This
n_ds l_ds
long ll_row, ll_handle

ll_handle = this.findItem(CurrentTreeItem!, 0)

if this.GetItem(ll_handle, ltvi_This) = -1 then return 0

il_currhandle = ll_handle

if ltvi_this.level = 2 then
	ll_handle = this.findItem(ParentTreeItem!, ll_handle)
	il_type = 2
else
	il_type = 1
end if

if ll_handle > 0 then
	this.of_GetDataRow(ll_handle,l_ds,ll_row)
	il_groupid = l_ds.object.id_user[ll_row]
end if

end event

event begindrag;call super::begindrag;TreeViewItem	ltvi_This

if not parent.of_getdroitmodification() then this.drag(cancel!)

this.GetItem(handle, ltvi_This)
if ltvi_this.level <> 1 then 
	this.drag(cancel!)
else
	this.selectitem(handle)
end if

end event

event dragwithin;call super::dragwithin;u_tv ltv_source

ltv_source = source
if ltv_source <> tv_users then return
selectitem(handle)

end event

event dragdrop;call super::dragdrop;TreeViewItem	ltvi_This
n_ds l_ds
long ll_row, ll_handle, ll_userid, ll_grpid, ll_newHdl
string ls_group, ls_user, ls_nom, ls_prenom
u_tv ltv_source

ltv_source = source
if ltv_source <> tv_users then return

ll_handle = tv_users.finditem ( currenttreeitem!, 0 )

tv_users.of_GetDataRow(ll_handle,l_ds,ll_row)
ls_user = l_ds.object.cp_desc[ll_row]
ll_userid = l_ds.object.id_user[ll_row]
ls_nom = l_ds.object.nom[ll_row]
ls_prenom = l_ds.object.prenom[ll_row]

this.GetItem(handle, ltvi_This)
if ltvi_this.level <> 1 then return
this.of_GetDataRow(handle,l_ds,ll_row)
ls_group = l_ds.object.nom[ll_row]
ll_grpid = l_ds.object.id_user[ll_row]

this.of_GetDatastore(2,l_ds)

this.expanditem(handle)
ll_row = l_ds.find('t_groupeusager_id_user = '+string(ll_userid)+' and t_groupeusager_id_group = '+string(ll_grpid),1,l_ds.rowcount())
if ll_row > 0 then
	// Si on l'a trouvé, l'usager est déjà membre du groupe
	gnv_app.inv_error.of_message("CIPQ0020", {"L'usager "+ls_user+" est déjà membre du groupe "+ls_group+"."})
	return
end if

// Users dans groupes
ll_row = l_ds.insertrow(0)
l_ds.object.id_user[ll_row] = ll_userid
l_ds.object.t_groupeusager_id_user[ll_row] = ll_userid
l_ds.object.t_groupeusager_id_group[ll_row] = ll_grpid
l_ds.object.nom[ll_row] = ls_nom
l_ds.object.prenom[ll_row] = ls_prenom
ll_newHdl = this.of_InsertItem(handle,l_ds,ll_row,'Sort')
this.selectitem(ll_newHdl)

// Groupes dans Users
tv_users.of_GetDatastore(2,l_ds)
ll_row = l_ds.insertrow(0)
l_ds.object.id_user[ll_row] = ll_grpid
l_ds.object.t_groupeusager_id_user[ll_row] = ll_userid
l_ds.object.t_groupeusager_id_group[ll_row] = ll_grpid
l_ds.object.nom[ll_row] = ls_group
tv_users.of_InsertItem(ll_handle,l_ds,ll_row,'Sort')

end event

type tv_users from u_tv within w_groupes
integer x = 1975
integer y = 256
integer width = 1819
integer height = 1828
integer taborder = 30
string dragicon = "C:\ii4net\CIPQ\images\ajout_personne.ico"
boolean dragauto = true
boolean bringtotop = true
long backcolor = 15793151
boolean border = false
borderstyle borderstyle = stylebox!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
string picturename[] = {""}
end type

event constructor;call super::constructor;integer li_rc

li_rc = AddPicture("C:\ii4net\CIPQ\images\boss.gif")
li_rc = AddPicture("C:\ii4net\CIPQ\images\boss_dis.gif")
li_rc = of_SetDatasource(1, "d_userslistgr", SQLCA, "cp_desc", "", False)
li_rc = AddPicture("C:\ii4net\CIPQ\images\user.jpg")
li_rc = of_SetDatasource(2, "d_groupesuser", SQLCA, "nom", ":level.1.id_user", False, li_rc, li_rc)

li_rc = of_SetPicturecolumn(1, "picuser", "pictureindex")
li_rc = of_SetPicturecolumn(1, "picuser", "selectedpictureindex")

of_InitialRetrieve()

end event

event selectionchanged;call super::selectionchanged;TreeViewItem ltvi_This
n_ds l_ds
long ll_row, ll_handle

// Si ce n'est pas pour l'ajout d'un nouvel usager
if not ib_insertion then
	this.GetItem(newhandle, ltvi_This)
	
	il_currhandle = newhandle
	
	if ltvi_this.level = 2 then
		il_userhandle = this.findItem(ParentTreeItem!, newhandle)
		il_type = 4
	else
		il_userhandle = newhandle
		il_type = 3
	end if
	
	if il_userhandle > 0 then
		this.of_GetDataRow(il_userhandle,l_ds,ll_row)
		il_userid = l_ds.object.id_user[ll_row]
		
		dw_detailsusager.retrieve(il_userid)
	end if
end if

end event

event getfocus;call super::getfocus;TreeViewItem ltvi_This
n_ds l_ds
long ll_row, ll_handle

ll_handle = this.findItem(CurrentTreeItem!, 0)

if this.GetItem(ll_handle, ltvi_This) = -1 then return 0

il_currhandle = ll_handle

if ltvi_this.level = 2 then
	il_userhandle = this.findItem(ParentTreeItem!, ll_handle)
	il_type = 4
else
	il_userhandle = ll_handle
	il_type = 3
end if

if ll_handle > 0 then
	this.of_GetDataRow(ll_handle,l_ds,ll_row)
	il_userid = l_ds.object.id_user[ll_row]
end if

end event

event begindrag;call super::begindrag;TreeViewItem ltvi_This
n_ds l_ds
long ll_row

if not parent.of_getdroitmodification() then this.drag(cancel!)

this.GetItem(handle, ltvi_This)
// Si ce n'est pas un usager (si c'est un groupe)
if ltvi_this.level <> 1 then 
	this.drag(cancel!)
else
	this.of_GetDataRow(handle,l_ds,ll_row)
	// Si c'est un nouvel usager qui n'est pas enregistré encore
	// ou encore, si c'est un usager inactif
	if isNull(l_ds.object.id_user[ll_row]) or &
		l_ds.object.id_user[ll_row] = -1 or &
		isNull(l_ds.object.actif[ll_row]) or &
		l_ds.object.actif[ll_row] = 0 then
		this.drag(cancel!)
	else
		this.selectitem(handle)
	end if
end if

end event

event dragwithin;call super::dragwithin;u_tv ltv_source

ltv_source = source
if ltv_source <> tv_groupes then return
selectitem(handle)

end event

event dragdrop;call super::dragdrop;TreeViewItem	ltvi_This
n_ds l_ds
long ll_row, ll_handle, ll_userid, ll_grpid, ll_newHdl, ll_actif
string ls_group, ls_user, ls_nom, ls_prenom
u_tv ltv_source

ltv_source = source
if ltv_source <> tv_groupes then return

ll_handle = tv_groupes.finditem ( currenttreeitem!, 0 )

tv_groupes.of_GetDataRow(ll_handle,l_ds,ll_row)
ls_group = l_ds.object.nom[ll_row]
ll_grpid = l_ds.object.id_user[ll_row]

this.GetItem(handle, ltvi_This)
if ltvi_this.level <> 1 then return
this.of_GetDataRow(handle,l_ds,ll_row)
ls_user = l_ds.object.cp_desc[ll_row]
ll_userid = l_ds.object.id_user[ll_row]
ls_nom = l_ds.object.nom[ll_row]
ls_prenom = l_ds.object.prenom[ll_row]
ll_actif = l_ds.object.actif[ll_row]

if isNull(ll_actif) or ll_actif = 0 then
	// Si l'usager est inactif
	gnv_app.inv_error.of_message("CIPQ0020", {"L'usager "+ls_user+" est inactif.~r~nVous ne pouvez pas l'associer à un groupe."})
	return
end if

this.of_GetDatastore(2,l_ds)

this.expanditem(handle)
ll_row = l_ds.find('t_groupeusager_id_user = '+string(ll_userid)+' and t_groupeusager_id_group = '+string(ll_grpid),1,l_ds.rowcount())
if ll_row > 0 then
	// Si on l'a trouvé, l'usager est déjà membre du groupe
	gnv_app.inv_error.of_message("CIPQ0020", {"L'usager "+ls_user+" est déjà membre du groupe "+ls_group+"."})
	return
end if

// Groupes dans Users
ll_row = l_ds.insertrow(0)
l_ds.object.id_user[ll_row] = ll_grpid
l_ds.object.t_groupeusager_id_user[ll_row] = ll_userid
l_ds.object.t_groupeusager_id_group[ll_row] = ll_grpid
l_ds.object.nom[ll_row] = ls_group
ll_newHdl = this.of_InsertItem(handle,l_ds,ll_row,'Sort')
this.selectitem(ll_newHdl)

// Users dans groupes
tv_groupes.of_GetDatastore(2,l_ds)
ll_row = l_ds.insertrow(0)
l_ds.object.id_user[ll_row] = ll_userid
l_ds.object.t_groupeusager_id_user[ll_row] = ll_userid
l_ds.object.t_groupeusager_id_group[ll_row] = ll_grpid
l_ds.object.nom[ll_row] = ls_nom
l_ds.object.prenom[ll_row] = ls_prenom
tv_groupes.of_InsertItem(ll_handle,l_ds,ll_row,'Sort')

end event

event selectionchanging;call super::selectionchanging;if parent.of_getdroitmodification() then
	// Si ce n'est pas pour l'ajout d'un nouvel usager
	if not ib_insertion then
		if dw_detailsusager.event pfc_update(True, True) <> 1 then
			return 1
		end if
	end if
end if

end event

type uo_toolbar from u_cst_toolbarstrip within w_groupes
integer x = 23
integer y = 2264
integer width = 4631
integer taborder = 60
boolean bringtotop = true
end type

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
		
	CASE "Fermer"
		Close(parent)
		
	CASE "Enregistrer"
		event pfc_save()
		
END CHOOSE

end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_toolbar_group from u_cst_toolbarstrip within w_groupes
event destroy ( )
integer x = 78
integer y = 2100
integer width = 1833
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_group.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
		
	CASE "Ajouter"
		of_AjouterGroupe()
		
	CASE "Supprimer"
		of_SupprimerGroupe()
		
	CASE "Droits"
		of_DroitsGroupe()
		
END CHOOSE

end event

type uo_toolbar_user from u_cst_toolbarstrip within w_groupes
event destroy ( )
integer x = 1979
integer y = 2100
integer width = 2619
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_user.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
		
	CASE "Ajouter"
		dw_detailsusager.SetFocus()
		dw_detailsusager.SetColumn("login_user")
		dw_detailsusager.event pfc_insertRow()
		
	CASE "Retirer de ce groupe"
		of_SupprimerUser()
		
	CASE "Changer mot de passe"
		IF parent.event pfc_save() >= 0 THEN
			if not parent.of_getdroitmodification() then
				gnv_app.inv_error.of_message("PRO0013")
				return
			end if
	
			if il_userid < 0 or il_type <> 3 then
				gnv_app.inv_error.of_message("PRO0009")
			else
				long ll_count
				
				Select count(1)
				INTO :ll_count
				FROM t_password WHERE id_user = :il_userid ;
				
				IF ll_count = 0 THEN
					INSERT INTO t_password (id_user, password) 
					(select t_users.id_user,
							  t_users.login_user
						from t_users
					  where t_users.id_user = :il_userid);
				END IF
				
				// ouvrir w_editpwd
				w_editpwd lw_wind
				
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("Changement mot de passe usager", string(il_userid))
				
				Open(lw_wind)
			end if
		END IF
		
END CHOOSE

end event

type dw_detailsusager from u_dw within w_groupes
integer x = 3835
integer y = 248
integer width = 763
integer height = 680
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_user"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_preupdate;call super::pfc_preupdate;long ll_no, ll_row, ll_cnt
string ls_login

IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	// Récupérer d'abord l'ID pour pouvoir l'exclure du test
	ll_no = THIS.object.id_user[ll_row]
	
	ls_login = lower(THIS.object.login_user[ll_row])
	THIS.object.login_user[ll_row] = ls_login
	
	select count(*)
	  into :ll_cnt
	  from t_users
	 where typepass <> 'groupe'
		and login_user = :ls_login
		and id_user <> :ll_no;
	
	//Si le login existe déjà
	IF ll_cnt > 0 THEN
		gnv_app.inv_error.of_message("CIPQ0014", {"Nom d'usager"})
		RETURN FAILURE
	END IF
	
	IF IsNull(ll_no) THEN
		ll_no = PARENT.of_recupererprochainiduser()
		THIS.object.id_user[ll_row] = ll_no
		il_userid = ll_no
		
		ib_update = true
	END IF
	
END IF
RETURN SUCCESS

end event

event pfc_insertrow;call super::pfc_insertrow;if AncestorReturnValue > 0 then
	n_ds l_ds
	long ll_row, ll_userid, ll_grpid
	
	tv_users.of_GetDatastore(1,l_ds)
	
	ll_row = l_ds.insertrow(0)
	l_ds.object.id_user[ll_row] = -1
	l_ds.object.nom[ll_row] = ''
	l_ds.object.prenom[ll_row] = ''
	l_ds.object.picuser[ll_row] = 2
	il_userhandle = tv_users.of_InsertItem(0,l_ds,ll_row,'Last')
	ib_insertion = true
	tv_users.selectitem(il_userhandle)
	ib_insertion = false
end if

return AncestorReturnValue

end event

event pfc_update;call super::pfc_update;if AncestorReturnValue >= 0 and il_userhandle > 0 then
	n_ds l_ds
	long ll_row, ll_thisrow
	
	tv_users.of_GetDataRow(il_userhandle,l_ds,ll_row)
	
	ll_thisrow = this.getRow()
	
	if ll_thisrow <= 0 then return -1
	l_ds.object.id_user[ll_row] = this.object.id_user[ll_thisrow]
	l_ds.object.nom[ll_row] = this.object.nom[ll_thisrow]
	l_ds.object.prenom[ll_row] = this.object.prenom[ll_thisrow]
	l_ds.object.actif[ll_row] = this.object.actif[ll_thisrow]
	
	if ib_update then
		tv_users.of_RefreshItem(il_userhandle, ll_row)
		
		ib_update = false
	end if
	
	if ib_premiere_modif and ib_change then
		gnv_app.inv_error.of_message("CIPQ0020", {"Les changements que vous avez faits sont effectifs immédiatement.~r~nPar contre, vous devez fermer et rouvrir cette fenêtre pour les visualiser."})
		
		ib_premiere_modif = false
	end if
end if
return AncestorReturnValue

end event

event itemchanged;call super::itemchanged;ib_change = true

IF dwo.name = "login_user" THEN
	string	ls_psw
	long		ll_count
	
	//Si l'ancien password était vide, on le met par défaut au login
	ls_psw = THIS.object.password[row]
	IF IsNull(ls_psw) OR ls_psw = "" THEN
		THIS.object.password[row] = lower(data)
		
		if not ib_en_insertion then
			Select count(1)
			INTO :ll_count
			FROM t_password WHERE id_user = :il_userid ;
			
			IF ll_count = 0 THEN
				INSERT INTO t_password (id_user, password) 
				VALUES (:il_userid, lower(:data));
			ELSE
				UPDATE t_password 
				SET password = lower(:data)
				WHERE id_user = :il_userid ;
			END IF
		end if
	END IF
	
END IF
end event

event editchanged;call super::editchanged;ib_change = true
end event

type gb_groupes from groupbox within w_groupes
integer x = 59
integer y = 180
integer width = 1874
integer height = 2044
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Groupes"
end type

type gb_usagers from groupbox within w_groupes
integer x = 1957
integer y = 180
integer width = 2665
integer height = 2044
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Utilisateurs"
end type

type rr_1 from roundrectangle within w_groupes
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 172
integer width = 4631
integer height = 2072
integer cornerheight = 40
integer cornerwidth = 46
end type

