$PBExportHeader$pro_n_cst_dwsrv_rowmanager.sru
$PBExportComments$(PRO) Extension DataWindow RowManager service
forward
global type pro_n_cst_dwsrv_rowmanager from pfc_n_cst_dwsrv_rowmanager
end type
end forward

global type pro_n_cst_dwsrv_rowmanager from pfc_n_cst_dwsrv_rowmanager
end type
global pro_n_cst_dwsrv_rowmanager pro_n_cst_dwsrv_rowmanager

on pro_n_cst_dwsrv_rowmanager.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_rowmanager.destroy
TriggerEvent( this, "destructor" )
end on

