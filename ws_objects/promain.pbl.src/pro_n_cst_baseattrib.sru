$PBExportHeader$pro_n_cst_baseattrib.sru
$PBExportComments$(PRO) Extension attribute base class
forward
global type pro_n_cst_baseattrib from pfc_n_cst_baseattrib
end type
end forward

global type pro_n_cst_baseattrib from pfc_n_cst_baseattrib
end type
global pro_n_cst_baseattrib pro_n_cst_baseattrib

on pro_n_cst_baseattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_baseattrib.destroy
TriggerEvent( this, "destructor" )
end on

