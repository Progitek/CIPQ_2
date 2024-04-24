$PBExportHeader$pro_n_cst_platform.sru
$PBExportComments$(PRO) Extension Cross Platform service
forward
global type pro_n_cst_platform from pfc_n_cst_platform
end type
end forward

global type pro_n_cst_platform from pfc_n_cst_platform
end type
global pro_n_cst_platform pro_n_cst_platform

on pro_n_cst_platform.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_platform.destroy
TriggerEvent( this, "destructor" )
end on

