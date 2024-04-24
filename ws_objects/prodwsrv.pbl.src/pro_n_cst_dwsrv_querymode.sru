$PBExportHeader$pro_n_cst_dwsrv_querymode.sru
$PBExportComments$(PRO) Extension DataWindow QueryMode service
forward
global type pro_n_cst_dwsrv_querymode from pfc_n_cst_dwsrv_querymode
end type
end forward

global type pro_n_cst_dwsrv_querymode from pfc_n_cst_dwsrv_querymode
end type
global pro_n_cst_dwsrv_querymode pro_n_cst_dwsrv_querymode

on pro_n_cst_dwsrv_querymode.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_querymode.destroy
TriggerEvent( this, "destructor" )
end on

