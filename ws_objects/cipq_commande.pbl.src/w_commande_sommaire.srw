$PBExportHeader$w_commande_sommaire.srw
forward
global type w_commande_sommaire from w_sheet_frame
end type
type uo_fin from u_cst_toolbarstrip within w_commande_sommaire
end type
type dw_eleveur_commande_sommaire from u_dw within w_commande_sommaire
end type
type dw_sommaire_commande_repetitive from u_dw within w_commande_sommaire
end type
type dw_sommaire_commande from u_dw within w_commande_sommaire
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_commande_sommaire
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_commande_sommaire
end type
type pb_rech from u_pb within w_commande_sommaire
end type
type gb_1 from u_gb within w_commande_sommaire
end type
type gb_2 from u_gb within w_commande_sommaire
end type
type rr_1 from roundrectangle within w_commande_sommaire
end type
end forward

global type w_commande_sommaire from w_sheet_frame
string tag = "menu=m_enregistrerlescommandes"
integer width = 4686
integer height = 2468
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
uo_fin uo_fin
dw_eleveur_commande_sommaire dw_eleveur_commande_sommaire
dw_sommaire_commande_repetitive dw_sommaire_commande_repetitive
dw_sommaire_commande dw_sommaire_commande
uo_toolbar_bas uo_toolbar_bas
uo_toolbar_haut uo_toolbar_haut
pb_rech pb_rech
gb_1 gb_1
gb_2 gb_2
rr_1 rr_1
end type
global w_commande_sommaire w_commande_sommaire

type variables
long	il_eleveur = 0

boolean	ib_gedis = FALSE

datetime	adt_courant
end variables

forward prototypes
public subroutine of_savedetailtoprinter (date ad_datecommande, string as_noeleveur, string as_nocommande, string as_itemcommande, string as_mode, real ar_quantite)
end prototypes

public subroutine of_savedetailtoprinter (date ad_datecommande, string as_noeleveur, string as_nocommande, string as_itemcommande, string as_mode, real ar_quantite);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_savedetailtoprinter
//
//	Accès:  			Public
//
//	Argument:		ad_datecommande
//						as_noeleveur
//						as_nocommande
//						as_itemcommande
//						as_mode
//						ar_quantite
//
//	Retourne:  		Rien
//
// Description:	Mettre dans la table de l'impression différée
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-29	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_aString, ls_sql

//Générer la ligne à imprimer
If as_Mode = "Supprimer" Then
    ls_aString = "Via sommaire: " +string(ad_DateCommande, "yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + as_NoEleveur + "; NoComm: " + as_NoCommande + "; Item: " + as_ItemCommande
Else
    ls_aString = "Via sommaire: " + string(ad_DateCommande, "yyyy-mm-dd") + "; " + as_Mode + ": " + string(now(), "hh:mm") + "; " + as_NoEleveur + "; NoComm: " + as_NoCommande + "; Com: " + string(ar_quantite) + "; Item: " + as_ItemCommande
End If

ls_aString = ls_aString + " Par: " + gnv_app.of_getuserid( )

//Écrire dans 'Tmp_ImpressionCommande'
ls_sql = "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande ) SELECT '" + ls_aString + "' AS Description"

EXECUTE IMMEDIATE :ls_sql USING SQLCA;

COMMIT USING SQLCA;
end subroutine

on w_commande_sommaire.create
int iCurrent
call super::create
this.uo_fin=create uo_fin
this.dw_eleveur_commande_sommaire=create dw_eleveur_commande_sommaire
this.dw_sommaire_commande_repetitive=create dw_sommaire_commande_repetitive
this.dw_sommaire_commande=create dw_sommaire_commande
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar_haut=create uo_toolbar_haut
this.pb_rech=create pb_rech
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_fin
this.Control[iCurrent+2]=this.dw_eleveur_commande_sommaire
this.Control[iCurrent+3]=this.dw_sommaire_commande_repetitive
this.Control[iCurrent+4]=this.dw_sommaire_commande
this.Control[iCurrent+5]=this.uo_toolbar_bas
this.Control[iCurrent+6]=this.uo_toolbar_haut
this.Control[iCurrent+7]=this.pb_rech
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.rr_1
end on

on w_commande_sommaire.destroy
call super::destroy
destroy(this.uo_fin)
destroy(this.dw_eleveur_commande_sommaire)
destroy(this.dw_sommaire_commande_repetitive)
destroy(this.dw_sommaire_commande)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar_haut)
destroy(this.pb_rech)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rr_1)
end on

