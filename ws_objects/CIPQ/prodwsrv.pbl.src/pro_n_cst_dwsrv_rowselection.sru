$PBExportHeader$pro_n_cst_dwsrv_rowselection.sru
$PBExportComments$(PRO) Extension DataWindow Row Selection service
forward
global type pro_n_cst_dwsrv_rowselection from pfc_n_cst_dwsrv_rowselection
end type
end forward

global type pro_n_cst_dwsrv_rowselection from pfc_n_cst_dwsrv_rowselection
end type
global pro_n_cst_dwsrv_rowselection pro_n_cst_dwsrv_rowselection

on pro_n_cst_dwsrv_rowselection.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_rowselection.destroy
TriggerEvent( this, "destructor" )
end on

