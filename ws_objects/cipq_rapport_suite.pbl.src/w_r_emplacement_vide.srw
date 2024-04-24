$PBExportHeader$w_r_emplacement_vide.srw
forward
global type w_r_emplacement_vide from w_rapport
end type
end forward

global type w_r_emplacement_vide from w_rapport
end type
global w_r_emplacement_vide w_r_emplacement_vide

event pfc_postopen;call super::pfc_postopen;//dw_preview.of_SetTri(TRUE)
//
//dw_preview.inv_filter.of_setvisibleonly( FALSE)
//dw_preview.event pfc_filterdlg()

dw_preview.retrieve( )
end event

on w_r_emplacement_vide.create
call super::create
end on

on w_r_emplacement_vide.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from w_rapport`dw_preview within w_r_emplacement_vide
string dataobject = "d_r_plan_verraterie_vide_se"
end type

