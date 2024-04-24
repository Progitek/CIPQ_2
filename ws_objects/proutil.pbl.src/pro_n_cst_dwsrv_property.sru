$PBExportHeader$pro_n_cst_dwsrv_property.sru
$PBExportComments$(PRO) Extension DataWindow Property - The service
forward
global type pro_n_cst_dwsrv_property from pfc_n_cst_dwsrv_property
end type
end forward

global type pro_n_cst_dwsrv_property from pfc_n_cst_dwsrv_property
end type
global pro_n_cst_dwsrv_property pro_n_cst_dwsrv_property

on pro_n_cst_dwsrv_property.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_property.destroy
TriggerEvent( this, "destructor" )
end on

