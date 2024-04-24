$PBExportHeader$n_cst_messagefrancais.sru
$PBExportComments$Service de gestion des messages d'erreur / conversion en français
forward
global type n_cst_messagefrancais from n_base
end type
end forward

global type n_cst_messagefrancais from n_base
end type
global n_cst_messagefrancais n_cst_messagefrancais

type variables
n_cst_messagefrancaisattrib	inv_MessageFrancaisAttrib

end variables

forward prototypes
private subroutine of_recupererangeedetruite (ref u_dw adw_control)
public function n_cst_messagefrancaisattrib of_retournemessagefrancais (ref u_dw adw_control, long al_code_erreur, string as_texte_erreur)
end prototypes

private subroutine of_recupererangeedetruite (ref u_dw adw_control);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_RecupererRangeeDetruite
//
//	Accès:  			Private
//
//	Argument:		adw_control - référence - dw sur laquelle ramenet la rangée 
//
//	Retourne:  		rien
//
//	Description:	Ramener la rangée detruite dans le primary buffer
//						Note avant révision:
// 					Rowsmove locks current row to 0 if rowcount() = 0
// 					workaround it...
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
//
//////////////////////////////////////////////////////////////////////////////

inv_messagefrancaisattrib.il_nb_rangee_detruite = adw_control.DeletedCount()
 
IF inv_messagefrancaisattrib.il_nb_rangee_detruite > 0 THEN
	
	IF adw_control.RowCount() = 0 THEN
							
		adw_control.RowsMove( 1, 1, Delete!, adw_control,adw_control.il_rangee_detruite, Primary! )
		adw_control.Filter()	// suggestion de Problem ID 24489
	ELSE
		adw_control.RowsMove( 1, 1, Delete!, adw_control,adw_control.il_rangee_detruite, Primary! )
	END IF
						
	adw_control.SetRow(adw_control.il_rangee_detruite)
	adw_control.ScrollToRow(adw_control.il_rangee_detruite)
					
END IF
end subroutine

public function n_cst_messagefrancaisattrib of_retournemessagefrancais (ref u_dw adw_control, long al_code_erreur, string as_texte_erreur);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_RetourneMessageFrancais
//
//	Accès:  			Public
//
//	Arguments:		al_code_erreur 	- code d'erreur provenant de la bd
//						as_texte_erreur	- texte original de l'erreur
//						adw_control			- objet dw qui a généré l'erreur
//
//	Retourne:  		n_cst_messagefrancaisattrib - attributs du message
//
//	Description:	Prend les messages anglais retournés par la banque et
//						les traduits (le customize aussi)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
//
//////////////////////////////////////////////////////////////////////////////

Int		li_nb_colonne,	li_cpt1,	li_cpt2,	li_pos_deb, li_pos_fin
String	ls_nom_colonne, ls_libelle, ls_colonne_cle, ls_libelle_conc, ls_vide[]
			
// On vide le vecteur de paramètre avant de commencer
inv_MessageFrancaisAttrib.is_msgparm = ls_vide

