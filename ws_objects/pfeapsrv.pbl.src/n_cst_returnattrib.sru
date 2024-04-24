$PBExportHeader$n_cst_returnattrib.sru
$PBExportComments$Extension Simple return attributes
forward
global type n_cst_returnattrib from pro_n_cst_returnattrib
end type
end forward

global type n_cst_returnattrib from pro_n_cst_returnattrib
end type
global n_cst_returnattrib n_cst_returnattrib

on n_cst_returnattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_returnattrib.destroy
TriggerEvent( this, "destructor" )
end on

