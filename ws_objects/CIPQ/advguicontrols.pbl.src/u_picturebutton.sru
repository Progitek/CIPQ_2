$PBExportHeader$u_picturebutton.sru
forward
global type u_picturebutton from picture
end type
end forward

global type u_picturebutton from picture
integer width = 777
integer height = 288
string pointer = "HyperLink!"
boolean focusrectangle = false
event ue_mousebuttondown pbm_lbuttondown
event ue_mousebuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
event ue_mousedblclick pbm_lbuttondblclk
end type
global u_picturebutton u_picturebutton

type variables
long il_position_x
long il_position_y
end variables

event ue_mousebuttondown;// Retenir la position original du X et du Y
il_position_x = this.x
il_position_y = this.y

IF il_position_x <> 0 AND il_position_y <> 0 THEN
	this.x = this.x + 10
	this.y = this.y + 10
END IF
end event

event ue_mousebuttonup;IF il_position_x <> 0 AND il_position_y <> 0 THEN
	this.x = il_position_x
	this.y = il_position_y
END IF
end event

on u_picturebutton.create
end on

on u_picturebutton.destroy
end on

