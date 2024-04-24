$PBExportHeader$w_billets.srw
forward
global type w_billets from w_main
end type
type dw_billet from u_dw within w_billets
end type
type cb_close from commandbutton within w_billets
end type
type cb_update from commandbutton within w_billets
end type
type cb_insert from commandbutton within w_billets
end type
end forward

global type w_billets from w_main
integer width = 3671
integer height = 1972
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean ib_isupdateable = false
boolean ib_disableclosequery = true
dw_billet dw_billet
cb_close cb_close
cb_update cb_update
cb_insert cb_insert
end type
global w_billets w_billets

type variables
public long il_idbillet, il_idprojet
public boolean change = false
end variables

forward prototypes
public subroutine save ()
end prototypes

public subroutine save ();
end subroutine

on w_billets.create
int iCurrent
call super::create
this.dw_billet=create dw_billet
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_insert=create cb_insert
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_billet
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_update
this.Control[iCurrent+4]=this.cb_insert
end on

on w_billets.destroy
call super::destroy
destroy(this.dw_billet)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_insert)
end on

event open;call super::open;datawindowchild ddwc_mod

il_idbillet = message.doubleparm
if il_idbillet > 0 then
	if dw_billet.getChild("id_module",ddwc_mod) = -1 then
		error_type(50)
	end if
	ddwc_mod.setTransObject(SQLCA)
	ddwc_mod.Retrieve()
	dw_billet.event ue_retrieve()
else
	dw_billet.event ue_insert()
end if

end event

event closequery;call super::closequery;if change then
	if error_type(200) = 1 then
		IF dw_billet.event ue_update() = 1 THEN
			RETURN 1
		END IF
	end if
end if

if isvalid(w_listebillets) then
	w_listebillets.dw_listebillets.event ue_retrieve(1)
end if
end event

type dw_billet from u_dw within w_billets
event ue_retrieve ( )
event ue_insert ( )
event type integer ue_update ( )
event ue_delete ( )
integer y = 8
integer width = 3593
integer height = 1820
integer taborder = 10
string title = "Billet"
string dataobject = "d_billet"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event ue_retrieve();Retrieve(il_idbillet)

end event

event ue_insert();long ll_newrow,ll_newrow2, ll_newrow3

// Insérer billet 

ll_newrow = dw_billet.insertRow(0)

If w_app.il_patid > 0 ANd not isnull(w_app.il_patid) THEN
	dw_billet.setItem(ll_newrow,'id_patient',w_app.il_patid)
END IF

dw_billet.setItem(ll_newrow,'id_user',gl_iduser)
dw_billet.setItem(ll_newrow,'id_prog',gl_iduser)
dw_billet.setItem(ll_newrow,'bdate',today())
dw_billet.setItem(ll_newrow,'bheure',now())
dw_billet.setItem(ll_newrow,'degre',30)

dw_billet.scrollToRow(ll_newrow)
dw_billet.setFocus()


end event

event type integer ue_update();// Mise à jour du billet
long	ll_row, ll_id

ll_row = dw_billet.GetRow()
IF ll_row > 0 THEN
	ll_id = dw_billet.object.id_patient[ll_row]
	If ll_id = 0 OR isnull(ll_id) THEN
		Messagebox("Erreur", "Le nom du client est obligatoire.")
		RETURN 1
	END IF
	
	
	if update() = 1 then
		commit using sqlca;
		change = false
		il_idbillet = getItemNumber(getRow(),'id_billet')
	else
		rollback using sqlca;
		error_type(50)
		RETURN 1
	end if
END IF

RETURN 0

end event

event ue_delete();deleterow(getrow())
change = true
end event

event editchanged;change = true
end event

event itemchanged;string ls_appellant
long ll_idmodule, ll_idprojet, ll_degre
datawindowchild ddwc_mod

