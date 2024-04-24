$PBExportHeader$pro_n_cst_logonattrib.sru
$PBExportComments$(PRO) Extension Long attributes
forward
global type pro_n_cst_logonattrib from pfc_n_cst_logonattrib
end type
end forward

global type pro_n_cst_logonattrib from pfc_n_cst_logonattrib
end type

on pro_n_cst_logonattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_logonattrib.destroy
TriggerEvent( this, "destructor" )
end on

