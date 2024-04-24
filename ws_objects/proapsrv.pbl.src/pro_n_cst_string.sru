$PBExportHeader$pro_n_cst_string.sru
$PBExportComments$(PRO) Extension String service
forward
global type pro_n_cst_string from pfc_n_cst_string
end type
end forward

global type pro_n_cst_string from pfc_n_cst_string
end type

on pro_n_cst_string.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_string.destroy
TriggerEvent( this, "destructor" )
end on

