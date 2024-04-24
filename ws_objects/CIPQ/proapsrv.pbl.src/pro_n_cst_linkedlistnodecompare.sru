$PBExportHeader$pro_n_cst_linkedlistnodecompare.sru
$PBExportComments$(PRO) Extension Linked List Node compare
forward
global type pro_n_cst_linkedlistnodecompare from pfc_n_cst_linkedlistnodecompare
end type
end forward

global type pro_n_cst_linkedlistnodecompare from pfc_n_cst_linkedlistnodecompare
end type
global pro_n_cst_linkedlistnodecompare pro_n_cst_linkedlistnodecompare

on pro_n_cst_linkedlistnodecompare.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_linkedlistnodecompare.destroy
TriggerEvent( this, "destructor" )
end on

