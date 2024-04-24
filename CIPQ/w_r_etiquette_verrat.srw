HA$PBExportHeader$w_r_etiquette_verrat.srw
forward
global type w_r_etiquette_verrat from w_rapport
end type
end forward

global type w_r_etiquette_verrat from w_rapport
string title = "Rapport - $$HEX1$$c900$$ENDHEX$$tiquettes de verrats"
end type
global w_r_etiquette_verrat w_r_etiquette_verrat

on w_r_etiquette_verrat.create
call super::create
end on

on w_r_etiquette_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long	ll_nbligne

ll_nbligne = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_etiquette_verrat
string dataobject = "d_r_etiquette_verrat_nup2"
boolean ib_isupdateable = false
end type

