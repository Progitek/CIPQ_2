$PBExportHeader$w_sheet_pilotage.srw
forward
global type w_sheet_pilotage from w_sheet
end type
type p_8 from picture within w_sheet_pilotage
end type
type rr_infopat from roundrectangle within w_sheet_pilotage
end type
type st_title from st_uo_transparent within w_sheet_pilotage
end type
type dw_pilotage from u_dw within w_sheet_pilotage
end type
type uo_toolbar from u_cst_toolbarstrip within w_sheet_pilotage
end type
type rr_1 from roundrectangle within w_sheet_pilotage
end type
end forward

global type w_sheet_pilotage from w_sheet
integer width = 3689
integer height = 2096
p_8 p_8
rr_infopat rr_infopat
st_title st_title
dw_pilotage dw_pilotage
uo_toolbar uo_toolbar
rr_1 rr_1
end type
global w_sheet_pilotage w_sheet_pilotage

on w_sheet_pilotage.create
int iCurrent
call super::create
this.p_8=create p_8
this.rr_infopat=create rr_infopat
this.st_title=create st_title
this.dw_pilotage=create dw_pilotage
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_8
this.Control[iCurrent+2]=this.rr_infopat
this.Control[iCurrent+3]=this.st_title
this.Control[iCurrent+4]=this.dw_pilotage
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.rr_1
end on

on w_sheet_pilotage.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_8)
destroy(this.rr_infopat)
destroy(this.st_title)
destroy(this.dw_pilotage)
destroy(this.uo_toolbar)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Rechercher...", "Search!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
	
uo_toolbar.of_displaytext(true)

THIS.Title = st_title.text
end event

event pfc_postopen;call super::pfc_postopen;dw_pilotage.event pfc_retrieve()
end event

type p_8 from picture within w_sheet_pilotage
string tag = "resize=frb"
integer x = 69
integer y = 44
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\maison.jpg"
boolean focusrectangle = false
end type

type rr_infopat from roundrectangle within w_sheet_pilotage
string tag = "resize=frbsr"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 37
integer y = 28
integer width = 3529
integer height = 100
integer cornerheight = 75
integer cornerwidth = 75
end type

type st_title from st_uo_transparent within w_sheet_pilotage
string tag = "resize=frbsr"
integer x = 174
integer y = 44
integer width = 1161
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
long backcolor = 15793151
string text = "Titre"
end type

type dw_pilotage from u_dw within w_sheet_pilotage
integer x = 91
integer y = 188
integer width = 3383
integer height = 1452
integer taborder = 10
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.RETRIEVE()
end event

event constructor;call super::constructor;THIS.of_setfind( true)
SetRowFocusIndicator(HAnd!)
end event

type uo_toolbar from u_cst_toolbarstrip within w_sheet_pilotage
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 1708
integer width = 3538
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Add","Ajouter"
		dw_pilotage.event pfc_insertrow()
	CASE "Supprimer", "Delete"
		dw_pilotage.event pfc_deleterow()
			
	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Rechercher..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_pilotage.RowCount() > 0 THEN
				dw_pilotage.SetRow(1)
				dw_pilotage.ScrollToRow(1)
				dw_pilotage.event pfc_finddlg()
			END IF
		END IF
		
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type rr_1 from roundrectangle within w_sheet_pilotage
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 152
integer width = 3525
integer height = 1528
integer cornerheight = 40
integer cornerwidth = 46
end type

