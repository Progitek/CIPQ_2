$PBExportHeader$pro_n_cst_linkedlistbase.sru
$PBExportComments$(PRO) Extension Linked List Base service
forward
global type pro_n_cst_linkedlistbase from pfc_n_cst_linkedlistbase
end type
end forward

global type pro_n_cst_linkedlistbase from pfc_n_cst_linkedlistbase
end type

on pro_n_cst_linkedlistbase.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_linkedlistbase.destroy
TriggerEvent( this, "destructor" )
end on

