$PBExportHeader$pro_n_cst_dwsrv_dropdownsearchattrib.sru
$PBExportComments$(PRO) Extension DataWindow DropDownSearch attributes
forward
global type pro_n_cst_dwsrv_dropdownsearchattrib from pfc_n_cst_dwsrv_dropdownsearchattrib
end type
end forward

global type pro_n_cst_dwsrv_dropdownsearchattrib from pfc_n_cst_dwsrv_dropdownsearchattrib
end type

on pro_n_cst_dwsrv_dropdownsearchattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwsrv_dropdownsearchattrib.destroy
TriggerEvent( this, "destructor" )
end on

