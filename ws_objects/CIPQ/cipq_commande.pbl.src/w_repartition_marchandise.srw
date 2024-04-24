$PBExportHeader$w_repartition_marchandise.srw
forward
global type w_repartition_marchandise from w_sheet_frame
end type
type rr_1 from roundrectangle within w_repartition_marchandise
end type
type uo_fin from u_cst_toolbarstrip within w_repartition_marchandise
end type
type dw_repartition_entete from u_dw within w_repartition_marchandise
end type
type st_desc from statictext within w_repartition_marchandise
end type
type dw_repartition_resume from u_dw within w_repartition_marchandise
end type
type dw_repartition_produit from u_dw within w_repartition_marchandise
end type
type em_date from u_em within w_repartition_marchandise
end type
type st_1 from statictext within w_repartition_marchandise
end type
type pb_go from picturebutton within w_repartition_marchandise
end type
type gb_1 from groupbox within w_repartition_marchandise
end type
type rr_2 from roundrectangle within w_repartition_marchandise
end type
type rr_3 from roundrectangle within w_repartition_marchandise
end type
type dw_repartition_haut from u_dw within w_repartition_marchandise
end type
type dw_repartition_bas from u_dw within w_repartition_marchandise
end type
type gb_2 from groupbox within w_repartition_marchandise
end type
type gb_3 from groupbox within w_repartition_marchandise
end type
end forward

global type w_repartition_marchandise from w_sheet_frame
string tag = "menu=m_repartitiondesmarchandises"
rr_1 rr_1
uo_fin uo_fin
dw_repartition_entete dw_repartition_entete
st_desc st_desc
dw_repartition_resume dw_repartition_resume
dw_repartition_produit dw_repartition_produit
em_date em_date
st_1 st_1
pb_go pb_go
gb_1 gb_1
rr_2 rr_2
rr_3 rr_3
dw_repartition_haut dw_repartition_haut
dw_repartition_bas dw_repartition_bas
gb_2 gb_2
gb_3 gb_3
end type
global w_repartition_marchandise w_repartition_marchandise

type variables
string	is_sql_original

long		il_qtedistribuable = 0
end variables

forward prototypes
public subroutine of_rafraichirdws ()
public subroutine of_linkdws ()
public subroutine of_ventiler ()
public subroutine of_voir_quantite_non_attribuee ()
public subroutine of_corriger_quantite ()
public subroutine of_charger_dddw_code ()
public subroutine of_transfert ()
public subroutine of_retrieve_resume ()
public function long of_getdivider (long al_qtecommande)
end prototypes

public subroutine of_rafraichirdws ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_rafraichirdws
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour rafraichir les dws
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-31	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rowcount
date	ld_cur
ld_cur = date(em_date.text)

ll_rowcount = dw_repartition_produit.Retrieve(ld_cur)

SetPointer(HourGlass!)

IF ll_rowcount > 0 THEN
	dw_repartition_produit.selectrow( 1, TRUE )
	dw_repartition_produit.Event RowFocusChanged(1)
ELSE
	dw_repartition_haut.reset()
	dw_repartition_bas.reset()
END IF
end subroutine

public subroutine of_linkdws ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_linkdws
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour linker les dws reliées au produit
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-01-31	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_produit1, ls_desc = ""
long		ll_row, ll_rtn
date		ld_cur

ld_cur = date(em_date.text)

ll_row = dw_repartition_produit.GetRow()
IF ll_row > 0 THEN
	ls_produit1 = dw_repartition_produit.object.noproduit1[ll_row]
	dw_repartition_resume.Retrieve(ld_cur, ls_produit1)

	ls_desc = dw_repartition_produit.object.t_produit_nomproduit[ll_row]
	
	ll_rtn = dw_repartition_haut.Retrieve(ld_cur, ls_produit1)
	IF ll_rtn > 0 THEN
		dw_repartition_haut.event rowfocuschanged(1)
	END IF
	
ELSE
	dw_repartition_resume.Reset()
END IF

//Mettre la description en conséquence
st_desc.text = ls_desc

THIS.of_charger_dddw_code()

end subroutine

public subroutine of_ventiler ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ventiler
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour ventiler selon les mélanges
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-01	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_qte, ll_qte_reste, ll_rowcounthaut, ll_cpt_haut, ll_rep, ll_ext, ll_qtecommande, &
			ll_qteexpedie, ll_QteManque, ll_balance, ll_vent, ll_repeat, ll_divider, ll_MelQte, &
			ll_qexped, ll_difference, ll_controle, ll_rowdddw, ll_QteDistribue
string	ls_codemel, ls_transfcommande, ls_melange = "", ls_lot
boolean	lb_continue = TRUE, lb_DeuxEChoix = TRUE
date		ld_cur

dw_repartition_entete.AcceptText()
dw_repartition_haut.AcceptText()
dw_repartition_bas.AcceptText()

ld_cur = date(em_date.text)
ll_qte = dw_repartition_entete.object.qte[1]
ls_codemel = dw_repartition_entete.object.code[1]
ll_balance = dw_repartition_entete.object.vent_balance[1]
ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
ll_vent = dw_repartition_entete.object.vent_tout_lot[1]


IF IsNull(ll_qte) OR ll_qte = 0 OR IsNull(ll_qte_reste) OR ll_qte_reste = 0 THEN RETURN

ll_rowcounthaut = dw_repartition_haut.RowCount()

