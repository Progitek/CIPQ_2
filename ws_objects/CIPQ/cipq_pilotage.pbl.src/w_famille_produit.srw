﻿$PBExportHeader$w_famille_produit.srw
forward
global type w_famille_produit from w_sheet_pilotage
end type
end forward

global type w_famille_produit from w_sheet_pilotage
string tag = "menu=m_famillesdeproduits"
end type
global w_famille_produit w_famille_produit

on w_famille_produit.create
int iCurrent
call super::create
end on

on w_famille_produit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_famille_produit
integer y = 40
integer width = 105
integer height = 92
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\famille.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_famille_produit
integer height = 108
end type

type st_title from w_sheet_pilotage`st_title within w_famille_produit
integer x = 183
string text = "Familles de produits"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_famille_produit
string dataobject = "d_famille_produit"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Produit_Famille", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_famille_produit
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_famille_produit
end type

