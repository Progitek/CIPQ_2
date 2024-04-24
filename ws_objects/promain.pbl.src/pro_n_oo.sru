$PBExportHeader$pro_n_oo.sru
$PBExportComments$(PRO) Extension OLEObject class
forward
global type pro_n_oo from pfc_n_oo
end type
end forward

global type pro_n_oo from pfc_n_oo
end type
global pro_n_oo pro_n_oo

on pro_n_oo.create
call oleobject::create
TriggerEvent( this, "constructor" )
end on

on pro_n_oo.destroy
call oleobject::destroy
TriggerEvent( this, "destructor" )
end on

