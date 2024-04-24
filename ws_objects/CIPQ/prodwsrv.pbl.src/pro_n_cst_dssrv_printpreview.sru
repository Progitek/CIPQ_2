$PBExportHeader$pro_n_cst_dssrv_printpreview.sru
$PBExportComments$(PRO) Extension DataStore PrintPreview service
forward
global type pro_n_cst_dssrv_printpreview from pfc_n_cst_dssrv_printpreview
end type
end forward

global type pro_n_cst_dssrv_printpreview from pfc_n_cst_dssrv_printpreview
end type
global pro_n_cst_dssrv_printpreview pro_n_cst_dssrv_printpreview

on pro_n_cst_dssrv_printpreview.create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_dssrv_printpreview.destroy
TriggerEvent( this, "destructor" )
end on

