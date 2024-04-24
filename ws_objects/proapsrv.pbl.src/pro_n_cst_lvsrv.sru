$PBExportHeader$pro_n_cst_lvsrv.sru
$PBExportComments$(PRO) Extension ListView Base service
forward
global type pro_n_cst_lvsrv from pfc_n_cst_lvsrv
end type
end forward

global type pro_n_cst_lvsrv from pfc_n_cst_lvsrv
end type
global pro_n_cst_lvsrv pro_n_cst_lvsrv

on pro_n_cst_lvsrv.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_lvsrv.destroy
TriggerEvent( this, "destructor" )
end on

