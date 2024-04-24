﻿$PBExportHeader$w_r_expedition_produit.srw
forward
global type w_r_expedition_produit from w_rapport
end type
type cbx_saut_page from u_cbx within w_r_expedition_produit
end type
type cbx_afficher from u_cbx within w_r_expedition_produit
end type
end forward

global type w_r_expedition_produit from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Expéditions par produit"
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
cbx_saut_page cbx_saut_page
cbx_afficher cbx_afficher
end type
global w_r_expedition_produit w_r_expedition_produit

event ue_transfertinternet();//ue_transfertinternet
gnv_app.inv_transfert_internet.of_transfertexpheb( dw_preview, "produit")
end event

on w_r_expedition_produit.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
this.cbx_saut_page=create cbx_saut_page
this.cbx_afficher=create cbx_afficher
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_saut_page
this.Control[iCurrent+2]=this.cbx_afficher
end on

on w_r_expedition_produit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_saut_page)
destroy(this.cbx_afficher)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
string	ls_cie, ls_sql
datetime	ldt_de, ldt_au

ldt_de = datetime(date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de", FALSE)), 00:00:00)
ldt_au = datetime(date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au", FALSE)), 23:59:59.999999)
ls_cie = gnv_app.inv_entrepotglobal.of_retournedonnee("lien centre rapport")
IF ls_cie = "" OR lower(ls_cie) = "tous" THEN SetNull(ls_cie)

select count(1) into :ll_nb from #temp_RapLoc;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #temp_RapLoc (cie_no varchar(3) null,~r~n" + &
													"No_Eleveur integer null,~r~n" + &
													"Groupe integer null,~r~n" + &
													"GroupeSecondaire integer null,~r~n" + &
													"liv_date datetime null,~r~n" + &
													"prod_no varchar(15) null,~r~n" + &
													"TotExped double null,~r~n" + &
													"Code_Hebergeur varchar(1) null,~r~n" + &
													"Pure integer null,~r~n" + &
													"CodeRace varchar(255) null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #temp_RapLoc;
	commit using sqlca;
end if

//à reviser
INSERT INTO #temp_RapLoc (cie_no, No_Eleveur, Groupe, GroupeSecondaire, liv_date, prod_no, TotExped, Pure, Code_Hebergeur, CodeRace )
SELECT 
Temp_TblStatFacture.CIE_NO,
Temp_TblStatFacture.No_Eleveur,
t_ELEVEUR.Groupe,
t_ELEVEUR.GroupeSecondaire,
datetime(string(dateformat(Temp_TblStatFacture.LIV_DATE, 'yyyy-mm-dd'), ' 00:00:00')) as Date_sans_heure,
Temp_TblStatFactureDetail.PROD_NO, 
Sum(Temp_TblStatFactureDetail.QTE_EXP) AS TotExped, 
0 AS Pure, 
t_Produit.CodeHebergeur AS CodeHebergeur, 
'' AS CodeRACE
FROM 
((Select 
T_StatFacture.CIE_NO,
T_StatFacture.No_Eleveur,
T_StatFacture.LIV_DATE,
T_StatFacture.liv_no
FROM 
T_StatFacture INNER JOIN t_Eleveur ON 
T_StatFacture.No_Eleveur = t_Eleveur.No_Eleveur
WHERE
T_StatFacture.LIV_DATE >= :ldt_de and
T_StatFacture.LIV_DATE <= :ldt_au and
(T_StatFacture.CIE_NO = :ls_cie or :ls_cie is null)) as Temp_TblStatFacture INNER JOIN t_ELEVEUR ON 
Temp_TblStatFacture.No_Eleveur = t_ELEVEUR.No_Eleveur) INNER JOIN 
((SELECT 
T_StatFactureDetail.VERRAT_NO,
T_StatFactureDetail.QTE_EXP,
T_StatFactureDetail.CIE_NO,
T_StatFactureDetail.LIV_NO,
T_StatFactureDetail.PROD_NO
FROM 
t_Produit_Famille RIGHT JOIN 
(((Select 
T_StatFacture.CIE_NO,
T_StatFacture.No_Eleveur,
T_StatFacture.LIV_DATE,
T_StatFacture.liv_no
FROM 
T_StatFacture INNER JOIN t_Eleveur ON 
T_StatFacture.No_Eleveur = t_Eleveur.No_Eleveur
WHERE
T_StatFacture.LIV_DATE >= :ldt_de and
T_StatFacture.LIV_DATE <= :ldt_au and
(T_StatFacture.CIE_NO = :ls_cie or :ls_cie is null)) as Temp_TblStatFacture INNER JOIN T_StatFactureDetail ON 
(Temp_TblStatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND 
(Temp_TblStatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)) LEFT JOIN 
t_Produit ON T_StatFactureDetail.PROD_NO = t_Produit.NoProduit) ON 
t_Produit_Famille.Famille = t_Produit.Famille) as Temp_TblStatFactureDetail INNER JOIN t_Produit ON 
Temp_TblStatFactureDetail.PROD_NO = t_Produit.NoProduit) ON
Temp_TblStatFacture.LIV_NO = Temp_TblStatFactureDetail.LIV_NO AND 
Temp_TblStatFacture.CIE_NO = Temp_TblStatFactureDetail.CIE_NO
WHERE 
t_Produit.NoClasse = 9
GROUP BY 
Temp_TblStatFacture.CIE_NO, 
Temp_TblStatFacture.No_Eleveur, 
t_ELEVEUR.Groupe, 
t_ELEVEUR.GroupeSecondaire, 
Date_sans_heure, 
Temp_TblStatFactureDetail.PROD_NO, 
Pure, 
CodeHebergeur
HAVING 
Temp_TblStatFactureDetail.PROD_NO Not Like 'PUR%' AND 
TotExped<>0
UNION
(SELECT
Temp_TblStatFacture.CIE_NO,
Temp_TblStatFacture.No_Eleveur,
t_ELEVEUR.Groupe,
t_ELEVEUR.GroupeSecondaire,
datetime(string(dateformat(Temp_TblStatFacture.LIV_DATE, 'yyyy-mm-dd'), ' 00:00:00')) as Date_sans_heure,
Temp_TblStatFactureDetail.VERRAT_NO AS PROD_NO,
Sum(Temp_TblStatFactureDetail.QTE_EXP) AS TotExped,
1 AS Pure,
Left(CodeVerrat,1) AS CodeHebergeur,
T_Verrat.CodeRACE
FROM ((Select
T_StatFacture.CIE_NO,
T_StatFacture.No_Eleveur,
T_StatFacture.LIV_DATE,
T_StatFacture.liv_no
FROM
T_StatFacture INNER JOIN t_Eleveur ON
T_StatFacture.No_Eleveur = t_Eleveur.No_Eleveur
WHERE
T_StatFacture.LIV_DATE >= :ldt_de and
T_StatFacture.LIV_DATE <= :ldt_au and
(T_StatFacture.CIE_NO = :ls_cie or :ls_cie is null)) as Temp_TblStatFacture INNER JOIN t_ELEVEUR ON Temp_TblStatFacture.No_Eleveur = t_ELEVEUR.No_Eleveur) INNER JOIN ((SELECT 
T_StatFactureDetail.VERRAT_NO,
T_StatFactureDetail.QTE_EXP,
T_StatFactureDetail.CIE_NO,
T_StatFactureDetail.LIV_NO,
T_StatFactureDetail.PROD_NO
FROM 
t_Produit_Famille RIGHT JOIN 
(((Select 
T_StatFacture.CIE_NO,
T_StatFacture.No_Eleveur,
T_StatFacture.LIV_DATE,
T_StatFacture.liv_no
FROM 
T_StatFacture INNER JOIN t_Eleveur ON 
T_StatFacture.No_Eleveur = t_Eleveur.No_Eleveur
WHERE
T_StatFacture.LIV_DATE >= :ldt_de and
T_StatFacture.LIV_DATE <= :ldt_au and
(T_StatFacture.CIE_NO = :ls_cie or :ls_cie is null)) as Temp_TblStatFacture INNER JOIN T_StatFactureDetail ON 
(Temp_TblStatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) AND 
(Temp_TblStatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)) LEFT JOIN 
t_Produit ON T_StatFactureDetail.PROD_NO = t_Produit.NoProduit) ON 
t_Produit_Famille.Famille = t_Produit.Famille) as Temp_TblStatFactureDetail INNER JOIN T_Verrat ON Temp_TblStatFactureDetail.VERRAT_NO = T_Verrat.CodeVerrat) ON (Temp_TblStatFacture.LIV_NO = Temp_TblStatFactureDetail.LIV_NO) AND (Temp_TblStatFacture.CIE_NO = Temp_TblStatFactureDetail.CIE_NO)
GROUP BY
Temp_TblStatFacture.CIE_NO,
Temp_TblStatFacture.No_Eleveur,
t_ELEVEUR.Groupe,
t_ELEVEUR.GroupeSecondaire,
Date_sans_heure,
Temp_TblStatFactureDetail.VERRAT_NO,
Pure,
T_Verrat.CodeRACE,
CodeHebergeur
HAVING 
TotExped<>0) ;
COMMIT USING SQLCA;

SetPointer(Hourglass!)


dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(date(ldt_de), date(ldt_au), ls_cie )
end event

type dw_preview from w_rapport`dw_preview within w_r_expedition_produit
integer y = 80
integer height = 2228
string dataobject = "d_r_expedition_produit"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event

event dw_preview::pfc_filterdlg;call super::pfc_filterdlg;string	ls_filtre

ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)
IF Not IsNull(ls_filtre) AND ls_filtre <> "" THEN
	dw_preview.object.t_som.visible = 0
	dw_preview.object.dw_1.visible = 0
	dw_preview.object.gt_total_heb_t.visible = 0
	dw_preview.object.cf_gt_gt.visible = 0
	cbx_afficher.visible = FALSE
END IF

RETURN AncestorReturnValue
end event

type cbx_saut_page from u_cbx within w_r_expedition_produit
integer x = 27
integer y = 4
integer width = 814
integer height = 64
boolean bringtotop = true
long backcolor = 12639424
string text = "Saut de page par sous-groupe"
end type

event clicked;call super::clicked;//Mettre un saut de page dynamiquement
long	ll_cpt

SetPointer(HourGlass!)

IF This.Checked = TRUE THEN
	FOR ll_cpt = 1 TO dw_preview.rowcount()
		dw_preview.object.new_page_flag[ll_cpt]  = 1
	END FOR
ELSE
	FOR ll_cpt = 1 TO dw_preview.rowcount()
		dw_preview.object.new_page_flag[ll_cpt]  = 0
	END FOR
END IF
dw_preview.GroupCalc()

dw_preview.SetFocus()
end event

type cbx_afficher from u_cbx within w_r_expedition_produit
integer x = 1120
integer y = 4
integer width = 599
integer height = 64
boolean bringtotop = true
long backcolor = 12639424
string text = "Afficher le grand total"
boolean checked = true
end type

event clicked;call super::clicked;IF This.Checked = TRUE THEN
	dw_preview.object.t_gt.visible = 1
	dw_preview.object.cf_tres_grand_total.visible = 1
ELSE
	dw_preview.object.t_gt.visible = 0
	dw_preview.object.cf_tres_grand_total.visible = 0
END IF
end event

