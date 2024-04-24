$PBExportHeader$pro_u_dw.sru
$PBExportComments$(PRO) Extension DataWindow class
forward
global type pro_u_dw from pfc_u_dw
end type
end forward

global type pro_u_dw from pfc_u_dw
boolean border = false
event type integer pro_majligneparligne ( )
event pro_postgetfocus ( )
event pro_postretourfocus ( )
event pro_postdeleterow ( )
event pro_postscrollvertical ( )
event pro_premiereligne ( )
event pro_derniereligne ( )
event pro_ligneprecedente ( )
event pro_lignesuivante ( )
event pro_derniere_modification ( )
event pro_enter pbm_dwnprocessenter
event pro_keypress pbm_dwnkey
event pro_postconstructor ( )
event pro_exporter ( )
end type
global pro_u_dw pro_u_dw

type variables
string	is_objet_rbutton, is_premiere_colonne_pour_insertion = "", is_colonne_modified[], is_sql_genere
boolean	ib_en_insertion = FALSE, ib_maj_ligne_par_ligne = TRUE, ib_getfocus_erreur = FALSE
boolean	ib_suppression_message_itemerror = false, ib_ignore_dberror = FALSE, ib_ChampRequisRangeeCourante = TRUE
boolean	ib_insertion_a_la_fin = FALSE, ib_itemchanged_encours = FALSE, ib_getfocus_en_cours = FALSE
boolean	ib_InsertAutomatique = TRUE, ib_ConfirmationDestruction = TRUE, ib_nouvelle_rangee = FALSE
boolean	ib_en_destruction = FALSE
long		il_rangee_detruite
string	is_texte_original, is_colonnes_tour[]

dwobject    					idwo_current
n_cst_dwsrv 					inv_dwsrv

string	is_nom_ancetre

boolean ib_dw_has_retrieval_args
n_dwspy_util inv_util

constant char TAB = "~t"
constant char NEW_LINE = "~n"

end variables
forward prototypes
public function window of_getfenetreparent ()
public function string of_gettitrefenetre ()
public function integer of_activer_tabpg (boolean ab_flag)
public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly)
public subroutine of_setmajligneparligne (boolean ab_switch)
public function integer of_valideinsertion ()
public subroutine of_setpremierecolonneinsertion (string as_colonne)
public function string of_obtenirexpressionclesprimaires (long al_rangee)
public subroutine of_settri (boolean ab_switch)
public function boolean of_objetexiste (string as_nomobjet)
public function string uf_getretrievalargs (string as_arg, ref string as_ret[])
public function string uf_setdwargs (string as_arg[], string as_sql)
end prototypes

event type integer pro_majligneparligne();// Script ajouté pour faire la mise à jour ligne par ligne

integer			li_retour_update
w_master			lw_parent
dwItemStatus 	ldwItemStatus

IF NOT this.ib_maj_ligne_par_ligne THEN
	RETURN no_action
END IF

// Si la rangée est nouvelle (New! - > rien n'a été saisi), ne pas continuer

ldwItemStatus = this.GetItemStatus(this.GetRow(),0,Primary!)
IF ldwItemStatus = New! OR ldwItemStatus = NotModified! THEN
	RETURN no_action
END IF

// Si on est en mode de recherche ne pas continuer
IF this.Object.DataWindow.QueryMode = "yes" THEN
	RETURN no_action
END IF

// mise à jour
IF this.of_AcceptText(TRUE) = 1 THEN
	IF this.ModifiedCount() > 0 OR this.DeletedCount() > 0 THEN
		lw_parent = THIS.of_GetFenetreParent()
		li_retour_update = lw_parent.event pfc_save()
		RETURN li_retour_update
	END IF
ELSE
	RETURN FAILURE
END IF

RETURN no_action
end event

event pro_postgetfocus();w_master lw_parent

lw_parent = this.of_GetFenetreParent()
lw_parent.idw_precedente.SetFocus()
end event

event pro_postretourfocus();string	ls_nom_colonne, ls_protect, ls_expr, ls_resultat, &
			ls_eval
integer	li_colonne_initiale, li_colonne_en_cours
long		ll_retour
integer	li_protect

ll_retour = -1

// Routine pour déplacer le curseur sur la prochaine colonne disponible
// si la colonne possède un attribut protect (risque de devenir protégée isrownew)
// spécialement pour le changement de dw

THIS.SetRedraw(FALSE)
li_colonne_initiale = THIS.GetColumn()
ls_nom_colonne = THIS.GetColumnName()
ls_protect = TRIM(THIS.Describe(ls_nom_colonne + ".Protect"))
IF isnull(ls_protect) = FALSE AND ls_protect <> "0" AND ls_protect <> "!" AND ls_protect <> "?" AND ls_protect <> "" THEN

	IF Pos( ls_expr, "~t" ) > 0 THEN
		// il exist une expression protect. PB a retourner
		//		"0<tab>expression"

		// étape 1) eleve les "
		ls_expr = Mid( ls_expr, 2, Len( ls_expr ) - 2 )

		// étape 2) extraire l'expression (après le tab)
		ls_expr = Mid( ls_expr, Pos( ls_expr, "~t" ) + 1 )

		// étape 3) créer une expression evaluate pour la rangée
		ls_eval = "evaluate('" + ls_expr + "'," + string( THIS.Getrow()) + ")"

		// étape 4) executer l'expression evaluate pour obtenir la valeur protect
		// pour la colonne sur la rangée clicked
		ls_resultat = THIS.Describe( ls_eval )
		li_protect = Integer( ls_resultat )

		IF li_protect = 1 THEN
			li_colonne_en_cours = li_colonne_initiale
			DO WHILE ll_retour = -1
				li_colonne_en_cours ++
				IF li_colonne_en_cours > long(THIS.Object.DataWindow.Column.Count) THEN
					li_colonne_en_cours = 1
				END IF
				ll_retour = THIS.Setcolumn(li_colonne_en_cours)
				//Si on a fait le tour des colonnes et qu'il n'y en a aucune de disponible
				//retour à la colonne initiale
				IF li_colonne_en_cours = li_colonne_initiale - 1 THEN EXIT
			LOOP
		END IF
	END IF

END IF
THIS.SetRedraw(TRUE)
end event

event pro_postdeleterow();ib_nouvelle_rangee = False
end event

event pro_postscrollvertical();Long ll_ligne

ll_ligne = Long( This.Describe( "datawindow.firstrowonpage" ) )

This.ScrollToRow(ll_ligne)
end event

event pro_premiereligne();IF THIS.of_AcceptText(TRUE) = 1 THEN
	this.SetRow(1)
	this.ScrolltoRow(this.GetRow())
END IF
end event

event pro_derniereligne();IF THIS.of_AcceptText(TRUE) = 1 THEN
	this.SetRow(this.Rowcount())
	this.ScrolltoRow(this.GetRow())
END IF


end event

event pro_ligneprecedente();long	ll_rangee

IF THIS.of_AcceptText(TRUE) = 1 THEN
	ll_rangee = This.GetRow() - 1

	this.SetRow(ll_rangee)
	THis.ScrollToRow( this.GetRow())
END IF

end event

event pro_lignesuivante();long	ll_rangee

IF THIS.of_AcceptText(TRUE) = 1 THEN
	ll_rangee = this.GetRow() + 1
	this.SetRow(ll_rangee)
	this.ScrolltoRow(this.GetRow())
END IF


end event

event pro_derniere_modification();string	ls_utilisateur, ls_updatetable, ls_key, ls_dataobject
datetime	ldt_modif

ls_updatetable = THIS.Object.DataWindow.Table.UpdateTable

IF Isnull(ls_updatetable) OR ls_updatetable = "?" THEN
	Messagebox("Dernière modification", "Cette section d'information n'est pas modifiable.")
	
ELSE
	ls_key = THIS.of_obtenirexpressionclesprimaires( THIS.GetRow() )
	ls_dataobject = THIS.dataobject
	
	SELECT first login_usager, date_maj INTO :ls_utilisateur, :ldt_modif FROM t_audit where primarykey = :ls_key AND dataobject = :ls_dataobject ORDER by date_maj DESC;
	
	If Not Isnull(ls_utilisateur) AND ls_utilisateur <> "" THEN
		Messagebox("Dernière modification", "La dernière modification a été effectuée par : " + ls_utilisateur + ", le " + &
			string(ldt_modif) + ".")
			 
	ELSE
		Messagebox("Dernière modification", "Il est impossible de retracer la dernière modification.")
	END IF
END IF
end event

event pro_enter;// Le code suivant permet de remplacer la fonction originale de la touche ENTER
// pour quelle devienne identique à la touche TAB

string	ls_nom_colonne


IF (is_nom_ancetre = "w_sheet" or is_nom_ancetre = "w_sheet_navig" &
		or is_nom_ancetre = "w_response" OR is_nom_ancetre = "w_reference_ancetre" OR &
		is_nom_ancetre = "w_formulaire_ancetre" OR is_nom_ancetre = "w_sheet_frame" ) THEN

	// N'envoie pas la touche TAB s'il y a eu une erreur sur la colonne
	ls_nom_colonne = this.getcolumnname()
	IF AcceptText() < 0 or this.Describe(ls_nom_colonne + ".Type") <> "column" or &
		(long(this.Describe(ls_nom_colonne + ".Height")) > 78 and &
		this.Describe(ls_nom_colonne + ".Type") = "column" and &
		left(this.Describe(ls_nom_colonne + ".ColType"),4) = "char" and &
		this.Describe(ls_nom_colonne + ".Edit.Style") = "edit") THEN

		ib_suppression_message_itemerror = TRUE
		RETURN 0

	ELSE

		SEND(HANDLE(THIS), 256, 9, Long(0,0))

	END IF

