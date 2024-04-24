$PBExportHeader$pro_n_cst_sortattrib.sru
$PBExportComments$(PRO) Extension Attributes for the DataWindow Sort service
forward
global type pro_n_cst_sortattrib from pfc_n_cst_sortattrib
end type
end forward

global type pro_n_cst_sortattrib from pfc_n_cst_sortattrib
end type

on pro_n_cst_sortattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_sortattrib.destroy
TriggerEvent( this, "destructor" )
end on

