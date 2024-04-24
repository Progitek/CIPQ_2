﻿$PBExportHeader$w_type_semence.srw
forward
global type w_type_semence from w_sheet_pilotage
end type
end forward

global type w_type_semence from w_sheet_pilotage
string tag = "menu=m_typesdesemence"
end type
global w_type_semence w_type_semence

on w_type_semence.create
int iCurrent
call super::create
end on

on w_type_semence.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_type_semence
integer x = 64
integer y = 40
integer width = 96
integer height = 80
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\Soft-rain-icon.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_type_semence
end type

type st_title from w_sheet_pilotage`st_title within w_type_semence
string text = "Types de semence"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_type_semence
string dataobject = "d_type_semence"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_TypeDeSemence", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_type_semence
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_type_semence
end type
