﻿$PBExportHeader$n_cst_sortattrib.sru
$PBExportComments$Extension Attributes for the DataWindow Sort service
forward
global type n_cst_sortattrib from pro_n_cst_sortattrib
end type
end forward

global type n_cst_sortattrib from pro_n_cst_sortattrib
end type
global n_cst_sortattrib n_cst_sortattrib

on n_cst_sortattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_sortattrib.destroy
TriggerEvent( this, "destructor" )
end on

