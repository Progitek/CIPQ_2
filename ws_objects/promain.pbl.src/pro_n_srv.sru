$PBExportHeader$pro_n_srv.sru
$PBExportComments$(PRO) Extension Service class
forward
global type pro_n_srv from pfc_n_srv
end type
end forward

global type pro_n_srv from pfc_n_srv
end type
global pro_n_srv pro_n_srv

on pro_n_srv.create
call service::create
TriggerEvent( this, "constructor" )
end on

on pro_n_srv.destroy
call service::destroy
TriggerEvent( this, "destructor" )
end on