IF Isnull(ls_codemel) OR ls_codemel = "" THEN
	ll_rep = gnv_app.inv_error.of_message("CIPQ0088")
	
	IF ll_rep = 1 THEN
		
		//Rafraichir la variable
		ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
		
		FOR ll_cpt_haut = 1 TO ll_rowcounthaut
			lb_continue = TRUE
			
			ls_transfcommande = dw_repartition_haut.object.transfcommande[ll_cpt_haut]
			//Si à transférer, aller au prochain
			IF ls_transfcommande = "" OR IsNull(ls_transfcommande) THEN
				
				//Livraison extérieur:
				ll_ext = dw_repartition_entete.object.liv_ext[1] 
				IF ll_ext = 1 THEN
					//Si le SecteurTransporteur n'est pas externe on passe au suivant
					ll_ext = dw_repartition_haut.object.externe[ll_cpt_haut]
					IF ll_ext = 0 THEN lb_continue = FALSE
				END IF
				
				IF lb_continue = TRUE THEN
					//Ventilation
					
					ll_qtecommande = dw_repartition_haut.object.qtecommande[ll_cpt_haut]
					If IsNull(ll_qtecommande) THEN ll_qtecommande = 0
					ll_qteexpedie = dw_repartition_haut.object.qteexpedie[ll_cpt_haut]
					If IsNull(ll_qteexpedie) THEN ll_qteexpedie = 0
					
					IF (ll_qtecommande - ll_qteexpedie) > ll_qte_reste THEN
						dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie + ll_qte_reste
						ll_qte_reste = 0
						dw_repartition_entete.object.qte_restant[1] = 0
						//Plus rien à distribuer
						EXIT
						
					ELSE
						
						ll_QteManque = ll_qtecommande - ll_qteexpedie
						ll_qteexpedie = ll_qteexpedie + ll_QteManque
						dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
						dw_repartition_entete.object.qte_restant[1] = dw_repartition_entete.object.qte_restant[1] - ll_qtemanque
						IF dw_repartition_entete.object.qte_restant[1] = 0 THEN
							EXIT
						ELSE
							lb_continue = FALSE
						END IF
					END IF
					
					IF lb_continue = TRUE THEN
						IF dw_repartition_entete.object.qte_restant[1] < ll_qtecommande THEN
							ll_qteexpedie = dw_repartition_entete.object.qte_restant[1]
							dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
							ll_qte_reste = 0
							dw_repartition_entete.object.qte_restant[1] = 0
							//Plus rien à distribuer
						ELSE
							
							IF ll_qteexpedie = 0 THEN
								IF dw_repartition_entete.object.qte_restant[1] <> 0 THEN
									ll_qteexpedie = ll_qtecommande
									dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
									ll_qte_reste = dw_repartition_entete.object.qte_restant[1] - ll_qteexpedie
									dw_repartition_entete.object.qte_restant[1] = ll_qte_reste
								ELSE
									EXIT
								END IF
							END IF
						END IF
					END IF
				END IF
			END IF
			
		END FOR
		
		dw_repartition_entete.AcceptText()
		dw_repartition_haut.AcceptText()
		this.event pfc_save()
		
	END IF	
	
//ELSE
// MESSAGE POUVANT TRAITER LES COMMANDES RÉPÉTITIVES A PART
//	IF gnv_app.inv_error.of_message("CIPQ0089") = 1 THEN
//		lb_DeuxEChoix = TRUE
//	ELSE
//		lb_DeuxEChoix = FALSE
//	END IF
END IF

dw_repartition_entete.AcceptText()
dw_repartition_haut.AcceptText()

//Rafraichir la variable
ll_qte_reste = dw_repartition_entete.object.qte_restant[1]

//*************************************************
//Ventillation avec code de mélanges (no lot)
//*************************************************

//On ventille la balance du lot, même si déja eu de ce lot, selon la demande
//Dans ce cas, les cases Ventilation = 0 et Externe = 0
IF ll_balance = 1 THEN
	FOR ll_cpt_haut = 1 TO ll_rowcounthaut
			ls_transfcommande = dw_repartition_haut.object.transfcommande[ll_cpt_haut]
			//Si à transférer, aller au prochain
			IF ls_transfcommande = "" OR IsNull(ls_transfcommande) THEN
				ll_qtecommande = dw_repartition_haut.object.qtecommande[ll_cpt_haut]
				If IsNull(ll_qtecommande) THEN ll_qtecommande = 0
				ll_qteexpedie = dw_repartition_haut.object.qteexpedie[ll_cpt_haut]
				If IsNull(ll_qteexpedie) THEN ll_qteexpedie = 0				
				
				ll_QteManque = ll_qtecommande - ll_qteexpedie
				
				IF ll_QteManque <> 0 THEN
					IF ll_QteManque > ll_qte_reste THEN
						ll_qteexpedie = ll_qteexpedie + ll_qte_reste
						dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
						ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
						IF IsNull(ls_melange) OR ls_melange = "" THEN 
							ls_melange = ""
						ELSE
							ls_melange += ", "
						END IF
						ls_melange = ls_melange + string(ll_qte_reste) + " " + ls_codemel
						dw_repartition_haut.object.melange[ll_cpt_haut] = ls_melange
						ll_qte_reste = 0
						dw_repartition_entete.object.qte_restant[1] = 0
						EXIT
						
					ELSE
						ll_qteexpedie = ll_qteexpedie + ll_QteManque
						dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
						ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
						IF IsNull(ls_melange) OR ls_melange = "" THEN 
							ls_melange = ""
						ELSE
							ls_melange += ", "
						END IF
						ls_melange = ls_melange + string(ll_QteManque) + " " + ls_codemel
						dw_repartition_haut.object.melange[ll_cpt_haut] = ls_melange
						ll_qte_reste = ll_qte_reste - ll_QteManque
						dw_repartition_entete.object.qte_restant[1] = ll_qte_reste
						IF ll_qte_reste = 0 THEN EXIT
						
					END IF
					
					IF ll_qte_reste = 0 THEN EXIT
					
				END IF
			END IF
		
	END FOR

