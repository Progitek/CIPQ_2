$PBExportHeader$w_bon_expedition.srw
forward
global type w_bon_expedition from w_sheet_frame
end type
type uo_fin from u_cst_toolbarstrip within w_bon_expedition
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_bon_expedition
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_bon_expedition
end type
type dw_bon_expedition from u_dw within w_bon_expedition
end type
type dw_bon_expedition_detail from u_dw within w_bon_expedition
end type
type gb_1 from groupbox within w_bon_expedition
end type
type gb_2 from groupbox within w_bon_expedition
end type
type rr_1 from roundrectangle within w_bon_expedition
end type
end forward

global type w_bon_expedition from w_sheet_frame
string tag = "menu=m_consulterlesbonsdexpedition"
string title = "Bon de livraison"
uo_fin uo_fin
uo_toolbar_haut uo_toolbar_haut
uo_toolbar_bas uo_toolbar_bas
dw_bon_expedition dw_bon_expedition
dw_bon_expedition_detail dw_bon_expedition_detail
gb_1 gb_1
gb_2 gb_2
rr_1 rr_1
end type
global w_bon_expedition w_bon_expedition

type variables
boolean	ib_insertion_temp = FALSE
end variables

forward prototypes
public function long of_recupererprochainnumeroitem ()
public function integer of_livraison_sans_produit ()
end prototypes

public function long of_recupererprochainnumeroitem ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumeroitem
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Numéro 
//
// Description:	Fonction pour trouver la valeur du prochain numéro 
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-03	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(ligne_no) + 1
INTO		:ll_no
FROM		t_statfacturedetail
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

public function integer of_livraison_sans_produit ();// of_livraison_sans_produit
// Fonction qui vérifie s'il n'y a pas au moins un produit dans la livraison

long ll_row, ll_count
string ls_noproduit
boolean lb_produit_pg1 = false

// 2010-02-24 - Sébastien - avertissement quand il n'y a pas de produit facturé
for ll_row = 1 to dw_bon_expedition_detail.rowCount()
	if lb_produit_pg1 then exit
	
	ls_noproduit = dw_bon_expedition_detail.object.prod_no[ll_row]
	// 2010-07-13 - Sébastien - On ne valide plus la quantité
//	ll_qte = dw_bon_expedition_detail.object.qte_exp[ll_row]
//	If IsNull(ll_qte) THEN ll_qte = 0
	
	select count(1) into :ll_count
	from t_Transport where codeTransport = :ls_noproduit;
	
	if ll_count = 0 then lb_produit_pg1 = true
next

if not lb_produit_pg1 then
	return gnv_app.inv_error.of_message("CIPQ0166")
end if

return 0
end function

on w_bon_expedition.create
int iCurrent
call super::create
this.uo_fin=create uo_fin
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar_bas=create uo_toolbar_bas
this.dw_bon_expedition=create dw_bon_expedition
this.dw_bon_expedition_detail=create dw_bon_expedition_detail
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_fin
this.Control[iCurrent+2]=this.uo_toolbar_haut
this.Control[iCurrent+3]=this.uo_toolbar_bas
this.Control[iCurrent+4]=this.dw_bon_expedition
this.Control[iCurrent+5]=this.dw_bon_expedition_detail
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.rr_1
end on

on w_bon_expedition.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_fin)
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar_bas)
destroy(this.dw_bon_expedition)
destroy(this.dw_bon_expedition_detail)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rr_1)
end on

event open;call super::open;//Faire le lien des critères

date		ld_date
long		ll_no_bon, ll_rtn, ll_no_eleveur
string	ls_filtre = "", ls_sql_dw = "", ls_centre

