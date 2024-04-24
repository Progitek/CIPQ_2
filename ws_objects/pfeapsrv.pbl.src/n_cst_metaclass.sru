$PBExportHeader$n_cst_metaclass.sru
$PBExportComments$Extension Metaclass service
forward
global type n_cst_metaclass from pro_n_cst_metaclass
end type
end forward

global type n_cst_metaclass from pro_n_cst_metaclass
end type

on n_cst_metaclass.create
TriggerEvent( this, "constructor" )
end on

on n_cst_metaclass.destroy
TriggerEvent( this, "destructor" )
end on

