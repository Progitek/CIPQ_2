$PBExportHeader$w_bonnonfact.srw
forward
global type w_bonnonfact from w_rapport
end type
end forward

global type w_bonnonfact from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Bon de commande"
end type
global w_bonnonfact w_bonnonfact

on w_bonnonfact.create
call super::create
end on

on w_bonnonfact.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne
string	ls_cie, ls_livno, ls_client
date ldt_date

ldt_date = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien bonfact date"))

ll_nbligne = dw_preview.retrieve(ldt_date)

end event

type dw_preview from w_rapport`dw_preview within w_bonnonfact
string dataobject = "d_bonnonfact"
end type

