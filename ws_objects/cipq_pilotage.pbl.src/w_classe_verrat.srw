﻿$PBExportHeader$w_classe_verrat.srw
forward
global type w_classe_verrat from w_sheet_pilotage
end type
end forward

global type w_classe_verrat from w_sheet_pilotage
string tag = "menu=m_classesdeverrats"
integer x = 214
integer y = 221
end type
global w_classe_verrat w_classe_verrat

on w_classe_verrat.create
int iCurrent
call super::create
end on

on w_classe_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_classe_verrat
integer x = 73
integer y = 52
integer height = 52
string picturename = "C:\ii4net\CIPQ\images\listview_column.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_classe_verrat
end type

type st_title from w_sheet_pilotage`st_title within w_classe_verrat
string text = "Classes de verrats"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_classe_verrat
string dataobject = "d_classe_verrat"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Classe", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_classe_verrat
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_classe_verrat
end type

