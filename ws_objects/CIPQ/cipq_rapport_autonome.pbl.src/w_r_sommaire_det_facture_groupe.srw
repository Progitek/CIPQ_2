$PBExportHeader$w_r_sommaire_det_facture_groupe.srw
forward
global type w_r_sommaire_det_facture_groupe from w_rapport
end type
type cbx_saut from u_cbx within w_r_sommaire_det_facture_groupe
end type
end forward

global type w_r_sommaire_det_facture_groupe from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Sommaire du détail des factures par groupe"
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
cbx_saut cbx_saut
end type
global w_r_sommaire_det_facture_groupe w_r_sommaire_det_facture_groupe

type variables
date	id_date
end variables

event ue_transfertinternet();//dw_preview.setsort("embal DESC,prod_no ASC,idgroupsecondaire ASC,t_ELEVEUR.No_Eleveur ASC,t_statfacture.FACT_NO ASC,uprix ASC")
//dw_preview.sort( )
gnv_app.inv_transfert_internet.of_transfertdetailfacture(dw_preview)
end event

on w_r_sommaire_det_facture_groupe.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
this.cbx_saut=create cbx_saut
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_saut
end on

on w_r_sommaire_det_facture_groupe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_saut)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cur
date		ld_cur

ls_cur = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date", FALSE)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")
ld_cur = date(ls_cur)

SetPointer(Hourglass!)

//Préparer les tables temporaires
//gnv_app.of_Cree_TableFact_Temp("temp_som_det_fac_statfacture")

//INSERT INTO #temp_som_det_fac_statfacture SELECT t_StatFacture.* 
//FROM t_StatFacture 
//WHERE t_StatFacture.FACT_DATE = :ld_cur;
//COMMIT USING SQLCA;

//#temp_som_det_fac_statfactureDetail
//INSERT INTO #temp_som_det_fac_statfactureDetail SELECT t_StatFactureDetail.* 
//FROM #temp_som_det_fac_statfacture 
//INNER JOIN t_StatFactureDetail 
//ON (#temp_som_det_fac_statfacture.LIV_NO = t_StatFactureDetail.LIV_NO) 
//AND (#temp_som_det_fac_statfacture.CIE_NO = t_StatFactureDetail.CIE_NO);
//COMMIT USING SQLCA;

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

id_date = date(ls_cur)
ll_nb = dw_preview.Retrieve(id_date, 0)
end event

type dw_preview from w_rapport`dw_preview within w_r_sommaire_det_facture_groupe
integer x = 27
integer y = 76
integer height = 2208
string dataobject = "d_r_sommaire_det_facture_groupe"
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

type cbx_saut from u_cbx within w_r_sommaire_det_facture_groupe
integer x = 23
integer y = 12
integer width = 1102
integer height = 68
boolean bringtotop = true
long backcolor = 12639424
string text = "Saut de page par client"
end type

event clicked;call super::clicked;//Mettre un saut de page dynamiquement
long	ll_cpt, ll_nb

SetPointer(Hourglass!)

IF This.Checked = TRUE THEN
	ll_nb = dw_preview.Retrieve(id_date, 1)
ELSE
	ll_nb = dw_preview.Retrieve(id_date, 0)
END IF
dw_preview.SetFocus()
end event

