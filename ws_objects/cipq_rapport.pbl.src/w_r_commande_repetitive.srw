$PBExportHeader$w_r_commande_repetitive.srw
forward
global type w_r_commande_repetitive from w_rapport
end type
end forward

global type w_r_commande_repetitive from w_rapport
string title = "Rapport - Liste des commande répétitives"
end type
global w_r_commande_repetitive w_r_commande_repetitive

on w_r_commande_repetitive.create
call super::create
end on

on w_r_commande_repetitive.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne
date		ld_de, ld_a

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien imp commande rep de"))
ld_a = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien imp commande rep a"))

ll_nbligne = dw_preview.retrieve(ld_de, ld_a)

end event

type dw_preview from w_rapport`dw_preview within w_r_commande_repetitive
string dataobject = "d_r_commande_repetitive_liste"
end type

