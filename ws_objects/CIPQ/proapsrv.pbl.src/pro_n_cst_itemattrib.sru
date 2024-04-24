$PBExportHeader$pro_n_cst_itemattrib.sru
$PBExportComments$(PRO) Extension Item attributes
forward
global type pro_n_cst_itemattrib from pfc_n_cst_itemattrib
end type
end forward

global type pro_n_cst_itemattrib from pfc_n_cst_itemattrib
end type

on pro_n_cst_itemattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_itemattrib.destroy
TriggerEvent( this, "destructor" )
end on

