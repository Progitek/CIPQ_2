$PBExportHeader$pro_n_cst_winsrv_sheetmanager.sru
$PBExportComments$(PRO) Extension Window Sheet Manager service
forward
global type pro_n_cst_winsrv_sheetmanager from pfc_n_cst_winsrv_sheetmanager
end type
end forward

global type pro_n_cst_winsrv_sheetmanager from pfc_n_cst_winsrv_sheetmanager
end type
global pro_n_cst_winsrv_sheetmanager pro_n_cst_winsrv_sheetmanager

on pro_n_cst_winsrv_sheetmanager.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_winsrv_sheetmanager.destroy
TriggerEvent( this, "destructor" )
end on

