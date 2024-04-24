$PBExportHeader$w_droitsgroupes.srw
forward
global type w_droitsgroupes from w_sheet_frame
end type
type tv_droits from u_tv within w_droitsgroupes
end type
type uo_toolbar_ok from u_cst_toolbarstrip within w_droitsgroupes
end type
type uo_toolbar_annuler from u_cst_toolbarstrip within w_droitsgroupes
end type
type dw_droits from u_dw within w_droitsgroupes
end type
type gb_droits from groupbox within w_droitsgroupes
end type
type gb_menu from groupbox within w_droitsgroupes
end type
type rr_1 from roundrectangle within w_droitsgroupes
end type
end forward

global type w_droitsgroupes from w_sheet_frame
string tag = "menu=m_administration"
boolean ib_isupdateable = false
tv_droits tv_droits
uo_toolbar_ok uo_toolbar_ok
uo_toolbar_annuler uo_toolbar_annuler
dw_droits dw_droits
gb_droits gb_droits
gb_menu gb_menu
rr_1 rr_1
end type
global w_droitsgroupes w_droitsgroupes

type variables
Private:

long il_user
boolean change = false

end variables

forward prototypes
private function string of_getmenudesc (string as_text)
end prototypes

private function string of_getmenudesc (string as_text);//////////////////////////////////////////////////////////////////////////////
//	Function:				of_GetMenuDesc
//	Description:  		Return the text of an object.
//////////////////////////////////////////////////////////////////////////////
long ll_idx, ll_cnt, ll_pos
string ls_desc, ls_piece1, ls_piece2

SetPointer ( HourGlass! )

ls_desc = trim(as_text)

If ls_desc <> "" Then
	ls_desc = rep(ls_desc, "~"", "")
	ll_pos = Pos ( ls_desc, "&&" ) 
	If ll_pos > 0 Then
		ls_piece1 = Mid(ls_desc, 1, ll_pos - 1)
		ls_piece2 = Mid(ls_desc, ll_pos)
		ls_piece1 = rep(ls_piece1, "&", "")
		ls_piece2 = rep(ls_piece2, "&", "")
		ls_desc = ls_piece1 + "&" + ls_piece2
	Else
		ls_desc = rep(ls_desc, "&", "")
	End If
	ll_pos = Pos ( ls_desc, "~t" ) 
	If ll_pos > 0 Then
		ls_desc = Mid(ls_desc, 1, ll_pos - 1)
	End If
End If

Return ls_desc
end function

on w_droitsgroupes.create
int iCurrent
call super::create
this.tv_droits=create tv_droits
this.uo_toolbar_ok=create uo_toolbar_ok
this.uo_toolbar_annuler=create uo_toolbar_annuler
this.dw_droits=create dw_droits
this.gb_droits=create gb_droits
this.gb_menu=create gb_menu
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_droits
this.Control[iCurrent+2]=this.uo_toolbar_ok
this.Control[iCurrent+3]=this.uo_toolbar_annuler
this.Control[iCurrent+4]=this.dw_droits
this.Control[iCurrent+5]=this.gb_droits
this.Control[iCurrent+6]=this.gb_menu
this.Control[iCurrent+7]=this.rr_1
end on

on w_droitsgroupes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_droits)
destroy(this.uo_toolbar_ok)
destroy(this.uo_toolbar_annuler)
destroy(this.dw_droits)
destroy(this.gb_droits)
destroy(this.gb_menu)
destroy(this.rr_1)
end on

event pfc_preopen;call super::pfc_preopen;string ls_nom

