$PBExportHeader$w_r_liste_technicien_laboratoire.srw
forward
global type w_r_liste_technicien_laboratoire from w_rapport
end type
end forward

global type w_r_liste_technicien_laboratoire from w_rapport
integer x = 214
integer y = 221
end type
global w_r_liste_technicien_laboratoire w_r_liste_technicien_laboratoire

on w_r_liste_technicien_laboratoire.create
call super::create
end on

on w_r_liste_technicien_laboratoire.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

dw_preview.retrieve( )
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_technicien_laboratoire
string dataobject = "d_r_liste_technicien_laboratoire"
end type

