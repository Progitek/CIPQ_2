﻿$PBExportHeader$w_emplacement_section.srw
forward
global type w_emplacement_section from w_sheet_pilotage
end type
end forward

global type w_emplacement_section from w_sheet_pilotage
string tag = "menu=m_sectionsdesverratsselonleuremplacement"
string title = "Sections des verrats selon leur emplacement"
end type
global w_emplacement_section w_emplacement_section

on w_emplacement_section.create
int iCurrent
call super::create
end on

on w_emplacement_section.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_emplacement_section
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_emplacement_section
end type

type st_title from w_sheet_pilotage`st_title within w_emplacement_section
integer width = 1477
string text = "Sections des verrats selon leur emplacement"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_emplacement_section
string dataobject = "d_emplacement_section"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Emplacement_Section", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_emplacement_section
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_emplacement_section
end type

