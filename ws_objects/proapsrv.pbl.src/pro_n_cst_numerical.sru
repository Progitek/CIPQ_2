$PBExportHeader$pro_n_cst_numerical.sru
$PBExportComments$(PRO) Extension Numerical service
forward
global type pro_n_cst_numerical from pfc_n_cst_numerical
end type
end forward

global type pro_n_cst_numerical from pfc_n_cst_numerical
end type

on pro_n_cst_numerical.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_numerical.destroy
TriggerEvent( this, "destructor" )
end on

