﻿$PBExportHeader$w_r_labo_infolot.srw
forward
global type w_r_labo_infolot from w_rapport
end type
end forward

global type w_r_labo_infolot from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Pour labo"
end type
global w_r_labo_infolot w_r_labo_infolot

on w_r_labo_infolot.create
call super::create
end on

on w_r_labo_infolot.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_preview.Retrieve()



end event

type dw_preview from w_rapport`dw_preview within w_r_labo_infolot
string dataobject = "d_r_labo_infolot"
end type

