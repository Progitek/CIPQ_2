﻿$PBExportHeader$w_localisation_depot.srw
forward
global type w_localisation_depot from w_sheet_pilotage
end type
end forward

global type w_localisation_depot from w_sheet_pilotage
string tag = "menu=m_localisationsdesdepots"
end type
global w_localisation_depot w_localisation_depot

on w_localisation_depot.create
int iCurrent
call super::create
end on

on w_localisation_depot.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_localisation_depot
string picturename = "C:\ii4net\CIPQ\images\listview_userobject.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_localisation_depot
end type

type st_title from w_sheet_pilotage`st_title within w_localisation_depot
string text = "Localisations des dépôts"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_localisation_depot
string dataobject = "d_localisation_depot"
end type

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_localisation_depot
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_localisation_depot
end type

