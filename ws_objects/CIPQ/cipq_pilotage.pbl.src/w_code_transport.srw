﻿$PBExportHeader$w_code_transport.srw
forward
global type w_code_transport from w_sheet_pilotage
end type
end forward

global type w_code_transport from w_sheet_pilotage
string tag = "menu=m_codesdetransport"
end type
global w_code_transport w_code_transport

on w_code_transport.create
int iCurrent
call super::create
end on

on w_code_transport.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_code_transport
integer y = 32
integer width = 110
integer height = 88
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\trans.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_code_transport
end type

type st_title from w_sheet_pilotage`st_title within w_code_transport
integer x = 210
string text = "Codes de transport"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_code_transport
string dataobject = "d_code_transport"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_transport", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_code_transport
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_code_transport
end type

