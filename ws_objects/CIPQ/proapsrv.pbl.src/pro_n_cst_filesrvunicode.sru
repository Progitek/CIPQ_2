$PBExportHeader$pro_n_cst_filesrvunicode.sru
$PBExportComments$(PRO) Extension Unicode File handler service
forward
global type pro_n_cst_filesrvunicode from pfc_n_cst_filesrvunicode
end type
end forward

global type pro_n_cst_filesrvunicode from pfc_n_cst_filesrvunicode
end type
global pro_n_cst_filesrvunicode pro_n_cst_filesrvunicode

on pro_n_cst_filesrvunicode.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_filesrvunicode.destroy
TriggerEvent( this, "destructor" )
end on

