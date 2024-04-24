$PBExportHeader$pro_n_cst_errorattrib.sru
$PBExportComments$(PRO) Extension Message (error) attributes
forward
global type pro_n_cst_errorattrib from pfc_n_cst_errorattrib
end type
end forward

global type pro_n_cst_errorattrib from pfc_n_cst_errorattrib
end type

on pro_n_cst_errorattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_errorattrib.destroy
TriggerEvent( this, "destructor" )
end on

