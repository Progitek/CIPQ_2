﻿$PBExportHeader$pro_n_cst_nodecomparebase.sru
$PBExportComments$(PRO) Extension Node Compare Base class
forward
global type pro_n_cst_nodecomparebase from pfc_n_cst_nodecomparebase
end type
end forward

global type pro_n_cst_nodecomparebase from pfc_n_cst_nodecomparebase
end type
global pro_n_cst_nodecomparebase pro_n_cst_nodecomparebase

on pro_n_cst_nodecomparebase.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_nodecomparebase.destroy
TriggerEvent( this, "destructor" )
end on

