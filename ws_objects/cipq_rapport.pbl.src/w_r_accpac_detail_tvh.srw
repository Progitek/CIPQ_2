$PBExportHeader$w_r_accpac_detail_tvh.srw
forward
global type w_r_accpac_detail_tvh from w_rapport
end type
end forward

global type w_r_accpac_detail_tvh from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - AccPack - Détail mensuel"
end type
global w_r_accpac_detail_tvh w_r_accpac_detail_tvh

on w_r_accpac_detail_tvh.create
call super::create
end on

on w_r_accpac_detail_tvh.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb, ll_cpt
string	ls_cur, ls_compte

ll_nb = dw_preview.Retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_accpac_detail_tvh
string dataobject = "d_r_accpac_detail_tvh"
end type

