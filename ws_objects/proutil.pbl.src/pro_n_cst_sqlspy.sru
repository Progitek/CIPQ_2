$PBExportHeader$pro_n_cst_sqlspy.sru
$PBExportComments$(PRO) Extension SQL Spy service
forward
global type pro_n_cst_sqlspy from pfc_n_cst_sqlspy
end type
end forward

global type pro_n_cst_sqlspy from pfc_n_cst_sqlspy
end type
global pro_n_cst_sqlspy pro_n_cst_sqlspy

on pro_n_cst_sqlspy.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_sqlspy.destroy
TriggerEvent( this, "destructor" )
end on

