﻿$PBExportHeader$u_tabpg_eleveur_info.sru
forward
global type u_tabpg_eleveur_info from u_tabpg
end type
type uo_toolbar_haut_gauche from u_cst_toolbarstrip within u_tabpg_eleveur_info
end type
type dw_eleveur_info from u_dw within u_tabpg_eleveur_info
end type
type uo_toolbar_bas from u_cst_toolbarstrip within u_tabpg_eleveur_info
end type
type uo_toolbar_haut_droite from u_cst_toolbarstrip within u_tabpg_eleveur_info
end type
type dw_eleveur_code_hebergeur from u_dw within u_tabpg_eleveur_info
end type
type dw_eleveur_telephone from u_dw within u_tabpg_eleveur_info
end type
end forward

global type u_tabpg_eleveur_info from u_tabpg
integer width = 4425
integer height = 1896
long backcolor = 15793151
uo_toolbar_haut_gauche uo_toolbar_haut_gauche
dw_eleveur_info dw_eleveur_info
uo_toolbar_bas uo_toolbar_bas
uo_toolbar_haut_droite uo_toolbar_haut_droite
dw_eleveur_code_hebergeur dw_eleveur_code_hebergeur
dw_eleveur_telephone dw_eleveur_telephone
end type
global u_tabpg_eleveur_info u_tabpg_eleveur_info

type variables
boolean	ib_ModifEleveurCodeHebergeur = FALSE
end variables

forward prototypes
public function integer of_recupererprochainnumero ()
public function integer of_recupererprochainnumerotel ()
end prototypes

public function integer of_recupererprochainnumero ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumero
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
//	2007-10-19	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(no_eleveur) + 1
INTO		:ll_no
FROM		t_eleveur
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

public function integer of_recupererprochainnumerotel ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumerotel
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
//	2008-11-12	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(compteurtel) + 1
INTO		:ll_no
FROM		t_eleveur_tel
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on u_tabpg_eleveur_info.create
int iCurrent
call super::create
this.uo_toolbar_haut_gauche=create uo_toolbar_haut_gauche
this.dw_eleveur_info=create dw_eleveur_info
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar_haut_droite=create uo_toolbar_haut_droite
this.dw_eleveur_code_hebergeur=create dw_eleveur_code_hebergeur
this.dw_eleveur_telephone=create dw_eleveur_telephone
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar_haut_gauche
this.Control[iCurrent+2]=this.dw_eleveur_info
this.Control[iCurrent+3]=this.uo_toolbar_bas
this.Control[iCurrent+4]=this.uo_toolbar_haut_droite
this.Control[iCurrent+5]=this.dw_eleveur_code_hebergeur
this.Control[iCurrent+6]=this.dw_eleveur_telephone
end on

on u_tabpg_eleveur_info.destroy
call super::destroy
destroy(this.uo_toolbar_haut_gauche)
destroy(this.dw_eleveur_info)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar_haut_droite)
destroy(this.dw_eleveur_code_hebergeur)
destroy(this.dw_eleveur_telephone)
end on

type uo_toolbar_haut_gauche from u_cst_toolbarstrip within u_tabpg_eleveur_info
event destroy ( )
string tag = "resize=frbsr"
integer x = 87
integer y = 1764
integer width = 1545
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_haut_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un téléphone"
		dw_eleveur_telephone.event pfc_insertrow()
	CASE "Supprimer un téléphone"
		dw_eleveur_telephone.event pfc_deleterow()
		
END CHOOSE
end event

type dw_eleveur_info from u_dw within u_tabpg_eleveur_info
integer y = 8
integer width = 4411
integer height = 1892
integer taborder = 10
string dataobject = "d_eleveur_info"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

end event

event pfc_retrieve;call super::pfc_retrieve;long		ll_rtn, ll_groupe, ll_newrow, ll_null

setnull(ll_groupe)
setnull(ll_null)

//Retrieve de la dddw
dataWindowChild ldwc_groupe, ldwc_groupes

THIS.GetChild('groupesecondaire', ldwc_groupe)
ldwc_groupe.setTransObject(SQLCA)
ll_rtn = ldwc_groupe.retrieve(ll_groupe)
ll_newrow = ldwc_groupe.insertrow(1)
ldwc_groupe.setitem( 1, "idgroupsecondaire", ll_null)	

THIS.GetChild('groupe', ldwc_groupes)
ldwc_groupes.setTransObject(SQLCA)
ldwc_groupes.setFilter("isnull( actif ) or actif = 1")
ll_rtn = ldwc_groupes.retrieve()