event pfc_preopen;call super::pfc_preopen;long	ll_rangee, ll_retour

ll_rangee = dw_eleveur_commande_sommaire.InsertRow(0)

il_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien eleveur commande sommaire"))
IF il_eleveur > 0 THEN
	//Sélectionner dans la liste
	dw_eleveur_commande_sommaire.object.no_eleveur[ll_rangee] = il_eleveur
	ll_retour = dw_sommaire_commande_repetitive.Retrieve(il_eleveur)
	ll_retour = dw_sommaire_commande.Retrieve(il_eleveur)	
END IF

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur commande sommaire", "")
end event

event open;call super::open;uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Supprimer cette commande", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Supprimer cette commande répétitive", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_displaytext(true)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Enregistrer", "Save!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_commande_sommaire
integer x = 233
integer y = 24
string text = "Sommaire des commandes"
end type

type p_8 from w_sheet_frame`p_8 within w_commande_sommaire
integer x = 55
integer y = 12
integer width = 142
integer height = 104
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\comm_sommaire.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_commande_sommaire
integer y = 4
end type

type uo_fin from u_cst_toolbarstrip within w_commande_sommaire
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

event ue_buttonclicked;call super::ue_buttonclicked;boolean lb_ImpJournal

CHOOSE CASE as_button

	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer"
		PARENT.event pfc_save()
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()
		
END CHOOSE

end event

type dw_eleveur_commande_sommaire from u_dw within w_commande_sommaire
integer x = 27
integer y = 168
integer width = 2574
integer height = 128
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_eleveur_commande_sommaire"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;
IF row > 0 THEN
	// Lancer le retrieve dans la partie du bas
	il_eleveur = long(data)
	
	dw_sommaire_commande_repetitive.Retrieve(il_eleveur)
	dw_sommaire_commande.Retrieve(il_eleveur)
END IF
end event

type dw_sommaire_commande_repetitive from u_dw within w_commande_sommaire
integer x = 110
integer y = 1352
integer width = 4366
integer height = 660
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sommaire_commande_repetitive"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;SetRowFocusindicator(Hand!)
end event

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null
long					ll_rowdddw
datawindowchild 	ldwc_verrat, ldwc_noproduit

SetNull(ls_null)

CHOOSE CASE dwo.name
				
		
	CASE "t_commanderepetitivedetail_codeverrat"
		
		IF IsNull(data) or data = "" THEN 
			THIS.object.t_commanderepetitivedetail_description[row] = ""
			RETURN 
		END IF
		
		THIS.GetChild('t_commanderepetitivedetail_codeverrat', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("codeverrat = '" + data + "'", 1, ldwc_verrat.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_verrat.GetItemString(ll_rowdddw,"nom")
			THIS.object.t_commanderepetitivedetail_description[row] = ls_desc
		ELSE
			gnv_app.inv_error.of_message("CIPQ0054")
			THIS.ib_suppression_message_itemerror = TRUE
			SetNull(data)
			RETURN 1
		END IF
		
		THIS.object.t_commanderepetitivedetail_noproduit[row] = ls_null
		
		

	CASE "t_commanderepetitivedetail_noproduit"

		//Vérifier s'il y a un raccourci sur la saisie de l'utilisateur
		string	ls_TempValue, ls_produit
		
		SELECT id_prod_ass INTO :ls_tempvalue FROM T_AssociationProd WHERE id_ass = :data ;
		
		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then 
			ls_produit = ls_TempValue
			THIS.object.t_commanderepetitivedetail_noproduit[row] = ls_tempvalue
			data = ls_tempvalue
		ELSE
			ls_produit = data
		END IF
		
		THIS.GetChild('t_commanderepetitivedetail_noproduit', ldwc_noproduit)
		ldwc_noproduit.setTransObject(SQLCA)
		ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_noproduit.GetItemString(ll_rowdddw,"nomproduit")
			THIS.object.t_commanderepetitivedetail_description[row] = ls_desc
			THIS.object.t_produit_nomproduit[row] = ls_desc
		ELSE
			SetNull(data)
			THIS.object.t_commanderepetitivedetail_noproduit[row] = ls_null
			gnv_app.inv_error.of_message("CIPQ0055")
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
		END IF
		
		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then 
			RETURN 2
		END IF		

		
END CHOOSE

end event

event itemfocuschanged;call super::itemfocuschanged;datawindowchild 	ldwc_verrat, ldwc_noproduit
string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat
n_cst_eleveur		lnv_eleveur
boolean				lb_gedis = FALSE

IF Row > 0 THEN
	
	lb_gedis = lnv_eleveur.of_formationgedis(il_eleveur)	
	IF isnull(lb_gedis) THEN lb_gedis = FALSE

	CHOOSE CASE dwo.name 
		CASE "t_commanderepetitivedetail_noproduit"
			
			ls_codeverrat = THIS.object.t_commanderepetitivedetail_codeverrat[row]
			
			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
				//Filtre par no de verrat
				ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
					" FROM t_Produit INNER JOIN t_Verrat_Produit ON t_Produit.NoProduit = t_Verrat_Produit.NoProduit "
					
				If lb_gedis = TRUE Then
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
				Else
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
						"') AND ((Right(upper(t_Produit.NoProduit),3))<>'-GS'))"
				End If				
						
			ELSE
				//Pas de verrat spécifié
				ls_select_str = gnv_app.of_findsqlproduit( il_eleveur, FALSE, FALSE)
				
			END IF

			IF GetChild( "t_commanderepetitivedetail_noproduit", ldwc_noproduit ) = 1 THEN
				  ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
			END IF
			
	END CHOOSE

END IF
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF
		
string	ls_noproduit
long		ll_row

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	ls_noproduit = THIS.object.t_commanderepetitivedetail_noproduit[ll_row]
	//Si pas de produit
	IF IsNull(ls_noproduit) OR ls_noproduit = "" THEN
		gnv_app.inv_error.of_message("pfc_requiredmissing", {"t_commandedetail_noproduit"})
		RETURN FAILURE
	END IF
END IF

RETURN AncestorReturnValue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
END IF
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_noproduit
string 				ls_produit
long					ll_rowdddw

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "t_commanderepetitivedetail_noproduit"
			
			ls_produit = THIS.object.t_commanderepetitivedetail_noproduit[THIS.GetRow()]
			IF IsNull(ls_produit) THEN
				AcceptText()
				ls_produit = THIS.object.t_commanderepetitivedetail_noproduit[THIS.GetRow()]
			END IF

			IF GetChild( "t_commanderepetitivedetail_noproduit", ldwc_noproduit ) = 1 THEN
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

event pfc_predeleterow;call super::pfc_predeleterow;long		ll_row, ll_quantite, ll_qteinit, ll_compteur, ll_qtecommande, ll_cpt
string	ls_transferepar, ls_sql, ls_defaultcie, ls_tranname, ls_nocommande, ls_ItemCommande, &
			ls_noeleveur, ls_codeverrat, ls_produit, ls_cieno
date		ld_commande
boolean	lb_trouve = FALSE
ll_row = THIS.GetRow()

IF AncestorReturnValue > 0 THEN
	
	IF ll_row > 0 THEN
		ls_nocommande = string(THIS.object.t_commanderepetitivedetail_norepeat[ll_row])
		ls_defaultcie = gnv_app.of_getcompagniedefaut( )

		//Delete du père
		//Faire le tour pour voir si c'est le seul item
		FOR ll_cpt = 1 TO dw_sommaire_commande_repetitive.RowCount()
			IF ll_cpt <> ll_row AND &
				dw_sommaire_commande_repetitive.object.t_commanderepetitivedetail_norepeat[ll_cpt] = ls_nocommande THEN
				lb_trouve = TRUE
			END IF
		END FOR
		
		IF lb_trouve = FALSE THEN
			ls_cieno = gnv_app.of_getcompagniedefaut( )
			DELETE FROM t_commanderepetitive
			WHERE 	norepeat = :ls_nocommande AND cieno = :ls_cieno ;
			COMMIT USING SQLCA;
			dw_sommaire_commande_repetitive.retrieve(il_eleveur)
			RETURN -1
		END IF
	END IF
		
END IF

RETURN AncestorReturnValue
end event

type dw_sommaire_commande from u_dw within w_commande_sommaire
integer x = 110
integer y = 380
integer width = 4366
integer height = 720
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sommaire_commande"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;SetRowFocusindicator(Hand!)
end event

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null
long					ll_rowdddw, ll_null, ll_qte
datawindowchild 	ldwc_verrat, ldwc_noproduit

setnull(ls_null)
setnull(ll_null)

CHOOSE CASE dwo.name
		
	CASE "t_commandedetail_codeverrat"

		IF IsNull(data) or data = "" THEN 
			THIS.object.t_commandedetail_description[row] = ""
			RETURN 
		END IF
		
		THIS.GetChild('t_commandedetail_codeverrat', ldwc_verrat)
		ldwc_verrat.setTransObject(SQLCA)
		ll_rowdddw = ldwc_verrat.Find("codeverrat = '" + data + "'", 1, ldwc_verrat.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_verrat.GetItemString(ll_rowdddw,"nom")
			THIS.object.t_commandedetail_description[row] = ls_desc
		ELSE
			gnv_app.inv_error.of_message("CIPQ0054")
			THIS.ib_suppression_message_itemerror = TRUE
			SetNull(data)
			RETURN 1
		END IF
		
		THIS.object.t_commandedetail_noproduit[row] = ""



	CASE "t_commandedetail_noproduit"

		//Vérifier s'il y a un raccourci sur la saisie de l'utilisateur
		string	ls_TempValue, ls_produit
		
		SELECT id_prod_ass INTO :ls_tempvalue FROM T_AssociationProd WHERE id_ass = :data ;
		
		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then 
			ls_produit = ls_TempValue
			THIS.object.t_commandedetail_noproduit[row] = ls_tempvalue
			data = ls_tempvalue
		ELSE
			ls_produit = data
		END IF
		
		THIS.GetChild('t_commandedetail_noproduit', ldwc_noproduit)
		ldwc_noproduit.setTransObject(SQLCA)
		ll_rowdddw = ldwc_noproduit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, ldwc_noproduit.RowCount())		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			//Mettre à jour la description
			ls_desc = ldwc_noproduit.GetItemString(ll_rowdddw,"nomproduit")
			THIS.object.t_commandedetail_description[row] = ls_desc
			THIS.object.t_produit_nomproduit[row] = ls_desc
		ELSE
			gnv_app.inv_error.of_message("CIPQ0055")
			SetNull(data)
			THIS.object.t_commandedetail_noproduit[row] = ls_null
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
		END IF

		If Not IsNull(ls_TempValue) AND ls_TempValue <> "" Then 
			RETURN 2
		END IF	
		
	CASE "t_commandedetail_qtecommande"
		ll_qte = long(data)
		THIS.object.t_commandedetail_qteinit[row] = ll_qte
		THIS.AcceptText()
		
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;datawindowchild 	ldwc_verrat, ldwc_noproduit
string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat
n_cst_eleveur		lnv_eleveur
boolean				lb_gedis = FALSE

IF Row > 0 THEN
	
	lb_gedis = lnv_eleveur.of_formationgedis(il_eleveur)	
	IF isnull(lb_gedis) THEN lb_gedis = FALSE

	CHOOSE CASE dwo.name 
		CASE "t_commandedetail_noproduit"
			
			ls_codeverrat = THIS.object.t_commandedetail_codeverrat[row]
			
			If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
				//Filtre par no de verrat
				ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
					" FROM t_Produit INNER JOIN t_Verrat_Produit ON t_Produit.NoProduit = t_Verrat_Produit.NoProduit "
					
				If lb_gedis = TRUE Then
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
				Else
					ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
						"') AND ((Right(upper(t_Produit.NoProduit),3))<>'-GS'))"
				End If				
						
			ELSE
				//Pas de verrat spécifié
				ls_select_str = gnv_app.of_findsqlproduit( il_eleveur, FALSE, FALSE)
				
			END IF

			IF GetChild( "t_commandedetail_noproduit", ldwc_noproduit ) = 1 THEN
				  ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
			END IF
			
	END CHOOSE

END IF
end event

event pfc_deleterow;call super::pfc_deleterow;//RENDU DANS LE PFC_PREDELETEROW

//long		ll_row, ll_quantite, ll_qteinit, ll_compteur, ll_qtecommande, ll_cpt
//string	ls_transferepar, ls_sql, ls_defaultcie, ls_tranname, ls_nocommande, ls_ItemCommande, &
//			ls_noeleveur, ls_codeverrat, ls_produit, ls_cieno
//date		ld_commande
//boolean	lb_trouve = FALSE
//ll_row = THIS.GetRow()
//
//IF AncestorReturnValue > 0 THEN
//	
//	IF ll_row > 0 THEN
//		ll_quantite = THIS.object.t_commandedetail_qtecommande[ll_row]
//		ls_nocommande = string(THIS.object.t_commandedetail_nocommande[ll_row])
//		ls_transferepar = THIS.object.t_commande_transferepar[ll_row]
//		ls_defaultcie = gnv_app.of_getcompagniedefaut( )
//		ll_qteinit = THIS.object.t_commandedetail_qteinit[ll_row]
//		ls_tranname = THIS.object.t_commandedetail_tranname[ll_row]
//		ll_compteur = THIS.object.t_commandedetail_compteur[ll_row]
//		ld_commande = date(THIS.object.t_commande_datecommande[ll_row])
//		ls_noeleveur = string(THIS.object.t_commande_no_eleveur[ll_row])
//		ls_codeverrat = THIS.object.t_commandedetail_codeverrat[ll_row]
//		ls_produit = THIS.object.t_commandedetail_noproduit[ll_row]
//
//		IF IsNull(ls_transferepar) OR ls_transferepar = "" THEN
//			//Supprimer les commandes originales si ne vient pas d'un transfert, qteinit<>0 et pas transféré
//			If Not IsNull(ll_qteinit) And ll_qteinit <> 0 And IsNull(ls_tranname) Then
//				ls_sql = "DELETE FROM t_CommandeOriginale " + &
//		            "WHERE (((t_CommandeOriginale.CieNo)='" + ls_defaultcie + "') AND "  + &
//						"((t_CommandeOriginale.NoCommande)='" + ls_nocommande + "') AND " + &
//						"((t_CommandeOriginale.NoLigne)= " + string(ll_compteur) + "))"
//				
//				gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Suppression", parent.Title)
//		    End If
//		End If
//		
//		
//		//Imprimer
//		IF ll_quantite <> 0 AND isnull(ll_quantite) = FALSE THEN
//			IF IsNull(ls_codeverrat) THEN
//				ls_ItemCommande = string(ls_produit)
//			ELSE
//				ls_ItemCommande = string(ls_produit) + ", Verrat: " + ls_codeverrat
//			END IF
//			
//			IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
//				of_SaveDetailToPrinter(ld_commande, ls_noeleveur, ls_nocommande, ls_ItemCommande, "Supprimer", ll_quantite)
//			END IF
//		End If
//		
//		//Delete du père
//		//Faire le tour pour voir si c'est le seul item
//		FOR ll_cpt = 1 TO dw_sommaire_commande.RowCount()
//			IF ll_cpt <> ll_row AND &
//				dw_sommaire_commande.object.t_commandedetail_nocommande[ll_cpt] = ls_nocommande THEN
//				
//				lb_trouve = TRUE
//			END IF
//		END FOR
//		
//		IF lb_trouve = FALSE THEN
//			ls_cieno = gnv_app.of_getcompagniedefaut( )
//			DELETE FROM t_commande
//			WHERE 	nocommande = :ls_nocommande AND cieno = :ls_cieno ;
//			COMMIT USING SQLCA;
//		END IF
//	END IF
//		
//END IF

RETURN AncestorReturnValue
end event

event pfc_update;call super::pfc_update;long		ll_row, ll_quantite, ll_qteinit, ll_compteur
string	ls_nocommande, ls_noeleveur, ls_codeverrat, ls_ItemCommande, ls_cie, ls_sql, ls_noproduit
date		ld_commande

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	If AncestorReturnValue = 1 OR ib_ignore_dberror = TRUE THEN
	
		ll_quantite = THIS.object.t_commandedetail_qtecommande[ll_row]
		ls_nocommande = string(THIS.object.t_commandedetail_nocommande[ll_row])
		ld_commande = date(THIS.object.t_commande_datecommande[ll_row])
		ls_noeleveur = string(THIS.object.t_commande_no_eleveur[ll_row])
		ls_codeverrat = THIS.object.t_commandedetail_codeverrat[ll_row]
		ls_noproduit = THIS.object.t_commandedetail_noproduit[ll_row]
		ll_qteinit = THIS.object.t_commandedetail_qteinit[ll_row]
		If isNull(ll_qteinit) THEN ll_qteinit = 0
		ls_cie = THIS.object.t_commandedetail_cieno[ll_row]
		ll_compteur = THIS.object.t_commandedetail_compteur[ll_row]

		//Mettre à jour la commande originale
		ls_sql = "UPDATE t_CommandeOriginale SET QteInit = " + string(ll_qteinit) + &
			"WHERE CieNo = '" + ls_cie + "' AND NoCommande = '" + ls_nocommande + "' AND NoLigne = " + string(ll_compteur)
		
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Mise à jour", parent.Title)
		
		commit USING SQLCA;

		//Imprimer
		IF ll_quantite <> 0 THEN
			IF IsNull(ls_codeverrat) THEN
				ls_ItemCommande = ls_noproduit
			ELSE
				ls_ItemCommande = ls_noproduit + ", Verrat: " + ls_codeverrat
			END IF
			
			IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
				of_SaveDetailToPrinter(ld_commande, ls_noeleveur, ls_nocommande, ls_ItemCommande, "Modifier", ll_quantite)
			END IF
		End If
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF
		
string	ls_noproduit, ls_nocommande
long		ll_row
datetime	ldt_ligne

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	ls_noproduit = THIS.object.t_commandedetail_noproduit[ll_row]
	//Si pas de produit
	IF IsNull(ls_noproduit) OR ls_noproduit = "" THEN
		gnv_app.inv_error.of_message("pfc_requiredmissing", {"t_commandedetail_noproduit"})
		RETURN FAILURE
	END IF
	
	//Vérifier si la date a été mise à jour
	ldt_ligne = THIS.object.t_commande_datecommande[ll_row]
	IF date(ldt_ligne) <> date(adt_courant) THEN
		//La date a changée, il faut faire le update
		
		ls_nocommande = THIS.object.t_commandedetail_nocommande[ll_row]
		
		UPDATE 	t_commande
		SET 		datecommande = :ldt_ligne 
		WHERE		nocommande = :ls_nocommande ;
		
		COMMIT USING SQLCA;
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;
IF currentrow > 0 THEN
	adt_courant = THIS.object.t_commande_datecommande[currentrow]
END IF
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_noproduit
string 				ls_produit
long					ll_rowdddw

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "t_commandedetail_noproduit"
			
			ls_produit = THIS.object.t_commandedetail_noproduit[THIS.GetRow()]
			IF IsNull(ls_produit) THEN
				AcceptText()
				ls_produit = THIS.object.t_commandedetail_noproduit[THIS.GetRow()]
			END IF

			IF GetChild( "t_commandedetail_noproduit", ldwc_noproduit ) = 1 THEN
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

event pfc_predeleterow;call super::pfc_predeleterow;long		ll_row, ll_quantite, ll_qteinit, ll_compteur, ll_qtecommande, ll_cpt
string	ls_transferepar, ls_sql, ls_defaultcie, ls_tranname, ls_nocommande, ls_ItemCommande, &
			ls_noeleveur, ls_codeverrat, ls_produit, ls_cieno
date		ld_commande
boolean	lb_trouve = FALSE
ll_row = THIS.GetRow()

IF AncestorReturnValue > 0 THEN
	
	IF ll_row > 0 THEN
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("donnee sommaire commande", "oui")
		ll_quantite = THIS.object.t_commandedetail_qtecommande[ll_row]
		ls_nocommande = string(THIS.object.t_commandedetail_nocommande[ll_row])
		ls_transferepar = THIS.object.t_commande_transferepar[ll_row]
		ls_defaultcie = gnv_app.of_getcompagniedefaut( )
		ll_qteinit = THIS.object.t_commandedetail_qteinit[ll_row]
		ls_tranname = THIS.object.t_commandedetail_tranname[ll_row]
		ll_compteur = THIS.object.t_commandedetail_compteur[ll_row]
		ld_commande = date(THIS.object.t_commande_datecommande[ll_row])
		ls_noeleveur = string(THIS.object.t_commande_no_eleveur[ll_row])
		ls_codeverrat = THIS.object.t_commandedetail_codeverrat[ll_row]
		ls_produit = THIS.object.t_commandedetail_noproduit[ll_row]

		IF IsNull(ls_transferepar) OR ls_transferepar = "" THEN
			//Supprimer les commandes originales si ne vient pas d'un transfert, qteinit<>0 et pas transféré
			If Not IsNull(ll_qteinit) And ll_qteinit <> 0 And IsNull(ls_tranname) Then
				ls_sql = "DELETE FROM t_CommandeOriginale " + &
		            "WHERE (((t_CommandeOriginale.CieNo)='" + ls_defaultcie + "') AND "  + &
						"((t_CommandeOriginale.NoCommande)='" + ls_nocommande + "') AND " + &
						"((t_CommandeOriginale.NoLigne)= " + string(ll_compteur) + "))"
				
				gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_CommandeOriginale", "Suppression", parent.Title)
		    End If
		End If
		
		
		//Imprimer
		IF ll_quantite <> 0 AND isnull(ll_quantite) = FALSE THEN
			IF IsNull(ls_codeverrat) THEN
				ls_ItemCommande = string(ls_produit)
			ELSE
				ls_ItemCommande = string(ls_produit) + ", Verrat: " + ls_codeverrat
			END IF
			
			IF UPPER(gnv_app.of_getvaleurini( "DATABASE", "SaveToPrinter")) = "TRUE" THEN 
				of_SaveDetailToPrinter(ld_commande, ls_noeleveur, ls_nocommande, ls_ItemCommande, "Supprimer", ll_quantite)
			END IF
		End If
		
		//Delete du père
		//Faire le tour pour voir si c'est le seul item
		FOR ll_cpt = 1 TO dw_sommaire_commande.RowCount()
			IF ll_cpt <> ll_row AND &
				dw_sommaire_commande.object.t_commandedetail_nocommande[ll_cpt] = ls_nocommande THEN
				
				lb_trouve = TRUE
			END IF
		END FOR
		
		IF lb_trouve = FALSE THEN
			ls_cieno = gnv_app.of_getcompagniedefaut( )
			DELETE FROM t_commande
			WHERE 	nocommande = :ls_nocommande AND cieno = :ls_cieno ;
			COMMIT USING SQLCA;
			dw_sommaire_commande.retrieve(il_eleveur)
			RETURN -1
		END IF
	END IF
		
END IF

RETURN AncestorReturnValue
end event

event updateend;call super::updateend;IF rowsInserted > 0 OR rowsupdated > 0 OR rowsdeleted > 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("donnee sommaire commande", "oui")
END IF

end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_commande_sommaire
event destroy ( )
string tag = "resize=frbsr"
integer x = 110
integer y = 1128
integer width = 4366
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;boolean lb_ImpJournal

CHOOSE CASE as_button

	CASE "Supprimer cette commande"		
		dw_sommaire_commande.event pfc_deleterow()
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()
		
END CHOOSE

end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_commande_sommaire
event destroy ( )
string tag = "resize=frbsr"
integer x = 110
integer y = 2016
integer width = 4366
integer taborder = 70
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;boolean lb_ImpJournal

CHOOSE CASE as_button

	CASE "Supprimer cette commande répétitive"		
		dw_sommaire_commande_repetitive.event pfc_deleterow()
		
		// Impression du journal
	 	lb_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')
	    if lb_ImpJournal then gnv_app.inv_journal.of_ImprimerJournal()
		
END CHOOSE

end event

type pb_rech from u_pb within w_commande_sommaire
integer x = 2478
integer y = 188
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
string text = ""
string picturename = "C:\ii4net\CIPQ\images\recherche.gif"
end type

event clicked;call super::clicked;w_eleveur_rech	lw_wind_rech
long	ll_no_eleveur

gnv_app.inv_entrepotglobal.of_ajoutedonnee("eleveur rech rouges et inactifs", 1)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "oui")

Open(lw_wind_rech)

ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("retour eleveur rech"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "")

IF not isnull(ll_no_eleveur) AND ll_no_eleveur > 0 THEN
	dw_eleveur_commande_sommaire.object.no_eleveur[1] = ll_no_eleveur
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour eleveur rech", "")
	
	// Lancer le retrieve dans la partie du bas
	il_eleveur = ll_no_eleveur
	dw_sommaire_commande_repetitive.Retrieve(il_eleveur)
	dw_sommaire_commande.Retrieve(il_eleveur)	
END IF
end event

type gb_1 from u_gb within w_commande_sommaire
integer x = 69
integer y = 300
integer width = 4457
integer height = 964
integer taborder = 0
long backcolor = 15793151
string text = "Commandes"
end type

type gb_2 from u_gb within w_commande_sommaire
integer x = 69
integer y = 1276
integer width = 4457
integer height = 884
integer taborder = 0
long backcolor = 15793151
string text = "Commandes répétitives"
end type

type rr_1 from roundrectangle within w_commande_sommaire
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 148
integer width = 4549
integer height = 2048
integer cornerheight = 40
integer cornerwidth = 46
end type

