﻿$PBExportHeader$w_r_dihydro.srw
forward
global type w_r_dihydro from w_rapport
end type
end forward

global type w_r_dihydro from w_rapport
string title = "Rapport - traitement de Dihydrostreptomycine"
end type
global w_r_dihydro w_r_dihydro

on w_r_dihydro.create
call super::create
end on

on w_r_dihydro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nolot, ll_cpt, ll_nbligne
string	ls_annexe

ls_annexe = gnv_app.inv_entrepotglobal.of_retournedonnee("lien lot annexe")
ll_nolot = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien lot"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", "")

IF ls_annexe = "oui" THEN
	ll_nbligne = dw_preview.retrieve(ll_nolot, 1)
else
	ll_nbligne = dw_preview.retrieve(ll_nolot, 0)
end if

//IF ls_annexe = "oui" THEN
//	FOR ll_cpt = 1 TO ll_nbligne
//		dw_preview.object.cc_chk[ll_cpt] = 1
//	END FOR
//	
//END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_dihydro
string dataobject = "d_r_dihydro"
end type
