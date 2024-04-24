﻿$PBExportHeader$w_verrats.srw
forward
global type w_verrats from w_sheet_frame
end type
type dw_verrat from u_dw within w_verrats
end type
type uo_toolbar from u_cst_toolbarstrip within w_verrats
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_verrats
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_verrats
end type
type dw_verrat_produit from u_dw within w_verrats
end type
type gb_1 from u_gb within w_verrats
end type
type rr_1 from roundrectangle within w_verrats
end type
end forward

global type w_verrats from w_sheet_frame
string tag = "menu=m_verrats"
dw_verrat dw_verrat
uo_toolbar uo_toolbar
uo_toolbar_bas uo_toolbar_bas
uo_toolbar_haut uo_toolbar_haut
dw_verrat_produit dw_verrat_produit
gb_1 gb_1
rr_1 rr_1
end type
global w_verrats w_verrats

forward prototypes
public subroutine of_majcourante ()
public subroutine of_majavenir ()
public subroutine of_recalcul ()
public subroutine of_ecrasement ()
public subroutine of_validationproduit (string as_noproduit)
end prototypes

public subroutine of_majcourante ();long		ll_rep, ll_count, ll_countavenir
boolean 	lb_skip = false
string	ls_sql

//Valider la date du jour
IF Day(Today()) <> 1 THEN 
	gnv_app.inv_error.of_message( "CIPQ0028")
	RETURN
END IF

ll_rep = gnv_app.inv_error.of_message( "CIPQ0027")

IF ll_rep = 1 THEN
	
	//Vérifier s'il y a des possibilité de MAJ de sous-groupes
	SELECT Count(*) INTO :ll_count from t_verrat where sous_groupe_prochain is not null AND sous_groupe_prochain <> '' ;
	
	IF ll_count = 0 THEN 
		gnv_app.inv_error.of_message( "CIPQ0029")
		lb_skip = TRUE
	ELSE
		IF gnv_app.inv_error.of_message("CIPQ0082", {string(ll_count)}) <> 1 THEN
			lb_skip = TRUE
		END IF
	END IF
	
	//Lancer la maj des sous-groupes, le "courant" devient égal au "à venir"
	IF lb_skip = FALSE THEN
	
		ls_sql = "UPDATE T_Verrat SET T_Verrat.Sous_Groupe = Sous_Groupe_Prochain"
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_Verrat", "Mise à jour", THIS.Title)

		ls_sql = "UPDATE T_Verrat SET T_Verrat.Sous_Groupe_Prochain = Null"
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_Verrat", "Mise à jour", THIS.Title)
		
	ELSE
		lb_skip = FALSE
	END IF
	
	
	//Vérifier s'il y a des possibilité de MAJ de classes
	SELECT Count(*) INTO :ll_count from t_verrat where classe_prochaine is not null and classe_prochaine <> '' ;
	
	IF ll_count = 0 THEN 
		gnv_app.inv_error.of_message( "CIPQ0030")
		lb_skip = TRUE
	ELSE
		IF gnv_app.inv_error.of_message("CIPQ0083", {string(ll_count)}) <> 1 THEN
			lb_skip = TRUE
		END IF
	END IF	
	
	//Lancer la maj des classes, le "courant" devient égal au "à venir"
	IF lb_skip = FALSE THEN

		ls_sql = "UPDATE T_Verrat SET T_Verrat.Classe = Classe_Prochaine"
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_Verrat", "Mise à jour", THIS.Title)
		
		ls_sql = "UPDATE T_Verrat SET T_Verrat.Classe_Prochaine = Null"
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_Verrat", "Mise à jour", THIS.Title)
		
	ELSE
		lb_skip = FALSE
	END IF
	
	
	//Vérifier s'il y a des possibilité de MAJ de sous-groupes
	SELECT Count(*) INTO :ll_count from T_Verrat_produit where NoProduit_Prochain is not null;
	
	IF ll_count = 0 THEN 
		gnv_app.inv_error.of_message( "CIPQ0031")
		lb_skip = TRUE
	ELSE
		IF gnv_app.inv_error.of_message("CIPQ0084", {string(ll_count)}) <> 1 THEN
			lb_skip = TRUE
		END IF
	END IF	
	
	//Lancer la maj des produits, le "courant" devient égal au "à venir"
	IF lb_skip = FALSE THEN
		
		ls_sql = "UPDATE t_Verrat_Produit SET t_Verrat_Produit.NoProduit = t_Verrat_Produit.NoProduit_Prochain"
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Verrat_Produit", "Mise à jour", THIS.Title)

		ls_sql = "UPDATE t_Verrat_Produit SET t_Verrat_Produit.NoProduit_Prochain = Null"
		gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Verrat_Produit", "Mise à jour", THIS.Title)
		
	END IF
	
	//Rafraichir
	dw_verrat.event pfc_retrieve()
	
