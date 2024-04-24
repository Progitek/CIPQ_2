$PBExportHeader$n_cst_list.sru
$PBExportComments$Extension List service
forward
global type n_cst_list from pro_n_cst_list
end type
end forward

global type n_cst_list from pro_n_cst_list
end type
global n_cst_list n_cst_list

on n_cst_list.create
TriggerEvent( this, "constructor" )
end on

on n_cst_list.destroy
TriggerEvent( this, "destructor" )
end on

