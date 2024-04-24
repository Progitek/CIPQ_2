$PBExportHeader$pro_n_cst_treenodecompare.sru
$PBExportComments$(PRO) Extension tree node compare class
forward
global type pro_n_cst_treenodecompare from pfc_n_cst_treenodecompare
end type
end forward

global type pro_n_cst_treenodecompare from pfc_n_cst_treenodecompare
end type
global pro_n_cst_treenodecompare pro_n_cst_treenodecompare

on pro_n_cst_treenodecompare.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_treenodecompare.destroy
TriggerEvent( this, "destructor" )
end on

