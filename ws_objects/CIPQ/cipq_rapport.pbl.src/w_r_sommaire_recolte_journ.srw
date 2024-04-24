﻿$PBExportHeader$w_r_sommaire_recolte_journ.srw
forward
global type w_r_sommaire_recolte_journ from w_rapport
end type
end forward

global type w_r_sommaire_recolte_journ from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Sommaire des récoltes journalières"
end type
global w_r_sommaire_recolte_journ w_r_sommaire_recolte_journ

on w_r_sommaire_recolte_journ.create
call super::create
end on

on w_r_sommaire_recolte_journ.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne
string	ls_date

ls_date = gnv_app.inv_entrepotglobal.of_retournedonnee("lien rapport recolte commande date")
IF ls_date = "" OR isnull(ls_date) OR ls_date = "00-00-0000" THEN
	ls_date = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")
ELSE
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rapport recolte commande date", "")
END IF

ll_nbligne = dw_preview.retrieve(date(ls_date))

end event

type dw_preview from w_rapport`dw_preview within w_r_sommaire_recolte_journ
string dataobject = "d_r_sommaire_recolte_journ"
end type