uo_toolbar_ok.of_settheme("classic")
uo_toolbar_ok.of_DisplayBorder(true)
uo_toolbar_ok.of_AddItem("Ok", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_ok.of_displaytext(true)

uo_toolbar_annuler.of_settheme("classic")
uo_toolbar_annuler.of_DisplayBorder(true)
uo_toolbar_annuler.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar_annuler.of_displaytext(true)

il_user = long(gnv_app.inv_entrepotglobal.of_retournedonnee("Droits groupe", true))

select nom into :ls_nom from t_users where id_user = :il_user;

st_title.text = "Gestion des droits pour le groupe " + ls_nom

end event

event closequery;call super::closequery;if change then
	choose case gnv_app.inv_error.of_message("pfc_closequery_savechanges")
		case 1
			if tv_droits.event ue_update() < 1 then return 1
		case 3
			return 1
	end choose
end if

end event

event pfc_postopen;call super::pfc_postopen;tv_droits.event ue_refresh()

end event

type st_title from w_sheet_frame`st_title within w_droitsgroupes
integer width = 2231
string text = "Droits des groupes"
end type

type p_8 from w_sheet_frame`p_8 within w_droitsgroupes
integer x = 64
integer y = 48
integer width = 101
integer height = 80
boolean originalsize = false
string picturename = "Custom016!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_droitsgroupes
integer width = 4617
end type

type tv_droits from u_tv within w_droitsgroupes
event ue_refresh ( )
event type integer ue_update ( )
event ue_check ( long al_hndl,  boolean ab_value )
event type long ue_addobject ( long al_parent,  string as_objet,  string as_desc )
event type integer ue_explodeobject ( menu am_item,  long al_hndl )
event type integer ue_updatetree ( long al_hndl )
integer x = 78
integer y = 252
integer width = 3529
integer height = 1940
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 15793151
boolean border = false
boolean linesatroot = true
boolean hideselection = false
end type

event ue_refresh();m_application lm_menuapp
TreeViewItem ltvi_item

// Si la page principale n'est pas chargée (techniquement impossible)
if not isValid(gnv_app.of_getFrame()) then return

// Si le menu de la page principale n'est pas chargé
if not isValid(gnv_app.of_getFrame().menuID) then return

// Si le menu de la page principale n'est pas m_aplication
if gnv_app.of_getFrame().menuID <> m_application then return

lm_menuapp = gnv_app.of_getFrame().menuID

// Si le menu formulaires est pas chargé
if isValid(lm_menuapp.m_formulaires) then
	this.event ue_explodeObject(lm_menuapp.m_formulaires, 0)
end if

// Si le menu pilotage est pas chargé
if isValid(lm_menuapp.m_pilotage) then
	this.event ue_explodeObject(lm_menuapp.m_pilotage, 0)
end if

// Si le menu rapports est pas chargé
if isValid(lm_menuapp.m_rapports) then
	this.event ue_explodeObject(lm_menuapp.m_rapports, 0)
end if

end event

event type integer ue_update();long ll_curhndl
treeViewItem ltvi_old

ll_curhndl = this.finditem(CurrentTreeItem!, 0)

if ll_curhndl > 0 then
	// Récupérer l'item anciennement sélectionné
	if this.GetItem(ll_curhndl, ltvi_old) > 0 then
		if dw_droits.event ue_update(ltvi_old) = 1 then
			this.setItem(ll_curhndl, ltvi_old)
			
			this.event ue_check(ll_curhndl, ltvi_old.bold)
		else
			return -1
		end if
	end if
end if


if not gnv_app.inv_audit.of_runsql_audit("delete from t_droitsusagers where id_user = " + string(il_user), "T_DroitsUsagers", "Suppression", parent.title) then return -1
commit;

ll_curhndl = this.findItem(RootTreeItem!, 0)

do while ll_curhndl > 0
	if event ue_updateTree(ll_curhndl) = -2 then return -1
	
	ll_curhndl = this.findItem(NextTreeItem!, ll_curhndl)
loop
commit;

change = false

return 1

end event

event ue_check(long al_hndl, boolean ab_value);treeViewItem ltvi_item
long ll_tmphndl

if getItem(al_hndl, ltvi_item) < 0 then return

ltvi_item.bold = ab_value

setItem(al_hndl, ltvi_item)

if ab_value then
	ll_tmphndl = findItem(ParentTreeItem!, al_hndl)
	
	do while ll_tmphndl > 0
		if getItem(ll_tmphndl, ltvi_item) > 0 then
			ltvi_item.bold = ab_value
			
			setItem(ll_tmphndl, ltvi_item)
			
			ll_tmphndl = findItem(ParentTreeItem!, ll_tmphndl)
		end if
	loop
else
	ll_tmphndl = findItem(ChildTreeItem!, al_hndl)
	
	do while ll_tmphndl > 0
		event ue_check(ll_tmphndl, ab_value)
		ll_tmphndl = findItem(NextTreeItem!, ll_tmphndl)
	loop
end if

end event

event type long ue_addobject(long al_parent, string as_objet, string as_desc);//////////////////////////////////////////////////////////////////////////////
//	Event:	ue_addobject
//////////////////////////////////////////////////////////////////////////////
long ll_cnt
string ls_droits
treeViewItem ltvi_object
n_cst_string lnv_str

SetPointer ( HourGlass! )

if as_desc = "" and al_parent <> 0 then return -1
if lnv_str.of_isFormat(as_desc) then return -1

ltvi_object.Label = as_desc
ltvi_object.Data = as_objet + '~n'

select count(1) into :ll_cnt from t_droitsusagers where id_user = :il_user and objet = :as_objet;

if ll_cnt > 0 then
	ltvi_object.bold = true
	
	select droits
	  into :ls_droits
	  from t_droitsusagers
	 where id_user = :il_user
		and objet = :as_objet;
	
	ltvi_object.Data = as_objet + '~n' + ls_droits
else
	ltvi_object.bold = false
end if

Return this.insertItemLast(al_parent, ltvi_object)

end event

event type integer ue_explodeobject(menu am_item, long al_hndl);//////////////////////////////////////////////////////////////////////////////
//	Event:			ue_ExplodeObject
//	Description:  	Recursively scan an object.
//////////////////////////////////////////////////////////////////////////////
long ll_cnt, ll_idx, ll_hndl
string ls_name

SetPointer ( HourGlass! )

if not isValid(am_item) then return -1
if pos(am_item.tag, 'exclure_securite') > 0 then return -1

// get the class itself
ls_name = lower(className(am_item))

select count(1)
  into :ll_cnt
  from t_droitsusagers
 where (id_user = :gnv_app.il_id_user
		 or id_user in (select id_group
									  from t_groupeusager
									 where id_user = :gnv_app.il_id_user))
	and objet = :ls_name;

if ll_cnt = 0 then return -1

ll_hndl = this.event ue_AddObject(al_hndl, ls_name, of_getMenuDesc(am_item.text))

yield()
setPointer(HourGlass!)

if ll_hndl > 0 then
	// see how many objects to be scaned
	ll_cnt = UpperBound(am_item.item)
	// get the controls on the object
	For ll_idx = 1 To ll_cnt
		this.event ue_explodeObject(am_item.item[ll_idx], ll_hndl)
	Next
end if

Return 1

end event

event type integer ue_updatetree(long al_hndl);TreeViewItem ltvi_item
string ls_objet, ls_droits = ""
long ll_child

if this.getItem(al_hndl, ltvi_item) <= 0 then return -1

if ltvi_item.bold then
	ls_objet = string(ltvi_item.data)
	ls_droits = mid(ls_objet, pos(ls_objet, '~n') + 1)
	ls_objet = left(ls_objet, pos(ls_objet, '~n') - 1)
	
	if not gnv_app.inv_audit.of_runsql_audit("insert into t_droitsusagers (id_user, objet, droits) values (" + string(il_user) + ", '" + ls_objet + "', '" + ls_droits + "')", "T_DroitsUsagers", "Insertion", parent.title) then
		ll_child = 0
		return -2
	end if
	
	ll_child = this.findItem(ChildTreeItem!, al_hndl)

	do while ll_child > 0
		if this.event ue_updateTree(ll_child) = -2 then return -2
		ll_child = this.findItem(NextTreeItem!, ll_child)
	loop
end if

return 1

end event

event selectionchanged;call super::selectionchanged;TreeViewItem ltvi_This
string ls_obj, ls_droits

// Récupérer l'item nouvellement sélectionné
if this.GetItem(newhandle, ltvi_This) > 0 then
	ls_obj = string(ltvi_This.data)
	ls_droits = mid(ls_obj, pos(ls_obj, '~n') + 1)
	ls_obj = left(ls_obj, pos(ls_obj, '~n') - 1)
	
	// Afficher le détail des droits de cet item
	dw_droits.event ue_retrieve(ls_obj, ltvi_This.bold, ls_droits)
end if

end event

event selectionchanging;call super::selectionchanging;treeViewItem ltvi_old

if not parent.of_getdroitmodification() then return 0

if oldHandle > 0 then
	// Récupérer l'item anciennement sélectionné
	if this.GetItem(oldhandle, ltvi_old) > 0 then
		if dw_droits.event ue_update(ltvi_old) = 1 then
			this.setItem(oldhandle, ltvi_old)
			
			this.event ue_check(oldhandle, ltvi_old.bold)
		else
			return 1
		end if
	end if
end if

end event

type uo_toolbar_ok from u_cst_toolbarstrip within w_droitsgroupes
integer x = 23
integer y = 2264
integer width = 786
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_ok.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;if change then
	if tv_droits.event ue_update() < 1 then return 0
end if

close(parent)

end event

type uo_toolbar_annuler from u_cst_toolbarstrip within w_droitsgroupes
integer x = 3927
integer y = 2264
integer width = 713
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_annuler.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;close(parent)

end event

type dw_droits from u_dw within w_droitsgroupes
event type long ue_retrieve ( string as_objet,  boolean ab_acces,  string as_droits )
event type integer ue_update ( ref treeviewitem atvi_upditem )
integer x = 3653
integer y = 252
integer width = 928
integer height = 740
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_detaildroits"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
string is_updatesallowed = ""
end type

event type long ue_retrieve(string as_objet, boolean ab_acces, string as_droits);// Affichage des droits passés en paramètre
long ll_row

if isNull(as_objet) or as_objet = '' or &
	isNull(ab_acces) or &
	isNull(as_droits)	then return -1

this.reset()

ll_row = this.insertRow(0)

if ll_row <= 0 then return -1

this.setItem(ll_row, 'id_user', il_user)
this.setItem(ll_row, 'objet', as_objet)

if ab_acces then
	this.setItem(ll_row, 'C', 1)
end if

if pos(upper(as_droits), 'I') > 0 then
	this.setItem(ll_row, 'I', 1)
end if

if pos(upper(as_droits), 'M') > 0 then
	this.setItem(ll_row, 'M', 1)
end if

if pos(upper(as_droits), 'D') > 0 then
	this.setItem(ll_row, 'D', 1)
end if

if pos(upper(as_droits), 'A') > 0 then
	this.setItem(ll_row, 'A', 1)
end if

return 1

end event

event type integer ue_update(ref treeviewitem atvi_upditem);long ll_row
string ls_objet, ls_droits = ""
boolean lb_acces

if not parent.of_getdroitmodification() then
	gnv_app.inv_error.of_message("PRO0013")
	return -1
end if

if isNull(atvi_upditem) then return -1
ll_row = this.getRow()
if ll_row <= 0 then return -1

this.acceptText()

ls_objet = this.getItemString(ll_row, 'objet')

atvi_upditem.data = ls_objet + '~n'

if this.getItemNumber(ll_row, 'C') = 1 then
	atvi_upditem.bold = true
	
	// Si on a le droit d'insérer
	if this.getItemNumber(ll_row, 'I') = 1 then ls_droits += 'I'
	// Si on a le droit de modifier
	if this.getItemNumber(ll_row, 'M') = 1 then ls_droits += 'M'
	// Si on a le droit de détruire
	if this.getItemNumber(ll_row, 'D') = 1 then ls_droits += 'D'
	// Si on a d'autres droits
	if this.getItemNumber(ll_row, 'A') = 1 then ls_droits += 'A'

	atvi_upditem.Data = ls_objet + '~n' + ls_droits
else
	atvi_upditem.bold = false
end if

gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_droitsusagers", TRUE)

return 1

end event

event itemchanged;call super::itemchanged;change = true

end event

event editchanged;call super::editchanged;change = true

end event

type gb_droits from groupbox within w_droitsgroupes
integer x = 3630
integer y = 180
integer width = 978
integer height = 2040
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Droits"
end type

type gb_menu from groupbox within w_droitsgroupes
integer x = 50
integer y = 180
integer width = 4558
integer height = 2040
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Menu"
end type

type rr_1 from roundrectangle within w_droitsgroupes
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 168
integer width = 4617
integer height = 2076
integer cornerheight = 40
integer cornerwidth = 46
end type

