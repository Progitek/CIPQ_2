﻿$PBExportHeader$w_r_conciliation_factures_hebergement.srw
forward
global type w_r_conciliation_factures_hebergement from w_rapport
end type
end forward

global type w_r_conciliation_factures_hebergement from w_rapport
string title = "Rapport - Conciliation des factures en Hébergement"
end type
global w_r_conciliation_factures_hebergement w_r_conciliation_factures_hebergement

on w_r_conciliation_factures_hebergement.create
call super::create
end on

on w_r_conciliation_factures_hebergement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")


ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

type dw_preview from w_rapport`dw_preview within w_r_conciliation_factures_hebergement
string dataobject = "d_r_conciliation_factures_hebergement"
end type
