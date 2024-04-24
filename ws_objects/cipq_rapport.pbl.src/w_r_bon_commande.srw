$PBExportHeader$w_r_bon_commande.srw
forward
global type w_r_bon_commande from w_rapport
end type
end forward

global type w_r_bon_commande from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Bon de commande"
end type
global w_r_bon_commande w_r_bon_commande

on w_r_bon_commande.create
call super::create
end on

on w_r_bon_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne
string	ls_cie, ls_livno, ls_client

ls_cie = gnv_app.inv_entrepotglobal.of_retournedonnee("lien bon cie")
ls_livno = gnv_app.inv_entrepotglobal.of_retournedonnee("lien bon liv")
ls_client = gnv_app.inv_entrepotglobal.of_retournedonnee("lien bon client")

ll_nbligne = dw_preview.retrieve(ls_cie, ls_livno)

IF ll_nbligne > 0 THEN
	dw_preview.object.cc_client[1] = ls_client
	
END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_bon_commande
string dataobject = "d_r_bon_commande"
end type

