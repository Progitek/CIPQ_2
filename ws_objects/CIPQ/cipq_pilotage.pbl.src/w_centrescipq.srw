﻿$PBExportHeader$w_centrescipq.srw
forward
global type w_centrescipq from w_sheet
end type
type uo_toolbar from u_cst_toolbarstrip within w_centrescipq
end type
type dw_centrescipq from u_dw within w_centrescipq
end type
type p_8 from picture within w_centrescipq
end type
type st_title from st_uo_transparent within w_centrescipq
end type
type rr_1 from roundrectangle within w_centrescipq
end type
type rr_infopat from roundrectangle within w_centrescipq
end type
end forward

global type w_centrescipq from w_sheet
string tag = "menu=m_centrescipq"
integer x = 214
integer y = 221
integer width = 3689
integer height = 2096
string title = "Centres CIPQ"
uo_toolbar uo_toolbar
dw_centrescipq dw_centrescipq
p_8 p_8
st_title st_title
rr_1 rr_1
rr_infopat rr_infopat
end type
global w_centrescipq w_centrescipq

on w_centrescipq.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_centrescipq=create dw_centrescipq
this.p_8=create p_8
this.st_title=create st_title
this.rr_1=create rr_1
this.rr_infopat=create rr_infopat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_centrescipq
this.Control[iCurrent+3]=this.p_8
this.Control[iCurrent+4]=this.st_title
this.Control[iCurrent+5]=this.rr_1
this.Control[iCurrent+6]=this.rr_infopat
end on

on w_centrescipq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_centrescipq)
destroy(this.p_8)
destroy(this.st_title)
destroy(this.rr_1)
destroy(this.rr_infopat)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
	
uo_toolbar.of_displaytext(true)
end event

event pfc_postopen;call super::pfc_postopen;dw_centrescipq.event pfc_retrieve()
end event

type uo_toolbar from u_cst_toolbarstrip within w_centrescipq
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 1708
integer width = 3538
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Add","Ajouter"
		dw_centrescipq.event pfc_insertrow()
	CASE "Supprimer", "Delete"
		dw_centrescipq.event pfc_deleterow()			
	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type dw_centrescipq from u_dw within w_centrescipq
integer x = 91
integer y = 188
integer width = 3383
integer height = 1452
integer taborder = 10
string dataobject = "d_centrescipq"
end type

event pfc_retrieve;call super::pfc_retrieve;long ll_activesms, ll_protocolssl, i, ll_nbrow

ll_nbrow =  THIS.RETRIEVE()

for i = 1 to this.rowcount( )

	setnull(ll_activesms)
	setnull(ll_protocolssl)
	
	ll_activesms = this.getItemNumber(i,'activesms')
	if isnull(ll_activesms) then this.setitem(i,'activesms',0)
	ll_protocolssl = this.getItemNumber(i,'protocolesecurity')
	if isnull(ll_protocolssl) then this.setitem(i,'protocolesecurity',0)
	
next

return ll_nbrow

end event

type p_8 from picture within w_centrescipq
string tag = "resize=frb"
integer x = 69
integer y = 44
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\maison.jpg"
boolean focusrectangle = false
end type

type st_title from st_uo_transparent within w_centrescipq
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
string text = "Centres CIPQ"
end type

type rr_1 from roundrectangle within w_centrescipq
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

type rr_infopat from roundrectangle within w_centrescipq
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
