$PBExportHeader$w_r_integrite_fact.srw
forward
global type w_r_integrite_fact from w_rapport
end type
end forward

global type w_r_integrite_fact from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Problème (facturation)"
end type
global w_r_integrite_fact w_r_integrite_fact

on w_r_integrite_fact.create
call super::create
end on

on w_r_integrite_fact.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long	ll_nb
date	ld_cur
SetPointer(Hourglass!)

ld_cur = date ( gnv_app.inv_entrepotglobal.of_retournedonnee("lien integrite date"))
ll_nb = dw_preview.Retrieve(ld_cur)

end event

type dw_preview from w_rapport`dw_preview within w_r_integrite_fact
string dataobject = "d_r_integrite_fact"
end type