ELSE
	
	IF ll_vent = 0 THEN //Méthode traditionnelle
		FOR ll_cpt_haut = 1 TO ll_rowcounthaut
			
			lb_continue = TRUE
			
			ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
			ls_transfcommande = dw_repartition_haut.object.transfcommande[ll_cpt_haut]
			ll_repeat = dw_repartition_haut.object.repeat[ll_cpt_haut]
			//Si à transférer, aller au prochain
			IF ls_transfcommande = "" OR IsNull(ls_transfcommande) THEN
							
				//si DeuxEChoix = True (distribution exclusive aux commandes répétitives)
				//IF NOT(lb_DeuxEChoix = TRUE AND ll_repeat = 0) THEN
					
					//Livraison extérieur:
					ll_ext = dw_repartition_entete.object.liv_ext[1] 
					IF ll_ext = 1 THEN
						//Si le SecteurTransporteur n'est pas externe on passe au suivant
						ll_ext = dw_repartition_haut.object.externe[ll_cpt_haut]
						IF ll_ext = 0 THEN lb_continue = FALSE
					END IF
					
					IF lb_continue = TRUE THEN
					
						//On distribue
						ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
						IF POS(ls_melange, ls_codemel) = 0 OR isnull(ls_melange) OR ls_melange = "" THEN
							ll_qtecommande = dw_repartition_haut.object.qtecommande[ll_cpt_haut]
							If IsNull(ll_qtecommande) THEN ll_qtecommande = 0
							ll_qteexpedie = dw_repartition_haut.object.qteexpedie[ll_cpt_haut]
							If IsNull(ll_qteexpedie) THEN ll_qteexpedie = 0		
							
							ll_divider = THIS.of_getdivider(ll_qtecommande)
							ll_MelQte = Round(ll_qtecommande / ll_divider ,0)
							
							ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
							
							IF ll_qte_reste < ll_MelQte THEN
								ll_MelQte = ll_qte_reste
							END IF
							
							IF mod(ll_qtecommande , ll_divider ) > 0 THEN
								IF (ll_qteexpedie + ll_MelQte) < ll_qtecommande THEN
									ll_MelQte ++
								END IF
							END IF
							
							IF ll_MelQte > 30 THEN 
								ll_MelQte = 30
							END IF
							
							IF ll_qteexpedie < ll_qtecommande THEN 
								IF ( ll_qteexpedie + ll_MelQte ) > ll_qtecommande THEN
									ll_MelQte = ll_qtecommande - ll_qteexpedie
								END IF
								IF ll_qte_reste < ll_MelQte THEN
									ll_MelQte = ll_qte_reste
								END IF
								
								ll_qexped = ll_qteexpedie
								
								dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie + ll_MelQte
								dw_repartition_entete.object.qte_restant[1] = ll_qte_reste - ll_MelQte
								
								ll_difference = dw_repartition_haut.object.qteexpedie[ll_cpt_haut] - ll_qexped
								
								IF ll_controle <> 1 THEN
									ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
									IF IsNull(ls_melange) OR ls_melange = "" THEN 
										ls_melange = ""
									ELSE
										ls_melange += ", "
									END IF
									ls_melange = ls_melange + string(ll_difference) + " " + ls_codemel
									dw_repartition_haut.object.melange[ll_cpt_haut] = ls_melange
								END IF
								
							END IF
							
							dw_repartition_entete.AcceptText()
							dw_repartition_haut.AcceptText()
							
							ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
							IF ll_qte_reste = 0 THEN
								ll_controle = 1
							END IF 
						END IF
					
					END IF
					
				//END IF
				
			END IF
			
			IF ll_qte_reste = 0 THEN EXIT
			
		END FOR
		
	ELSE   //Nouvelle méthode pour tout distribuer: comme si pas de Code Mélange
		FOR ll_cpt_haut = 1 TO ll_rowcounthaut
			
			lb_continue = TRUE
			
			ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
			ls_transfcommande = dw_repartition_haut.object.transfcommande[ll_cpt_haut]
			ll_repeat = dw_repartition_haut.object.repeat[ll_cpt_haut]
			//Si à transférer, aller au prochain
			IF ls_transfcommande = "" OR IsNull(ls_transfcommande) THEN
							
				//si DeuxEChoix = True (distribution exclusive aux commandes répétitives)
				//IF NOT(lb_DeuxEChoix = TRUE AND ll_repeat = 0) THEN
					//Livraison extérieur:
					ll_ext = dw_repartition_entete.object.liv_ext[1] 
					IF ll_ext = 1 THEN
						//Si le SecteurTransporteur n'est pas externe on passe au suivant
						ll_ext = dw_repartition_haut.object.externe[ll_cpt_haut]
						IF ll_ext = 0 THEN lb_continue = FALSE
					END IF
					
					IF lb_continue = TRUE THEN
               	//On distribue
                  //Si jamais eu de ce lot dans le mélange, on distribue selon la demande
						ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
						IF POS(ls_melange, ls_codemel) = 0 OR isnull(ls_melange) OR ls_melange = "" THEN
							ll_qtecommande = dw_repartition_haut.object.qtecommande[ll_cpt_haut]
							If IsNull(ll_qtecommande) THEN ll_qtecommande = 0
							ll_qteexpedie = dw_repartition_haut.object.qteexpedie[ll_cpt_haut]
							If IsNull(ll_qteexpedie) THEN ll_qteexpedie = 0		
							
							ll_QteManque = ll_qtecommande - ll_qteexpedie
							IF ll_qtemanque > 0 THEN 
								IF ll_qtemanque > ll_qte_reste THEN
									ll_qteexpedie += ll_qte_reste
									dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
									ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
									IF IsNull(ls_melange) OR ls_melange = "" THEN 
										ls_melange = ""
									ELSE
										ls_melange += ", "
									END IF
									ls_melange = ls_melange + string(ll_qte_reste) + " " + ls_codemel
									dw_repartition_haut.object.melange[ll_cpt_haut] = ls_melange		
									ll_qte_reste = 0
								ELSE
									ll_qteexpedie += ll_qtemanque
									dw_repartition_haut.object.qteexpedie[ll_cpt_haut] = ll_qteexpedie
									ls_melange = dw_repartition_haut.object.melange[ll_cpt_haut]
									IF IsNull(ls_melange) OR ls_melange = "" THEN 
										ls_melange = ""
									ELSE
										ls_melange += ", "
									END IF
									ls_melange = ls_melange + string(ll_qtemanque) + " " + ls_codemel
									dw_repartition_haut.object.melange[ll_cpt_haut] = ls_melange									
									ll_qte_reste -= ll_qtemanque
									
							
								END IF		
								dw_repartition_entete.object.qte_restant[1] = ll_qte_reste
							END IF
						END IF
					END IF
				//END IF
			END IF
			
			dw_repartition_entete.AcceptText()
			dw_repartition_haut.AcceptText()
			
			ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
			IF ll_qte_reste = 0 THEN EXIT
		
		END FOR		
		
	END IF
