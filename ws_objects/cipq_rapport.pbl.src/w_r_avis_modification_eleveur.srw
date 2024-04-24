﻿$PBExportHeader$w_r_avis_modification_eleveur.srw
forward
global type w_r_avis_modification_eleveur from w_rapport
end type
end forward

global type w_r_avis_modification_eleveur from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Avis de modification des commandes fixes"
end type
global w_r_avis_modification_eleveur w_r_avis_modification_eleveur

on w_r_avis_modification_eleveur.create
call super::create
end on

on w_r_avis_modification_eleveur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_no_eleveur, ll_nbligne

ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur avis modification"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur avis modification", "")

ll_nbligne = dw_preview.retrieve(ll_no_eleveur)
end event

type dw_preview from w_rapport`dw_preview within w_r_avis_modification_eleveur
string dataobject = "d_r_avis_modification_eleveur"
end type
