$PBExportHeader$pro_n_cst_filesrvsol2.sru
$PBExportComments$(PRO) Extension Solaris File handler service
forward
global type pro_n_cst_filesrvsol2 from pfc_n_cst_filesrvsol2
end type
end forward

global type pro_n_cst_filesrvsol2 from pfc_n_cst_filesrvsol2
end type
global pro_n_cst_filesrvsol2 pro_n_cst_filesrvsol2

on pro_n_cst_filesrvsol2.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_filesrvsol2.destroy
TriggerEvent( this, "destructor" )
end on

