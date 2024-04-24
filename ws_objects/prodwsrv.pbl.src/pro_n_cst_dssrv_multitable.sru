$PBExportHeader$pro_n_cst_dssrv_multitable.sru
$PBExportComments$(PRO) Extension DataStore Multiple Table service
forward
global type pro_n_cst_dssrv_multitable from pfc_n_cst_dssrv_multitable
end type
end forward

global type pro_n_cst_dssrv_multitable from pfc_n_cst_dssrv_multitable
end type
global pro_n_cst_dssrv_multitable pro_n_cst_dssrv_multitable

on pro_n_cst_dssrv_multitable.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dssrv_multitable.destroy
TriggerEvent( this, "destructor" )
end on

