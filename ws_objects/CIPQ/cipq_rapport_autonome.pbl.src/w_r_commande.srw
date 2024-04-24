$PBExportHeader$w_r_commande.srw
forward
global type w_r_commande from w_rapport
end type
end forward

global type w_r_commande from w_rapport
string title = "Rapport - Commande"
end type
global w_r_commande w_r_commande

on w_r_commande.create
call super::create
end on

on w_r_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb
string	ls_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")


ll_nb = dw_preview.Retrieve(date(ls_cur))
end event

type dw_preview from w_rapport`dw_preview within w_r_commande
string dataobject = "d_r_commande"
end type

