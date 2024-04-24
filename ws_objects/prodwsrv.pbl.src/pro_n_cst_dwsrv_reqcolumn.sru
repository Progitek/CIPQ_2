$PBExportHeader$pro_n_cst_dwsrv_reqcolumn.sru
$PBExportComments$(PRO) Extension DataWindow Required Column service
forward
global type pro_n_cst_dwsrv_reqcolumn from pfc_n_cst_dwsrv_reqcolumn
end type
end forward

global type pro_n_cst_dwsrv_reqcolumn from pfc_n_cst_dwsrv_reqcolumn
end type
global pro_n_cst_dwsrv_reqcolumn pro_n_cst_dwsrv_reqcolumn

on pro_n_cst_dwsrv_reqcolumn.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_reqcolumn.destroy
TriggerEvent( this, "destructor" )
end on

