$PBExportHeader$pro_n_cst_dwsrv_report.sru
$PBExportComments$(PRO) Extension DataWindow Reporting service
forward
global type pro_n_cst_dwsrv_report from pfc_n_cst_dwsrv_report
end type
end forward

global type pro_n_cst_dwsrv_report from pfc_n_cst_dwsrv_report
end type
global pro_n_cst_dwsrv_report pro_n_cst_dwsrv_report

on pro_n_cst_dwsrv_report.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_report.destroy
TriggerEvent( this, "destructor" )
end on