RETURN THIS.retrieve()
end event

event rowfocuschanged;call super::rowfocuschanged;long		ll_rtn, ll_groupe, ll_newrow, ll_null

setnull(ll_groupe)
SetNull(ll_null)

//Retrieve de la dddw
dataWindowChild ldwc_groupes, ldwc_groupe

IF currentrow > 0 THEN
	
	SetNull(ll_groupe)
	
	ll_groupe = THIS.object.groupe[currentrow]
	
	THIS.GetChild('groupesecondaire', ldwc_groupes)
	ldwc_groupes.setTransObject(SQLCA)
	ldwc_groupes.retrieve(ll_groupe)
	ll_newrow = ldwc_groupes.insertrow(1)
	ldwc_groupes.setitem( 1, "idgroupsecondaire", ll_null)	
	
END IF
end event

event itemchanged;call super::itemchanged;long	ll_rtn, ll_groupe, ll_null, ll_newrow
date	ld_null, ld_renouv

w_eleveur	lw_parent

lw_parent = THIS.of_getfenetreparent( )

setnull(ld_null)
setnull(ll_null)

CHOOSE CASE dwo.name
	
	CASE "daterenouvellement"
		IF IsNull(data) THEN
			THIS.object.plivrgratuit[row] = 0
		END IF
		
	CASE "secteur_transporteur"
		IF long(data) = 7 THEN
			THIS.object.codetransport[row] = "LV"
		ELSE
			THIS.object.codetransport[row] = "LMAI"
		END IF
		
	CASE "groupe"
		datawindowchild	ldwc_groupe
		SetNull(ll_groupe)
		
		ll_groupe = long(data)
		
		THIS.GetChild('groupesecondaire', ldwc_groupe)
		ldwc_groupe.setTransObject(SQLCA)
		ldwc_groupe.retrieve(ll_groupe)
		ll_newrow = ldwc_groupe.insertrow(1)
		ldwc_groupe.setitem( 1, "idgroupsecondaire", ll_null)	
	
		//Mettre le sous-groupe à null
		THIS.object.groupesecondaire[row] = ll_null
		
	CASE "plivrgratuit"
		
		IF long(data) = 1 THEN
			//Ramasser le 1er du mois
			ld_renouv = relativedate(today(), - Day(today()))
			
			THIS.object.daterenouvellement[row] = ld_renouv
			THIS.object.dateannulation[row] = ld_null
			THIS.object.livgratuiteannee[row] = lw_parent.il_lgannee
			THIS.object.livgratuitemois[row] = lw_parent.il_lgmois			
		ELSE
			THIS.object.dateannulation[row] = today()
			THIS.object.livgratuiteannee[row] = ll_null
			THIS.object.livgratuitemois[row] = ll_null
		END IF

 	CASE "plivrgratuittot"
		
		IF long(data) = 1 THEN
			//Ramasser le 1er du mois
			ld_renouv = relativedate(today(), - Day(today()))
			
			THIS.object.daterenouvellement[row] = ld_renouv
			THIS.object.dateannulation[row] = ld_null
			THIS.object.livgratuiteannee[row] = lw_parent.il_lgannee_tot
			THIS.object.livgratuitemois[row] = lw_parent.il_lgmois_tot		
		ELSE
			THIS.object.dateannulation[row] = today()
			THIS.object.livgratuiteannee[row] = ll_null
			THIS.object.livgratuitemois[row] = ll_null
		END IF

END CHOOSE
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	string	ls_cie
	w_eleveur	lw_parent

	lw_parent = THIS.of_getfenetreparent( )

	//Pousser les valeurs de la clé primaire
	ls_cie = gnv_app.of_getcompagniedefaut()
	
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.no_eleveur[AncestorReturnValue] = ll_no
	
	THIS.object.cie_no[AncestorReturnValue] = ls_cie
	
	THIS.object.nbre_jrs[AncestorReturnValue] = lw_parent.il_nbjours
	THIS.object.taux_int[AncestorReturnValue] = lw_parent.idec_tinteret
	
END IF


