$PBExportHeader$pro_n_cst_dropdown.sru
$PBExportComments$(PRO) Extension DropDown Service
forward
global type pro_n_cst_dropdown from pfc_n_cst_dropdown
end type
end forward

global type pro_n_cst_dropdown from pfc_n_cst_dropdown
end type
global pro_n_cst_dropdown pro_n_cst_dropdown

on pro_n_cst_dropdown.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dropdown.destroy
TriggerEvent( this, "destructor" )
end on

