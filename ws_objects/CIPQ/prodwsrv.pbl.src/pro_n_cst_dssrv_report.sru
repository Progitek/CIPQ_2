$PBExportHeader$pro_n_cst_dssrv_report.sru
$PBExportComments$(PRO) Extension DataStore Reporting service
forward
global type pro_n_cst_dssrv_report from pfc_n_cst_dssrv_report
end type
end forward

global type pro_n_cst_dssrv_report from pfc_n_cst_dssrv_report
end type
global pro_n_cst_dssrv_report pro_n_cst_dssrv_report

on pro_n_cst_dssrv_report.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dssrv_report.destroy
TriggerEvent( this, "destructor" )
end on