END IF
end subroutine

public subroutine of_majavenir ();long		ll_rep
string 	ls_sql

ll_rep = gnv_app.inv_error.of_message( "CIPQ0027")

IF ll_rep = 1 THEN
	//Lancer la maj, le "à venir" devient égal au "courant"
	
	ls_sql = "UPDATE T_Verrat SET T_Verrat.Sous_Groupe_Prochain = Sous_Groupe"
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_verrat", "Mise à jour", THIS.Title)
	
	ls_sql = "UPDATE T_Verrat SET T_Verrat.Classe_Prochaine = Classe"
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_verrat", "Mise à jour", THIS.Title)
	
	ls_sql = "UPDATE t_Verrat_Produit SET t_Verrat_Produit.NoProduit_Prochain = t_Verrat_Produit.NoProduit"
	gnv_app.inv_audit.of_runsql_audit( ls_sql, "t_Verrat_Produit", "Mise à jour", THIS.Title)
	
	//Rafraichir
	dw_verrat.event pfc_retrieve()
	
END IF

end subroutine

public subroutine of_recalcul ();//gnv_app.of_verrat_famille_frequence_recolte_vali( )

RETURN
end subroutine

public subroutine of_ecrasement ();string	ls_numero, ls_centre, ls_tatouage, ls_coderace
long		ll_row
w_verrat_ecrasement 	lw_window
ll_row = dw_verrat.GetRow()

IF ll_row > 0 THEN
	ls_numero = string(dw_verrat.object.codeverrat[ll_row])
	ls_centre = string(dw_verrat.object.cie_no[ll_row])
	ls_tatouage = string(dw_verrat.object.tatouage[ll_row])
	ls_coderace = string(dw_verrat.object.coderace[ll_row])
	
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien écrasement numéro", ls_numero)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien écrasement centre", ls_centre)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien écrasement tatouage", ls_tatouage)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien écrasement code race", ls_coderace)
	
	Open(lw_window)
	dw_verrat.event pfc_retrieve()
END IF	

end subroutine

public subroutine of_validationproduit (string as_noproduit);long ll_count ,ll_idprodspec, ll_eco, i
string ls_codehebergeur, ls_classe, ls_noclasse, ls_codeverrat, ls_souscodeh, ls_sqlclasse, ls_tabclasse[], ls_eco
string ls_sql
dec{2} ld_prix

SELECT count(1) INTO :ll_count
FROM t_produit INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat
WHERE noproduit = :as_noproduit;

