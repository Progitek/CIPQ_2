$PBExportHeader$n_cst_selectionattrib.sru
$PBExportComments$Extension Selection attributes
forward
global type n_cst_selectionattrib from pro_n_cst_selectionattrib
end type
end forward

global type n_cst_selectionattrib from pro_n_cst_selectionattrib
end type
global n_cst_selectionattrib n_cst_selectionattrib

on n_cst_selectionattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_selectionattrib.destroy
TriggerEvent( this, "destructor" )
end on