END IF

RETURN 1
end event

event pro_keypress;IF IsValid(gnv_app.of_getframe()) THEN
	w_sheet 	lw_parent

	IF KeyDown(KeyControl!) THEN
		boolean	lb_up = FALSE, lb_down = FALSE
		IF KeyDown(KeyPageUp!) THEN
			lb_up = TRUE
		ELSEIF KeyDown(KeyPageDown!) THEN
			lb_down = TRUE
		END IF

		IF lb_down = TRUE OR lb_up = TRUE THEN
			//Vérifie si il y a des onglets
			
			u_tabpg	ltabpg_Courant
			boolean 	lb_modetab = FALSE
			int		li_selectedtab, li_cpt, li_upper

			lw_parent = THIS.of_GetFenetreParent()
			lb_ModeTab = lw_parent.of_GetTabPg(ltabpg_Courant) = 1

			IF lb_ModeTab = TRUE THEN

				li_selectedtab = ltabpg_Courant.itab_Parent.SelectedTab
				IF lb_up = TRUE THEN
					li_selectedtab -= 1
				ELSE
					li_selectedtab += 1
				END IF

				li_upper = UpperBound(ltabpg_Courant.itab_Parent.control[])

				IF li_selectedtab = 0 THEN //Revenu au début
					li_selectedtab = li_upper

				ELSEIF li_selectedtab > li_upper THEN //Rendu à la fin
					li_selectedtab = 1
				END IF

				IF IsValid(ltabpg_Courant.itab_Parent.control[li_selectedtab]) THEN
					IF ltabpg_Courant.itab_Parent.control[li_selectedtab].visible = TRUE AND &
						ltabpg_Courant.itab_Parent.control[li_selectedtab].enabled = TRUE THEN
						SetPointer(Hourglass!)
						ltabpg_Courant.itab_Parent.SelectTab(li_selectedtab)
					END IF
				END IF

			END IF
		END IF

	END IF


	
END IF
end event

event pro_postconstructor();integer li_cnt
string ls_menuitem

window lw_Parent
n_cst_string lnv_strsrv

lw_Parent = this.of_getfenetreparent()

// Appliquer la sécurité pour la mise à jour
if pos(lw_parent.tag, 'exclure_securite') = 0 then
	ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(lw_parent.tag), "menu", ";"))
	if isNull(ls_menuitem) then ls_menuitem = ""
	
	select count(1)
	  into :li_cnt
	  from t_droitsusagers
	 where (id_user = :gnv_app.il_id_user
			 or id_user in (select id_group
									from t_groupeusager
								  where id_user = :gnv_app.il_id_user))
		and objet = :ls_menuitem
		and isnull(locate(upper(droits), 'M'), 0) > 0;
	
	if li_cnt = 0 then
		this.object.datawindow.readonly = "Yes"
	end if
end if

end event

event pro_exporter();w_exportation	w_to_open

OpenWithParm(w_to_open, THIS)
end event

public function window of_getfenetreparent ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetFenetreParent
//
// Accès:			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Window parent
//
//	Description:  	Retourne la fenêtre parent du datawindow
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

Window		lw_parent
userobject 	luo_parent
u_tabpg		ltabpg_parent
graphicobject	lgo_object

CHOOSE CASE parent.Typeof()
	CASE Userobject! //la datawindow est sur un tabpage
		luo_parent = parent
		IF luo_parent.Getparent().Typeof() = Tab! THEN
			ltabpg_parent = luo_parent
			ltabpg_parent.of_GetParentWindow(lw_parent)
		ELSE
			lgo_object = this
			DO
				lgo_object = GetParent(lgo_object)
			LOOP WHILE TypeOf(lgo_object) <> Window!

			lw_Parent = lgo_object
		END IF
	CASE Window!
		lw_parent = parent
	CASE ELSE
		SetNull(lw_parent)
END CHOOSE

RETURN lw_parent
end function

public function string of_gettitrefenetre ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetTitreFenetre
//
// Accès:			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Titre de la fenêtre
//
//	Description:  	Retourne le titre de la fenêtre parent du datawindow
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

Window		lw_parent
string 		ls_titre_fenetre

lw_parent = of_GetFenetreParent()

IF Not IsNull(lw_parent) THEN
	ls_titre_fenetre = lw_parent.title
ELSE
	ls_titre_fenetre = ""
END IF

RETURN ls_titre_fenetre
end function

