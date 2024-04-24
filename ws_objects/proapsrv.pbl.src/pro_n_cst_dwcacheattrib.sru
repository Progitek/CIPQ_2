$PBExportHeader$pro_n_cst_dwcacheattrib.sru
$PBExportComments$(PRO) Extension Caching attributes
forward
global type pro_n_cst_dwcacheattrib from pfc_n_cst_dwcacheattrib
end type
end forward

global type pro_n_cst_dwcacheattrib from pfc_n_cst_dwcacheattrib
end type

on pro_n_cst_dwcacheattrib.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dwcacheattrib.destroy
TriggerEvent( this, "destructor" )
end on

