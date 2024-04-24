﻿$PBExportHeader$w_r_fiche_sante.srw
forward
global type w_r_fiche_sante from w_rapport
end type
end forward

global type w_r_fiche_sante from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Liste des commande répétitives"
end type
global w_r_fiche_sante w_r_fiche_sante

on w_r_fiche_sante.create
call super::create
end on

on w_r_fiche_sante.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne
date		ld_de, ld_a
string	ls_date_tmp, ls_tatouage

ls_date_tmp = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de")
if isNull(ls_date_tmp) then ls_date_tmp = ""
if isDate(ls_date_tmp) then ld_de = date(ls_date_tmp) else setNull(ld_de)

ls_date_tmp = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au")
if isNull(ls_date_tmp) then ls_date_tmp = ""
if isDate(ls_date_tmp) then ld_a = date(ls_date_tmp) else setNull(ld_a)

ls_tatouage = gnv_app.inv_entrepotglobal.of_retournedonnee("rapport fiche sante tatou", false)

ll_nbligne = dw_preview.retrieve(ls_tatouage, ld_de, ld_a)
end event

type dw_preview from w_rapport`dw_preview within w_r_fiche_sante
string dataobject = "d_r_fiche_sante"
end type

