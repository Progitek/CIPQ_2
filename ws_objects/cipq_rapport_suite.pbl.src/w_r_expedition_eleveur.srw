﻿$PBExportHeader$w_r_expedition_eleveur.srw
forward
global type w_r_expedition_eleveur from w_rapport
end type
end forward

global type w_r_expedition_eleveur from w_rapport
string title = "Rapport - Expéditions par éleveur"
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
end type
global w_r_expedition_eleveur w_r_expedition_eleveur

event ue_transfertinternet();//ue_transfertinternet
gnv_app.inv_transfert_internet.of_transfertexpheb( dw_preview, "éleveur")
end event

on w_r_expedition_eleveur.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
end on

on w_r_expedition_eleveur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cie
date		ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de", FALSE))
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au", FALSE))
ls_cie = gnv_app.inv_entrepotglobal.of_retournedonnee("lien centre rapport")
IF ls_cie = "" OR lower(ls_cie) = "tous" THEN SetNull(ls_cie)

SetPointer(Hourglass!)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au, ls_cie )
end event

type dw_preview from w_rapport`dw_preview within w_r_expedition_eleveur
string dataobject = "d_r_expedition_eleveur"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID

lnv_menu.of_GetMenuReference (lm_menu,"m_trier", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event

event dw_preview::pfc_filterdlg;call super::pfc_filterdlg;string ls_filtre

ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)
IF ls_filtre <> "" AND Not(Isnull(ls_filtre)) THEN
	dw_preview.object.gt_heb_t.visible = 0
	dw_preview.object.cf_gt_sum.visible = 0
END IF

RETURN AncestorReturnValue
end event
