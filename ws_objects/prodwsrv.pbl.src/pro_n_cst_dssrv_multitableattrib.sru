﻿$PBExportHeader$pro_n_cst_dssrv_multitableattrib.sru
$PBExportComments$(PRO) Extension Datastore Multiple Table attributes
forward
global type pro_n_cst_dssrv_multitableattrib from pfc_n_cst_dssrv_multitableattrib
end type
end forward

global type pro_n_cst_dssrv_multitableattrib from pfc_n_cst_dssrv_multitableattrib
end type

on pro_n_cst_dssrv_multitableattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dssrv_multitableattrib.destroy
TriggerEvent( this, "destructor" )
end on