public function integer of_activer_tabpg (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_activer_tabpg
//
//	Accès:  			Public
//
//	Argument:		ab_flag - Indicateur d'actiation
//
//	Retourne:  		0 - Ne fait rien
//
//	Description:	Selon l'argument, active/désactive les onglets du contrôle
//						U_TAB courant. Valide que pour la DW maître de l'onglet
//						principal.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

w_master lw_parent
u_tab		ltab_courant
u_tabpg	ltabpg_courant
u_dw		ldw_master, ldw_LastDwActive
integer	li_cpt, li_nb_control
string	ls_classname
long		ll_upper, ll_cpt
boolean	lb_trouve = FALSE

// Vérification de l'argument
If IsNull( ab_flag ) Then
	Return -1
End If

lw_parent = This.of_GetFenetreParent()

If lw_parent.of_GetTabpg(ltabpg_Courant) = 1 then
	ldw_LastDwActive = lw_parent.of_getLastDWActive()

	If IsValid( ldw_LastDwActive ) Then
		If IsValid( ldw_LastDwActive.inv_linkage ) Then
			ldw_LastDwActive.inv_linkage.of_FindRoot(ldw_master)

			If This = ldw_master Then
				ltab_courant = ltabpg_Courant.GetParent()
				li_nb_control = UpperBound(ltab_courant.control[])

				// Activer/Désactiver les autres onglets de la fenêtre
				FOR li_cpt = 2 TO li_nb_control

					IF ab_flag = TRUE THEN
						ls_classname = ltab_courant.control[li_cpt].classname()
						ll_upper = UpperBound(lw_parent.is_tabpagedesactive)
						FOR ll_cpt = 1 TO ll_upper
							IF lw_parent.is_tabpagedesactive[ll_cpt] = ls_classname THEN
								lb_trouve = TRUE
								EXIT
							END IF
						END FOR
					END IF

					IF lb_trouve = FALSE THEN
						ltab_courant.control[li_cpt].enabled = ab_flag
					END IF

					lb_trouve = FALSE

				NEXT
			Else
				// On ne fait rien, on n'est pas sur la DW racine
				//
				Return 0
			End If
		Else
			// On fait rien, les DW ne sont pas liées
			//
			Return 0
		End If
	Else
		// Pas de DW active
		//
		Return 0
	End If
Else
	// On fait rien, on n'est pas sur des onglets
	//
	Return 0
End If

Return 1
end function

public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode: 		of_CheckRequired
//
// Accès:			Public
//
//	Arguments:		adw_buffer	- The buffer to check for required fields
// 					al_row   	- First row to be checked.  Also stores the number
//										  of the found row
//						ai_col   	- First column to be checked.  Also stores the
//										  number of the found column
//						as_colname  - Contains the columnname in error
//
//	Retourne:  		1  = The required fields test was successful, check arguments
//							  for required fields missing
//	 					0  = The required fields test was successful and no errors were found
//  					-1 = Error
//
//	Description:	Fonction "overwrited" pour vérifier que la rangée courante
//						et donner le libellé de la colonne dans le message d'erreur
//						sans donner le numéro de la rangée
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

w_master	lw_pfcparent
window	lw_parent
boolean	lb_skipmessage = False
integer	li_rc

IF ib_ChampRequisRangeeCourante THEN

	string	ls_msgparm[1]

	// Check arguments
	if IsNull (adw_buffer) or IsNull (al_row) or IsNull (ai_col) or IsNull (as_colname) then
		return FAILURE
	end if

	SetPointer(HourGlass!)

	// Vérifier la rangée modifiée seulement
	al_row = THIS.GetNextModified(0,primary!)

	// Call FindRequired to locate first error, if any
	if this.FindRequired (adw_buffer, al_row, ai_col, as_colname, ab_updateonly) < 0 then
		return FAILURE
	end if

	// Double Check if failure condition was ecountered.
	if al_row < 0 then Return FAILURE

	// Check if no missing values were found.
	if al_row = 0 then Return 0

	// -- A Missing Value was encountered. --

	// Get a reference to the window
	this.of_GetParentWindow (lw_parent)
	if IsValid (lw_parent) then
		if lw_parent.TriggerEvent ("pfc_descendant") = 1 then
			lw_pfcparent = lw_parent
		end if
	end if

	// Make sure the window is not closing.
	if IsValid (lw_pfcparent) then
		if lw_pfcparent.of_GetCloseStatus() then
			// It is closing, so don't show errors now.
			lb_skipmessage = True
		end if
	end if

	// Skip the message if the window is closing.
	If Not lb_skipmessage Then
		// Call stub function to either handle condition or provide a more suitable
		// column name.
		li_rc = this.Event pfc_checkrequirederror (al_row, as_colname)
		If li_rc < 0 Then Return -1

		If li_rc >= 1 Then
			// Display condition.
			ls_msgparm[1] = THIS.Describe( Left( as_colname, 38 ) + "_t.text" )
			//Enlever les 2 points à la fin
			IF RIGHT(ls_msgparm[1], 1) = ":" THEN
				ls_msgparm[1] = MID(ls_msgparm[1], 1, LEN(ls_msgparm[1]) - 1)
			END IF

			IF ls_msgparm[1] = "!" THEN  // SI = "!" le nom du libellé a été modifié dans la datawindow objet
				ls_msgparm[1] = as_colname
			END IF

			gnv_app.inv_error.of_Message("CIPQ0006", ls_msgparm)

			// Make sure row/column gets focus.
			this.SetRow (al_row)
			this.ScrollToRow (al_row)
			this.SetColumn (ai_col)
			this.SetFocus ()

		End If
	End If

	// Return that a required column does contain a null value.
	Return 1

ELSE
	//appeler la fonction de l'ancêtre
	RETURN SUPER::of_checkrequired(adw_buffer,al_row,ai_col,as_colname,ab_updateonly)


END IF
end function

public subroutine of_setmajligneparligne (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_SetMajLigneParLigne
//
// Accès:			Public
//
//	Argument: 		ab_switch
//   					TRUE  - Permettre mise à jour ligne par ligne
//   					FALSE - Ne pas permettre la mise à jour ligne par ligne
//
//	Retourne:  		rien
//
//	Description:  	Permettre ou non la mise à jour ligne par ligne
//						(par défaut = TRUE)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

If NOT IsNull(ab_switch) Then
	ib_maj_ligne_par_ligne = ab_switch
End If
end subroutine

public function integer of_valideinsertion ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ValideInsertion
//
//	Accès:			Public
//
//	Argument: 		Aucun
//
//	Retourne:  		1
//
//	Description:  	Effectif si le service d'insertion auto est utilisé
// 					Effectif pour un datawindow vide seulement
// 					Effectif pour un enfant dont le parent contient de l'information
//						Effectif si la préférence de l'utilisateur le permet
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

boolean		lb_ParentVide
u_dw			ldw_Master
long			ll_NbrRow, ll_Row
string		ls_pref

//Vérifie si la datawindow est vide
if THIS.RowCount() = 0 then

	w_master		lw_parent

	// vérifie si insertion est permise
	lw_parent = this.of_GetFenetreParent()

	IF Upper(this.Object.Datawindow.ReadOnly) = "NO" THEN

		//Vérifie si le parent contient au moins une ligne et que le status
		//soit différent de NEW!
		if IsValid(inv_linkage) then
			if inv_linkage.of_GetMaster(ldw_Master) = 1 then
				ll_NbrRow = ldw_Master.RowCount()
				if ll_NbrRow = 0 then
					lb_ParentVide = true
				else
					for ll_Row = 1 to ll_NbrRow
						if ldw_Master.GetItemStatus(ll_Row,0,Primary!) = NEW! then
							lb_ParentVide = true
							exit
						end if
					next
				end if
			else
				// on est sur le master, on ne veut pas insérer
				lb_ParentVide = true
			end if
		else
			// on n'a pas de linkage, on ne veut pas insérer
			lb_ParentVide = true
		end if

		if not lb_ParentVide then
			//Insertion d'une ligne
			this.Event Post pfc_insertRow()
			THIS.SetFocus()
		end if
	end if
end if

return 1
end function

public subroutine of_setpremierecolonneinsertion (string as_colonne);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_SetPremiereColonneInsertion
//
// Accès:			Public
//
//	Argument: 		as_colonne - Colonne
//
//	Retourne:  		rien
//
//	Description:  	Pour signaler la colonne sur laquelle le focus doit être
//						après insertion
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

is_premiere_colonne_pour_insertion = as_colonne
end subroutine

public function string of_obtenirexpressionclesprimaires (long al_rangee);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ObtenirExpressionClesPrimaires
//
//	Accès:			Public
//
//	Argument: 		al_rangee  - Rangée pour laquelle on veut obtenir les clés primaires
//
//	Retourne:  		expression pour trouver la rangée avec les clés primaires
//
//	Description:  	Retourne l'expression qui permet de trouver la rangée avec ses clés
// 					primaires
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string 	ls_expr_find, ls_colonne_nom, ls_valeur, ls_type_colonne, ls_expr_col
long 		ll_nb_colonnes, ll_compteur_colonnes
dwItemStatus	ldw_ItemStatus

IF al_rangee = 0 OR this.rowcount() < 1 THEN
	RETURN ls_expr_find
END IF

ldw_ItemStatus =this.GetItemStatus(al_rangee,0,Primary!)
//IF ldw_ItemStatus = New! OR ldw_ItemStatus = NewModified! OR IsNull(ldw_ItemStatus) THEN
//	RETURN ls_expr_find
//END IF

// obtenir les clés primaires et leurs valeurs pour la rangée passée en paramètre

ll_nb_colonnes = Long(this.Describe("DataWindow.Column.Count"))

FOR ll_compteur_colonnes = 1 TO ll_nb_colonnes
	ls_colonne_nom = this.Describe("#" + String(ll_compteur_colonnes) + ".Name")
	IF Lower( this.Describe( ls_colonne_nom + ".key") ) = "yes" THEN
		// obtenir la valeur de la colonne

		ls_type_colonne = THIS.Describe(ls_colonne_nom + ".coltype" )

		CHOOSE CASE lower( Left( ls_type_colonne, 5 ) )
			CASE "char(","varch"
				ls_valeur = THIS.GetItemString( al_rangee, ls_colonne_nom )
				ls_valeur = gnv_app.inv_string.of_GlobalReplace(ls_valeur,"~"","~~~"")
				ls_valeur = gnv_app.inv_string.of_GlobalReplace(ls_valeur,"'","''")
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"
			CASE "date"
				// transformer la date à un format string normalisé...
				ls_valeur = String( THIS.GetItemDate( al_rangee, ls_colonne_nom ),"yyyy-mm-dd" )
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"
			CASE "datet"
				// transformer le datetime à un format string normalisé...
				ls_valeur = String( THIS.GetItemDateTime( al_rangee, ls_colonne_nom ), &
						"yyyy-mm-dd hh:mm:ss.ffffff" )
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"
				IF ls_valeur = "" THEN SetNull(ls_valeur)
			CASE "decim", "long", "ulong"
				ls_valeur = String( THIS.GetItemDecimal( al_rangee, ls_colonne_nom) )
				ls_expr_col = ls_colonne_nom + " = " + ls_valeur
			CASE "numbe", "real"
				ls_valeur = String( THIS.GetItemNumber( al_rangee, ls_colonne_nom) )
				ls_expr_col = ls_colonne_nom + " = " + ls_valeur
			CASE "time"
				// transformer le time à un format string normalisé...
				ls_valeur = String( THIS.GetItemTime( al_rangee, ls_colonne_nom ), &
						"hh:mm:ss.ffffff" )
				ls_expr_col = ls_colonne_nom + " = ~'" + ls_valeur + "~'"

			CASE ELSE
				ls_expr_col = ""
		END CHOOSE

		IF Isnull(ls_valeur) THEN
			ls_expr_col = "IsNull(" + ls_colonne_nom + ")"
		END IF

		IF ls_expr_find = "" THEN
			ls_expr_find = ls_expr_col
		ELSE
			ls_expr_find = ls_expr_find + " and " + ls_expr_col
		END IF

	END IF
NEXT


RETURN ls_expr_find
end function

public subroutine of_settri (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_SetTri
//
// Accès:			Public
//
//	Argument: 		TRUE  - Active le service
// 			  		FALSE
//
//	Retourne:  		Rien
//
//	Description:  	Active le service de tri personnalisé pour l'usager
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

int		li_i, li_numcomputes, li_numcols, li_nbexclure = 0
string	ls_computes[], ls_exclure[], ls_tag, ls_tag2

THIS.of_SetSort(ab_switch)

IF ab_switch = TRUE THEN
	IF POS(THIS.tag, "exclure_mr") = 0 THEN
		THIS.inv_sort.of_SetStyle(THIS.inv_sort.DRAGDROP)
		THIS.inv_sort.of_SetColumnNameSource(2)
		THIS.inv_sort.of_SetUseDisplay(TRUE)
		THIS.inv_sort.of_SetVisibleOnly(TRUE)
	
		// Faire le tour des colonnes
		li_numcols = UpperBound(is_colonnes_tour)
		FOR li_i = 1 to li_numcols
			//Exclure toutes les colonnes qui sont exclure_mr
			ls_tag = lower(THIS.Describe(is_colonnes_tour[li_i] + "_t.Tag"))
			IF POS(ls_tag, "exclure_tri") <> 0 THEN
				li_nbexclure ++
				ls_exclure[li_nbexclure] = is_colonnes_tour[li_i]
			ELSE
				IF POS(ls_tag, "exclure_mr") <> 0 OR ls_tag = "!" THEN
					IF POS(ls_tag, "ajout_tri") = 0 AND POS(ls_tag, "ajout_tri") = 0 THEN
						li_nbexclure ++
						ls_exclure[li_nbexclure] = is_colonnes_tour[li_i]
					END IF
				END IF
			END IF

		END FOR
	
		THIS.inv_sort.of_SetExclude(ls_exclure)
		
	ELSE
		//Dw en exclusion - exclure_mr, fermer le service
		THIS.of_settri(FALSE)
	END IF

END IF
end subroutine

public function boolean of_objetexiste (string as_nomobjet);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_ObjetExiste
//
//	Accès:  			Public
//
//	Argument:		as_nomobjet - Nom de l'objet à chercher
//
//	Retourne:  		rien
//
//	Description:	Fonction pour déterminer si un objet existe dans la
//						datawindow en cours
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string	ls_objects

ls_objects = THIS.describe(" datawindow.objects ")

IF pos(ls_objects, as_nomobjet) > 0 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public function string uf_getretrievalargs (string as_arg, ref string as_ret[]);String	ls_args_arr[], ls_arg_name, ls_arg_datatype, ls_arg_val, ls_retrieval_args_frag
Integer	li_args_qty, li_tab_pos
Long		i
String	ls_set, ls_frag_header
String	ls_declare, ls_retrieval_args

ls_retrieval_args = This.Describe("DataWindow.Table.Arguments")
li_args_qty = inv_util.uf_string_to_array(ls_retrieval_args, NEW_LINE, ref ls_args_arr[])

// Process each retrieval arg:
for i = 1 to li_args_qty
	li_tab_pos = Pos(ls_args_arr[i], TAB)
	ls_arg_name = Left(ls_args_arr[i], li_tab_pos - 1)
	as_ret[UpperBound(as_ret) + 1] = ":" + ls_arg_name
	ls_arg_datatype = Right(ls_args_arr[i], Len(ls_args_arr[i]) - li_tab_pos)
	
	ls_arg_val = This.Describe("Evaluate('" + ls_arg_name + "',  1) " )
	
	if IsNull(ls_arg_val) then
		ls_arg_val = "<NULL>"
	else
		choose case Left(ls_arg_datatype, 4)
		case "char", "stri", "date"
			ls_arg_val = "'" + ls_arg_val + "'"
		end choose
	end if
	
	Choose Case Lower(Left(ls_arg_datatype, 4))
		Case "numb"				; ls_arg_datatype = "Integer"
		Case "stri", "char"	; ls_arg_datatype = "VarChar(500)"
		Case	Else				; ls_arg_datatype = ls_arg_datatype
	End Choose
		
	ls_declare += "~r~nDECLARE @" + ls_arg_name + " " + ls_arg_datatype + ";" 
	ls_arg_val = " = " + ls_arg_val
	ls_set += "~r~n" + "SET @" + ls_arg_name + " " + ls_arg_val + ";" 
next

return ls_declare + ls_set + ls_retrieval_args_frag + "~r~n"
end function

public function string uf_setdwargs (string as_arg[], string as_sql);String	ls_newarg
Long		i
n_cst_string lncst_str

For i = 1 to UpperBound(as_arg)
	ls_newarg = Rep(as_arg[i], ":", "@")
	as_sql = lncst_str.of_globalreplace(as_sql, as_arg[i], ls_newarg, True)
Next

Return as_sql
end function

event rbuttondown;call super::rbuttondown;long 		ll_pos, ll_cpt, ll_cptobject, ll_posobjet
string	ls_library, ls_librarylist[], ls_objectslist[], &
			ls_dataobject, ls_objects, ls_vide[], ls_nom, ls_libarietrouvee
boolean 	lb_trouve = FALSE, lb_ctrl, lb_alt
n_parm   lnv_parm
String	ls_sql, ls_retrieval_args, ls_ret[]
str_inputbox	lstr
String	ls_Begin = "BEGIN~r~n~r~n"
n_cst_string	lnv_string

lb_ctrl = KeyDown(KeyControl!)
lb_alt = KeyDown(KeyAlt!)

is_objet_rbutton = THIS.GetObjectAtPointer()
ll_pos = POS(is_objet_rbutton, "~t")
is_objet_rbutton = MID(is_objet_rbutton, 1, ll_pos - 1)

// Faire afficher un messagebox du nom de l'objet et du pbl
// sur Right-click et CTRL
IF lb_ctrl = TRUE THEN

	ls_dataobject = THIS.Dataobject
	ls_library = GetLibraryList()
	lnv_string.of_ParseToArray ( ls_library, ",", ls_librarylist)

	//Faire le tour de tous les PBL
	FOR ll_cpt = 1 TO UpperBound(ls_librarylist)

		//name ~t date/time modified ~t comments ~n
		ls_objects = LibraryDirectory (ls_librarylist[ll_cpt], DirDatawindow!)
		lnv_string.of_ParseToArray ( ls_objects, "~n", ls_objectslist)

		//Faire le tour de tous les objets de la librarie
		FOR ll_cptobject = 1 TO UpperBound(ls_objectslist)
			ll_posobjet = POS(ls_objectslist[ll_cptobject], "~t")
			IF ll_posobjet > 0 THEN
				ls_nom = LEFT(ls_objectslist[ll_cptobject], ll_posobjet - 1)
				IF ls_nom = ls_dataobject THEN
					//Objet trouvé, sortir
					lb_trouve = TRUE
					ls_libarietrouvee = ls_librarylist[ll_cpt]
					EXIT
				END IF
			END IF
		END FOR
		ls_objectslist[] = ls_vide[]

		IF lb_trouve = TRUE THEN EXIT

	END FOR

	IF lb_trouve = TRUE and lb_alt = False THEN
		::ClipBoard(ls_dataobject)
		Messagebox(ls_libarietrouvee, ls_dataobject)
	END IF

END IF

If lb_ctrl and lb_alt Then
	ls_retrieval_args = This.Describe("DataWindow.Table.Arguments")
	ib_dw_has_retrieval_args = (ls_retrieval_args <> "?")
	ls_sql =  This.GetSQLSelect()
	If ib_dw_has_retrieval_args Then
		ls_retrieval_args = uf_getretrievalargs(ls_retrieval_args, ls_ret)
		ls_sql = uf_setdwargs(ls_ret, ls_sql)
	Else
		ls_retrieval_args = ""
	End If
	ls_libarietrouvee = Mid(ls_libarietrouvee, LastPos(ls_libarietrouvee, "\") + 1, Len(ls_libarietrouvee))
	lstr.as_title = ls_libarietrouvee + " - " +ls_dataobject
	lstr.as_question = ls_Begin + ls_retrieval_args + "~r~n" + ls_sql + "~r~n~r~n" + "END" + "~r~n"
	OpenWithParm(w_dwsyntax, lstr)
End If


end event

on pro_u_dw.create
call super::create
end on

on pro_u_dw.destroy
call super::destroy
end on

event constructor;call super::constructor;integer li_numcols, li_i

window				lw_parent
w_master				lw_fenetreParent
w_sheet				lw_sheet
classdefinition	lcd_classe_definition

// Appeler l'évènement post
event post pro_postconstructor()

lw_parent = this.of_GetFenetreParent()
lw_fenetreParent = lw_parent

IF IsValid(lw_parent) THEN
	lcd_classe_definition = lw_parent.classdefinition
	is_nom_ancetre = lcd_classe_definition.Ancestor.Name
END IF

IF is_nom_ancetre = "w_sheet" or is_nom_ancetre = "w_sheet_navig" or is_nom_ancetre = "w_sheet_frame" &
	OR is_nom_ancetre = "w_reference_ancetre" OR is_nom_ancetre = "w_formulaire_ancetre" THEN

	lw_sheet = lw_parent
	lw_sheet.idw_precedente = this

END IF


try
	SetTransObject(SQLCA)
	THIS.of_SetTransObject(SQLCA)
catch ( throwable error )
	
end try

inv_dwsrv = CREATE n_cst_dwsrv
inv_dwsrv.of_SetRequestor(THIS)

IF IsValid(THIS.Object.DataWindow) THEN
	// Faire le tour des colonnes pour les charger
	li_numcols = integer(THIS.Object.DataWindow.Column.Count)
	
	FOR li_i = 1 to li_numcols
		is_colonnes_tour[li_i] = THIS.Describe("#" + string(li_i) + ".Name")
	END FOR
END IF
end event

event pfc_insertrow;//Override de l'ancêtre pour permettre insertion à la fin de la datawindow

long ll_rangee
integer li_cnt
string ls_menuitem

window lw_fenetreparent
n_cst_string lnv_strsrv

lw_fenetreparent = this.of_GetFenetreParent()

// Confirmer le paramètre de sécurité pour l'insertion de la fenêtre
if pos(lw_fenetreparent.tag, 'exclure_securite') = 0 then
	ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(lw_fenetreparent.tag), "menu", ";"))
	if isNull(ls_menuitem) then ls_menuitem = ""
	
	select count(1)
	  into :li_cnt
	  from t_droitsusagers
	 where (id_user = :gnv_app.il_id_user
			 or id_user in (select id_group
									from t_groupeusager
								  where id_user = :gnv_app.il_id_user))
		and objet = :ls_menuitem
		and isnull(locate(upper(droits), 'I'), 0) > 0;
	
	if li_cnt = 0 then
		gnv_app.inv_error.of_message("PRO0012")
		return FAILURE
	end if
end if

//insertion à la fin
if ib_insertion_a_la_fin THEN
	ll_rangee = this.Event pfc_addrow()
ELSE
	CALL SUPER::pfc_insertrow
	ll_rangee = AncestorReturnValue
END IF

// Pour mettre le focus sur la nouvelle rangée insérée
If ll_rangee > 0 THEN

	ib_en_insertion = TRUE

	IF ll_rangee <> this.GetRow() Then
		this.SetRow (ll_rangee)
		this.ScrollToRow (ll_rangee)
	END IF

	IF is_premiere_colonne_pour_insertion <> "" THEN
		THIS.SetColumn( is_premiere_colonne_pour_insertion )
	ELSE
		THIS.SetColumn( 1 )
	END IF

	//********************************************************
   // pour les datawindows qui sont sur des onglets seulement
   //********************************************************

	THIS.of_activer_tabpg( TRUE )

	// Forcer le statut NewModified! pour régler le problème quand on insert et qu'on ne pousse aucune
	//	donnée au départ, on ne veut pas que l'utilisateur puisse changer de rangée sans sauvegarde
	THIS.SetItemStatus(ll_rangee, 0,  Primary!, NewModified!)
	
	w_master lw_parent
	of_GetParentWindow(lw_parent)
	lw_parent.idw_precedente = THIS
	
End If

Return ll_Rangee
end event

event pfc_update;call super::pfc_update;integer 			li_colonne_initiale, li_colonne_en_cours
long 				ll_retour = -1, ll_pos_n, ll_rangee
string			ls_nom_colonne, ls_left, ls_cle, ls_table, ls_update, ls_login, ls_sql, ls_genere
Datetime			ldt_date_du_jour
w_master 		lw_parent
n_tr				ltr_object

lw_parent = THIS.of_GetFenetreParent()

If AncestorReturnValue = 1 OR ib_ignore_dberror = TRUE THEN
	ib_ignore_dberror = FALSE
	
	ll_rangee = THIS.GetRow()
	
	SQLCA.of_Commit()
	this.il_rangee_detruite = 0
	this.Event pfc_ResetUpdate()
	
	li_colonne_initiale = this.GetColumn()
	ls_nom_colonne = this.GetColumnName()
	IF THIS = lw_parent.of_GetLastDWActive() AND ib_en_insertion = TRUE THEN
		// Routine pour déplacer le curseur sur la prochaine colonne disponible
		// si la colonne possède un attribut protect (risque de devenir protégée isrownew)
		IF isnull(THIS.Describe(ls_nom_colonne + ".Protect")) = FALSE AND &
			trim(THIS.Describe(ls_nom_colonne + ".Protect")) <> "0" THEN
			ll_pos_n = POS(lower(THIS.Describe(ls_nom_colonne + ".Protect")),"isrownew")
			IF ll_pos_n <> 0 THEN
				li_colonne_en_cours = li_colonne_initiale
				THIS.SetRedraw(FALSE)
				DO WHILE ll_retour = -1
					li_colonne_en_cours ++
					IF li_colonne_en_cours > long(THIS.Object.DataWindow.Column.Count) THEN
						li_colonne_en_cours = 1
					END IF
					ll_retour = THIS.Setcolumn(li_colonne_en_cours)
					IF li_colonne_en_cours = li_colonne_initiale - 1 THEN EXIT
				LOOP
				THIS.SetRedraw(TRUE)
			END IF
		END IF
	END IF
	
	If ib_en_insertion Then ib_en_insertion = FALSE
	
	RETURN 1
ELSE
	SQLCA.of_Rollback()
	RETURN -1
END IF
end event

event pfc_undo;
IF ib_en_insertion THEN
	THIS.event pfc_deleterow()
ELSE
	
	CALL SUPER::pfc_undo	
END IF

RETURN AncestorReturnValue

////override
////on veut annuler les modifications de la rangée courante
//long 		ll_rangee, ll_rowcount
//w_master lw_parent
//int 		li_retour
//dwItemStatus ldwi_status
//
//lw_parent = THIS.of_GetFenetreParent()
//ll_rangee = this.GetRow()
//
//lw_parent.SetRedraw(false)
//
//ll_rowcount = This.RowCount()
//ldwi_status = This.GetItemStatus(ll_rangee, 0, Primary!)
//
//IF ll_rangee > 0 THEN
//	If ll_rowcount = 1 and (ldwi_status = New! or ldwi_status = NewModified!) Then
//		// Il y a qu'une seule ligne et c'est une nouvelle ligne alors on
//		// fait un Reset()
//		This.Reset()
//
//		// Si l'interface à des onglets, il faut les désactiver
//		//
//		THIS.of_activer_tabpg( False )
//
//		li_retour = 1
//	Else
//		THIS.Event pfc_retrieve()
//		//To be continued
//		li_retour = 1
//	End If
//ELSE
//	li_retour = -1
//END IF
//
//lw_parent.SetRedraw(true)
//
//RETURN li_retour
end event

event itemerror;call super::itemerror;Int			li_colonne, li_pos_paren, li_taille_colonne
Long			ll_null
String		ls_style, ls_ind_requis, ls_coltype, ls_null, ls_message, &
				ls_col_ref, ls_nom_colonne, ls_descr_expr, ls_libelle, ls_format_date,&
				ls_annee_date
Time			ltm_null
Date			ld_null
Datetime		ldt_null
Boolean		lb_date_nulle
n_cst_MessageFrancaisAttrib  lnv_Message

// permet de ne pas afficher le message par défaut

IF ib_suppression_message_itemerror THEN
	ib_suppression_message_itemerror = FALSE
	// ne pas afficher un message...
	RETURN 1
END IF

li_colonne 		= THIS.GetColumn()
ls_col_ref 		= "#" + String( li_colonne )
ls_nom_colonne	= dwo.name
ls_style 		= THIS.Describe( ls_col_ref + ".edit.style" )
ls_ind_requis 	= THIS.Describe( ls_col_ref + "." + ls_style + ".required" )
ls_coltype 		= dwo.coltype
li_pos_paren 	= Pos( ls_coltype, "(" )

IF li_pos_paren > 0 THEN
	li_taille_colonne = Integer( Mid( ls_coltype, li_pos_paren + 1, Pos( ls_coltype, ")" ) - li_pos_paren - 1 ) )
	ls_coltype = Left( ls_coltype, li_pos_paren - 1 )
END IF

// Ajout d'une 3 ième condition (OR STRING(time(data)) = "00:00:00")
// pour tenir compte de la fonction GetText() qui retourne "2000-01-01 00:00:00"
// au lieu de nulle selon les paramètres régionaux de windows ( pour année à 2 positions)
IF ls_coltype = "datetime" THEN

	// Changement pour Windows 2000
	environment env

	GetEnvironment(env)

	CHOOSE CASE env.OSType

		CASE Windows!
			ls_annee_date  = ProfileString("c:\windows\win.ini","intl","sShortDate","none")

		CASE WindowsNT! //Windows NT et Windows 2000
			RegistryGet("HKEY_USERS\.Default\Control Panel\International", "sShortDate", RegString!, ls_annee_date)
	END CHOOSE


	IF right(ls_annee_date,4) = "yyyy" THEN
		lb_date_nulle = FALSE
	ELSE
		IF STRING(time(data)) = "00:00:00" THEN
			lb_date_nulle =TRUE
		ELSE
			lb_date_nulle = FALSE
		END IF
	END IF
ELSE
	lb_date_nulle = FALSE
END IF

IF ls_ind_requis = "yes" AND (data = "" OR IsNull(data) OR lb_date_nulle = TRUE) THEN
	// traiter les colonnes NULL et requis

	CHOOSE CASE ls_coltype
		CASE "char"
			string	ls_valeur
			ls_valeur = GetItemString( row, li_colonne )
			IF NOT isNull( ls_valeur ) THEN
				SetNull( ls_null )
				SetItem( row, li_colonne, ls_null )
			END IF
		CASE "date"
			date	ld_valeur
			ld_valeur = GetItemDate( row, li_colonne )
			IF NOT isNull( ld_valeur ) THEN
				SetNull( ld_null )
				SetItem( row, li_colonne, ld_null )
			END IF
		CASE "datetime"
			datetime	ldt_valeur
			ldt_valeur = GetItemDateTime( row, li_colonne )
			IF NOT isNull( ldt_valeur ) THEN
				SetNull( ldt_null )
				SetItem( row, li_colonne, ldt_null )
			END IF
		CASE "time"
			time	lt_valeur
			lt_valeur = GetItemTime( row, li_colonne )
			IF NOT isNull( lt_valeur ) THEN
				SetNull( ltm_null )
				SetItem( row, li_colonne, ltm_null )
			END IF
		CASE "number", "decimal", "long", "ulong", "real"
			long	ll_valeur
			ll_valeur = GetItemNumber( row, li_colonne )
			IF NOT isNull( ll_valeur ) THEN
				SetNull( ll_null )
				SetItem( row, li_colonne, ll_null )
			END IF
	END CHOOSE


	RETURN 2 // Accepter le null (temporairement)
									// trappé par fu_verifier_null
ELSE
	// Préparer le message par défaut

	// obtenir le libellé de la colonne
	ls_libelle = 	THIS.Describe( Left( ls_nom_colonne, 38 ) + "_t.text" )

 	IF ls_libelle = "!" THEN  // SI = "!" le nom du libellé a été modifié dans la datawindow objet
		ls_libelle = ls_nom_colonne
	END IF

	CHOOSE CASE ls_coltype
		CASE "char"
				// On peut saisir un maximum de x caractères
				lnv_message.is_msgid = "CIPQ0001"
				lnv_message.is_msgparm[1] = string( li_taille_colonne )
				lnv_message.is_msgparm[2] = ls_libelle
		CASE "date", "datetime"
				// Traduire le format de date Windows
				// Dans le message, toujours affichar "AAAA-MM-JJ"
//				ls_format_date = ProfileString( "c:\windows\win.ini", "intl", "sshortdate", "" )
//				CHOOSE CASE ls_format_date
//					CASE "yyyy-MM-dd","yyyy-M-d"
//						ls_format_date = "AAAA-MM-JJ"
//					CASE "yyyy/MM/dd","yyyy/M/d"
//						ls_format_date = "AAAA/MM/JJ"
//					CASE "yyyy MM dd","yyyy M d"
//						ls_format_date = "AAAA MM JJ"
//					CASE "yy-MM-dd","yy-M-d"
//						ls_format_date = "AA-MM-JJ"
//					CASE "yy/MM/dd","yy/M/d"
//						ls_format_date = "AA/MM/JJ"
//					CASE "yy MM dd","yy M d"
//						ls_format_date = "AA MM JJ"
//
//					CASE "dd-MM-yyyy","d-M-yyyy"
						ls_format_date = "JJ-MM-AAAA"
//					CASE "dd/MM/yyyy","d/M/yyyy"
//						ls_format_date = "JJ/MM/AAAA"
//					CASE "dd MM yyyy","d M yyyy"
//						ls_format_date = "JJ MM AAAA"
//					CASE "dd-MM-yy","d-M-yy"
//						ls_format_date = "JJ-MM-AA"
//					CASE "dd/MM/yy","d/M/yy"
//						ls_format_date = "JJ/MM/AA"
//					CASE "dd MM yy","d M yy"
//						ls_format_date = "JJ MM AA"
//
//					CASE "MM-dd-yyyy","M-d-yyyy"
//						ls_format_date = "MM-JJ-AAAA"
//					CASE "MM/dd/yyyy","M/d/yyyy"
//						ls_format_date = "MM/JJ/AAAA"
//					CASE "MM dd yyyy","M d yyyy"
//						ls_format_date = "MM JJ AAAA"
//					CASE "MM-dd-yy","M-d-yy"
//						ls_format_date = "MM-JJ-AA"
//					CASE "MM/dd/yy","M/d/yy"
//						ls_format_date = "MM/JJ/AA"
//					CASE "MM dd yy","M d yy"
//						ls_format_date = "MM JJ AA"
//				END CHOOSE
				// Doit être une date de format:
				lnv_message.is_msgid = "CIPQ0002"
				lnv_message.is_msgparm[1] = ls_libelle
				lnv_message.is_msgparm[2] = ls_format_date
		CASE "time"
				// Doit être une heure de format:
				lnv_message.is_msgid = "CIPQ0003"
				lnv_message.is_msgparm[1] = ls_libelle
				lnv_message.is_msgparm[2] = this.Describe( ls_col_ref + ".format" )
		CASE "number", "decimal", "long", "ulong", "real"
				// Doit être numérique
				lnv_message.is_msgid = "CIPQ0004"
				lnv_message.is_msgparm[1] = ls_libelle
	END CHOOSE

	// S'il existe, obtenir le message dans la datawindow objet (validation)

	ls_message = THIS.Describe( ls_col_ref + ".validationmsg" )

	IF  NOT ls_message = "?" AND NOT ls_message = "!" AND NOT ls_message = "" THEN

		IF Left( ls_message, 1 ) = "~"" AND Right( ls_message, 1 ) = "~"" THEN
			// Describe retourne ~~" au lieu de ~~~" dans le message
			ls_message = gnv_app.inv_string.of_GlobalReplace( ls_message, "~~~~~"", "~~~~~~~"" )
			// **** fin fix ****
			ls_descr_expr = "evaluate(" + ls_message + "," &
				+ string( THIS.GetRow() ) + ")"
		ELSE
			ls_descr_expr = "evaluate(~"" &
				+ gnv_app.inv_string.of_GlobalReplace ( ls_message, "~"", "~~~"" ) &
				+ "~"," + string( THIS.GetRow() ) + ")"
		END IF
		lnv_message.is_msgparm[upperbound(lnv_message.is_msgparm)+1] = " " + Describe( ls_descr_expr ) + "."
   ELSE
		lnv_message.is_msgparm[upperbound(lnv_message.is_msgparm)+1] = "."
	END IF

	gnv_app.inv_error.of_Message( lnv_message.is_msgid,lnv_message.is_msgparm)

	Return 1
END IF
end event

event dberror;// Override de l'ancêtre
n_cst_MessageFrancaisAttrib  lnv_MessageFrancaisAttrib
u_dw		ldw_control


// Assurer que tous les verrous sont libérés avant d'afficher un message (RollBack)
// sauf pour les messages d'attention (50000 à 50999)
CHOOSE CASE Left( Upper( SQLCA.DBMS ), 3 )
	CASE "SYB", "SYC"
		IF	(sqldbcode >= 50000 AND sqldbcode <= 50999)	THEN
			// Message d'attention, ne pas faire un rollback
			ib_ignore_dberror = TRUE
		ELSE
			ROLLBACK USING SQLCA;
		END IF
	CASE ELSE
		ROLLBACK USING SQLCA;
END CHOOSE

// appeler le service de traduction du message
ldw_control = this

lnv_MessageFrancaisAttrib = gnv_app.inv_MessageFrancais.of_RetourneMessageFrancais(ldw_control,sqldbcode,sqlerrtext)

//=================== Afficher le message d'erreur ======================
IF lnv_MessageFrancaisAttrib.is_msgid = "" THEN

	lnv_MessageFrancaisAttrib.is_msgparm[1] = String( sqldbcode )
	lnv_MessageFrancaisAttrib.is_msgparm[2] = sqlerrtext + " " + this.dataobject
	gnv_app.inv_error.of_Message("CIPQ0005",lnv_MessageFrancaisAttrib.is_msgparm)

	// terminer l'application en déclenchant l'événement Close de l'application.
	IF IsValid(THIS.Of_GetFenetreParent()) THEN
		CLOSE(THIS.Of_GetFenetreParent())
	END IF



ELSE

	IF lnv_MessageFrancaisAttrib.il_nb_rangee_detruite > 0  THEN
		This.TriggerEvent( Rowfocuschanged!)

		// On initialise à 0 la variable d'instance 'il_rangee_detruite', suite aux
		il_rangee_detruite = 0
	END IF

	gnv_app.inv_error.of_Message(lnv_MessageFrancaisAttrib.is_msgid,lnv_MessageFrancaisAttrib.is_msgparm)

	RETURN 1
END IF
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;long 	ll_row, ll_NbrRow, li_retour
u_dw	ldw_Master

// Si l'ancêtre empêche l'insertion
If AncestorReturnValue <= PREVENT_ACTION then
	return PREVENT_ACTION
end if

// Si la datawindow n'est pas en mise à jour ne pas insérer
IF NOT THIS.of_GetUpdateable() THEN
	RETURN PREVENT_ACTION
END IF

//Vérifie si le statut de la rangée courante est New!
//si oui,ne pas permettre l'insertion
FOR ll_row = 1 to this.RowCount()
	IF this.GetitemStatus(ll_row,0,Primary!) = New! THEN
		RETURN PREVENT_ACTION
	END IF
NEXT

IF this.of_AcceptText(TRUE) = 1 THEN
	li_retour = this.Event pro_MajLigneParLigne()
ELSE
	RETURN PREVENT_ACTION
END IF

IF li_retour < 0 THEN
	RETURN PREVENT_ACTION
ELSE

	//Vérifie si la datawindow est vide
	if this.RowCount() = 0 then
	
		//Si le parent est vide, on insère sur le parent et
		// non sur le fils
		if IsValid(inv_linkage) then
			this.inv_linkage.of_GetMaster(ldw_Master)
			
			if IsValid(ldw_Master) then
				ll_NbrRow = ldw_Master.RowCount()
				if ll_NbrRow = 0 then
					ldw_Master.SetFocus()
					ldw_Master.Event pfc_insertrow()
					RETURN PREVENT_ACTION
				ELSE
					// si la rangée du parent est New! ne pas insérer de fils
					for ll_Row = 1 to ll_NbrRow
						if ldw_Master.GetItemStatus(ll_Row,0,Primary!) = NEW! then
							RETURN PREVENT_ACTION
						end if
					next
				end if
			end if
		end if
	END IF
END IF

return CONTINUE_ACTION
end event

event itemchanged;call super::itemchanged;ib_itemchanged_encours = TRUE
end event

event getfocus;call super::getfocus;// L'utilisation de ib_getfocus_en_cours évite une boucle infinie
// lorsqu'on affiche un message dans l'événement GetFocus.
// Suite à l'affichage du message, l'objet obtient à nouveau le focus
// et redéclenche l'événement GetFocus...
groupcalc()
// Redonne le focus à la datawindow précédente lorsque celle-ci
// a une erreur
integer	li_retour, li_posx, li_posy
w_master lw_parent
w_sheet	lw_sheet
string	ls_nom_dataobject
long 		ll_rangee

dwItemStatus ldwItemStatus_status
lw_parent = THIS.of_GetFenetreParent()

IF ib_getfocus_en_cours THEN
	RETURN
END IF

ib_getfocus_en_cours = TRUE

IF ib_maj_ligne_par_ligne THEN
	
	IF IsValid(lw_parent.idw_precedente) THEN
		IF lw_parent.idw_precedente = THIS OR gnv_app.inv_entrepotglobal.of_retournedonnee( "Statut frame", FALSE) = "Min" THEN
			// ne rien faire
		ELSE
			li_retour = lw_parent.event pfc_save()
			IF li_retour < 0 THEN
				ib_getfocus_erreur = TRUE
				lw_parent.idw_precedente.Post Event pro_postgetfocus()
			ELSE
				ib_getfocus_erreur = FALSE
				
				lw_parent.idw_precedente = this
				THIS.Post Event pro_postRetourFocus()
			END IF
		END IF
	END IF
END IF

ll_rangee = THIS.GetRow()

IF li_retour >= 0 THEN
	//********************************************************
   // pour les datawindows qui sont sur des onglets seulement
   //********************************************************

	If This.RowCount() = 0 Then
		// Désactiver les autres onglets de la fenêtre
		THIS.of_activer_tabpg( FALSE )
	Else
		// Activer les autres onglets de la fenêtre
		THIS.of_activer_tabpg( TRUE )
	End If
END IF


ib_getfocus_en_cours = FALSE
ib_itemchanged_encours = FALSE

gnv_app.of_GetFrame().POST SetRedraw(TRUE)

	
end event

event clicked;call super::clicked;int		li_ok, li_tab_order = 0, li_protect = 0
string 	ls_expr, ls_eval, ls_resultat

if ib_InsertAutomatique AND ib_getfocus_erreur = FALSE then
	THIS.of_valideinsertion()
end if

IF row > 0 AND THIS.GetRow() <> row THEN
	// on force un changement de rangee seulement si PB ne le fait pas automatiquement
	// PB le fait automatiquement si:
	//		l'usager a cliqué sur une colonne
	//		la colonne a un tab order positif
	//		la colonne est non protect

	IF dwo.type = "column" THEN
		li_tab_order = Integer( dwo.tabsequence )

		ls_expr = dwo.protect
		IF ls_expr <> "!" AND ls_expr <> "?" AND ls_expr <> "" THEN
			IF Pos( ls_expr, "~t" ) > 0 THEN
				// il exist une expression protect. PB a retourner
				//		"0<tab>expression"

				// étape 1) eleve les "
				ls_expr = Mid( ls_expr, 2, Len( ls_expr ) - 2 )

				// étape 2) extraire l'expression (après le tab)
				ls_expr = Mid( ls_expr, Pos( ls_expr, "~t" ) + 1 )

				// étape 3) créer une expression evaluate pour la rangée
				ls_eval = "evaluate('" + ls_expr + "'," + string( row) + ")"

				// étape 4) executer l'expression evaluate pour obtenir la valeur protect
				// pour la colonne sur la rangée clicked
				ls_resultat = THIS.Describe( ls_eval )
				li_protect = Integer( ls_resultat )
			ELSE
				// PB a retourner une valeur seulement
				li_protect = Integer( ls_expr )
			END IF
		END IF
	END IF
	IF li_protect = 1 OR li_tab_order = 0 OR dwo.type <> "column" THEN
		//Ligne suivante changée pour PB8 (rowselect.EXTENDED ne marchait plus)
		//li_ok = THIS.ScrolltoRow( row )
		THIS.POST ScrolltoRow( row )
	END IF
END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;integer li_cnt
string ls_menuitem
dwItemStatus l_status

w_master	lw_parent
n_cst_string lnv_strsrv

lw_parent = this.of_GetFenetreParent()

// Si la datawindow n'est pas en mise à jour ne pas détruire
IF NOT THIS.of_GetUpdateable() THEN
	RETURN PREVENT_ACTION
END IF

// Confirmer le paramètre de sécurité pour la destruction de la fenêtre
// Si on est en mode insertion, laisser passer la destruction
l_status = this.getItemStatus(this.GetRow(), 0, Primary!)
if pos(lw_parent.tag, 'exclure_securite') = 0 and l_status <> New! and l_status <> NewModified! then
	ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(lw_parent.tag), "menu", ";"))
	if isNull(ls_menuitem) then ls_menuitem = ""
	
	select count(1)
	  into :li_cnt
	  from t_droitsusagers
	 where (id_user = :gnv_app.il_id_user
			 or id_user in (select id_group
									from t_groupeusager
								  where id_user = :gnv_app.il_id_user))
		and objet = :ls_menuitem
		and isnull(locate(upper(droits), 'D'), 0) > 0;
	
	if li_cnt = 0 then
		gnv_app.inv_error.of_message("PRO0014")
		return PREVENT_ACTION
	end if