IF ll_count > 0 THEN

	SELECT t_produit.codehebergeur, t_verrat.classe
		INTO :ls_codehebergeur, :ls_classe
	FROM t_produit INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat
	WHERE noproduit = :as_noproduit;
	
	//PASSER TOUTES LES LIGNES AVEC LE BON CODE HÉBERGEUR
	DECLARE listhebergement CURSOR FOR
		
		SELECT id_prodspec, noclasse, codeverrat, prix, souscodehebergeur, economie 
		FROM t_prodspec 
		WHERE codehebergeur = :ls_codehebergeur;
	
	OPEN listhebergement;
	
	FETCH listhebergement INTO :ll_idprodspec,:ls_noclasse,:ls_codeverrat,:ld_prix,:ls_souscodeh,:ll_eco;
	
	DO WHILE SQLCA.SQLCode = 0
		// CLASSE
		ls_sqlclasse = ''
		ls_tabclasse = split(ls_noclasse,';')
		If Not isnull(ls_tabclasse[1]) THEN
			
			For i = 1 To Upperbound(ls_tabclasse)
				Choose Case Mid(ls_tabclasse[i],1,1)
					Case '='
						ls_sqlclasse = ls_sqlclasse + " t_verrat.classe = '" + Mid(ls_tabclasse[i],2,Len(ls_tabclasse[i])) + "' AND "
					Case '<'
						ls_sqlclasse = ls_sqlclasse + " t_verrat.classe <> '" + Mid(ls_tabclasse[i],3,Len(ls_tabclasse[i])) + "' AND "
				End Choose
			Next
			
			ls_sqlclasse = left(ls_sqlclasse,Len(ls_sqlclasse)-4)
			If isnull(ls_sqlclasse) Or ls_sqlclasse = '' THEN
				ls_noclasse = ''
			Else
				ls_sqlclasse = " AND " + ls_sqlclasse 
			End If
		Else
			ls_sqlclasse = ''
		End If
		
		//CODEVERRAT
		If isnull(ls_codeverrat) Or ls_codeverrat = '' Then
			ls_codeverrat = ''
		Else
			Choose Case Mid(ls_codeverrat,1,1)
				Case '.'
					ls_codeverrat = " AND SUBSTR(t_verrat.codeverrat,2,1)  = " + Mid(ls_codeverrat,2,1)
				Case '!'
					ls_codeverrat = " AND SUBSTR(t_verrat.codeverrat,2,1)  <> " + Mid(ls_codeverrat,2,1) 
			End Choose
		End If
		
		// ECONOMIE
		IF isnull(ll_eco) THEN 
			ls_eco = ", noeconomievolume = null"
		ELSE
			ls_eco = ", noeconomievolume = '" + string(ll_eco) + "'"
		END IF
		
		
		ls_sql = "SELECT count(1) FROM t_produit INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat WHERE noproduit = '"+string(as_noproduit)+"' " + ls_sqlclasse + ls_codeverrat
		DECLARE list DYNAMIC CURSOR FOR SQLSA;
		PREPARE sqlsa FROM :ls_sql;
		
		OPEN list;
		
		FETCH list INTO :ll_count;
		
		DO WHILE SQLCA.SQLCode = 0 
		
			If ll_count > 0 Then
					UPDATE t_produit 
					SET prixunitaire = :ld_prix, prixunitairesp = :ld_prix, noeconomievolume = :ll_eco, no_sch = :ls_souscodeh
					WHERE noproduit = :as_noproduit;
			End If
			
			FETCH list INTO :ll_count;
		
		LOOP
		
		CLOSE list;

	FETCH listhebergement INTO :ll_idprodspec,:ls_noclasse,:ls_codeverrat,:ld_prix,:ls_souscodeh,:ll_eco;
		
	LOOP
	
	CLOSE listhebergement;

END IF

end subroutine

on w_verrats.create
int iCurrent
call super::create
this.dw_verrat=create dw_verrat
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_verrat_produit=create dw_verrat_produit
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_verrat
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.uo_toolbar_bas
this.Control[iCurrent+4]=this.uo_toolbar_haut
this.Control[iCurrent+5]=this.dw_verrat_produit
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_verrats.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_verrat)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar_haut)
destroy(this.dw_verrat_produit)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_verrat.event pfc_retrieve()
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

