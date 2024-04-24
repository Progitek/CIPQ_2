$PBExportHeader$pro_n_cst_splashattrib.sru
$PBExportComments$(PRO) Extension Splash attributes
forward
global type pro_n_cst_splashattrib from pfc_n_cst_splashattrib
end type
end forward

global type pro_n_cst_splashattrib from pfc_n_cst_splashattrib
end type

on pro_n_cst_splashattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_splashattrib.destroy
TriggerEvent( this, "destructor" )
end on

