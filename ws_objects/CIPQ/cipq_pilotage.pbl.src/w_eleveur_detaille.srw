$PBExportHeader$w_eleveur_detaille.srw
forward
global type w_eleveur_detaille from w_sheet_pilotage
end type
type st_1 from statictext within w_eleveur_detaille
end type
end forward

global type w_eleveur_detaille from w_sheet_pilotage
string tag = "menu=m_informationsdetailleesdeleleveur"
st_1 st_1
end type
global w_eleveur_detaille w_eleveur_detaille

on w_eleveur_detaille.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_eleveur_detaille.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

type p_8 from w_sheet_pilotage`p_8 within w_eleveur_detaille
integer width = 82
string picturename = "C:\ii4net\CIPQ\images\user.jpg"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_eleveur_detaille
end type

type st_title from w_sheet_pilotage`st_title within w_eleveur_detaille
string text = "Informations détaillées de l~'éleveur"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_eleveur_detaille
integer width = 3392
string dataobject = "d_eleveur_detaille"
end type

event dw_pilotage::constructor;call super::constructor;SetRowFocusIndicator(OFF!)
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_eleveur_detaille
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_eleveur_detaille
end type

type st_1 from statictext within w_eleveur_detaille
integer x = 128
integer y = 1232
integer width = 2363
integer height = 196
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217857
long backcolor = 67108864
string text = "Ne sert plus"
boolean focusrectangle = false
end type

