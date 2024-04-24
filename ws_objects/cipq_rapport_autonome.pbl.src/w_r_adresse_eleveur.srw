﻿$PBExportHeader$w_r_adresse_eleveur.srw
forward
global type w_r_adresse_eleveur from w_rapport
end type
end forward

global type w_r_adresse_eleveur from w_rapport
string title = "Rapport - Adresses des éleveurs"
end type
global w_r_adresse_eleveur w_r_adresse_eleveur

on w_r_adresse_eleveur.create
call super::create
end on

on w_r_adresse_eleveur.destroy
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

type dw_preview from w_rapport`dw_preview within w_r_adresse_eleveur
string dataobject = "d_r_adresse_eleveur"
end type