end if

// si c'est le cas, demander la confirmation de destruction
IF ib_ConfirmationDestruction and ib_maj_ligne_par_ligne THEN
	if gnv_app.inv_error.of_message("CIPQ0021") = 2 THEN
		RETURN PREVENT_ACTION
	END IF
END IF

// Initialise la TRUE l'indicateur de nouvelle ligne si le statut de la
// rangée est à New ou NewModified
IF l_status = New! or l_status = NewModified! THEN
	ib_nouvelle_rangee = TRUE
END IF

RETURN CONTINUE_ACTION
end event

event pfc_deleterow;//*******************************************//
//*********   OVERRIDE ANCÊTRE **************//
//*******************************************//

//////////////////////////////////////////////////////////////////////////////
//
//	Événement:  		pfc_deleterow
//
//	Argument:  			Aucun
//
//	Retourne:  			1  = success
//  						0  = Row not deleted
//							-1 = error
//
//	Description:		Deletes the current or selected row(s)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Enhanced with PreDelete process.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
long		ll_row
w_master lw_parent

IF THIS.RowCount() < 1 THEN
	gnv_app.inv_error.of_Message("CIPQ0022")
	Return NO_ACTION
END IF

// Perform Pre Delete process.
If this.Event pfc_predeleterow() <= PREVENT_ACTION Then
	Return NO_ACTION
