$PBExportHeader$pro_n_cst_sql.sru
$PBExportComments$(PRO) Extension SQL Service service
forward
global type pro_n_cst_sql from pfc_n_cst_sql
end type
end forward

global type pro_n_cst_sql from pfc_n_cst_sql
end type

on pro_n_cst_sql.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_sql.destroy
TriggerEvent( this, "destructor" )
end on

