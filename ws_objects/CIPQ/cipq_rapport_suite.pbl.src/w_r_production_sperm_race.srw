$PBExportHeader$w_r_production_sperm_race.srw
forward
global type w_r_production_sperm_race from w_rapport
end type
type cbx_afficher from u_cbx within w_r_production_sperm_race
end type
end forward

global type w_r_production_sperm_race from w_rapport
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
cbx_afficher cbx_afficher
end type
global w_r_production_sperm_race w_r_production_sperm_race

event ue_transfertinternet();gnv_app.inv_transfert_internet.of_transfertproductionspermatique( dw_preview)
end event

on w_r_production_sperm_race.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
this.cbx_afficher=create cbx_afficher
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_afficher
end on

on w_r_production_sperm_race.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_afficher)
end on

event pfc_postopen;call super::pfc_postopen;date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de", FALSE))
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au", FALSE))

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_production_sperm_race
integer y = 96
integer height = 2212
string dataobject = "d_r_production_sperm_race"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_tiri", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_trier", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event

type cbx_afficher from u_cbx within w_r_production_sperm_race
integer x = 27
integer y = 12
integer width = 731
integer height = 68
boolean bringtotop = true
long backcolor = 12639424
string text = "Afficher le nombre de mois"
boolean checked = true
end type

event clicked;call super::clicked;IF THIS.Checked = TRUE THEN
	dw_preview.object.cf_moismois.visible = 1
	dw_preview.object.st_mois.visible = 1
ELSE
	dw_preview.object.cf_moismois.visible = 0
	dw_preview.object.st_mois.visible = 0	
END IF
end event

