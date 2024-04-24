$PBExportHeader$n_cst_linkedlistbase.sru
$PBExportComments$Extension Linked List Base service
forward
global type n_cst_linkedlistbase from pro_n_cst_linkedlistbase
end type
end forward

global type n_cst_linkedlistbase from pro_n_cst_linkedlistbase
end type
global n_cst_linkedlistbase n_cst_linkedlistbase

on n_cst_linkedlistbase.create
TriggerEvent( this, "constructor" )
end on

on n_cst_linkedlistbase.destroy
TriggerEvent( this, "destructor" )
end on

