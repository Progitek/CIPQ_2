﻿$PBExportHeader$w_sous_groupe_verrat.srw
forward
global type w_sous_groupe_verrat from w_sheet_pilotage
end type
end forward

global type w_sous_groupe_verrat from w_sheet_pilotage
string tag = "menu=m_sousgroupesdeverrats"
end type
global w_sous_groupe_verrat w_sous_groupe_verrat

on w_sous_groupe_verrat.create
int iCurrent
call super::create
end on

on w_sous_groupe_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_sous_groupe_verrat
integer x = 78
integer y = 52
integer height = 52
string picturename = "C:\ii4net\CIPQ\images\listview_column.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_sous_groupe_verrat
end type

type st_title from w_sheet_pilotage`st_title within w_sous_groupe_verrat
string text = "Sous-groupes de verrats"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_sous_groupe_verrat
string dataobject = "d_sous_groupe_verrat"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_SousGroupe", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_sous_groupe_verrat
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_sous_groupe_verrat
end type

