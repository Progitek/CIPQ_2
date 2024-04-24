﻿$PBExportHeader$w_r_livreur_representant.srw
forward
global type w_r_livreur_representant from w_rapport
end type
end forward

global type w_r_livreur_representant from w_rapport
string title = "Rapport - Liste des livreurs par représentant"
end type
global w_r_livreur_representant w_r_livreur_representant

on w_r_livreur_representant.create
call super::create
end on

on w_r_livreur_representant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;
dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

dw_preview.retrieve( )
end event

type dw_preview from w_rapport`dw_preview within w_r_livreur_representant
string dataobject = "d_r_livreur_representant"
end type

