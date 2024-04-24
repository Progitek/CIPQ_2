﻿$PBExportHeader$w_r_accpac_detail.srw
forward
global type w_r_accpac_detail from w_rapport
end type
end forward

global type w_r_accpac_detail from w_rapport
string title = "Rapport - AccPack - Détail mensuel"
end type
global w_r_accpac_detail w_r_accpac_detail

on w_r_accpac_detail.create
call super::create
end on

on w_r_accpac_detail.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb, ll_cpt
string	ls_cur, ls_compte

ll_nb = dw_preview.Retrieve()
ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien detail mensuel")
IF ll_nb > 0 THEN
	FOR ll_cpt = 1 TO ll_nb
		dw_preview.object.cc_date_periode[ll_cpt] = ls_cur	
	END FOR
END IF

ls_compte = gnv_app.inv_entrepotglobal.of_retournedonnee("lien detail mensuel compte")
IF Not IsNull(ls_compte) AND ls_compte <> "" THEN
	//Ne sert pas
END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_accpac_detail
string dataobject = "d_r_accpac_detail"
end type
