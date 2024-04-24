$PBExportHeader$n_cst_dwsrv_querymodeattrib.sru
$PBExportComments$Extension DataWindow QueryMode attributes
forward
global type n_cst_dwsrv_querymodeattrib from pro_n_cst_dwsrv_querymodeattrib
end type
end forward

global type n_cst_dwsrv_querymodeattrib from pro_n_cst_dwsrv_querymodeattrib
end type
global n_cst_dwsrv_querymodeattrib n_cst_dwsrv_querymodeattrib

on n_cst_dwsrv_querymodeattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsrv_querymodeattrib.destroy
TriggerEvent( this, "destructor" )
end on

