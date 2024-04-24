$PBExportHeader$n_cst_datetime.sru
$PBExportComments$Extension Date and/or Datetime service
forward
global type n_cst_datetime from pro_n_cst_datetime
end type
end forward

global type n_cst_datetime from pro_n_cst_datetime
end type
global n_cst_datetime n_cst_datetime

on n_cst_datetime.create
TriggerEvent( this, "constructor" )
end on

on n_cst_datetime.destroy
TriggerEvent( this, "destructor" )
end on

