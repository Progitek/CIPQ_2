$PBExportHeader$pro_n_cst_mruattrib.sru
$PBExportComments$(PRO) Extension Most Recently Used service attributes
forward
global type pro_n_cst_mruattrib from pfc_n_cst_mruattrib
end type
end forward

global type pro_n_cst_mruattrib from pfc_n_cst_mruattrib
end type

on pro_n_cst_mruattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_mruattrib.destroy
TriggerEvent( this, "destructor" )
end on

