$PBExportHeader$w_r_liste_classe.srw
forward
global type w_r_liste_classe from w_rapport
end type
end forward

global type w_r_liste_classe from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Liste des classes"
end type
global w_r_liste_classe w_r_liste_classe

on w_r_liste_classe.create
call super::create
end on

on w_r_liste_classe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_classe
string dataobject = "d_r_liste_classe"
end type

