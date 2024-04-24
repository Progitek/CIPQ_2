﻿$PBExportHeader$w_r_transferts_importes.srw
forward
global type w_r_transferts_importes from w_rapport
end type
end forward

global type w_r_transferts_importes from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Transferts importés"
end type
global w_r_transferts_importes w_r_transferts_importes

on w_r_transferts_importes.create
call super::create
end on

on w_r_transferts_importes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb, ll_month, ll_year
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

type dw_preview from w_rapport`dw_preview within w_r_transferts_importes
string dataobject = "d_r_transferts_importes"
end type