End If

// POST de l'événement atm_POSTDELETEROW
//
This.POST Event pro_postdeleterow()

// Tous les cas pouvant bloquer la suppression ont été vérifié.
// La rangée sera détruite et on garde par le fait même le numéro
// de cette rangée.
il_rangee_detruite = this.GetRow()

ib_en_destruction = FALSE

// Delete row.
if IsValid (inv_rowmanager) then
	li_rc = inv_rowmanager.event pfc_deleterow ()
else
	li_rc = this.DeleteRow (0)
end if

If li_rc > 0 Then ll_row = 0 Else ll_row = -1
//	Note: The deletion of multiple master rows is not supported by the linkage service.
if IsValid ( inv_Linkage ) then
	li_rc = inv_Linkage.Event pfc_deleterow (ll_row)
end If


IF li_rc <> SUCCESS THEN
	RETURN li_rc
END IF

//********************************************************
// pour les datawindows qui sont sur des onglets seulement
//********************************************************

If  This.RowCount() = 0 Then
	// Désactiver les autres onglets de la fenêtre
	THIS.of_activer_tabpg( FALSE )
End If

IF this.ib_maj_ligne_par_ligne THEN
	ib_en_destruction = TRUE
	RETURN this.event pfc_update(TRUE,FALSE)
ELSE
	RETURN 1
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;string ls_menuitem
integer li_cnt

