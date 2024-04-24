$PBExportHeader$pro_n_cst_dssrv.sru
$PBExportComments$(PRO) Extension Datastore Base service
forward
global type pro_n_cst_dssrv from pfc_n_cst_dssrv
end type
end forward

global type pro_n_cst_dssrv from pfc_n_cst_dssrv
end type
global pro_n_cst_dssrv pro_n_cst_dssrv

on pro_n_cst_dssrv.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dssrv.destroy
TriggerEvent( this, "destructor" )
end on

