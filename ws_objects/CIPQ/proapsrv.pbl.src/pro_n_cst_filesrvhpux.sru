$PBExportHeader$pro_n_cst_filesrvhpux.sru
$PBExportComments$(PRO) Extension hpux File handler service
forward
global type pro_n_cst_filesrvhpux from pfc_n_cst_filesrvhpux
end type
end forward

global type pro_n_cst_filesrvhpux from pfc_n_cst_filesrvhpux
end type
global pro_n_cst_filesrvhpux pro_n_cst_filesrvhpux

on pro_n_cst_filesrvhpux.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_filesrvhpux.destroy
TriggerEvent( this, "destructor" )
end on

