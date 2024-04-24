﻿$PBExportHeader$w_r_rejet_hebdomadaires.srw
forward
global type w_r_rejet_hebdomadaires from w_rapport
end type
end forward

global type w_r_rejet_hebdomadaires from w_rapport
integer x = 214
integer y = 221
end type
global w_r_rejet_hebdomadaires w_r_rejet_hebdomadaires

event pfc_postopen;call super::pfc_postopen;date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

dw_preview.retrieve(ld_de, ld_au )
end event

on w_r_rejet_hebdomadaires.create
call super::create
end on

on w_r_rejet_hebdomadaires.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from w_rapport`dw_preview within w_r_rejet_hebdomadaires
string dataobject = "d_r_rejets_hebdomadaires"
end type

