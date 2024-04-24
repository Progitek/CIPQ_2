$PBExportHeader$pro_n_cst_dberrorattrib.sru
$PBExportComments$(PRO) Extension dberror attributes
forward
global type pro_n_cst_dberrorattrib from pfc_n_cst_dberrorattrib
end type
end forward

global type pro_n_cst_dberrorattrib from pfc_n_cst_dberrorattrib
end type

on pro_n_cst_dberrorattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dberrorattrib.destroy
TriggerEvent( this, "destructor" )
end on