w_master	lw_parent
u_tabpg	ltabpg_courant
n_cst_string lnv_strsrv

lw_parent = this.of_GetFenetreParent()

// Confirmer le paramètre de sécurité pour la mise à jour de la fenêtre
if pos(lw_parent.tag, 'exclure_securite') = 0 then
	ls_menuitem = lower(lnv_strsrv.of_getkeyvalue(lower(lw_parent.tag), "menu", ";"))
	if isNull(ls_menuitem) then ls_menuitem = ""
	
	select count(1)
	  into :li_cnt
	  from t_droitsusagers
	 where (id_user = :gnv_app.il_id_user
			 or id_user in (select id_group
									from t_groupeusager
								  where id_user = :gnv_app.il_id_user))
		and objet = :ls_menuitem
		and isnull(locate(upper(droits), 'M'), 0) > 0;
	
	if li_cnt = 0 then
		gnv_app.inv_error.of_message("PRO0013")
		return FAILURE
	end if
end if

// Construire la liste des colonnes modifiées
string ls_colonne_null[]
long ll_acc, ll_inc, ll_rangee
string ls_colonne
is_colonne_modified = ls_colonne_null
ll_inc = 0
ll_rangee = this.getrow()
IF ll_rangee > 0 THEN
	For ll_acc = 1 to long(this.Describe("DataWindow.Column.Count"))
		IF this.getitemstatus(ll_rangee,ll_acc,Primary!) = datamodified! THEN
			ll_inc += 1
			ls_colonne = this.describe("#" + string(ll_acc) + ".name")
			is_colonne_modified[ll_inc] = ls_colonne
		END IF 
	next
