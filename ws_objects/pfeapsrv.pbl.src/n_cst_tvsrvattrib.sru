$PBExportHeader$n_cst_tvsrvattrib.sru
$PBExportComments$Extension TreeView datasource service attributes
forward
global type n_cst_tvsrvattrib from pro_n_cst_tvsrvattrib
end type
end forward

global type n_cst_tvsrvattrib from pro_n_cst_tvsrvattrib
end type
global n_cst_tvsrvattrib n_cst_tvsrvattrib

on n_cst_tvsrvattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_tvsrvattrib.destroy
TriggerEvent( this, "destructor" )
end on

