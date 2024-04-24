﻿$PBExportHeader$u_tabpg_isolement_calendrier.sru
forward
global type u_tabpg_isolement_calendrier from u_tabpg
end type
type st_1 from statictext within u_tabpg_isolement_calendrier
end type
type dw_isolement_calendrier from u_dw within u_tabpg_isolement_calendrier
end type
end forward

global type u_tabpg_isolement_calendrier from u_tabpg
integer width = 4425
integer height = 1828
long backcolor = 15793151
st_1 st_1
dw_isolement_calendrier dw_isolement_calendrier
end type
global u_tabpg_isolement_calendrier u_tabpg_isolement_calendrier

on u_tabpg_isolement_calendrier.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_isolement_calendrier=create dw_isolement_calendrier
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_isolement_calendrier
end on

on u_tabpg_isolement_calendrier.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_isolement_calendrier)
end on

type st_1 from statictext within u_tabpg_isolement_calendrier
integer x = 3598
integer y = 1652
integer width = 681
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "CIPQ - F - 44 (Mai 2006)"
boolean focusrectangle = false
end type

type dw_isolement_calendrier from u_dw within u_tabpg_isolement_calendrier
integer x = 9
integer y = 28
integer width = 4357
integer height = 1700
integer taborder = 10
string dataobject = "d_isolement_calendrier"
end type

event itemchanged;call super::itemchanged;datetime	ld_fin


IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE "traitementj1date"
			ld_fin = datetime(data)
			
			//Date de retrait 60 jours
			IF Not IsNull(ld_fin) THEN
				ld_fin = datetime(RelativeDate(date(ld_fin), 60))
			END IF
			
			THIS.object.traitementj1dateretrait[row] = ld_fin
			THIS.AcceptText()
			
		CASE "traitementj14date"
			ld_fin = datetime(data)
			
			//Date de retrait 30 jours 
			IF Not IsNull(ld_fin) THEN 
				ld_fin = datetime(RelativeDate(date(ld_fin), 30))
			END IF
			
			THIS.object.traitementj14dateretrait[row] = ld_fin
			THIS.AcceptText()
			
		CASE "mouleedatefin"
			ld_fin = datetime(data)
			
			//Date de retrait 14 jours 
			IF Not IsNull(ld_fin) THEN 
				ld_fin = datetime(RelativeDate(date(ld_fin), 14))
			END IF
			
			THIS.object.mouleedateretrait[row] = ld_fin
			THIS.AcceptText()
			
	END CHOOSE
END IF
			

end event
