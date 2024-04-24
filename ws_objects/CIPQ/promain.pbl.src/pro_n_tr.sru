$PBExportHeader$pro_n_tr.sru
$PBExportComments$(PRO) Extension Transaction class
forward
global type pro_n_tr from pfc_n_tr
end type
end forward

global type pro_n_tr from pfc_n_tr
end type
global pro_n_tr pro_n_tr

on pro_n_tr.create
TriggerEvent( this, "constructor" )
end on

on pro_n_tr.destroy
TriggerEvent( this, "destructor" )
end on