RETURN AncestorReturnValue
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue <> PREVENT_ACTION THEN
	
	long	ll_eleveur, ll_cur_eleveur, ll_row
	ll_row = THIS.GetRow()
	IF ll_row > 0 THEN
		//Vérifier s'il y a des commandes pour l'éleveur
		ll_cur_eleveur = THIS.object.no_eleveur[ll_row]
		
		SELECT 	no_eleveur 
		INTO 		:ll_eleveur
		from 		t_commande
		WHERE 	no_eleveur = :ll_cur_eleveur
		USING 	SQLCA;
		
		IF not isnull(ll_eleveur) AND ll_eleveur > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0047")
			RETURN PREVENT_ACTION
		END IF
		
		//Vérifier s'il y a des commandes récursives pour l'éleveur
		SetNull(ll_eleveur)
		
		SELECT 	no_eleveur 
		INTO 		:ll_eleveur
		from 		t_commanderepetitive
		WHERE 	no_eleveur = :ll_cur_eleveur
		USING 	SQLCA;
		
		IF not isnull(ll_eleveur) AND ll_eleveur > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0048")
			RETURN PREVENT_ACTION
		END IF		

		//Vérifier s'il y a des commandes statistiques pour l'éleveur
		SetNull(ll_eleveur)
		
		SELECT 	no_eleveur 
		INTO 		:ll_eleveur
		from 		t_statfacture
		WHERE 	no_eleveur = :ll_cur_eleveur
		USING 	SQLCA;
		
		IF not isnull(ll_eleveur) AND ll_eleveur > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0048")
			RETURN PREVENT_ACTION
		END IF		


	END IF

END IF
		
RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_row, ll_chk, ll_nbgratuite_mois, ll_nbgratuite_annee, ll_no_eleveur
datetime	ldt_null

ll_row  = THIS.GetRow()
SetNull(ldt_null)

IF ll_row > 0 THEN
	//Si les livraisons gratuites sont cochées, il faut que le nombre de livraisons soit spécifié
	ll_chk = THIS.object.plivrgratuit[ll_row]
	
	IF ll_chk = 1 THEN
		ll_nbgratuite_mois = THIS.object.livgratuitemois[ll_row]
		ll_nbgratuite_annee = THIS.object.livgratuiteannee[ll_row]
		
		IF isnull(ll_nbgratuite_annee) OR ll_nbgratuite_annee = 0 THEN
			gnv_app.inv_error.of_message("CIPQ0050")
			THIS.SetColumn("livgratuiteannee")
			RETURN FAILURE
		END IF

		IF isnull(ll_nbgratuite_mois) OR ll_nbgratuite_mois = 0 THEN
			gnv_app.inv_error.of_message("CIPQ0051")
			THIS.SetColumn("livgratuitemois")
			RETURN FAILURE
		END IF
		
	END IF
	
	//Mettre la date de transfert à null
	THIS.object.transdate[ll_row] = ldt_null
	
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_eleveur", TRUE)
	
END IF


RETURN ancestorreturnvalue
end event

event pfc_postupdate;call super::pfc_postupdate;IF AncestorReturnValue > 0 THEN

	long	ll_no_eleveur, ll_row
	
	ll_row = THIS.GetRow()
	
	IF ll_row > 0 THEN
		//Vérifier si les code d'hébergeur ont changé
		IF ib_ModifEleveurCodeHebergeur = TRUE THEN
			//Demander s'il veulent imprimer l'avis
			IF gnv_app.inv_error.of_message("CIPQ0052") = 1  THEN
				
				w_r_avis_modification_eleveur	lw_window_d
				
				ll_no_eleveur = THIS.object.no_eleveur[ll_row]
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur avis modification", string(ll_no_eleveur))
				OpenSheet(lw_window_d, gnv_app.of_GetFrame(), 6, layered!)
				
			END IF
			
			ib_ModifEleveurCodeHebergeur = FALSE
		END IF
	END IF
END IF

RETURN AncestorReturnValue
end event

event pro_majligneparligne;// Script ajouté pour faire la mise à jour ligne par ligne

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
	IF this.inv_linkage.of_getUpdatesPending() > 0 THEN
		li_retour_update = gnv_app.inv_error.of_message("pfc_dwlinkage_rowchanging")
		
		if li_retour_update = 3 then return FAILURE
		
		if li_retour_update = 2 then
			this.inv_linkage.of_undomodified(true)
			return no_action
		end if
		
		lw_parent = THIS.of_GetFenetreParent()
		li_retour_update = lw_parent.event pfc_save()
		RETURN li_retour_update
	END IF
ELSE
	RETURN FAILURE
END IF

RETURN no_action
end event