END IF 

//S'il n'y a pas de tabpage, faire toujours les preupdate
IF lw_parent.of_GetTabpg(ltabpg_courant) = 1 THEN
	//Si c'est sur le tabpage courant
	IF THIS.GetParent() <> ltabpg_courant THEN
		RETURN 2
		//N'exécutera pas le script du descendant s'il y ait indiqué:
		//IF ancestorreturnvalue <> SUCCESS THEN
		//	RETURN ancestorreturnvalue
		//END IF
	END IF
END IF

IF ib_en_destruction = TRUE THEN
	ib_en_destruction = FALSE
	RETURN 2
END IF

RETURN SUCCESS
end event

event sqlpreview;call super::sqlpreview;string	ls_cle, ls_login, ls_type_maj, ls_dataobject, ls_nomtable, ls_nomfenetre
datetime	ldt_date_maj
window	lw_fen

is_sql_genere = sqlsyntax

IF sqltype <> PreviewSelect!THEN
	//Audit
	
	ls_login = gnv_app.inv_entrepotglobal.of_retournedonnee("Login usager", FALSE)
	
	lw_fen = this.of_getfenetreparent( )
	ls_nomfenetre = lw_fen.title
	
	IF sqltype = PreviewInsert! THEN
		ls_type_maj = "Insertion"
	ELSEIF sqltype = PreviewDelete! THEN
		ls_type_maj = "Destruction"
	ELSEIF sqltype = PreviewUpdate! THEN
		ls_type_maj = "Mise à jour"
	END IF
	
	ldt_date_maj = datetime(today(),now())
	ls_dataobject = THIS.dataobject
	
	ls_nomtable = THIS.Object.DataWindow.Table.UpdateTable
	
	ls_cle = of_ObtenirExpressionClesPrimaires(row)
	
	is_sql_genere = gnv_app.inv_string.of_globalreplace( is_sql_genere, '"', '')
	is_sql_genere = gnv_app.inv_string.of_globalreplace( is_sql_genere, '?', '')
	
	//Stocker l'information dans la base de données d'audit
	INSERT INTO t_audit (login_usager, type_maj, sql_maj, date_maj, dataobject, primarykey, nom_table, nom_fenetre)
	VALUES 		(:ls_login, :ls_type_maj, :is_sql_genere, :ldt_date_maj, :ls_dataobject, :ls_cle, :ls_nomtable, :ls_nomfenetre) 
	USING 		SQLCA;
	
	Commit USING SQLCA;
	
	
