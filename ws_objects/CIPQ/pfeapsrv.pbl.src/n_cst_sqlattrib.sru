$PBExportHeader$n_cst_sqlattrib.sru
$PBExportComments$Extension SQL attributes
forward
global type n_cst_sqlattrib from pro_n_cst_sqlattrib
end type
end forward

global type n_cst_sqlattrib from pro_n_cst_sqlattrib
end type
global n_cst_sqlattrib n_cst_sqlattrib

on n_cst_sqlattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_sqlattrib.destroy
TriggerEvent( this, "destructor" )
end on

