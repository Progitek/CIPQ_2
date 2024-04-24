$PBExportHeader$pro_n_cst_selectionattrib.sru
$PBExportComments$(PRO) Extension Selection attributes
forward
global type pro_n_cst_selectionattrib from pfc_n_cst_selectionattrib
end type
end forward

global type pro_n_cst_selectionattrib from pfc_n_cst_selectionattrib
end type

on pro_n_cst_selectionattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_selectionattrib.destroy
TriggerEvent( this, "destructor" )
end on