END IF

//MAJ des qtés distribuées dans 'T_Recolte_GestionLot_Produit_QteDistribue'
//si un lot correspondant au code existe

datawindowchild ldwc_code
string	ls_famille,  ls_noproduitd
long		ll_compteur, ll_count1, ll_qtebd
n_ds		lds_search

lds_search = CREATE n_ds
lds_search.dataobject = "dddw_repartition_code_filtre_search"
lds_search.SetTransObject(SQLCA)

ll_rowdddw = lds_search.Retrieve(date(em_date.text),dw_repartition_produit.object.noproduit1[dw_repartition_produit.GetRow()],ls_codemel)

//Vérifier s'il fait partie de la liste
IF ll_rowdddw > 0 THEN
	
	ls_noproduitd = lds_search.GetItemString(ll_rowdddw,"t_recolte_gestionlot_produit_noproduit")
	ll_compteur = lds_search.GetItemNumber(ll_rowdddw,"t_recolte_gestionlot_produit_compteur")
	ls_famille = lds_search.GetItemString(ll_rowdddw,"t_recolte_gestionlot_produit_famille")
	
	ll_qte_reste = dw_repartition_entete.object.qte_restant[1]
	IF il_qtedistribuable <> ll_qte_reste THEN
		//On a distribué une qtée
		
		ll_QteDistribue = il_qtedistribuable - ll_qte_reste
		il_qtedistribuable = ll_qte_reste
		
		
		SELECT 	count(1), QteDistribue
		INTO		:ll_count1, :ll_qtebd
		FROM 		T_Recolte_GestionLot_Produit_QteDistribue 
		WHERE 	date(t_Recolte_GestionLot_Produit_QteDistribue.DateRecolte) = :ld_cur 
		AND 		upper(t_Recolte_GestionLot_Produit_QteDistribue.Famille) = upper(:ls_famille) 
		AND 		t_Recolte_GestionLot_Produit_QteDistribue.NoLot = :ls_codemel
		AND 		upper(t_Recolte_GestionLot_Produit_QteDistribue.NoProduit) = upper(:ls_noproduitd)
		AND 		t_Recolte_GestionLot_Produit_QteDistribue.Compteur = string(:ll_compteur)
		group by QteDistribue
		USING		SQLCA;
		
		IF ll_count1 > 0 THEN
			ll_qtebd = ll_qtebd + ll_QteDistribue
			
			UPDATE 	T_Recolte_GestionLot_Produit_QteDistribue SET QteDistribue = :ll_qtebd
			WHERE 	date(t_Recolte_GestionLot_Produit_QteDistribue.DateRecolte) = :ld_cur 
			AND 		upper(t_Recolte_GestionLot_Produit_QteDistribue.Famille) = upper(:ls_famille) 
			AND 		t_Recolte_GestionLot_Produit_QteDistribue.NoLot = :ls_codemel
			AND 		upper(t_Recolte_GestionLot_Produit_QteDistribue.NoProduit) = upper(:ls_noproduitd )
			AND 		t_Recolte_GestionLot_Produit_QteDistribue.Compteur = string(:ll_compteur)
			USING		SQLCA;
			
		ELSE
			
			INSERT 	INTO T_Recolte_GestionLot_Produit_QteDistribue 
			( DateRecolte, Famille, NoLot, NoProduit, Compteur, QteDistribue ) 
			VALUES (:ld_cur, :ls_famille, :ls_codemel, :ls_noproduitd, string(:ll_compteur), :ll_QteDistribue)
			USING		SQLCA;
			
		END IF
		
		COMMIT USING SQLCA;
	END IF
	
	dw_repartition_entete.object.vent_balance[1] = 0
	dw_repartition_entete.object.vent_tout_lot[1] = 0
	
