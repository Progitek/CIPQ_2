$PBExportHeader$w_r_destination_produits.srw
forward
global type w_r_destination_produits from w_rapport
end type
type cbx_afficher from u_cbx within w_r_destination_produits
end type
end forward

global type w_r_destination_produits from w_rapport
string title = "Rapport - Destination des produits"
cbx_afficher cbx_afficher
end type
global w_r_destination_produits w_r_destination_produits

on w_r_destination_produits.create
int iCurrent
call super::create
this.cbx_afficher=create cbx_afficher
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_afficher
end on

on w_r_destination_produits.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_afficher)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")

ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

//#temp_des_pro_statfacture et #temp_des_pro_statfactureDetail
gnv_app.of_Cree_TableFact_Temp("temp_des_pro_statfacture")

//Première extraction
INSERT INTO #temp_des_pro_statfacture 
SELECT t_StatFacture.* 
FROM t_StatFacture 
WHERE date(t_StatFacture.LIV_DATE)>= :ld_de And date(t_StatFacture.LIV_DATE) <= :ld_au ;
Commit USING SQLCA;

SetPointer(Hourglass!)

//extraction du détail '#temp_des_pro_statfactureDetail'
INSERT INTO #temp_des_pro_statfactureDetail SELECT t_StatFactureDetail.* 
FROM t_StatFacture INNER JOIN t_StatFactureDetail ON (t_StatFacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
AND (t_StatFacture.CIE_NO = t_StatFactureDetail.CIE_NO) 
WHERE date(t_StatFacture.LIV_DATE) >= :ld_de And date(t_StatFacture.LIV_DATE) <= :ld_au ;
Commit USING SQLCA;
SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(ld_de, ld_au)
end event

type dw_preview from w_rapport`dw_preview within w_r_destination_produits
integer y = 108
integer height = 2200
integer taborder = 22
string dataobject = "d_r_destination_produits"
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

type cbx_afficher from u_cbx within w_r_destination_produits
integer x = 27
integer y = 16
integer width = 709
integer height = 68
boolean bringtotop = true
long backcolor = 12639424
string text = "Afficher les montants"
boolean checked = true
end type

event clicked;call super::clicked;IF THIS.checked = FALSE THEN
	dw_preview.object.avgp.visible = 0
	dw_preview.object.avgp_t.visible = 0
	dw_preview.object.cf_sum_mont.visible = 0
ELSE
	dw_preview.object.avgp.visible = 1
	dw_preview.object.avgp_t.visible = 1
	dw_preview.object.cf_sum_mont.visible = 1
END IF

dw_preview.SetFocus()
end event