ld_date = date(gnv_app.inv_entrepotglobal.of_retournedonnee("critere bon date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon date", "")
ll_no_bon = long(gnv_app.inv_entrepotglobal.of_retournedonnee("critere bon no bon"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no bon", "")
ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("critere bon no eleveur"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no eleveur", "")
ls_centre = gnv_app.inv_entrepotglobal.of_retournedonnee("critere bon centre")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon centre", "")


If Not IsNull(ld_date) AND ld_date <> 1900-01-01 THEN
	ls_filtre += " date(LIV_DATE) = date('" + string(ld_date, "yyyy-mm-dd") + "') "
END IF

If Not IsNull(ll_no_bon) AND ll_no_bon <> 0 THEN
	IF Len(ls_filtre) > 0 THEN ls_filtre += " AND "
	ls_filtre += " LIV_NO = '" + string(ll_no_bon) + "' "
END IF

If Not IsNull(ll_no_eleveur) AND ll_no_eleveur <> 0 THEN
	IF Len(ls_filtre) > 0 THEN ls_filtre += " AND "
	ls_filtre += " t_StatFacture.no_eleveur = " + string(ll_no_eleveur) + " "
END IF

If Not IsNull(ls_centre) AND ls_centre <> "" THEN
	IF Len(ls_filtre) > 0 THEN ls_filtre += " AND "
	ls_filtre += " t_StatFacture.cie_no = " + ls_centre + " "
END IF

IF ls_filtre <> "" THEN
	//Arrange la clause where
	ls_sql_dw = dw_bon_expedition.GetSqlSelect()
	ls_sql_dw = ls_sql_dw + " WHERE " + ls_filtre
	SetPointer(HourGlass!)
	ll_rtn = dw_bon_expedition.SetSqlSelect(ls_sql_dw)
END IF

SetPointer(HourGlass!)
dw_bon_expedition.event pfc_retrieve()
end event

event pfc_postopen;call super::pfc_postopen;//Toolbars
//uo_toolbar_haut.of_settheme("classic")
//uo_toolbar_haut.of_DisplayBorder(true)
//uo_toolbar_haut.of_AddItem("Supprimer ce bon", "C:\ii4net\CIPQ\images\supprimer.ico")
//uo_toolbar_haut.POST of_displaytext(true)
//
uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un item", "AddWatch5!")
//uo_toolbar_bas.of_AddItem("Supprimer cet item", "DeleteWatch5!")
uo_toolbar_bas.POST of_displaytext(true)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Rechercher...", "Search!")
uo_fin.of_AddItem("Imprimer", "Print!")
uo_fin.of_AddItem("Imprimer l'écran", "Preview!")
uo_fin.of_AddItem("Enregistrer", "Save!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)
end event

event closequery;call super::closequery;date ld_cur
long ll_row

if ancestorReturnValue > 0 then return ancestorReturnValue

ll_row = dw_bon_expedition.GetRow()
IF ll_row > 0 THEN
	ld_cur = date(dw_bon_expedition.object.liv_date[ll_row])
	IF month(ld_cur) = month(today()) AND year(ld_cur) = year(today()) THEN
		if of_livraison_sans_produit() = 2 then return 1
	end if
end if
end event

type st_title from w_sheet_frame`st_title within w_bon_expedition
string text = "Bon de livraison"
end type

type p_8 from w_sheet_frame`p_8 within w_bon_expedition
integer height = 64
string picturename = "Copy!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_bon_expedition
end type

type uo_fin from u_cst_toolbarstrip within w_bon_expedition
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2228
integer width = 4544
integer taborder = 50
boolean bringtotop = true
end type

on uo_fin.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Imprimer"
		n_ds		lds_imprimer
		long		ll_nb_ligne, ll_row_dw
		string	ls_cie, ls_NoLivToPrint
		
		ll_row_dw = dw_bon_expedition.GetRow()
		
		IF ll_row_dw > 0 THEN
			SetPointer(HourGlass!)
			
			ls_cie = dw_bon_expedition.object.cie_no[ll_row_dw]
			ls_NoLivToPrint = dw_bon_expedition.object.liv_no[ll_row_dw]
			
			lds_imprimer = CREATE n_ds
			lds_imprimer.dataobject = "d_r_bon_stat_110"
			lds_imprimer.of_setTransobject(SQLCA)
			
			ll_nb_ligne = lds_imprimer.Retrieve(ls_cie, ls_NoLivToPrint)
			lds_imprimer.print(false, TRUE)
			
			IF IsValid(lds_imprimer) THEN destroy(lds_imprimer)
			
		END IF
		
	CASE "Imprimer l'écran"
		long ll_Job

		ll_Job = PrintOpen("Écran", TRUE)
		PrintScreen(ll_Job,1,1,8125,6250)

		PrintClose(ll_Job)
		
	CASE "Rechercher..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_bon_expedition.RowCount() > 0 THEN
				dw_bon_expedition.SetRow(1)
				dw_bon_expedition.ScrolltoRow(1)
				dw_bon_expedition.event pfc_finddlg()		
			END IF
		END IF
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer"
		//Mettre le TransDate à null
		long		ll_row
		datetime	ldt_null
		
		SetNull(ldt_null)
		ll_row = dw_bon_expedition.GetRow()
		IF ll_row > 0 THEN
			//Gestion des données pour le transfert
			dw_bon_expedition.object.transdate[ll_row] = ldt_null
		END IF
		
		if of_livraison_sans_produit() = 2 then return
		
		PARENT.event pfc_save()
END CHOOSE

end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_bon_expedition
event destroy ( )
string tag = "resize=frbsr"
boolean visible = false
integer x = 137
integer y = 820
integer width = 4320
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Supprimer ce bon"
		dw_bon_expedition.event pfc_deleterow()

END CHOOSE
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_bon_expedition
event destroy ( )
string tag = "resize=frbsr"
integer x = 137
integer y = 1960
integer width = 4320
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;date	ld_cur
long	ll_row

CHOOSE CASE as_button
		
	CASE "Supprimer cet item"
		dw_bon_expedition_detail.event pfc_deleterow()

	CASE "Ajouter un item"
		//Impossible d'ajouter si ce n'est pas dans le mois courant
		ll_row = dw_bon_expedition.GetRow()
		IF ll_row > 0 THEN
			ld_cur = date(dw_bon_expedition.object.liv_date[ll_row])
			IF month(ld_cur) = month(today()) AND year(ld_cur) = year(today()) THEN
				dw_bon_expedition_detail.SetFocus()
				dw_bon_expedition_detail.event pfc_insertrow()
			ELSE
				Messagebox("Attention", "Il est impossible de modifier un bon qui n'est pas du mois courant.")
			END IF
		END IF
END CHOOSE

end event

type dw_bon_expedition from u_dw within w_bon_expedition
integer x = 137
integer y = 316
integer width = 4311
integer height = 476
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_bon_expedition"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)


end event

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

RETURN THIS.Retrieve()
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue = CONTINUE_ACTION AND dw_bon_expedition_detail.RowCount() > 0 THEN
	gnv_app.inv_error.of_message("CIPQ0122")
	RETURN PREVENT_ACTION
END IF

RETURN AncestorReturnValue
end event

event rowfocuschanging;call super::rowfocuschanging;date ld_cur
long ll_row

if ancestorReturnValue > 0 then return ancestorReturnValue

if currentrow > 0 then
	ll_row = this.GetRow()
	IF ll_row > 0 THEN
		ld_cur = date(dw_bon_expedition.object.liv_date[ll_row])
		IF month(ld_cur) = month(today()) AND year(ld_cur) = year(today()) THEN
			if of_livraison_sans_produit() = 2 then
				this.post scrollToRow(currentrow)
				
				return 1
			end if
		end if
	end if
end if
end event

type dw_bon_expedition_detail from u_dw within w_bon_expedition
integer x = 137
integer y = 1104
integer width = 4311
integer height = 852
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_bon_expedition_detail"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_bon_expedition)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("cie_no","cie_no")
this.inv_linkage.of_Register("liv_no","liv_no")

SetRowFocusindicator(Hand!)

THIS.of_setpremierecolonneinsertion("qte_comm")
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

//2008-09-15 - On n'ajustera pas les commandes originales, ça ne vaut pas la peine, décision de Léonard et Odette

long		ll_iddepot, ll_row, ll_no, ll_count, ll_qte_exp, ll_qte_com
date		ld_dateexpedie
string	ls_codeverrat, ls_noproduit
boolean	lb_produit_pg1 = false

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	
	//2008-11-26 Mathieu Gendron
	//Pour accepter la sauvegarde Il faut que la qté commandée et expédiée soit du même signe
	ll_qte_exp = THIS.object.qte_exp[ll_row]
	If IsNull(ll_qte_exp) THEN ll_qte_exp = 0
	ll_qte_com = THIS.object.qte_comm[ll_row]
	If IsNull(ll_qte_com) THEN ll_qte_com = 0
	
	IF ll_qte_com <> 0 AND ll_qte_exp <> 0 THEN
		IF ( ll_qte_com < 0 AND ll_qte_exp > 0 ) OR ( ll_qte_com > 0 AND ll_qte_exp < 0 ) THEN
			Messagebox("Attention", "Si la quantité commandée est négative, la quantité expédiée doit l'être aussi, et inversement.")
			RETURN FAILURE
		END IF
	END IF
	
	ll_no = THIS.object.t_statfacturedetail_ligne_no[ll_row]
	IF IsNull(ll_no) THEN
		ll_no = PARENT.of_recupererprochainnumeroitem()
		THIS.object.t_statfacturedetail_ligne_no[ll_row] = ll_no
	END IF

	ls_codeverrat = THIS.object.verrat_no[ll_row]
	ls_noproduit = THIS.object.prod_no[ll_row]
	
	//Si pas de verrat
	
	If IsNull(ls_codeverrat) OR ls_codeverrat = "" Then
		If Not IsNull(ls_noproduit) Then
			SELECT count(1) INTO :ll_count
			FROM t_Verrat_Produit WHERE upper(t_Verrat_Produit.NoProduit) = upper(:ls_noproduit) USING SQLCA;
			
			IF ll_count > 0 THEN
				gnv_app.inv_error.of_message("CIPQ0060",{ls_noproduit})
				SetColumn("verrat_no")
			
				RETURN FAILURE
			End If
		End If
	End If
	
END IF

RETURN ancestorreturnvalue
end event

event itemfocuschanged;call super::itemfocuschanged;datawindowchild 	ldwc_verrat, ldwc_noproduit
string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat
n_cst_eleveur		lnv_eleveur
long					ll_row_parent, ll_eleveur
boolean				lb_gedis = FALSE

IF Row > 0 THEN
	
	ll_row_parent = dw_bon_expedition.GetRow()
	
	ll_eleveur = dw_bon_expedition.object.no_eleveur[ll_row_parent]
	
	lb_gedis = lnv_eleveur.of_formationgedis(ll_eleveur)	
	IF isnull(lb_gedis) THEN lb_gedis = FALSE

	CHOOSE CASE dwo.name 
		CASE "prod_no"
			
			ls_codeverrat = THIS.object.verrat_no[row]
			
			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
				//Filtre par no de verrat
				ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
					" FROM t_Produit INNER JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) "
					
				If lb_gedis = TRUE Then
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
				Else
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
						"') AND ((Right(t_Produit.NoProduit,3))<>'-GS'))"
				End If
						
			ELSE
				//Pas de verrat spécifié
				ls_select_str = gnv_app.of_findsqlproduit( ll_eleveur, TRUE, FALSE)
				
			END IF

			IF GetChild( "prod_no", ldwc_noproduit ) = 1 THEN
				ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
				
				//Nouveau retrieve parce que la dddw n'était pas toujours bien chargée
				ldwc_noproduit.setTransObject(SQLCA)
				ldwc_noproduit.Retrieve()
			END IF
			
	END CHOOSE

END IF
end event

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null
long					ll_rowdddw, ll_qte
datawindowchild 	ldwc_verrat, ldwc_noproduit

SetNull(ls_null)

CHOOSE CASE dwo.name
	
	CASE "qtecommande"
		ll_qte = long(data)
		THIS.object.qteinit[row] = ll_qte
		THIS.AcceptText()
		
	CASE "verrat_no"
		
		IF IsNull(data) or data = "" THEN 
			THIS.object.description[row] = ""
			RETURN 
		END IF
		
		THIS.GetChild('verrat_no', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("upper(codeverrat) = '" + upper(data) + "'", 1, ldwc_verrat.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_verrat.GetItemString(ll_rowdddw,"nom")
			THIS.object.description[row] = ls_desc
		ELSE
			gnv_app.inv_error.of_message("CIPQ0054")
			THIS.ib_suppression_message_itemerror = TRUE
			setnull(data)
			THIS.object.verrat_no[row] = ls_null
			RETURN 1
		END IF
		
		THIS.object.prod_no[row] = ls_null
		THIS.object.t_produit_nomproduit[row] = ""

	CASE "prod_no"

		//Vérifier s'il y a un raccourci sur la saisie de l'utilisateur
		string	ls_TempValue, ls_produit
		
		THIS.GetChild('prod_no', ldwc_noproduit)
		
		SELECT id_prod_ass INTO :ls_tempvalue FROM T_AssociationProd WHERE id_ass = trim(:data) ;
		
		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then
			ls_produit = ls_TempValue
			if ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_TempValue) + "-GS'", 1, ldwc_noproduit.RowCount()) > 0 then
				ls_produit += '-GS'
			end if
			
			THIS.object.prod_no[row] = ls_produit
		ELSE
			ls_produit = trim(data)
			if ls_produit <> data then
				THIS.object.prod_no[row] = ls_produit
			end if
		END IF
		
		ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_noproduit.GetItemString(ll_rowdddw,"nomproduit")
			THIS.object.description[row] = ls_desc
			THIS.object.t_produit_nomproduit[row] = ls_desc
		ELSE
			//On ne peut saisir un produit pas dans la liste
			gnv_app.inv_error.of_message("CIPQ0055")
			SetNull(data)
			THIS.object.prod_no[row] = ls_null
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.object.t_produit_nomproduit[row] = ""
			RETURN 1				
		END IF

		If (Not IsNull(ls_TempValue) AND ls_TempValue <> "") or ls_produit <> data Then
			RETURN 2
		END IF
		
END CHOOSE
end event

event pfc_retrieve;call super::pfc_retrieve;// Pour filtrer la liste de verrats - Sébastien 2008-10-31

datawindowchild ldwc_verrat

if this.getChild("verrat_no", ldwc_verrat) = 1 then
	return this.event pfc_populatedddw("verrat_no", ldwc_verrat)
else
	return -1
end if
end event

event pfc_populatedddw;call super::pfc_populatedddw;if as_colname = 'verrat_no' then
	if dw_bon_expedition.getRow() > 0 then
		adwc_obj.setTransObject(SQLCA)
		adwc_obj.setSQLSelect(gnv_app.of_sqllisteverrats(dw_bon_expedition.object.no_eleveur[dw_bon_expedition.getRow()]))
		return adwc_obj.retrieve()
	else
		adwc_obj.reset()
		return 0
	end if
end if
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_noproduit
string 				ls_produit
long					ll_rowdddw

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "prod_no"
			
			ls_produit = THIS.object.prod_no[THIS.GetRow()]
			IF IsNull(ls_produit) THEN
				AcceptText()
				ls_produit = THIS.object.prod_no[THIS.GetRow()]
			END IF

			IF GetChild( "prod_no", ldwc_noproduit ) = 1 THEN
				//Sélectionner la rangée
				ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())
				IF ll_rowdddw > 0 THEN
					ldwc_noproduit.SetRow(ll_rowdddw)
					ldwc_noproduit.ScrollToRow(ll_rowdddw)
				END IF
			END IF
			
	END CHOOSE

END IF
end event

type gb_1 from groupbox within w_bon_expedition
integer x = 91
integer y = 244
integer width = 4411
integer height = 728
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Commande"
end type

type gb_2 from groupbox within w_bon_expedition
integer x = 91
integer y = 1008
integer width = 4411
integer height = 1128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Items"
end type

type rr_1 from roundrectangle within w_bon_expedition
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 192
integer width = 4549
integer height = 2008
integer cornerheight = 40
integer cornerwidth = 46
end type