END IF	
dw_repartition_entete.AcceptText()
dw_repartition_haut.AcceptText()
this.event pfc_save()
this.post of_linkdws()

If IsValid(lds_search ) THEN Destroy(lds_search )
end subroutine

public subroutine of_voir_quantite_non_attribuee ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_voir_quantite_non_attribuee
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour voir les quantités non-attribuées
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-01	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

date		ld_comm

ld_comm = date(em_date.text)

//Ajouter les produits non attribués
INSERT INTO 
t_Recolte_GestionLot_Produit_QteDistribue 
( DateRecolte, Famille, NoLot, NoProduit, Compteur, QteDistribue ) 
SELECT 
t_Recolte_GestionLot_Produit.DateRecolte, 
t_Recolte_GestionLot_Produit.Famille, 
t_Recolte_GestionLot_Produit.NoLot, 
t_Recolte_GestionLot_Produit.NoProduit, 
t_Recolte_GestionLot_Produit.Compteur, 
0 AS Qte 
FROM t_Recolte_GestionLot_Produit 
LEFT JOIN t_Recolte_GestionLot_Produit_QteDistribue ON 
(t_Recolte_GestionLot_Produit.Compteur = t_Recolte_GestionLot_Produit_QteDistribue.Compteur) 
AND (upper(t_Recolte_GestionLot_Produit.NoProduit) = upper(t_Recolte_GestionLot_Produit_QteDistribue.NoProduit)) 
AND (t_Recolte_GestionLot_Produit.NoLot = t_Recolte_GestionLot_Produit_QteDistribue.NoLot) 
AND (upper(t_Recolte_GestionLot_Produit.Famille) = upper(t_Recolte_GestionLot_Produit_QteDistribue.Famille)) 
AND (t_Recolte_GestionLot_Produit.DateRecolte = t_Recolte_GestionLot_Produit_QteDistribue.DateRecolte) 
WHERE date(t_Recolte_GestionLot_Produit.DateRecolte) = :ld_comm AND 
t_Recolte_GestionLot_Produit.QteDoseMelange > 0 AND 
(t_Recolte_GestionLot_Produit_QteDistribue.DateRecolte Is Null) AND 
(t_Recolte_GestionLot_Produit_QteDistribue.Famille Is Null) AND 
(t_Recolte_GestionLot_Produit_QteDistribue.NoLot Is Null) AND 
(t_Recolte_GestionLot_Produit_QteDistribue.NoProduit Is Null) AND 
(t_Recolte_GestionLot_Produit_QteDistribue.Compteur Is Null);

COMMIT USING SQLCA;

//Ouvrir l'interface
w_repartition_produitnonattribue lw_wind

gnv_app.inv_entrepotglobal.of_ajoutedonnee("repartition non attribue date", em_date.text )

Open(lw_wind)
end subroutine

public subroutine of_corriger_quantite ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_corriger_quantite
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour ouvrir la fenêtre de correction des quantités
//						réparties
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-01	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Ouvrir l'interface
w_repartition_correction lw_wind

Open(lw_wind)

THIS.of_charger_dddw_code()




end subroutine

public subroutine of_charger_dddw_code ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_charger_dddw_code
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour recharger la liste des codes
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-01	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_rtn, ll_row
string	ls_produit
date		ld_cur
datawindowchild	ldwc_trans

ld_cur = date(em_date.text)

IF Not IsNull(ld_cur) THEN
	ll_row = dw_repartition_produit.GetRow()
	IF ll_row > 0 THEN
		ls_produit = dw_repartition_produit.object.noproduit1[ll_row]
		ll_rtn = dw_repartition_entete.GetChild('code', ldwc_trans)
		ldwc_trans.setTransObject(SQLCA)
		ll_rtn = ldwc_trans.retrieve(ld_cur, ls_produit)
	END IF
END IF
end subroutine

public subroutine of_transfert ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_transfert
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour transférer une commande
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

date	ld_commande

IF THIS.event pfc_save() >= 0 THEN
	ld_commande = date(em_date.text)
	
	If not isnull(ld_commande) THEN
		
		gnv_app.inv_transfert_inter_centre.of_transfert( ld_commande )	
	ELSE
		
		em_date.SetFocus()
	END IF
END IF
end subroutine

public subroutine of_retrieve_resume ();string	ls_produit1
long		ll_row
date		ld_cur

IF THIS.event pfc_save() >= 0 THEN
	ld_cur = date(em_date.text)
	
	ll_row = dw_repartition_produit.GetRow()
	IF ll_row > 0 THEN
		ls_produit1 = dw_repartition_produit.object.noproduit1[ll_row]
		dw_repartition_resume.Retrieve(ld_cur, ls_produit1)
	END IF
END IF
end subroutine

public function long of_getdivider (long al_qtecommande);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_getdivider
//
//	Accès:  			Public
//
//	Argument:		al_qtecommande - quantitée commandée
//
//	Retourne:  		Le divider
//
// Description:	Fonction pour gérer les modulos personnalisés
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-02-07	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long ll_divider

SELECT 	FIRST t_CfgModulo.Modulo_Calcul 
INTO		:ll_divider
FROM 		t_CfgModulo WHERE t_CfgModulo.Min_Qte <= :al_qtecommande ORDER BY Min_Qte DESC USING SQLCA;

RETURN ll_divider
end function

