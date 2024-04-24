﻿$PBExportHeader$w_r_production_sperm_verrat.srw
forward
global type w_r_production_sperm_verrat from w_rapport
end type
type cbx_afficher from u_cbx within w_r_production_sperm_verrat
end type
type cbx_collectis from u_cbx within w_r_production_sperm_verrat
end type
end forward

global type w_r_production_sperm_verrat from w_rapport
integer x = 214
integer y = 221
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
cbx_afficher cbx_afficher
cbx_collectis cbx_collectis
end type
global w_r_production_sperm_verrat w_r_production_sperm_verrat

event ue_transfertinternet();gnv_app.inv_transfert_internet.of_transfertproductionspermatique( dw_preview)
end event

on w_r_production_sperm_verrat.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
this.cbx_afficher=create cbx_afficher
this.cbx_collectis=create cbx_collectis
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_afficher
this.Control[iCurrent+2]=this.cbx_collectis
end on

on w_r_production_sperm_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_afficher)
destroy(this.cbx_collectis)
end on

event pfc_postopen;call super::pfc_postopen;date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de", FALSE))
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au", FALSE))

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_production_sperm_verrat
integer y = 108
integer height = 2196
string dataobject = "d_r_production_sperm_verrat"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_tiri", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event

type cbx_afficher from u_cbx within w_r_production_sperm_verrat
integer x = 23
integer y = 12
integer width = 731
integer height = 68
boolean bringtotop = true
long backcolor = 12639424
string text = "Afficher le code de préposé"
boolean checked = true
end type

event clicked;call super::clicked;dw_preview.object.code_prep_t.visible = this.checked

IF this.checked = TRUE THEN
	dw_preview.object.prepose.visible = 1
ELSE
	dw_preview.object.prepose.visible = 0
END IF

dw_preview.SetFocus()
end event

type cbx_collectis from u_cbx within w_r_production_sperm_verrat
integer x = 795
integer y = 12
integer width = 731
integer height = 68
boolean bringtotop = true
long backcolor = 12639424
string text = "Afficher collectis"
boolean checked = true
end type

event clicked;call super::clicked;dw_preview.object.t_collectis.visible = this.checked

IF this.checked = TRUE THEN
	dw_preview.object.collectis.visible = 1
ELSE
	dw_preview.object.collectis.visible = 0
END IF

dw_preview.SetFocus()
end event

