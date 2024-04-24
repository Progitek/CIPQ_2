$PBExportHeader$pro_n_cst_linkageattrib.sru
$PBExportComments$(PRO) Extension Attributes for the Linkage service
forward
global type pro_n_cst_linkageattrib from pfc_n_cst_linkageattrib
end type
end forward

global type pro_n_cst_linkageattrib from pfc_n_cst_linkageattrib
end type

on pro_n_cst_linkageattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_linkageattrib.destroy
TriggerEvent( this, "destructor" )
end on

