﻿$PBExportHeader$w_editpwd_user.srw
forward
global type w_editpwd_user from w_response
end type
type uo_toolbar from u_cst_toolbarstrip within w_editpwd_user
end type
type sle_confirm from u_sle within w_editpwd_user
end type
type st_confirm from u_st within w_editpwd_user
end type
type sle_nouveau from u_sle within w_editpwd_user
end type
type st_nouveau from u_st within w_editpwd_user
end type
type st_ancien from u_st within w_editpwd_user
end type
type sle_ancien from u_sle within w_editpwd_user
end type
type rr_1 from roundrectangle within w_editpwd_user
end type
end forward

global type w_editpwd_user from w_response
integer width = 1221
integer height = 632
boolean titlebar = false
boolean controlmenu = false
long backcolor = 12639424
string pointer = "Arrow!"
uo_toolbar uo_toolbar
sle_confirm sle_confirm
st_confirm st_confirm
sle_nouveau sle_nouveau
st_nouveau st_nouveau
st_ancien st_ancien
sle_ancien sle_ancien
rr_1 rr_1
end type
global w_editpwd_user w_editpwd_user

type variables
Protected:
long il_usager
string is_pwd
string is_defaut
end variables

on w_editpwd_user.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.sle_confirm=create sle_confirm
this.st_confirm=create st_confirm
this.sle_nouveau=create sle_nouveau
this.st_nouveau=create st_nouveau
this.st_ancien=create st_ancien
this.sle_ancien=create sle_ancien
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.sle_confirm
this.Control[iCurrent+3]=this.st_confirm
this.Control[iCurrent+4]=this.sle_nouveau
this.Control[iCurrent+5]=this.st_nouveau
this.Control[iCurrent+6]=this.st_ancien
this.Control[iCurrent+7]=this.sle_ancien
this.Control[iCurrent+8]=this.rr_1
end on

on w_editpwd_user.destroy
call super::destroy
destroy(this.uo_toolbar)
destroy(this.sle_confirm)
destroy(this.st_confirm)
destroy(this.sle_nouveau)
destroy(this.st_nouveau)
destroy(this.st_ancien)
destroy(this.sle_ancien)
destroy(this.rr_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_editpwd
//
//	Description:  Allows the editing of user or group information
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
this.title = 'Modifier mot de passe'

il_usager = long(gnv_app.inv_entrepotglobal.of_retournedonnee("Changement mot de passe usager", true))

if il_usager < 0 OR IsNull(il_usager)  then close(this)

select isnull(password, ''), login_user
  into :is_pwd, :is_defaut
  from t_users
 where id_user = :il_usager;

select FIRST isnull(password, '')
  into :is_pwd
  from t_password
 where id_user = :il_usager;
 
if SQLCA.SQLCode <> 0 then close(this)




end event

event pfc_save;call super::pfc_save;// Aucun changement
if sle_ancien.text = '' and sle_nouveau.text = '' and sle_confirm.text = '' then
	return 0
end if

// validate the old and new password
if sle_ancien.text <> is_pwd then
	gnv_app.inv_error.of_message("CIPQ0020", {"L'ancien mot de passe est incorrect."})
	Return -1
end if
if sle_nouveau.text <> sle_confirm.text then
	gnv_app.inv_error.of_message("CIPQ0020", {"La confirmation diffère du nouveau mot de passe."})
	Return -1
end if

// if everything is correct, update the password and inform the user
if not gnv_app.inv_audit.of_runsql_audit("update t_password set password = '" + sle_nouveau.text + "' where id_user = " + string(il_usager), "T_password", "Mise à jour", this.Title) then return -1

gnv_app.inv_error.of_message("CIPQ0086")
return AncestorReturnValue

end event

event pfc_postopen;call super::pfc_postopen;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Ok", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar.of_AddItem("Mettre par défaut", "C:\ii4net\CIPQ\images\loupe.bmp")
uo_toolbar.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.of_displaytext(true)
end event

type uo_toolbar from u_cst_toolbarstrip within w_editpwd_user
integer x = 23
integer y = 492
integer width = 1170
integer taborder = 60
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	case "Ok"
		if event pfc_save() < 0 then return
		
	Case "Mettre par défaut"
		//Déterminer la valeur par défaut
		if not gnv_app.inv_audit.of_runsql_audit("update t_users set password = null where id_user = " + string(il_usager), "T_Users", "Mise à jour", parent.Title) then return
		
		delete from t_password where id_user = :il_usager;
		
END CHOOSE

Close(parent)
end event

type sle_confirm from u_sle within w_editpwd_user
integer x = 640
integer y = 340
integer width = 517
integer height = 88
integer taborder = 30
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string pointer = "Arrow!"
boolean password = true
boolean ib_autoselect = true
boolean ib_rmbmenu = false
end type

type st_confirm from u_st within w_editpwd_user
integer x = 27
integer y = 312
integer width = 576
integer height = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string pointer = "Arrow!"
long textcolor = 32768
long backcolor = 15793151
string text = "Confirmer nouveau mot de passe :"
alignment alignment = right!
end type

type sle_nouveau from u_sle within w_editpwd_user
integer x = 640
integer y = 196
integer width = 517
integer height = 88
integer taborder = 20
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string pointer = "Arrow!"
boolean password = true
boolean ib_autoselect = true
boolean ib_rmbmenu = false
end type

type st_nouveau from u_st within w_editpwd_user
integer x = 206
integer y = 172
integer width = 398
integer height = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string pointer = "Arrow!"
long textcolor = 32768
long backcolor = 15793151
string text = "Nouveau mot de passe :"
alignment alignment = right!
end type

type st_ancien from u_st within w_editpwd_user
integer x = 261
integer y = 32
integer width = 343
integer height = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string pointer = "Arrow!"
long textcolor = 32768
long backcolor = 15793151
string text = "Ancien mot de passe :"
alignment alignment = right!
end type

type sle_ancien from u_sle within w_editpwd_user
integer x = 640
integer y = 52
integer width = 517
integer height = 88
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string pointer = "Arrow!"
boolean password = true
boolean ib_autoselect = true
boolean ib_rmbmenu = false
end type

type rr_1 from roundrectangle within w_editpwd_user
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 12
integer width = 1170
integer height = 456
integer cornerheight = 40
integer cornerwidth = 46
end type