on w_repartition_marchandise.create
int iCurrent
call super::create
this.rr_1=create rr_1
this.uo_fin=create uo_fin
this.dw_repartition_entete=create dw_repartition_entete
this.st_desc=create st_desc
this.dw_repartition_resume=create dw_repartition_resume
this.dw_repartition_produit=create dw_repartition_produit
this.em_date=create em_date
this.st_1=create st_1
this.pb_go=create pb_go
this.gb_1=create gb_1
this.rr_2=create rr_2
this.rr_3=create rr_3
this.dw_repartition_haut=create dw_repartition_haut
this.dw_repartition_bas=create dw_repartition_bas
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rr_1
this.Control[iCurrent+2]=this.uo_fin
this.Control[iCurrent+3]=this.dw_repartition_entete
this.Control[iCurrent+4]=this.st_desc
this.Control[iCurrent+5]=this.dw_repartition_resume
this.Control[iCurrent+6]=this.dw_repartition_produit
this.Control[iCurrent+7]=this.em_date
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.pb_go
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.rr_2
this.Control[iCurrent+12]=this.rr_3
this.Control[iCurrent+13]=this.dw_repartition_haut
this.Control[iCurrent+14]=this.dw_repartition_bas
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
end on

on w_repartition_marchandise.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rr_1)
destroy(this.uo_fin)
destroy(this.dw_repartition_entete)
destroy(this.st_desc)
destroy(this.dw_repartition_resume)
destroy(this.dw_repartition_produit)
destroy(this.em_date)
destroy(this.st_1)
destroy(this.pb_go)
destroy(this.gb_1)
destroy(this.rr_2)
destroy(this.rr_3)
destroy(this.dw_repartition_haut)
destroy(this.dw_repartition_bas)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;long		ll_rtn
date		ld_null
string	ls_null

SetNull(ld_null)
SetNull(ls_null)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Enregistrer", "Save!")
uo_fin.of_AddItem("Voir quantité non-attribuée", "C:\ii4net\CIPQ\images\lookup.bmp")
uo_fin.of_AddItem("Transfert", "Custom035!")
uo_fin.of_AddItem("Corriger les quantitées réparties", "C:\ii4net\CIPQ\images\bons.bmp")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = dw_repartition_entete.GetChild('code', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ld_null, ls_null)

dw_repartition_entete.InsertRow(0)

em_date.text = string(date(today()))

Long ll_newrow
DataWindowChild dddw_child

dw_repartition_haut.getchild( "trans", dddw_child)

ll_newrow = dddw_child.insertrow(1)

dddw_child.setitem( 1, "prefnom", "")
end event

event pfc_postopen;call super::pfc_postopen;pb_go.Event Clicked()
end event

event pfc_preopen;call super::pfc_preopen;gnv_app.of_RepartLock()

end event

event close;call super::close;gnv_app.of_RepartUnLock()
end event

type st_title from w_sheet_frame`st_title within w_repartition_marchandise
integer x = 224
string text = "Répartition des marchandises"
end type

type p_8 from w_sheet_frame`p_8 within w_repartition_marchandise
integer x = 55
integer y = 20
integer width = 151
integer height = 128
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\modeles.GIF"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_repartition_marchandise
integer y = 16
integer height = 140
end type

type rr_1 from roundrectangle within w_repartition_marchandise
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 180
integer width = 4549
integer height = 2016
integer cornerheight = 40
integer cornerwidth = 46
end type

type uo_fin from u_cst_toolbarstrip within w_repartition_marchandise
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2228
integer width = 4549
integer taborder = 80
boolean bringtotop = true
end type

on uo_fin.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer"
		IF PARENT.event pfc_save() >= 0 THEN

		END IF
	
	CASE "Voir quantité non-attribuée"
		parent.of_voir_quantite_non_attribuee( )
		
	CASE "Transfert"
		IF parent.event pfc_save() >= 0 THEN
			parent.of_transfert()
			parent.of_rafraichirdws()
		end if		
			
	CASE "Corriger les quantitées réparties"
		IF PARENT.event pfc_save() >= 0 THEN
			parent.of_corriger_quantite()
		END IF
		
END CHOOSE

end event

type dw_repartition_entete from u_dw within w_repartition_marchandise
integer x = 119
integer y = 268
integer width = 4357
integer height = 112
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_repartition_entete"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_insertautomatique = false
end type

event itemchanged;call super::itemchanged;long		ll_rowdddw, ll_distr
string	ls_code

CHOOSE CASE dwo.name
		
	CASE "code"
		
		datawindowchild ldwc_code
		
		THIS.GetChild('code', ldwc_code)
		ldwc_code.setTransObject(SQLCA)
		ll_rowdddw = ldwc_code.Find("upper(t_recolte_gestionlot_produit_nolot) = '" + upper(data) + "'", 1, ldwc_code.RowCount())		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			ll_distr = ldwc_code.GetItemNumber(ll_rowdddw,"distribuable")
			THIS.object.qte_restant[1] = ll_distr
			THIS.object.qte[1] = ll_distr
			il_qtedistribuable = ll_distr
		END IF
		
	CASE "qte"
		IF IsNull(data) THEN
			ll_distr = 0
		ELSE
			ll_distr = long(data)
		END IF
		THIS.object.qte_restant[1] = ll_distr
		il_qtedistribuable = ll_distr		
		
	CASE "vent_tout_lot"
		THIS.object.vent_balance[row] = 0
		
	CASE "vent_balance"
		IF data = "1" THEN
			ls_code = THIS.object.code[1]
			IF IsNull(ls_code) THEN
				gnv_app.inv_error.of_message("CIPQ0085")
				RETURN 2
			END IF
			
			THIS.object.liv_ext[1] = 0
			THIS.object.vent_tout_lot[1] = 0
		END IF
		
