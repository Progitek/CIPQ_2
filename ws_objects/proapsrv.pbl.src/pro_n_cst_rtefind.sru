$PBExportHeader$pro_n_cst_rtefind.sru
$PBExportComments$(PRO) Extension RTE Find/Replace service
forward
global type pro_n_cst_rtefind from pfc_n_cst_rtefind
end type
end forward

global type pro_n_cst_rtefind from pfc_n_cst_rtefind
end type
global pro_n_cst_rtefind pro_n_cst_rtefind

on pro_n_cst_rtefind.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_rtefind.destroy
TriggerEvent( this, "destructor" )
end on

