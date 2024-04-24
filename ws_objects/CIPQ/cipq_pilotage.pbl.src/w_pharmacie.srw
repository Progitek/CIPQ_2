﻿$PBExportHeader$w_pharmacie.srw
forward
global type w_pharmacie from w_sheet_pilotage
end type
end forward

global type w_pharmacie from w_sheet_pilotage
string tag = "menu=m_pharmacies"
end type
global w_pharmacie w_pharmacie

on w_pharmacie.create
int iCurrent
call super::create
end on

on w_pharmacie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_pharmacie
string tag = ""
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\note.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_pharmacie
string tag = ""
integer linethickness = 0
end type

type st_title from w_sheet_pilotage`st_title within w_pharmacie
string tag = ""
string text = "Médicaments"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_pharmacie
integer width = 3392
integer taborder = 0
string dataobject = "d_pharmacie"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;long ll_row
dec{4} ld_poids

IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

ll_row = this.getRow()

if ll_row > 0 then
	ld_poids = this.object.poidsdosage[ll_row]
	if isNull(ld_poids) then ld_poids = 0
	
	if this.object.ind_utilisation[ll_row] = 2 then
		if ld_poids <= 0 then
			gnv_app.inv_error.of_message("CIPQ0165")
			return FAILURE
		end if
	else
		setNull(ld_poids)
		this.object.poidsdosage[ll_row] = ld_poids
	end if
end if

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Pharmacie", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_pharmacie
string tag = ""
integer width = 3529
integer taborder = 0
boolean bringtotop = false
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_pharmacie
integer linethickness = 0
integer cornerheight = 75
integer cornerwidth = 75
end type
