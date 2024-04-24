$PBExportHeader$pro_n_cst_nodebase.sru
$PBExportComments$(PRO) Extension Node Base class
forward
global type pro_n_cst_nodebase from pfc_n_cst_nodebase
end type
end forward

global type pro_n_cst_nodebase from pfc_n_cst_nodebase
end type
global pro_n_cst_nodebase pro_n_cst_nodebase

on pro_n_cst_nodebase.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_nodebase.destroy
TriggerEvent( this, "destructor" )
end on

