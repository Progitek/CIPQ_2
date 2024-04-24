$PBExportHeader$w_impression_commande_repetitive.srw
forward
global type w_impression_commande_repetitive from w_sheet
end type
type em_a from editmask within w_impression_commande_repetitive
end type
type em_de from editmask within w_impression_commande_repetitive
end type
type st_3 from statictext within w_impression_commande_repetitive
end type
type st_2 from statictext within w_impression_commande_repetitive
end type
type uo_toolbar from u_cst_toolbarstrip within w_impression_commande_repetitive
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_impression_commande_repetitive
end type
type st_1 from statictext within w_impression_commande_repetitive
end type
type p_ra from picture within w_impression_commande_repetitive
end type
type rr_2 from roundrectangle within w_impression_commande_repetitive
end type
type rr_1 from roundrectangle within w_impression_commande_repetitive
end type
end forward

global type w_impression_commande_repetitive from w_sheet
string tag = "menu=m_impressiondescommandesrepetives"
integer width = 1838
integer height = 900
string title = "Impression des commandes répétitives"
em_a em_a
em_de em_de
st_3 st_3
st_2 st_2
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_impression_commande_repetitive w_impression_commande_repetitive

on w_impression_commande_repetitive.create
int iCurrent
call super::create
this.em_a=create em_a
this.em_de=create em_de
this.st_3=create st_3
this.st_2=create st_2
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_a
this.Control[iCurrent+2]=this.em_de
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.uo_toolbar_gauche
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.p_ra
this.Control[iCurrent+9]=this.rr_2
this.Control[iCurrent+10]=this.rr_1
end on

on w_impression_commande_repetitive.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_a)
destroy(this.em_de)
destroy(this.st_3)
destroy(this.st_2)
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
uo_toolbar_gauche.of_AddItem("Imprimer...", "Print!")
uo_toolbar_gauche.POST of_displaytext(true)

em_de.text = string(today())
em_a.text = string(today())
end event

type em_a from editmask within w_impression_commande_repetitive
integer x = 731
integer y = 404
integer width = 375
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type em_de from editmask within w_impression_commande_repetitive
integer x = 731
integer y = 284
integer width = 375
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type st_3 from statictext within w_impression_commande_repetitive
integer x = 535
integer y = 416
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 15793151
string text = "À:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_impression_commande_repetitive
integer x = 535
integer y = 300
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 15793151
string text = "De:"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_impression_commande_repetitive
event destroy ( )
integer x = 1275
integer y = 592
integer width = 507
integer taborder = 20
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_impression_commande_repetitive
event destroy ( )
integer x = 23
integer y = 592
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;date	ld_de, ld_a

//Les validations
ld_de = date(em_de.text)
ld_a = date(em_a.text)

IF IsNull(ld_de) THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing", {"De"})
	em_de.SetFocus()
END IF


IF IsNull(ld_a) THEN
	gnv_app.inv_error.of_message("pfc_requiredmissing", {"À"})
	em_a.SetFocus()
END IF

IF ld_de > ld_a THEN
	gnv_app.inv_error.of_message("CIPQ0104")
	em_de.SetFocus()
END IF

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien imp commande rep de", string(ld_de))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien imp commande rep a", string(ld_a))

w_r_commande_repetitive	lw_wind
OpenSheet(lw_wind, gnv_app.of_GetFrame(), 6, layered!)

end event

type st_1 from statictext within w_impression_commande_repetitive
integer x = 274
integer y = 60
integer width = 1467
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Impression des commandes répétitives"
boolean focusrectangle = false
end type

type p_ra from picture within w_impression_commande_repetitive
integer x = 55
integer y = 32
integer width = 165
integer height = 140
string picturename = "C:\ii4net\CIPQ\images\imprimer_repet.bmp"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_impression_commande_repetitive
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1765
integer height = 172
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_impression_commande_repetitive
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 1765
integer height = 356
integer cornerheight = 40
integer cornerwidth = 46
end type

