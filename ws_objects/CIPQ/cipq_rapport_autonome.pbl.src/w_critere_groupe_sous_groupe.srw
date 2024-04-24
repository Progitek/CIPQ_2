$PBExportHeader$w_critere_groupe_sous_groupe.srw
forward
global type w_critere_groupe_sous_groupe from w_sheet
end type
type dw_critere_groupe_sous_groupe from u_dw within w_critere_groupe_sous_groupe
end type
type uo_toolbar from u_cst_toolbarstrip within w_critere_groupe_sous_groupe
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_groupe_sous_groupe
end type
type st_1 from statictext within w_critere_groupe_sous_groupe
end type
type p_ra from picture within w_critere_groupe_sous_groupe
end type
type rr_2 from roundrectangle within w_critere_groupe_sous_groupe
end type
type rr_1 from roundrectangle within w_critere_groupe_sous_groupe
end type
end forward

global type w_critere_groupe_sous_groupe from w_sheet
string tag = "exclure_securite"
integer width = 1856
integer height = 928
string title = "Critères de groupe"
dw_critere_groupe_sous_groupe dw_critere_groupe_sous_groupe
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
st_1 st_1
p_ra p_ra
rr_2 rr_2
rr_1 rr_1
end type
global w_critere_groupe_sous_groupe w_critere_groupe_sous_groupe

type variables
n_cst_datetime	inv_datetime
date	id_debut, id_fin
end variables

on w_critere_groupe_sous_groupe.create
int iCurrent
call super::create
this.dw_critere_groupe_sous_groupe=create dw_critere_groupe_sous_groupe
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.st_1=create st_1
this.p_ra=create p_ra
this.rr_2=create rr_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_critere_groupe_sous_groupe
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.uo_toolbar_gauche
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.p_ra
this.Control[iCurrent+6]=this.rr_2
this.Control[iCurrent+7]=this.rr_1
end on

on w_critere_groupe_sous_groupe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_critere_groupe_sous_groupe)
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
uo_toolbar_gauche.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_gauche.POST of_displaytext(true)

end event

type dw_critere_groupe_sous_groupe from u_dw within w_critere_groupe_sous_groupe
integer x = 64
integer y = 200
integer width = 1733
integer height = 292
integer taborder = 10
string dataobject = "d_critere_groupe_sous_groupe"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;THIS.InsertRow(0)
end event

type uo_toolbar from u_cst_toolbarstrip within w_critere_groupe_sous_groupe
event destroy ( )
integer x = 1298
integer y = 636
integer width = 507
integer taborder = 20
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_critere_groupe_sous_groupe
event destroy ( )
integer x = 23
integer y = 636
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_retour, ls_groupe, ls_sous_groupe

ls_groupe = string(dw_critere_groupe_sous_groupe.object.groupe[1])
ls_sous_groupe = string(dw_critere_groupe_sous_groupe.object.sous_groupe[1])

IF IsNull(ls_groupe) THEN ls_groupe = ""
IF IsNull(ls_sous_groupe) THEN ls_sous_groupe = ""

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien groupe", ls_groupe)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien sous groupe", ls_sous_groupe)


w_r_liste_eleveur_groupe_sous_groupe lw_liste_eleveur_groupe_sous_groupe


ls_retour = gnv_app.inv_entrepotglobal.of_retournedonnee("rapport groupe", false)

//Ouvrir l'interface
SetPointer(HourGlass!)
CHOOSE CASE ls_retour
	CASE "w_r_liste_eleveur_groupe_sous_groupe"
		OpenSheet(lw_liste_eleveur_groupe_sous_groupe, gnv_app.of_GetFrame(), 6, layered!)

END CHOOSE
end event

type st_1 from statictext within w_critere_groupe_sous_groupe
integer x = 201
integer y = 44
integer width = 1042
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Critères de groupe"
boolean focusrectangle = false
end type

type p_ra from picture within w_critere_groupe_sous_groupe
integer x = 69
integer y = 48
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\repetitive.bmp"
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_critere_groupe_sous_groupe
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1787
integer height = 140
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_1 from roundrectangle within w_critere_groupe_sous_groupe
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 168
integer width = 1787
integer height = 436
integer cornerheight = 40
integer cornerwidth = 46
end type

