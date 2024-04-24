$PBExportHeader$pro_n_cst_tvattrib.sru
$PBExportComments$(PRO) Extension TreeView attributes
forward
global type pro_n_cst_tvattrib from pfc_n_cst_tvattrib
end type
end forward

global type pro_n_cst_tvattrib from pfc_n_cst_tvattrib
end type

on pro_n_cst_tvattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_tvattrib.destroy
TriggerEvent( this, "destructor" )
end on

