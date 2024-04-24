$PBExportHeader$pro_n_cst_dwsrv_filter.sru
$PBExportComments$(PRO) Extension DataWindow Filter service
forward
global type pro_n_cst_dwsrv_filter from pfc_n_cst_dwsrv_filter
end type
end forward

global type pro_n_cst_dwsrv_filter from pfc_n_cst_dwsrv_filter
end type
global pro_n_cst_dwsrv_filter pro_n_cst_dwsrv_filter

on pro_n_cst_dwsrv_filter.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_filter.destroy
TriggerEvent( this, "destructor" )
end on

