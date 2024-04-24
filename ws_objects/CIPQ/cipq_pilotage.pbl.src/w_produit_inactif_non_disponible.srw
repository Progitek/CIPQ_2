﻿$PBExportHeader$w_produit_inactif_non_disponible.srw
forward
global type w_produit_inactif_non_disponible from w_sheet_pilotage
end type
end forward

global type w_produit_inactif_non_disponible from w_sheet_pilotage
string tag = "menu=m_produitsinactifsounondisponibles"
end type
global w_produit_inactif_non_disponible w_produit_inactif_non_disponible

on w_produit_inactif_non_disponible.create
int iCurrent
call super::create
end on

on w_produit_inactif_non_disponible.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;//Override
This.Event pfc_preopen()
This.Post Event pfc_postopen()

uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Rechercher...", "Search!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
	
uo_toolbar.of_displaytext(true)

THIS.Title = st_title.text
end event

type p_8 from w_sheet_pilotage`p_8 within w_produit_inactif_non_disponible
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\annuler.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_produit_inactif_non_disponible
end type

type st_title from w_sheet_pilotage`st_title within w_produit_inactif_non_disponible
string text = "Produits inactifs ou non-disponibles"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_produit_inactif_non_disponible
string dataobject = "d_produit_inactif_non_disponible"
end type

event dw_pilotage::constructor;call super::constructor;This.of_SetSort(True)
inv_sort.of_Setstyle(INV_SORT.SIMPLE)
inv_sort.of_Setcolumndisplaynamestyle(INV_SORT.HEADER)
inv_sort.of_Setcolumnheader(True)

end event

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_produit", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_produit_inactif_non_disponible
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_produit_inactif_non_disponible
end type
