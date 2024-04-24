﻿$PBExportHeader$w_cote_fertilite.srw
forward
global type w_cote_fertilite from w_sheet_pilotage
end type
end forward

global type w_cote_fertilite from w_sheet_pilotage
string tag = "menu=m_cotesdefertilite"
end type
global w_cote_fertilite w_cote_fertilite

on w_cote_fertilite.create
int iCurrent
call super::create
end on

on w_cote_fertilite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_cote_fertilite
integer y = 40
integer width = 91
integer height = 80
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\task.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_cote_fertilite
end type

type st_title from w_sheet_pilotage`st_title within w_cote_fertilite
string text = "Cote de fertilité"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_cote_fertilite
string dataobject = "d_cote_fertilite"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_RecolteCote", TRUE)
	Messagebox("Attention", "Veuillez aviser l'administration du changement que vous venez de faire puisque ceci implique la modification d'un rapport.")
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_cote_fertilite
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_cote_fertilite
end type