//uo_toolbar.of_AddItem("Recalcul du nombre de verrats pour les fréquences de récolte", "C:\ii4net\CIPQ\images\famille.ico")
uo_toolbar.of_AddItem("Écrasement", "AlignBottom!")
uo_toolbar.of_AddItem("Imprimer l'écran", "Preview!")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un verrat", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Supprimer ce verrat", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_AddItem("Rechercher un verrat...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un produit", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer ce produit", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_verrats
integer x = 247
integer y = 72
string text = "Verrats"
end type

type p_8 from w_sheet_frame`p_8 within w_verrats
integer x = 50
integer y = 36
integer width = 165
integer height = 156
string picturename = "C:\ii4net\CIPQ\images\verrat.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_verrats
integer width = 4622
integer height = 168
end type

type dw_verrat from u_dw within w_verrats
integer x = 64
integer y = 244
integer width = 4512
integer height = 1232
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_verrat"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event clicked;call super::clicked;//Picture clicked
n_cst_menu	lnv_menu
menu			lm_item, lm_menu
string		ls_tatouage, ls_emplacement, ls_cieno
long			ll_nolot

lm_menu = gnv_app.of_getframe().MenuID
				
IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE "p_file"
			gnv_app.inv_entrepotglobal.of_ajoutedonnee('codeverrat', dw_verrat.object.codeverrat[dw_verrat.getrow( )])
			gnv_app.inv_entrepotglobal.of_ajoutedonnee('cie_no', dw_verrat.object.cie_no[dw_verrat.getrow( )])
			OpenSheet(w_savefile,gnv_app.of_GetFrame(),6,layered!)
		CASE "p_isolement"
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				ls_tatouage = THIS.object.tatouage[row]
				IF ls_tatouage <> "" AND Not IsNull(ls_tatouage) THEN
		
					//Déterminer le no lot d'isolement - s'il y a lieu
					SELECT nolot
					INTO :ll_nolot
					FROM t_isolementverrat
					WHERE tatouage = :ls_tatouage USING SQLCA;
					
					IF Not IsNull(ll_nolot) AND ll_nolot <> 0 THEN
						IF lnv_menu.of_GetMenuReference (lm_menu,"m_lotsdeverratsenisolement", lm_item) > 0 THEN
							IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
								gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien isolement verrat", string(ll_nolot))
								gnv_app.inv_entrepotglobal.of_ajoutedonnee("Tatoo isolement verrat", ls_tatouage)
								lm_item.event clicked()
							END IF
						END IF 
					ELSE
						gnv_app.inv_error.of_message("CIPQ0072")
					END IF
					
				END IF
				
			END IF
			
		CASE "p_imprimer"
			w_r_dossier_verrat_isolement	lw_window_v
			
			ls_tatouage = THIS.object.tatouage[row]
			IF ls_tatouage <> "" AND Not IsNull(ls_tatouage) THEN
				
				IF parent.event pfc_save() >= 0 THEN
					//Déterminer le no lot d'isolement - s'il y a lieu
					SELECT nolot
					INTO :ll_nolot
					FROM t_isolementverrat
					WHERE tatouage = :ls_tatouage USING SQLCA;
					
					IF Not IsNull(ll_nolot) AND ll_nolot <> 0 THEN
						
						gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(ll_nolot))
						gnv_app.inv_entrepotglobal.of_ajoutedonnee("type lien dossier", "verrat")
						gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien isolement tatouage", ls_tatouage)
						OpenSheet(lw_window_v, gnv_app.of_GetFrame(), 6, layered!)
						
					ELSE
						gnv_app.inv_error.of_message("CIPQ0072")
					END IF
				END IF
			END IF

			
		CASE "p_majcourante"
			of_majcourante()
			gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat", TRUE)
			
		CASE "p_majavenir"
			of_majavenir()
			gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat", TRUE)
			
		CASE "emplacement_t"
			
			ls_tatouage = THIS.object.tatouage[row]
			IF ls_tatouage <> "" AND Not IsNull(ls_tatouage) THEN
				ls_cieno = THIS.object.cie_no[row]
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("tatouage_emplacement", ls_tatouage)
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("cieno_emplacement", ls_cieno)
				open(w_emplacement_verrat)
				ls_emplacement = string(gnv_app.inv_entrepotglobal.of_retournedonnee("Nouvelle emplacement verrat"))
				if ls_emplacement <> "" then THIS.object.emplacement[row] = ls_emplacement
			
			ELSE
				gnv_app.inv_error.of_message("CIPQ0072")
			END IF
			
	END CHOOSE
END IF


end event

event buttonclicked;call super::buttonclicked;//buttonclicked
n_cst_menu	lnv_menu
string		ls_tatouage
menu			lm_item, lm_menu

lm_menu = gnv_app.of_getframe().MenuID

IF Row > 0 THEN
	CHOOSE CASE dwo.name
	
		CASE "b_plusdestination"
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,"m_destinationsdesverrats", lm_item) > 0 THEN
					IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
						lm_item.event clicked()
					END IF
				END IF 
			END IF
						
		CASE "b_pluscause"
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,"m_causesdesreformesdesverrats", lm_item) > 0 THEN
					IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
						lm_item.event clicked()
					END IF
				END IF 
			END IF
			
		
		CASE "b_fiche"
			ls_tatouage = dw_verrat.object.tatouage[row]
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,"m_fichesante", lm_item) > 0 THEN
					IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
						gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien fiche", ls_tatouage)
						lm_item.event clicked()
					END IF
				END IF 
			END IF

	END CHOOSE
END IF
end event

event itemchanged;call super::itemchanged;string	ls_tatouage, ls_coderace, ls_puce, ls_code_hebergeur, ls_debut, ls_no, ls_cie, ls_codeverrat, ls_nom
long		ll_no, ll_pos, ll_count
datetime ldt_ne, ldt_sortie, ldt_entree

CHOOSE CASE dwo.name
		
	CASE "emplacement"
		//Valider si cet emplacement est possible
		
		IF IsNull(data) THEN RETURN
		
		ll_pos = POS(data, "-")
		IF ll_pos > 0 THEN
			ls_debut = LEFT(data,1)
			ls_no = MID(data,3)
			ls_cie = THIS.object.cie_no[row]
			IF IsNumber(ls_no) THEN
				ll_no = long(ls_no)

				SELECT 	COUNT(1) 
				INTO		:ll_count
				FROM 		t_emplacement_section
				WHERE		cie_no = :ls_cie AND
							emplacement = :ls_debut AND
							noparc_debut <= :ll_no AND
							noparc_fin >= :ll_no ;
							
				IF ll_count = 0 THEN
					gnv_app.inv_error.of_message("CIPQ0137")
					RETURN 2
				END IF
			ELSE
				gnv_app.inv_error.of_message("CIPQ0137")
				RETURN 2
			END IF
		ELSE
			gnv_app.inv_error.of_message("CIPQ0137")
			RETURN 2
		END IF
		
		SELECT 	CodeVerrat
		INTO		:ls_codeverrat
		FROM 		t_verrat
		WHERE		emplacement = :data and
					cie_no = :ls_cie;
		
		IF not IsNull(ls_codeverrat) and not ls_codeverrat = "" then
			MessageBox("Attention","Cet emplacement est occupé: " + ls_codeverrat)
			RETURN 2
		end if
		
	CASE "codeverrat"
		//Vérifier si l'info du verrat est disponible dans l'isolement
		
		SELECT 	DISTINCT  
					tatouage, coderace, ne_le, datesortieverrat, tag, dateentreverrat, code_hebergeur, nom
		INTO		:ls_tatouage, :ls_coderace, :ldt_ne, :ldt_sortie, :ls_puce, :ldt_entree, :ls_code_hebergeur, :ls_nom
		FROM 		t_isolementverrat 
		WHERE 	t_isolementverrat.codeverrat = :data
		USING SQLCA;
		
		IF Not IsNull(ls_tatouage) AND ls_tatouage <> "" THEN
			THIS.object.tatouage[row] = ls_tatouage
			THIS.object.nom[row] = ls_nom
			THIS.object.vrairace[row] = ls_coderace
			THIS.object.ne_le[row] = ldt_ne
			//Sortie de l'isolement devient entrée en prod
			THIS.object.entproduct[row] = ldt_sortie
			THIS.object.tag[row] = ls_puce
			THIS.object.datequarantaine[row] = ldt_entree
			If Not IsNull(ls_code_hebergeur) and ls_code_hebergeur <> "" THEN
				THIS.object.coderace[row] = "LO"
			ELSE
				THIS.object.coderace[row] = ls_coderace
			END IF
		END IF
		
	CASE "tag"
		
		SELECT 	CodeVerrat
		INTO		:ls_codeverrat
		FROM 		t_verrat
		WHERE		TAG = :data;
		
		IF not IsNull(ls_codeverrat) and not ls_codeverrat = "" then
			MessageBox("Attention","Cette puce est déjà distribuée: " + ls_codeverrat)
			RETURN 2
		end if
		
END CHOOSE
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

date		ld_reforme
long		ll_row, ll_cause, ll_destination
string	ls_null, ls_coderace, ls_aCodeHeb, ls_codeverrat, ls_tatouage, ls_no, ls_nom, ls_centre, ls_remarque
dec		ldec_prix

SetNull(ls_null)
ll_row = THIS.GetRow()
IF ll_row > 0 THEN
	ll_cause = THIS.object.cause[ll_Row]
	ll_destination = THIS.object.cause[ll_Row]
	ld_reforme = date(THIS.object.elimin[ll_Row])
	ls_coderace = THIS.object.coderace[ll_Row]
	ls_codeverrat = THIS.object.codeverrat[ll_Row]
	ls_tatouage = THIS.object.tatouage[ll_Row]
	ls_centre = THIS.object.cie_no[ll_Row]
	
	// ON enleve les ";" dans les commentaires pour éviter des erreurs
	
	ls_remarque = THIS.object.remarques[ll_Row]
	ls_remarque = rep(ls_remarque, ";", "_")
	THIS.object.remarques[ll_Row] = ls_remarque
	
	IF Not IsNull(ld_reforme) THEN
		//Si éliminé 

		IF IsNull(ll_cause) THEN
			gnv_app.inv_error.of_message("CIPQ0120")
			RETURN FAILURE
		END IF
		
		IF IsNull(ll_destination) THEN
			gnv_app.inv_error.of_message("CIPQ0121")
			RETURN FAILURE
		END IF
		
		THIS.object.emplacement[ll_Row] = ls_null
		THIS.object.tag[ll_Row] = ls_null
	END IF
	
	IF ib_en_insertion = TRUE THEN
		//SI VERRAT D'HÉBERGEMENT
		IF UPPER(ls_coderace) = "LO" THEN
			ls_aCodeHeb = UPPER(LEFT(ls_codeverrat,1))
	
		
			IF IsNull(ls_tatouage) THEN ls_tatouage = ""
			ls_no = upper("HEB-" + ls_codeverrat)
			ls_nom = "HÉBERGEMENT VERRAT " + ls_codeverrat + ", " + ls_tatouage + ", " + ls_centre
			
			ldec_prix = gnv_app.of_getprixhebergement( "110" )
			
			
			// MISE À JOUR PRODUIT 
			//____________________
			
			string ls_classe,ls_codev,ls_souscodeh,ls_classe2
			long   ll_idprodspec,ll_eco
			dec{2} ld_prix
			
			ls_classe = dw_verrat.getitemstring( dw_verrat.getrow( ) , 'classe') 
			
			ls_classe2 = '%'+ls_classe+'%'
			
			ll_eco = 12
			
			setnull(ls_souscodeh)
					
			SELECT id_prodspec,isnull(codeverrat,'')
				INTO :ll_idprodspec, :ls_codev
			FROM t_prodspec 
			 WHERE codehebergeur = :ls_aCodeHeb
				AND ((((substring(noclasse,1,1) = '=' AND noclasse LIKE :ls_classe2 OR :ls_classe IS NULL) OR (substring(noclasse,1,2) = '<>' AND noclasse NOT LIKE :ls_classe2 OR :ls_classe IS NULL)))OR noclasse IS NULL)
				AND (substring(codeverrat,1,1) = (if substring(codeverrat,2,1) = substring(:ls_codeverrat,2,1) then '.' else '!' endif) OR (codeverrat IS NULL));
						

			IF ll_idprodspec > 0 THEN
				SELECT prix, souscodehebergeur, economie 
					INTO :ld_prix,:ls_souscodeh,:ll_eco
				FROM t_prodspec 
				WHERE id_prodspec = :ll_idprodspec;
			END IF
			
			ldec_prix = ld_prix
			
 			INSERT INTO t_produit (NoProduit, NomProduit, NoClasse, PrixUnitaire, PrixUnitaireSP, NoEconomieVolume, CodeHebergeur, Disponible, Special, Actif, codetemporaire, multiplication, alliancematernelle, no_sch )
			VALUES (:ls_no, :ls_nom, 19, :ldec_prix, :ldec_prix, :ll_eco, :ls_aCodeHeb, 1, 0, 0, 0, 0, 0, :ls_souscodeh )
   		USING SQLCA;
			
	   	COMMIT USING SQLCA;
			
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("produit par verrat",ls_no)
			
			w_produit	lw_window_d
			OpenSheet(lw_window_d, gnv_app.of_GetFrame(), 6, layered!)
		END IF
			
	END IF
	
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat", TRUE)
	
END IF

RETURN AncestorReturnValue
end event

event pfc_finddlg;call super::pfc_finddlg;SetPointer(Hourglass!)

THIS.object.datawindow.retrieve.asneeded = FALSE

CALL SUPER::pfc_finddlg
end event

type uo_toolbar from u_cst_toolbarstrip within w_verrats
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2276
integer width = 4617
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Imprimer l'écran"
		long ll_Job

		ll_Job = PrintOpen("Écran", TRUE)
		PrintScreen(ll_Job,1,1,8125,6250)

		PrintClose(ll_Job)	

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Fermer", "Close"		
		Close(parent)
		
//	CASE "Recalcul du nombre de verrats pour les fréquences de récolte"
//		of_recalcul()
		
	CASE "Écrasement"
		of_ecrasement()
		gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat", TRUE)
		
END CHOOSE

end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_verrats
event destroy ( )
string tag = "resize=frbsr"
integer x = 110
integer y = 2096
integer width = 4421
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un produit"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_verrat_produit.SetFocus()		
			dw_verrat_produit.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce produit"
		dw_verrat_produit.event pfc_deleterow()

END CHOOSE

end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_verrats
event destroy ( )
string tag = "resize=frbsr"
integer x = 73
integer y = 1472
integer width = 4503
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un verrat"
		dw_verrat.event pfc_insertrow()
	CASE "Supprimer ce verrat"
		dw_verrat.event pfc_deleterow()
	CASE "Rechercher un verrat..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_verrat.RowCount() > 0 THEN
				dw_verrat.SetRow(1)
				dw_verrat.ScrolltoRow(1)
				dw_verrat.event pfc_finddlg()		
			END IF
		END IF

END CHOOSE

end event

type dw_verrat_produit from u_dw within w_verrats
integer x = 114
integer y = 1632
integer width = 4416
integer height = 464
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_verrat_produit"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_verrat)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("cie_no","cie_no")
this.inv_linkage.of_Register("codeverrat","codeverrat")

SetRowFocusindicator(Hand!)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Produit", TRUE)
END IF

RETURN AncestorReturnValue
end event

type gb_1 from u_gb within w_verrats
integer x = 73
integer y = 1584
integer width = 4507
integer height = 644
integer taborder = 10
long backcolor = 15793151
string text = "Produits associés"
end type

type rr_1 from roundrectangle within w_verrats
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 216
integer width = 4622
integer height = 2044
integer cornerheight = 40
integer cornerwidth = 46
end type

