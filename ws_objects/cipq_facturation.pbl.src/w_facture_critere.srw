$PBExportHeader$w_facture_critere.srw
forward
global type w_facture_critere from w_sheet
end type
type dw_facture_critere from u_dw within w_facture_critere
end type
type st_mois from statictext within w_facture_critere
end type
type uo_toolbar from u_cst_toolbarstrip within w_facture_critere
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_facture_critere
end type
type st_1 from statictext within w_facture_critere
end type
type p_ra from picture within w_facture_critere
end type
type rr_2 from roundrectangle within w_facture_critere
end type
type rr_1 from roundrectangle within w_facture_critere
end type
end forward

global type w_facture_critere from w_sheet
string tag = "exclure_securite"
integer width = 3488
integer height = 752
string title = "Critères de factures"
dw_facture_critere dw_facture_critere
st_mois st_mois
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_facture_critere w_facture_critere

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
end variables

on w_facture_critere.create
int iCurrent
call super::create
this.dw_facture_critere=create dw_facture_critere
this.st_mois=create st_mois
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_facture_critere
this.Control[iCurrent+2]=this.st_mois
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.uo_toolbar_gauche
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.p_ra
this.Control[iCurrent+7]=this.rr_2
this.Control[iCurrent+8]=this.rr_1
end on

on w_facture_critere.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_facture_critere)
destroy(this.st_mois)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.st_1)
destroy(this.p_ra)
destroy(this.rr_2)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("Filtrer...", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_gauche.POST of_displaytext(true)

dw_facture_critere.InsertRow(0)
//dw_facture_critere.object.date_facturation[1] = date(today())
end event

type dw_facture_critere from u_dw within w_facture_critere
integer x = 73
integer y = 200
integer width = 3310
integer height = 204
integer taborder = 10
string dataobject = "d_facture_critere"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type st_mois from statictext within w_facture_critere
integer x = 448
integer y = 248
integer width = 1074
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_facture_critere
event destroy ( )
integer x = 2926
integer y = 460
integer width = 507
integer taborder = 20
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_facture_critere
event destroy ( )
integer x = 23
integer y = 460
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;//Bâtir le filtre

string	ls_filtre = ""
date		ld_date
long		ll_no_fact, ll_no_eleveur

dw_facture_critere.AcceptText()

ll_no_fact = dw_facture_critere.object.no_facture[1]
ll_no_eleveur = dw_facture_critere.object.no_eleveur[1]
ld_date = dw_facture_critere.object.date_facturation[1]

IF Not IsNull(ld_date) AND ld_date <> 1900-01-01 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere fact date", string(ld_date))
END IF

IF Not IsNull(ll_no_fact) AND ll_no_fact <> 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere fact no fact", string(ll_no_fact))
END IF

IF Not IsNull(ll_no_eleveur) AND ll_no_eleveur <> 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere fact no eleveur", string(ll_no_eleveur))
END IF

//Ouvrir l'interface
w_facture_correction	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
end event

type st_1 from statictext within w_facture_critere
integer x = 201
integer y = 44
integer width = 3159
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Critères de factures"
boolean focusrectangle = false
end type

type p_ra from picture within w_facture_critere
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "Prior5!"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_facture_critere
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 3415
integer height = 140
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_facture_critere
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 3415
integer height = 260
integer cornerheight = 40
integer cornerwidth = 46
end type

