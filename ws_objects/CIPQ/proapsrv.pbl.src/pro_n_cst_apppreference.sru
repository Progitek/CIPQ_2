$PBExportHeader$pro_n_cst_apppreference.sru
$PBExportComments$(PRO) Extension Application Preference service
forward
global type pro_n_cst_apppreference from pfc_n_cst_apppreference
end type
end forward

global type pro_n_cst_apppreference from pfc_n_cst_apppreference
end type
global pro_n_cst_apppreference pro_n_cst_apppreference

on pro_n_cst_apppreference.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_apppreference.destroy
TriggerEvent( this, "destructor" )
end on

