$PBExportHeader$pro_n_dda.sru
$PBExportComments$(PRO) Extension DynamicDescriptionArea class
forward
global type pro_n_dda from pfc_n_dda
end type
end forward

global type pro_n_dda from pfc_n_dda
end type
global pro_n_dda pro_n_dda

on pro_n_dda.create
call dynamicdescriptionarea::create
TriggerEvent( this, "constructor" )
end on

on pro_n_dda.destroy
call dynamicdescriptionarea::destroy
TriggerEvent( this, "destructor" )
end on