END IF
end event

event rowfocuschanging;call super::rowfocuschanging;int 		li_retour

// arrive lorsqu'un fils a une erreur et que l'on veut changer de rangée dans le père
// on doit refuser le changement de rangée
IF ib_getfocus_erreur THEN
	ib_getfocus_erreur = FALSE
	RETURN 1
END IF

IF currentrow <> 0 THEN
	IF this.il_rangee_detruite = 0 THEN
		li_retour = this.Event pro_MajLigneParLigne()
	END IF
END IF

IF li_retour < 0 THEN
	IF IsValid(inv_rowselect) THEN
		IF currentrow <> 0 THEN
			THIS.SelectRow( 0, FALSE )
			THIS.SelectRow( currentrow, TRUE )
		END IF
	END IF

	// On se positionne sur la bonne rangée suite à une erreur.
	//
	This.ScrollToRow( currentrow )

	RETURN 1
END IF

RETURN 0
end event

event scrollvertical;call super::scrollvertical;IF this.Describe("datawindow.firstrowonpage") = &
   this.Describe("datawindow.lastrowonpage") THEN
	Post Event pro_postscrollvertical()
END IF
end event

event pfc_finddlg;//Override

//Vérifier si on est en insertion
IF ib_en_insertion = FALSE THEN
	w_master lw_parent
	lw_parent = THIS.of_GetFenetreParent()
	IF lw_parent.event pfc_save() >= 0 THEN
		CALL SUPER::pfc_finddlg
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0023")
END IF
end event

event itemfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			itemfocuschanged
//
//	Description:  Send itemfocuschanged notification to DW services
//	If appropriate, display the microhelp stored in the tag value of the current column.
//
//	Note:  The tag value of a column can contain just the microhelp, or may
//	contain other information as well.
//	The format follows: MICROHELP=<microhelp to be displayed>.
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string			ls_microhelp, ls_retour
window			lw_parent

If IsNull(dwo) Or Not IsValid (dwo) Then
	dwobject		ldw_nulle
	SetNull(ldw_nulle)
	idwo_current = ldw_nulle
	Return
End If

idwo_current = dwo

//Check for microhelp requirements.
If gnv_app.of_GetMicrohelp() Then
	// Check the tag for any "microhelp" information.
	ls_microhelp = dwo.tag

	if IsNull (ls_microhelp) or Len(Trim(ls_microhelp))=0 OR ls_microhelp = "?" then
		ls_microhelp = 'Prêt'
	end if

	//Notify the window.
	THIS.of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		// Dynamic call to the parent window.
		lw_parent.Dynamic Event pfc_microHelp (ls_microhelp)
	End If
End If

If IsValid(inv_linkage) Then
	inv_linkage.Event pfc_itemfocuschanged (row, dwo)
End If

is_texte_original = THIS.GetText()
end event

event destructor;call super::destructor;IF IsValid(inv_dwsrv) THEN DESTROY inv_dwsrv
end event

event dropdown;call super::dropdown;// Ajouter un identifiant pour annuler ce que la personne a choisie, ligne blanche dans une dropdown
datawindowchild ldwc_child
string ls_colonne, ls_Display, ls_datacolumn, ls_required, ls_expression, ls_coltype, ls_tag
boolean lb_inserer = FALSE

ls_colonne = this.getcolumnName()
window lw_window

THIS.of_getparentwindow(lw_window)
IF lw_window.classname() <> "w_filtersimple" AND lw_window.classname() <> "w_sortdragdrop" THEN
	IF this.getchild(ls_colonne,ldwc_child) <> -1 THEN
		// Essayer de refaire le retrieve de la child... Pour l'instant je ne sais pas comment faire pour retrouver les arguments.
		ls_tag = this.describe(ls_colonne+ ".tag ")
		IF POS(ls_tag, "exclure_reretrieve") = 0 THEN
			ldwc_child.SetTransObject(SQLCA)
			ldwc_child.retrieve()
			
			IF ldwc_child.rowcount() > 0 THEN
				// Obtenir le nom du display column
				ls_Display = this.describe(ls_colonne+ ".DDDW.DisplayColumn ")
				// Si la colonne est requise on ne fait pas le reste du code
				ls_required = this.describe(ls_colonne+ ".DDDW.required")
		
				If ls_required <> "yes" THEN
					
					ls_coltype = ldwc_child.Describe("#1.Coltype")
					
					// Colonne caractere
					If pos(ls_coltype, "char") > 0 THEN
						IF  Not IsNull(ldwc_child.getitemstring(1,1)) or ldwc_child.getitemstring(1,1) <> ""  THEN lb_inserer = TRUE
					END IF
					// Colonne decimal
					If pos(ls_coltype, "decimal") > 0 OR pos(ls_coltype, "number") > 0 OR pos(ls_coltype, "long") > 0 THEN
						IF Not IsNull(ldwc_child.getitemnumber(1,1))   THEN lb_inserer = TRUE
					END IF
		
					IF lb_inserer THEN
						this.setredraw(FALSE)
						ldwc_child.insertrow(1)
						this.setcolumn(1)
						this.setcolumn(ls_colonne)
						this.setredraw(TRUE)
		
						// Faire le remplacement pour le insertrow(1)
						choose case ldwc_child.describe(ls_Display + ".type")
							case "compute"
								// Prendre la colonne source lorsque l'affichage est un compute
								ls_datacolumn = this.describe(ls_colonne+ ".DDDW.Datacolumn")
		
								ls_expression = ldwc_child.describe(ls_display+ ".expression")
								// Remplacer dans l'expression tout les "  par des '
								n_cst_string lfct_str
								ls_expression = lfct_str.of_GlobalReplace(ls_expression, "~"", "'")
		
								//ldwc_child.modify(ls_display+ ".expression=~" IF(IsNull(" + ls_datacolumn + "), '--- Aucun(e) ---', " + ls_expression + ")~"")
								ldwc_child.modify(ls_display+ ".expression=~" IF(IsNull(" + ls_datacolumn + "), '', " + ls_expression + ")~"")
		
							case "column"
								//ldwc_child.SetItem(1,ls_Display, "--- Aucun(e) ---")
								ldwc_child.SetItem(1,ls_Display, "")
						end choose
					END IF
				END IF
			END IF
		END IF
	END IF
END IF
end event

