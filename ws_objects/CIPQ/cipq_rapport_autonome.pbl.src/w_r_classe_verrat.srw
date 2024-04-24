$PBExportHeader$w_r_classe_verrat.srw
forward
global type w_r_classe_verrat from w_rapport
end type
end forward

global type w_r_classe_verrat from w_rapport
string title = "Rapport - Classification des verrats"
end type
global w_r_classe_verrat w_r_classe_verrat

on w_r_classe_verrat.create
call super::create
end on

on w_r_classe_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;
dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

dw_preview.retrieve( )
end event

type dw_preview from w_rapport`dw_preview within w_r_classe_verrat
string dataobject = "d_r_classe_verrat"
end type

