$PBExportHeader$pro_n_cst_dirattrib.sru
$PBExportComments$(PRO) Extension DIR attribus used by the File services
forward
global type pro_n_cst_dirattrib from pfc_n_cst_dirattrib
end type
end forward

global type pro_n_cst_dirattrib from pfc_n_cst_dirattrib
end type

on pro_n_cst_dirattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dirattrib.destroy
TriggerEvent( this, "destructor" )
end on

