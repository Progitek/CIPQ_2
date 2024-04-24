$PBExportHeader$pro_w_frame.srw
$PBExportComments$(PRO) Extension Frame Window class
forward
global type pro_w_frame from pfc_w_frame
end type
end forward

global type pro_w_frame from pfc_w_frame
end type
global pro_w_frame pro_w_frame

on pro_w_frame.create
call pfc_w_frame::create
end on

on pro_w_frame.destroy
call pfc_w_frame::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

