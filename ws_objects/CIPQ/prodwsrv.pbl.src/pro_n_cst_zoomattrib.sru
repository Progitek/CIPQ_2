$PBExportHeader$pro_n_cst_zoomattrib.sru
$PBExportComments$(PRO) Extension Attributes for the DataWindow Zoom service
forward
global type pro_n_cst_zoomattrib from pfc_n_cst_zoomattrib
end type
end forward

global type pro_n_cst_zoomattrib from pfc_n_cst_zoomattrib
end type

on pro_n_cst_zoomattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_zoomattrib.destroy
TriggerEvent( this, "destructor" )
end on

