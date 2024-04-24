$PBExportHeader$w_r_accpac_sommaire.srw
forward
global type w_r_accpac_sommaire from w_rapport
end type
end forward

global type w_r_accpac_sommaire from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - AccPack - Sommaire mensuel"
end type
global w_r_accpac_sommaire w_r_accpac_sommaire

on w_r_accpac_sommaire.create
call super::create
end on

on w_r_accpac_sommaire.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb
string	ls_cur

ll_nb = dw_preview.Retrieve()
ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien sommaire mensuel")
IF ll_nb > 0 THEN
	dw_preview.object.cc_date_periode[1] = ls_cur	
END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_accpac_sommaire
string dataobject = "d_r_accpac_sommaire"
end type

