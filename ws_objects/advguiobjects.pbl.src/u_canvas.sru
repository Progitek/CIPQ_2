$PBExportHeader$u_canvas.sru
forward
global type u_canvas from userobject
end type
end forward

global type u_canvas from userobject native "Canvas.pbx"
public subroutine  of_settransparent(boolean ab_set)
event type  int onpaint(ulong hdc)
integer width = 400
integer height = 200
end type
global u_canvas u_canvas

on u_canvas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_canvas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

