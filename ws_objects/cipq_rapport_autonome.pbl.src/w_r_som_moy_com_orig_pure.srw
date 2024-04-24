﻿$PBExportHeader$w_r_som_moy_com_orig_pure.srw
forward
global type w_r_som_moy_com_orig_pure from w_rapport
end type
end forward

global type w_r_som_moy_com_orig_pure from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Sommaire des moyennes des commandes originales de pure"
end type
global w_r_som_moy_com_orig_pure w_r_som_moy_com_orig_pure

on w_r_som_moy_com_orig_pure.create
call super::create
end on

on w_r_som_moy_com_orig_pure.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

gnv_app.of_DoMoyenneCommOrig_Pur(date(ls_cur))

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

type dw_preview from w_rapport`dw_preview within w_r_som_moy_com_orig_pure
string dataobject = "d_r_som_moy_com_orig_pure"
end type

