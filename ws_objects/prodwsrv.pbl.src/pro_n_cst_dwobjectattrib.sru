$PBExportHeader$pro_n_cst_dwobjectattrib.sru
$PBExportComments$(PRO) Extension Attributes for the Modify / Describe service
forward
global type pro_n_cst_dwobjectattrib from pfc_n_cst_dwobjectattrib
end type
end forward

global type pro_n_cst_dwobjectattrib from pfc_n_cst_dwobjectattrib
end type

on pro_n_cst_dwobjectattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwobjectattrib.destroy
TriggerEvent( this, "destructor" )
end on