type uo_toolbar_bas from u_cst_toolbarstrip within u_tabpg_eleveur_info
event destroy ( )
string tag = "resize=frbsr"
integer x = 50
integer y = 1228
integer width = 4224
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un éleveur"
		dw_eleveur_info.event pfc_insertrow()
	CASE "Supprimer un éleveur"
		dw_eleveur_info.event pfc_deleterow()		
END CHOOSE
end event

type uo_toolbar_haut_droite from u_cst_toolbarstrip within u_tabpg_eleveur_info
event destroy ( )
string tag = "resize=frbsr"
integer x = 1760
integer y = 1764
integer width = 2473
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_haut_droite.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un code"
		dw_eleveur_code_hebergeur.event pfc_insertrow()
		
	CASE "Supprimer un code"
		dw_eleveur_code_hebergeur.event pfc_deleterow()
END CHOOSE
end event

type dw_eleveur_code_hebergeur from u_dw within u_tabpg_eleveur_info
integer x = 1751
integer y = 1404
integer width = 2487
integer height = 356
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_eleveur_code_hebergeur"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_eleveur_info)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("no_eleveur","no_eleveur")

SetRowFocusindicator(Hand!)


//Retrieve de la dddw
dataWindowChild ldwc_sousgroupe
long		ll_rtn, ll_newrow, ll_null
string	ls_null

SetNull(ls_null)
setnull(ll_null)

THIS.GetChild('groupesecondaire', ldwc_sousgroupe)
ldwc_sousgroupe.setTransObject(SQLCA)
ll_rtn = ldwc_sousgroupe.retrieve(ls_null)

THIS.GetChild('groupesecondaire_1', ldwc_sousgroupe)
ldwc_sousgroupe.setTransObject(SQLCA)
ll_rtn = ldwc_sousgroupe.retrieve(ls_null)
end event

event itemchanged;call super::itemchanged;ib_ModifEleveurCodeHebergeur = TRUE

IF row > 0 THEN
	IF dwo.name = "codehebergeur" THEN
		//Retrieve de la dddw
		dataWindowChild ldwc_sousgroupe
		long		ll_rtn
		
		THIS.GetChild('groupesecondaire', ldwc_sousgroupe)
		ldwc_sousgroupe.setTransObject(SQLCA)
		ll_rtn = ldwc_sousgroupe.retrieve(data)
	END IF
	
END IF
end event

event pfc_insertrow;call super::pfc_insertrow;ib_ModifEleveurCodeHebergeur = TRUE

RETURN AncestorReturnValue
end event

event pfc_deleterow;call super::pfc_deleterow;ib_ModifEleveurCodeHebergeur = TRUE

RETURN AncestorReturnValue
end event

event rowfocuschanged;call super::rowfocuschanged;
If currentrow > 0 THEN
	//Retrieve de la dddw
	dataWindowChild ldwc_sousgroupe
	long		ll_rtn
	string	ls_code, ls_null
	
	setnull(ls_null)
	
	ls_code = dw_eleveur_code_hebergeur.object.codehebergeur[currentrow]
	IF Not IsNull(ls_code) THEN
		THIS.GetChild('groupesecondaire', ldwc_sousgroupe)
		ldwc_sousgroupe.setTransObject(SQLCA)
		//Null pour que ca retrieve tous
		ll_rtn = ldwc_sousgroupe.retrieve(ls_code)
	END IF
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;
IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Eleveur_CodeHebergeur", TRUE)
END IF

RETURN AncestorReturnValue
end event

event retrieveend;call super::retrieveend;if rowcount > 0 then this.event rowFocusChanged(1)

end event

event clicked;call super::clicked;string ls_codehebergeur
long ll_eleveur

if dwo.name = 'b_detail' then
	ls_codehebergeur = this.getItemString(row,'codehebergeur')
	ll_eleveur = dw_eleveur_info.getItemNumber(dw_eleveur_info.getrow(),'no_eleveur')
	gnv_app.inv_entrepotglobal.of_ajoutedonnee('noeleveur',ll_eleveur)
	openwithparm(w_codehebdet,ls_codehebergeur)
end if
end event

type dw_eleveur_telephone from u_dw within u_tabpg_eleveur_info
integer x = 87
integer y = 1404
integer width = 1545
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_eleveur_telephone"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_eleveur_info)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("no_eleveur","no_eleveur")

SetRowFocusindicator(Hand!)
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumerotel()
	THIS.object.compteurtel[AncestorReturnValue] = ll_no
	
END IF


RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;
IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_eleveur_tel", TRUE)
END IF

RETURN AncestorReturnValue
end event
