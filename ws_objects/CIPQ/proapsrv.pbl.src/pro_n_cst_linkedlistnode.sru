$PBExportHeader$pro_n_cst_linkedlistnode.sru
$PBExportComments$(PRO) Extension Linked List Node
forward
global type pro_n_cst_linkedlistnode from pfc_n_cst_linkedlistnode
end type
end forward

global type pro_n_cst_linkedlistnode from pfc_n_cst_linkedlistnode
end type
global pro_n_cst_linkedlistnode pro_n_cst_linkedlistnode

on pro_n_cst_linkedlistnode.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_linkedlistnode.destroy
TriggerEvent( this, "destructor" )
end on

