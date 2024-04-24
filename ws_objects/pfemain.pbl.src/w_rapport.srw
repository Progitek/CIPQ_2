$PBExportHeader$w_rapport.srw
forward
global type w_rapport from pro_w_rapport
end type
end forward

global type w_rapport from pro_w_rapport
string menuname = "m_rapport"
end type
global w_rapport w_rapport

on w_rapport.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport" then this.MenuID = create m_rapport
end on

on w_rapport.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from pro_w_rapport`dw_preview within w_rapport
integer width = 4567
integer taborder = 99
end type