END CHOOSE
end event

event buttonclicked;call super::buttonclicked;parent.of_ventiler()
end event

event dropdown;call super::dropdown;CHOOSE CASE THIS.GetColumnName()
		
	CASE "code"
		parent.of_charger_dddw_code()
		
//		IF THIS.rowcount() > 0 THEN
//			THIS.object.qte[1] = 0
//		END IF
		
END CHOOSE
end event

type st_desc from statictext within w_repartition_marchandise
integer x = 133
integer y = 1556
integer width = 869
integer height = 208
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
boolean border = true
long bordercolor = 8421504
boolean focusrectangle = false
end type

type dw_repartition_resume from u_dw within w_repartition_marchandise
integer x = 114
integer y = 1872
integer width = 914
integer height = 260
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_repartition_resume"
boolean ib_isupdateable = false
boolean ib_insertautomatique = false
end type

type dw_repartition_produit from u_dw within w_repartition_marchandise
integer x = 133
integer y = 608
integer width = 869
integer height = 916
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_repartition_produit"
boolean border = true
end type

event rowfocuschanged;call super::rowfocuschanged;long		ll_null
string	ls_null

SetNull(ls_null)
SetNull(ll_null)

If parent.event pfc_save() >= 0 THEN
	IF CurrentRow > 0 THEN
		dw_repartition_entete.object.qte_restant[1] = ll_null
		dw_repartition_entete.object.qte[1] = ll_null
		dw_repartition_entete.object.code[1] = ls_null
		
	END IF
	
	//Recharger la liste de code et linker les dw
	PARENT.of_linkdws()
END IF
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
end event

type em_date from u_em within w_repartition_marchandise
integer x = 297
integer y = 492
integer width = 439
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;call super::modified;SetPointer(HourGlass!)
pb_go.event clicked()
end event

type st_1 from statictext within w_repartition_marchandise
integer x = 133
integer y = 500
integer width = 165
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Date:"
boolean focusrectangle = false
end type

type pb_go from picturebutton within w_repartition_marchandise
integer x = 736
integer y = 492
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\rechercher.jpg"
alignment htextalign = left!
end type

event clicked;long	ll_null

SetNull(ll_null)

dw_repartition_entete.object.qte_restant[1] = ll_null
SetPointer(HourGlass!)

parent.of_rafraichirdws()
end event

type gb_1 from groupbox within w_repartition_marchandise
integer x = 87
integer y = 1812
integer width = 960
integer height = 340
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Résumé des répartitions"
end type

type rr_2 from roundrectangle within w_repartition_marchandise
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 12639424
integer x = 87
integer y = 452
integer width = 951
integer height = 1344
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_3 from roundrectangle within w_repartition_marchandise
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 23770623
integer x = 87
integer y = 240
integer width = 4421
integer height = 160
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_repartition_haut from u_dw within w_repartition_marchandise
integer x = 1143
integer y = 492
integer width = 3310
integer height = 900
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_repartition_haut"
boolean minbox = true
boolean hscrollbar = true
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;string	ls_cie
long		ll_rtn

ls_cie = gnv_app.of_getcompagniedefaut( )

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = THIS.GetChild('trans', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_cie)


this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_nocommande
long		ll_noitem

IF currentrow > 0 THEN
	
	ls_nocommande = dw_repartition_haut.object.nocommande[currentrow]
	ll_noitem = dw_repartition_haut.object.noitem[currentrow]
	
	dw_repartition_bas.Retrieve(ls_nocommande, ll_noitem)
	
END IF
end event

event itemchanged;call super::itemchanged;string	ls_transferepar, ls_trans, ls_left_centre
long		ll_qtecur, ll_cpt, ll_rowcount, ll_transfere, ll_QteInit, ll_temp, ll_QteTrans, &
			ll_totvalue, ll_QteExped, ll_null

SetNull(ll_null)

CHOOSE CASE dwo.name
		
	CASE "qteexpedie"
		ll_qtecur = THIS.object.qtecommande[row]
		If long(data) > ll_qtecur Then
			gnv_app.inv_error.of_message("CIPQ0080")
			RETURN 2
		ELSE
			THIS.AcceptText()
		END IF
		
		
	CASE "trans"
		IF IsNull(data) OR data = "" THEN THIS.object.qtetransfert[row] = 0
		
		//Modifier Trans des autres choix
		ll_rowcount = dw_repartition_bas.RowCount()
		FOR ll_cpt = 1 TO ll_rowcount
			dw_repartition_bas.object.trans[ll_cpt] = data
			IF IsNull(data) OR data = "" THEN dw_repartition_bas.object.qtetransfert[row] = 0
		END FOR
		
		dw_repartition_bas.AcceptText()
		parent.of_retrieve_resume()
		
		
	CASE "qtetransfert"
		ls_transferepar = THIS.object.transferepar[row]
		ll_qtecur = long(data)
	   
		/* On veut être capable de transférer un commande qui a été déjà transférer */
		/*
		IF not(IsNull(ls_transferepar) OR ls_transferepar = "") AND (not isnull(data)) AND data <> "" THEN
			gnv_app.inv_error.of_message("CIPQ0079" )
			THIS.ib_suppression_message_itemerror = TRUE
			return 1
		END IF
	   */	
		
		ls_trans = THIS.object.trans[row]
		IF IsNull(ls_trans) OR ls_trans = "" AND (not isnull(data)) AND data <> "" THEN
			//A déjà été transféré
			gnv_app.inv_error.of_message("CIPQ0081" )
			THIS.SetColumn("trans")
			SetNull(data)
			THIS.object.qtetransfert[row] = ll_null
			THIS.ib_suppression_message_itemerror = TRUE
			return 2
		ELSE
			THIS.AcceptText()
			
			//Si QtéInit existe seulement
			ll_QteInit = THIS.object.qteinit[row]
			ll_QteTrans = THIS.object.qtetransfert[row]
			ll_QteExped = THIS.object.qteexpedie[row]
			
			If Not IsNull(ll_QteInit) And ll_QteInit <> 0 Then
				
				IF IsNull(ll_QteTrans) THEN ll_QteTrans = 0
				IF IsNull(ll_QteExped) THEN ll_QteExped = 0
				
				//Valeur hypothétique de qteComm
				ll_temp = ll_QteInit - ll_QteTrans 
				//Valeur hypothétique des qtés traitées
				ll_totvalue = ll_QteTrans + ll_QteExped
				
				IF ll_totvalue > ll_QteInit THEN
					gnv_app.inv_error.of_message("CIPQ0087")
					RETURN 2
				ELSE
					THIS.object.qtecommande[row] = ll_temp
				END IF
				
			END IF
			
		END IF

		
		parent.of_retrieve_resume()
		
		THIS.GroupCalc()
