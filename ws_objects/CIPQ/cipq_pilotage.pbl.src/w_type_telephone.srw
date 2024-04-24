$PBExportHeader$w_type_telephone.srw
forward
global type w_type_telephone from w_sheet_pilotage
end type
end forward

global type w_type_telephone from w_sheet_pilotage
string tag = "menu=m_typedetelephone"
end type
global w_type_telephone w_type_telephone

on w_type_telephone.create
int iCurrent
call super::create
end on

on w_type_telephone.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_type_telephone
integer x = 73
integer width = 91
integer height = 76
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\tel.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_type_telephone
end type

type st_title from w_sheet_pilotage`st_title within w_type_telephone
string text = "Type de téléphone"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_type_telephone
string dataobject = "d_type_telephone"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Type_Telephone", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_type_telephone
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_type_telephone
end type

