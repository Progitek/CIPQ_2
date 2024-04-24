$PBExportHeader$w_r_liste_cotes_fertilite.srw
forward
global type w_r_liste_cotes_fertilite from w_rapport
end type
end forward

global type w_r_liste_cotes_fertilite from w_rapport
string title = "Rapport - Liste des cotes de fertilite"
end type
global w_r_liste_cotes_fertilite w_r_liste_cotes_fertilite

on w_r_liste_cotes_fertilite.create
call super::create
end on

on w_r_liste_cotes_fertilite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;
long		ll_nb

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(HourGlass!)
ll_nb = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_cotes_fertilite
string dataobject = "d_r_liste_cotes_fertilite"
end type

