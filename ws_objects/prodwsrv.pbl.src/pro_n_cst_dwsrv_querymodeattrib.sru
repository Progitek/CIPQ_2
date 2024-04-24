$PBExportHeader$pro_n_cst_dwsrv_querymodeattrib.sru
$PBExportComments$(PRO) Extension DataWindow QueryMode attributes
forward
global type pro_n_cst_dwsrv_querymodeattrib from pfc_n_cst_dwsrv_querymodeattrib
end type
end forward

global type pro_n_cst_dwsrv_querymodeattrib from pfc_n_cst_dwsrv_querymodeattrib
end type

on pro_n_cst_dwsrv_querymodeattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_querymodeattrib.destroy
TriggerEvent( this, "destructor" )
end on

