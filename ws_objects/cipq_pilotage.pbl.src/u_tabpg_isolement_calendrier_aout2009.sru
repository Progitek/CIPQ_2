﻿$PBExportHeader$u_tabpg_isolement_calendrier_aout2009.sru
forward
global type u_tabpg_isolement_calendrier_aout2009 from u_tabpg
end type
type st_1 from statictext within u_tabpg_isolement_calendrier_aout2009
end type
type dw_isolement_calendrier_aout2009 from u_dw within u_tabpg_isolement_calendrier_aout2009
end type
end forward

global type u_tabpg_isolement_calendrier_aout2009 from u_tabpg
integer width = 4425
integer height = 1828
long backcolor = 15793151
st_1 st_1
dw_isolement_calendrier_aout2009 dw_isolement_calendrier_aout2009
end type
global u_tabpg_isolement_calendrier_aout2009 u_tabpg_isolement_calendrier_aout2009

on u_tabpg_isolement_calendrier_aout2009.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_isolement_calendrier_aout2009=create dw_isolement_calendrier_aout2009
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_isolement_calendrier_aout2009
end on

on u_tabpg_isolement_calendrier_aout2009.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_isolement_calendrier_aout2009)
end on

type st_1 from statictext within u_tabpg_isolement_calendrier_aout2009
integer x = 3479
integer y = 1652
integer width = 814
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "CIPQ - F - 44 (Août 2009)"
boolean focusrectangle = false
end type

type dw_isolement_calendrier_aout2009 from u_dw within u_tabpg_isolement_calendrier_aout2009
integer x = 9
integer y = 28
integer width = 4357
integer height = 1700
integer taborder = 10
string dataobject = "d_isolement_calendrier_aout2009"
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
			
		CASE "traitementj30date"
			ld_fin = datetime(data)
			
			//Date de retrait 60 jours 
			IF Not IsNull(ld_fin) THEN 
				ld_fin = datetime(RelativeDate(date(ld_fin), 60))
			END IF
			
			THIS.object.traitementj30dateretrait[row] = ld_fin
			THIS.AcceptText()
			
	END CHOOSE
END IF
			

end event

event pfc_postupdate;call super::pfc_postupdate;long ll_verifie, ll_row

ll_row = this.getRow()

if ll_row > 0 then
	ll_verifie = this.object.verifiepar[ll_row]
	
	if not isNull(ll_verifie) then
		this.setTabOrder("verifiepar", 0)
	end if
end if

return ancestorReturnValue
end event

event retrieveend;call super::retrieveend;long ll_verifie, ll_row

ll_row = rowcount

if ll_row > 0 then
	ll_verifie = this.object.verifiepar[ll_row]
	
	if isNull(ll_verifie) then
		this.setTabOrder("verifiepar", 280)
	else
		this.setTabOrder("verifiepar", 0)
	end if
end if

return ancestorReturnValue
end event

