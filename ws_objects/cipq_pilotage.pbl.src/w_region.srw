$PBExportHeader$w_region.srw
forward
global type w_region from w_sheet_pilotage
end type
end forward

global type w_region from w_sheet_pilotage
string tag = "menu=m_regions"
end type
global w_region w_region

on w_region.create
int iCurrent
call super::create
end on

on w_region.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_region
integer y = 32
integer width = 96
integer height = 92
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\canada.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_region
end type

type st_title from w_sheet_pilotage`st_title within w_region
string text = "Régions"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_region
string dataobject = "d_region"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_RegionAgri", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_region
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_region
end type

