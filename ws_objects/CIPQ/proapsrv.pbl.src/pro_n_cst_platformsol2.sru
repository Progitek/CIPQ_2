$PBExportHeader$pro_n_cst_platformsol2.sru
$PBExportComments$(PRO) Extension Solaris Cross Platform service
forward
global type pro_n_cst_platformsol2 from pfc_n_cst_platformsol2
end type
end forward

global type pro_n_cst_platformsol2 from pfc_n_cst_platformsol2
end type
global pro_n_cst_platformsol2 pro_n_cst_platformsol2

on pro_n_cst_platformsol2.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_platformsol2.destroy
TriggerEvent( this, "destructor" )
end on