if dwo.name = 'id_projet' then
	if this.getChild("id_module",ddwc_mod) = -1 then
		error_type(50)
	end if
	ddwc_mod.setTransObject(SQLCA)
	ddwc_mod.SetFilter("id_projet = "+string(long(data)))
	ddwc_mod.Retrieve()
end if

if dwo.name = 'appelant' then 
	ls_appellant = data
	ll_idmodule = getItemNumber(row,'id_module')
	ll_idprojet = getItemNumber(row,'id_projet')
	ll_degre = getItemNumber(row,'degre')
	if not(isnull(ls_appellant) or isnull(ll_idmodule) or isnull(ll_idprojet) or isnull(ll_degre)) then
		if update() = 1 then
			commit using SQLCA;
			il_idbillet = getItemNumber(getRow(),'id_billet')
			event ue_retrieve()
		else
			rollback using SQLCA;
		end if
	end if
end if

if dwo.name = 'id_module' then
	ls_appellant = getItemString(row,'appelant')
	ll_idmodule = long(data)
	ll_idprojet = getItemNumber(row,'id_projet')
	ll_degre = getItemNumber(row,'degre')
	if not(isnull(ls_appellant) or isnull(ll_idmodule) or isnull(ll_idprojet) or isnull(ll_degre)) then
		if update() = 1 then
			commit using SQLCA;
			il_idbillet = getItemNumber(getRow(),'id_billet')
			event ue_retrieve()
		else
			rollback using SQLCA;
		end if
	end if
end if

if dwo.name = 'id_projet' then
	ls_appellant = getItemString(row,'appelant')
	ll_idmodule = getItemNumber(row,'id_module')
	ll_idprojet = long(data)
	ll_degre = getItemNumber(row,'degre')
	if not(isnull(ls_appellant) or isnull(ll_idmodule) or isnull(ll_idprojet) or isnull(ll_degre)) then
		if update() = 1 then
			commit using SQLCA;
			il_idbillet = getItemNumber(getRow(),'id_billet')
			event ue_retrieve()
		else
			rollback using SQLCA;
		end if
	end if
end if

if dwo.name = 'degre' then
	ls_appellant = getItemString(row,'appelant')
	ll_idmodule = getItemNumber(row,'id_module')
	ll_idprojet = getItemNumber(row,'id_projet')
	ll_degre = long(data)
	if not(isnull(ls_appellant) or isnull(ll_idmodule) or isnull(ll_idprojet) or isnull(ll_degre)) then
		if update() = 1 then
			commit using SQLCA;
			il_idbillet = getItemNumber(getRow(),'id_billet')
			event ue_retrieve()
		else
			rollback using SQLCA;
		end if
	end if
end if

if dwo.name = 'id_etat' then
	IF data = "1" THEN
		THIS.object.datedebut[row] = datetime(today(), now())
	ELSEIF data = "4" OR data = "5" THEN
		THIS.object.datefin[row] = datetime(today(), now())
	END IF
END IF
change = true
end event

event constructor;pro_resize luo_size
luo_size.uf_resizedw(this)

SetTransObject(SQLCA)
end event

event buttonclicked;call super::buttonclicked;if dwo.name = 'b_debut' then
	setItem(row,'datedebut',datetime(today(),now()))
	THIS.object.id_etat[row]  = "1"
end if
if dwo.name = 'b_fin' then
	setItem(row,'datefin',datetime(today(),now()))
	THIS.object.id_etat[row]  = "4"
end if
change = TRUE
end event

type cb_close from commandbutton within w_billets
integer x = 2903
integer y = 1832
integer width = 695
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fermer"
end type

event clicked;close(parent)
end event

type cb_update from commandbutton within w_billets
integer x = 2107
integer y = 1832
integer width = 795
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sauvegarde"
end type

event clicked;dw_billet.event ue_update()
end event

type cb_insert from commandbutton within w_billets
integer x = 18
integer y = 1832
integer width = 745
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ajouter"
end type

event clicked;IF dw_billet.event ue_update() = 0 THEN
	dw_billet.event ue_insert()
END IF
end event

