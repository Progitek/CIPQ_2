$PBExportHeader$w_r_accpac_sommaire_export.srw
forward
global type w_r_accpac_sommaire_export from w_rapport
end type
end forward

global type w_r_accpac_sommaire_export from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - AccPack - Sommaire mensuel tel que exportation"
end type
global w_r_accpac_sommaire_export w_r_accpac_sommaire_export

on w_r_accpac_sommaire_export.create
call super::create
end on

on w_r_accpac_sommaire_export.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb
string	ls_cur, ls_compte

ll_nb = dw_preview.Retrieve()
ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien sommaire mensuel dernier transfert")
IF ll_nb > 0 THEN
	dw_preview.object.cc_date_periode[1] = ls_cur	
END IF

ls_compte = gnv_app.inv_entrepotglobal.of_retournedonnee("lien sommaire mensuel dernier transfert compte")
IF Not IsNull(ls_compte) AND ls_compte <> "" THEN
	//Ne sert pas
END IF
end event

type dw_preview from w_rapport`dw_preview within w_r_accpac_sommaire_export
string dataobject = "d_r_accpac_sommaire_exportation"
end type

