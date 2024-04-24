$PBExportHeader$n_cst_trregistrationattrib.sru
$PBExportComments$Extension Transaction Registration attributes
forward
global type n_cst_trregistrationattrib from pro_n_cst_trregistrationattrib
end type
end forward

global type n_cst_trregistrationattrib from pro_n_cst_trregistrationattrib
end type
global n_cst_trregistrationattrib n_cst_trregistrationattrib

on n_cst_trregistrationattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_trregistrationattrib.destroy
TriggerEvent( this, "destructor" )
end on

