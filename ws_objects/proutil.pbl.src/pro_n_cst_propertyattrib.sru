$PBExportHeader$pro_n_cst_propertyattrib.sru
$PBExportComments$(PRO) Extension Property - attributes
forward
global type pro_n_cst_propertyattrib from pfc_n_cst_propertyattrib
end type
end forward

global type pro_n_cst_propertyattrib from pfc_n_cst_propertyattrib
end type

on pro_n_cst_propertyattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_propertyattrib.destroy
TriggerEvent( this, "destructor" )
end on

