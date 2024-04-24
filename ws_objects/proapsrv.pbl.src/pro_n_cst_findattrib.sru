$PBExportHeader$pro_n_cst_findattrib.sru
$PBExportComments$(PRO) Extension Find/Replace attributes
forward
global type pro_n_cst_findattrib from pfc_n_cst_findattrib
end type
end forward

global type pro_n_cst_findattrib from pfc_n_cst_findattrib
end type

on pro_n_cst_findattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_findattrib.destroy
TriggerEvent( this, "destructor" )
end on

