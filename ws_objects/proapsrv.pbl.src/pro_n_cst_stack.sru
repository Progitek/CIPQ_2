$PBExportHeader$pro_n_cst_stack.sru
$PBExportComments$(PRO) Extension Stack List service
forward
global type pro_n_cst_stack from pfc_n_cst_stack
end type
end forward

global type pro_n_cst_stack from pfc_n_cst_stack
end type

on pro_n_cst_stack.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_stack.destroy
TriggerEvent( this, "destructor" )
end on