END CHOOSE
end event

event pfc_retrieve;call super::pfc_retrieve;string	ls_cie
long		ll_rtn

ls_cie = gnv_app.of_getcompagniedefaut( )

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = THIS.GetChild('trans', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_cie)


RETURN AncestorReturnValue
end event

event buttonclicked;call super::buttonclicked;
//Ne plus faire suite à discussion avec kathleen

parent.of_retrieve_resume()
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
END IF
end event

type dw_repartition_bas from u_dw within w_repartition_marchandise
integer x = 1143
integer y = 1540
integer width = 3310
integer height = 584
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_repartition_bas"
boolean minbox = true
boolean hscrollbar = true
boolean ib_insertautomatique = false
end type

event constructor;call super::constructor;string	ls_cie
long		ll_rtn

ls_cie = gnv_app.of_getcompagniedefaut( )

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = THIS.GetChild('trans', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_cie)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_repartition_haut)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("nocommande","nocommande")
this.inv_linkage.of_Register("noligne","noligne")
end event

event itemchanged;call super::itemchanged;long		ll_qtecur, ll_qteinit, ll_qtetrans, ll_qteexped, ll_temp, ll_totvalue
string	ls_transferepar, ls_trans

CHOOSE CASE dwo.name
		
	CASE "qteexpedie"
		ll_qtecur = THIS.object.qtecommande[row]
		If long(data) > ll_qtecur Then
			gnv_app.inv_error.of_message("CIPQ0080")
			RETURN 2
		ELSE
			PARENT.of_retrieve_resume( )
		END IF
		
		
	CASE "trans"
		IF IsNull(data) OR data = "" THEN THIS.object.qtetransfert[row] = 0		
		PARENT.of_retrieve_resume( )
		
	CASE "qtecommande"
		PARENT.of_retrieve_resume( )
		
	CASE "qtetransfert"
		
		ls_transferepar = THIS.object.tranname[row]
		ll_qtecur = long(data)
		IF not(IsNull(ls_transferepar) OR ls_transferepar = "") THEN
			gnv_app.inv_error.of_message("CIPQ0079" )
			return 2
		ELSE
			ls_trans = THIS.object.trans[row]
			IF IsNull(ls_trans) OR ls_trans = "" THEN
				gnv_app.inv_error.of_message("CIPQ0081" )
				THIS.SetColumn("trans")
				return 2
			ELSE
				THIS.AcceptText()
				
				//Si QtéInit existe seulement
				ll_QteInit = THIS.object.qteinit[row]
				ll_QteTrans = THIS.object.qtetransfert[row]
				ll_QteExped = THIS.object.qteexpedie[row]
				
				If Not IsNull(ll_QteInit) And ll_QteInit <> 0 Then
					
					IF IsNull(ll_QteTrans) THEN ll_QteTrans = 0
					IF IsNull(ll_QteExped) THEN ll_QteExped = 0
					
					//Valeur hypothétique de qteComm
					ll_temp = ll_QteInit - ll_QteTrans 
					//Valeur hypothétique des qtés traitées
					ll_totvalue = ll_QteTrans + ll_QteExped
					
					IF ll_totvalue > ll_QteInit THEN
						gnv_app.inv_error.of_message("CIPQ0087")
						RETURN 2
					ELSE
						THIS.object.qtecommande[row] = ll_temp
					END IF
					
				END IF
				
			END IF
		END IF		
		
		PARENT.of_retrieve_resume( )
		
END CHOOSE
end event

event pfc_retrieve;call super::pfc_retrieve;string	ls_cie
long		ll_rtn

ls_cie = gnv_app.of_getcompagniedefaut( )

//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = THIS.GetChild('trans', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_cie)


RETURN ANCESTORReTURNVALUE 

end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
END IF
end event

type gb_2 from groupbox within w_repartition_marchandise
integer x = 1106
integer y = 1456
integer width = 3397
integer height = 696
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
string text = "Autres choix"
end type

type gb_3 from groupbox within w_repartition_marchandise
integer x = 1106
integer y = 424
integer width = 3397
integer height = 1012
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
string text = "Premiers choix"
end type

