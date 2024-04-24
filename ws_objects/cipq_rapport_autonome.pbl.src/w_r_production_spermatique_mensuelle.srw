﻿$PBExportHeader$w_r_production_spermatique_mensuelle.srw
forward
global type w_r_production_spermatique_mensuelle from w_rapport
end type
end forward

global type w_r_production_spermatique_mensuelle from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Production spermatique mensuelle"
end type
global w_r_production_spermatique_mensuelle w_r_production_spermatique_mensuelle

on w_r_production_spermatique_mensuelle.create
call super::create
end on

on w_r_production_spermatique_mensuelle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")


dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

type dw_preview from w_rapport`dw_preview within w_r_production_spermatique_mensuelle
string dataobject = "d_r_production_spermatique_mensuelle"
end type

