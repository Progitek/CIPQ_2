$PBExportHeader$pro_n_cst_tmgmultiple.sru
$PBExportComments$(PRO) Extension timing multiple object service
forward
global type pro_n_cst_tmgmultiple from pfc_n_cst_tmgmultiple
end type
end forward

global type pro_n_cst_tmgmultiple from pfc_n_cst_tmgmultiple
end type
global pro_n_cst_tmgmultiple pro_n_cst_tmgmultiple

on pro_n_cst_tmgmultiple.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_tmgmultiple.destroy
TriggerEvent( this, "destructor" )
end on

