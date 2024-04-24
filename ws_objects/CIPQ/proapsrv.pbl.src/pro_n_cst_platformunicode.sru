$PBExportHeader$pro_n_cst_platformunicode.sru
$PBExportComments$(PRO) Extension Unicode Cross Platform service
forward
global type pro_n_cst_platformunicode from pfc_n_cst_platformunicode
end type
end forward

global type pro_n_cst_platformunicode from pfc_n_cst_platformunicode
end type
global pro_n_cst_platformunicode pro_n_cst_platformunicode

on pro_n_cst_platformunicode.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_platformunicode.destroy
TriggerEvent( this, "destructor" )
end on

