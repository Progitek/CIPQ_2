$PBExportHeader$pro_n_cst_columnattrib.sru
$PBExportComments$(PRO) Extension Column attributes
forward
global type pro_n_cst_columnattrib from pfc_n_cst_columnattrib
end type
end forward

global type pro_n_cst_columnattrib from pfc_n_cst_columnattrib
end type

on pro_n_cst_columnattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_columnattrib.destroy
TriggerEvent( this, "destructor" )
end on

