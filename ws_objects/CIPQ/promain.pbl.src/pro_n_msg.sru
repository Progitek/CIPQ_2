$PBExportHeader$pro_n_msg.sru
$PBExportComments$(PRO) Extension Message class
forward
global type pro_n_msg from pfc_n_msg
end type
end forward

global type pro_n_msg from pfc_n_msg
end type
global pro_n_msg pro_n_msg

on pro_n_msg.create
TriggerEvent( this, "constructor" )
end on

on pro_n_msg.destroy
TriggerEvent( this, "destructor" )
end on