CHOOSE CASE al_code_erreur

		CASE -208		// Maj de la rangée par une autre interface
						// (par un autre usager ou le même usager consulte plusieurs occurrences de la même fenêtre )

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0007"
				//inv_MessageFrancaisAttrib.is_msgparm[1] = as_texte_erreur
				inv_MessageFrancaisAttrib.is_msgparm[1] = ""
				
				// Ramener la rangée detruite dans le primary buffer				
				this.of_RecupereRangeeDetruite(adw_control)
		
		CASE -85, -73, -108, -99, -101, -74		//Usager déconnecté
			
				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0008"
				
		CASE -195		// colonne obligatoire ( not null ) 

				// Obtenir le nom de colonne dans le message d'erreur
				li_pos_deb = Pos( as_texte_erreur, "Column" )
				IF li_pos_deb > 0 THEN
					li_pos_fin	= Pos( as_texte_erreur, " ", li_pos_deb + 7 )
					ls_nom_colonne = Mid( as_texte_erreur, li_pos_deb + 8, &
											li_pos_fin - (li_pos_deb + 9) )
				ELSE 
					li_pos_deb = Pos( as_texte_erreur, "SET" )
					li_pos_fin	= Pos( as_texte_erreur, "~"", li_pos_deb + 5 )
					ls_nom_colonne = Mid( as_texte_erreur, li_pos_deb + 5, &
											li_pos_fin - (li_pos_deb + 5) )
				END IF

				// obtenir le libellé de la colonne
				ls_libelle = adw_control.Describe( Left( ls_nom_colonne, 38 ) + "_t.text" )
			
 				IF ls_libelle = "!" THEN  // SI = "!" le nom du libellé a été modifié dans la datawindow objet
					ls_libelle = ls_nom_colonne
				ELSE
					//Enlever les 2 points à la fin
					IF RIGHT(ls_libelle, 1) = ":" THEN 
						ls_libelle = MID(ls_libelle, 1, LEN(ls_libelle) - 1)
					END IF
				END IF

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0006"
				inv_MessageFrancaisAttrib.is_msgparm[1] = ls_libelle
				
				IF Long( adw_control.Describe( ls_nom_colonne + ".id" ) ) > 0 THEN
					adw_control.SetColumn(ls_nom_colonne)
				END IF

				
		CASE 247		// arithmetic overflow 

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0009"
				inv_MessageFrancaisAttrib.is_msgparm[1] = String( al_code_erreur)
				inv_MessageFrancaisAttrib.is_msgparm[2] = as_texte_erreur
				
		CASE 403		// opérande invalide pour un type de colonne, Ex: " null" et " is not null" pour une colonne "bit"

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0010"
				inv_MessageFrancaisAttrib.is_msgparm[1] = String( al_code_erreur)
				inv_MessageFrancaisAttrib.is_msgparm[2] = as_texte_erreur
				
		CASE 404 //Trop de OR et AND dans une requête
			
				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0011"
				inv_MessageFrancaisAttrib.is_msgparm[1] = "trop d'utilisation de AND et OR"

		CASE -251, -145, -198   // Contrainte sur une clé étrangère 

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0012"
				
				// Trouver la foreign key correspondante dans la table et afficher le message correspondant
				String ls_nom, ls_formulaire
				
				ls_nom = mid(as_texte_erreur, pos(as_texte_erreur, "constraint '") + 12,len(as_texte_erreur))
				ls_nom = mid(ls_nom, 1,pos(ls_nom,"'. The conflict occurred in")-1)
//				SetNull(ls_formulaire)
//				
//				SELECT formulaire_associe
//				INTO :ls_formulaire
//				FROM tforeign_key
//				WHERE nom_foreign_key = :ls_nom USING SQLCA;
//				
//				If Not IsNull(ls_formulaire) THEN
//					inv_MessageFrancaisAttrib.is_msgparm[1] = ls_formulaire
//				ELSE
//					inv_MessageFrancaisAttrib.is_msgparm[1] = "Formulaire non reconnu contacter atmtech (Clé: " + ls_nom + " )"
//				END IF 
				
				inv_MessageFrancaisAttrib.is_msgparm[1] = as_texte_erreur

				// Ramener la rangée detruite dans le primary buffer
				this.of_RecupereRangeeDetruite(adw_control)
				
		CASE -307  // Run out of locks
				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0013"

		CASE -306  // Verrou mortel (DeadLock) 

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0013"

		//CASE 2601	// Clé non-unique
		CASE -193, -196

				// Obtenir le nom des colonnes clés et leurs libellés
				//	Si plus d'une colonne clé, on concaténe les libellés pour le message d'erreur 

				li_nb_colonne = Integer( adw_control.Describe( "DataWindow.Column.Count" ))
				FOR li_cpt1 = 1 TO li_nb_colonne
					ls_colonne_cle = adw_control.Describe( "#" + string( li_cpt1 ) + ".Key" )
					IF ls_colonne_cle = "yes" THEN
						li_cpt2 ++
						ls_nom_colonne	= adw_control.Describe( "#" + string( li_cpt1 ) + ".Name" )
						ls_libelle			= adw_control.Describe( Left( ls_nom_colonne, 38 ) + "_t.text" )
						//Enlever les 2 points à la fin
						IF RIGHT(ls_libelle, 1) = ":" THEN 
							ls_libelle = MID(ls_libelle, 1, LEN(ls_libelle) - 1)
						END IF
			
 						IF ls_libelle = "!" THEN  // SI = "!" le nom du libellé a été modifié dans la datawindow objet
							IF li_cpt2 = 1 THEN
								ls_libelle_conc = "~"" + ls_nom_colonne + "~""
							ELSE
								ls_libelle_conc = ", ~"" + ls_nom_colonne + "~""
							END IF
						ELSE
							IF li_cpt2 = 1 THEN
								ls_libelle_conc = ls_libelle_conc + &
									"~"" + ls_libelle + "~""
							ELSE
								ls_libelle_conc = ls_libelle_conc + &
									", ~"" + ls_libelle + "~""
							END IF
						END IF
					END IF
				NEXT
				

				inv_MessageFrancaisAttrib.is_msgparm[1] = ls_libelle_conc

				IF li_cpt2 = 1 THEN
					inv_MessageFrancaisAttrib.is_msgid = "CIPQ0014"
				ELSE
					inv_MessageFrancaisAttrib.is_msgid = "CIPQ0015"
				END IF
	
				IF Long( adw_control.Describe( ls_nom_colonne + ".id" ) )  > 0 THEN
					adw_control.SetColumn(ls_nom_colonne)
				END IF

		CASE -78 //server stack overflow
			
				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0011"
				inv_MessageFrancaisAttrib.is_msgparm[1] = "trop d'espace de pile sur le serveur"

		CASE 7412  //Log plein, seuil de tolérance (thresholkd) atteint, le log se vide automatiqu
			
				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0016"
				
		CASE 10330
			
				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0017"
				inv_MessageFrancaisAttrib.is_msgparm[1] = as_texte_erreur
			
		CASE -268, -265  // triggers et contraintes 

					inv_MessageFrancaisAttrib.is_msgid = "CIPQ0018"

				li_pos_fin = Pos( as_texte_erreur, "No changes" )
				IF li_pos_fin <> 0 THEN
					inv_MessageFrancaisAttrib.is_msgparm[1] = "Message de base de données " + &
						string(al_code_erreur) + &
						":~r~n~r~n" + Left( as_texte_erreur, li_pos_fin - 3 )
				ELSE
					inv_MessageFrancaisAttrib.is_msgparm[1] = "Message de base de données " + &
						string(al_code_erreur) + &
						":~r~n~r~n" + as_texte_erreur
					
				END IF

				// Ramener la rangée detruite dans le primary buffer
				this.of_RecupereRangeeDetruite(adw_control)
	
		CASE 50000  // Limite d'extraction atteinte 

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0019"
				inv_MessageFrancaisAttrib.is_msgparm[1] = Mid( as_texte_erreur, 15 )
			
		CASE 50001 to 50999  // Messages d'attention

				inv_MessageFrancaisAttrib.is_msgid = "CIPQ0020"
				inv_MessageFrancaisAttrib.is_msgparm[1] = as_texte_erreur
				
				li_pos_fin = Pos(as_texte_erreur, "No changes" )
				IF li_pos_fin > 0	THEN
					inv_MessageFrancaisAttrib.is_msgparm[1] = Left( as_texte_erreur, li_pos_fin - 3 )
				END IF
				
				li_pos_deb = Pos( as_texte_erreur, "Select error:" )
				IF li_pos_deb > 0	THEN
					inv_MessageFrancaisAttrib.is_msgparm[1] = MID( as_texte_erreur, 15 )
				END IF
		
END CHOOSE

RETURN inv_MessageFrancaisAttrib
end function

on n_cst_messagefrancais.create
call super::create
end on

on n_cst_messagefrancais.destroy
call super::destroy
end on

