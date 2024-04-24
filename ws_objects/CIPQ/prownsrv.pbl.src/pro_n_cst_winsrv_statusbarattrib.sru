$PBExportHeader$pro_n_cst_winsrv_statusbarattrib.sru
$PBExportComments$(PRO) Extension Widow Statusbar attributes
forward
global type pro_n_cst_winsrv_statusbarattrib from pfc_n_cst_winsrv_statusbarattrib
end type
end forward

global type pro_n_cst_winsrv_statusbarattrib from pfc_n_cst_winsrv_statusbarattrib
end type

on pro_n_cst_winsrv_statusbarattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_winsrv_statusbarattrib.destroy
TriggerEvent( this, "destructor" )
end on

