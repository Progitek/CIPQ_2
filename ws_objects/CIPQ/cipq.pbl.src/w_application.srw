﻿$PBExportHeader$w_application.srw
forward
global type w_application from w_frame
end type
end forward

global type w_application from w_frame
integer x = 107
integer width = 4713
integer height = 2820
string menuname = "m_application"
windowstate windowstate = maximized!
end type
global w_application w_application

on w_application.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_application" then this.MenuID = create m_application
end on

on w_application.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;w_navigateur_principal lw_window
opensheet(lw_window,this,6, layered!)
do while yield()
loop

//gnv_app.of_appdroits(THIS.menuID,"")
end event

event pfc_preclose;call super::pfc_preclose;UPDATE t_users SET logged_in = 0 WHERE id_user = :gnv_app.il_id_user;
RETURN AncestorReturnValue
end event
