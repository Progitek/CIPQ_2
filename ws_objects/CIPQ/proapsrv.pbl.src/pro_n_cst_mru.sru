$PBExportHeader$pro_n_cst_mru.sru
$PBExportComments$(PRO) Extension Most Recently Used service
forward
global type pro_n_cst_mru from pfc_n_cst_mru
end type
end forward

global type pro_n_cst_mru from pfc_n_cst_mru
end type
global pro_n_cst_mru pro_n_cst_mru

on pro_n_cst_mru.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_mru.destroy
TriggerEvent( this, "destructor" )
end on

