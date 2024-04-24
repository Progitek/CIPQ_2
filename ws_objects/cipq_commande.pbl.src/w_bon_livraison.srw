$PBExportHeader$w_bon_livraison.srw
forward
global type w_bon_livraison from w_sheet_frame
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_bon_livraison
end type
type uo_fin from u_cst_toolbarstrip within w_bon_livraison
end type
type dw_bon_commande from u_dw within w_bon_livraison
end type
type gb_1 from groupbox within w_bon_livraison
end type
type rr_1 from roundrectangle within w_bon_livraison
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_bon_livraison
end type
type dw_bon_commande_item from u_dw within w_bon_livraison
end type
end forward

global type w_bon_livraison from w_sheet_frame
string tag = "menu=m_saisiedunbondelivraisonpourfacturation"
string title = "Bon de livraison pour facturation"
string menuname = "m_bon_livraison_facturation"
uo_toolbar_bas uo_toolbar_bas
uo_fin uo_fin
dw_bon_commande dw_bon_commande
gb_1 gb_1
rr_1 rr_1
uo_toolbar_haut uo_toolbar_haut
dw_bon_commande_item dw_bon_commande_item
end type
global w_bon_livraison w_bon_livraison

type variables
boolean	ib_insertion_temp = FALSE
string	is_sql_original_dddw = ""
end variables

forward prototypes
public subroutine of_afficherclient (long al_client)
public subroutine of_setcodetransport (string as_code_transport)
public function integer of_changer_client (long al_no_client, long al_row)
public function long of_recupererprochainnumero (string as_cie)
public function long of_recupererprochainnumeroitem ()
public function integer of_livraison_sans_produit ()
end prototypes

public subroutine of_afficherclient (long al_client);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_afficherclient
//
//	Accès:  			Public
//
//	Argument:		al_client - no du client
//
//	Retourne:  		Rien
//
// Description:	Fonction pour afficher les informations clients
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-10-16	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
n_ds		lds_eleveur
long		ll_nbrow, ll_noeleveur, ll_livr, ll_transp, ll_row, ll_gedis, ll_hors, ll_null
string	ls_texte, ls_msg, ls_adresse, ls_ville, ls_code, ls_conte, ls_tel, ls_codetrans, ls_RepId, &
			ls_cie, ls_nomrep, ls_null, ls_regagr

ll_noeleveur = al_client
ls_cie = gnv_app.of_getcompagniedefaut()

SetNull(ll_null)
SetNull(ls_null)

lds_eleveur = CREATE n_ds

lds_eleveur.dataobject = "ds_eleveur"
lds_eleveur.of_setTransobject(SQLCA)
ll_nbrow = lds_eleveur.Retrieve(ll_noeleveur)

ll_row = dw_bon_commande.GetRow()

IF ll_nbrow > 0 THEN
	
	//Afficher le message d'avertissement
	ll_livr = lds_eleveur.object.livraisonspecial[ll_nbrow]
	IF ll_livr = 1 THEN
		ls_msg = trim(lds_eleveur.object.livraisonspecialmsg[ll_nbrow])
		
		//Ne pas afficher le message
		IF IsNull(ls_msg) OR ls_msg = "" THEN
			//gnv_app.inv_error.of_message("CIPQ0041")
		ELSE
			//gnv_app.inv_error.POST of_message("CIPQ0042", {ls_msg})
			dw_bon_commande.object.t_livraison.visible = TRUE
			ls_msg = gnv_app.inv_string.of_globalreplace( ls_msg, '"', "'")
			dw_bon_commande.object.t_livraison.text = "Message: " + ls_msg
			dw_bon_commande.object.t_exception.visible = TRUE
		END IF
	ELSE
		dw_bon_commande.object.t_livraison.visible = FALSE
		dw_bon_commande.object.t_exception.visible = FALSE
	END IF
	
	//Bâtir la string du client
	ls_adresse = trim(lds_eleveur.object.liv_adr_a[ll_nbrow])
	IF IsNull(ls_adresse) OR ls_adresse = "" THEN
		
		//Bâtir l'Adresse
		ls_adresse = trim(lds_eleveur.object.adresse[ll_nbrow])
		If Not IsNull(ls_adresse) and ls_adresse <> "" THEN
			ls_adresse += ", "
		END IF
		ls_texte = ls_adresse
		
		ls_adresse = trim(lds_eleveur.object.rue[ll_nbrow])
		IF IsNull(ls_adresse) THEN ls_adresse = ""
		
		ls_texte = ls_texte + ls_adresse
		
	ELSE
		
		ls_texte = ls_adresse
	END IF
	
	ls_ville = trim(lds_eleveur.object.liv_vil_a[ll_nbrow])
	If IsNull(ls_ville) OR ls_ville = "" THEN
		ls_ville = trim(lds_eleveur.object.ville[ll_nbrow])
		IF IsNull(ls_ville) THEN ls_ville = ""
	END IF
	ls_texte = ls_texte + "~r~n" + ls_ville
	
	ls_conte = trim(lds_eleveur.object.liv_conte[ll_nbrow])
	If IsNull(ls_conte) OR ls_conte = "" THEN
		ls_conte = trim(lds_eleveur.object.conte[ll_nbrow])
		IF IsNull(ls_conte) THEN ls_conte = ""
	END IF
	ls_texte = ls_texte + "~r~n" + ls_conte
	
	ls_code = trim(lds_eleveur.object.liv_cod_a[ll_nbrow])
	If IsNull(ls_code) OR ls_code = "" THEN
		ls_code = trim(lds_eleveur.object.code_post[ll_nbrow])
		IF IsNull(ls_code) THEN ls_code = ""
	END IF
	IF LEN(ls_code) >= 6 THEN
		ls_code = LEFT(ls_code, 3) + " " + RIGHT(ls_code,3)
	END IF		
	ls_texte = ls_texte + "~r~n" + ls_code 
	
	ls_tel = trim(lds_eleveur.object.liv_tel_a[ll_nbrow])
	If IsNull(ls_tel) OR ls_tel = "" THEN
		ls_tel = trim(lds_eleveur.object.telephone[ll_nbrow])
		IF IsNull(ls_tel) THEN ls_tel = ""
	END IF
	IF LEN(ls_tel) >= 10 THEN
		ls_tel = "(" + LEFT(ls_tel, 3) + ") " + MID(ls_tel,4,3) + "-" + MID(ls_tel,7,4)
	END IF
	ls_texte = ls_texte + "~r~n" + ls_tel				
	
	dw_bon_commande.object.cc_client[ll_row] = ls_texte
	
	//Transporteur
	ll_transp = lds_eleveur.object.liv_notran[ll_nbrow]
	If IsNull(ll_transp) OR ll_transp = 0 THEN
		ll_transp = lds_eleveur.object.secteur_transporteur[ll_nbrow]
		IF IsNull(ll_transp) THEN ll_transp = 0
	END IF
	dw_bon_commande.object.idtransporteur[ll_row] = ll_transp
	//OLD
	//dw_bon_commande.object.cc_transporteur[ll_row] = ll_transp
	
	//Code de transport
	ls_codetrans = trim(lds_eleveur.object.codetransport[ll_nbrow])
	dw_bon_commande.object.cc_codetransport[ll_row] = ls_codetrans
	//OLD
	//dw_bon_commande.object.codetransport[ll_row] = ls_codetrans
	
	//Mettre la région agricole
	ls_regagr = lds_eleveur.object.reg_agr[ll_nbrow]
	dw_bon_commande.object.reg_agr[ll_row] = ls_regagr
	
	//Formation gedis
	ll_gedis = lds_eleveur.object.formationgedis[ll_nbrow]
	IF ll_gedis = 1 THEN
		dw_bon_commande.object.cc_gedis[ll_row] = 1
	ELSE
		dw_bon_commande.object.cc_gedis[ll_row] = 0
	END IF
	
	of_setcodetransport(ls_codetrans)
	
	// TO DO
	//D'où vient ce putain de champ???		
	//Me.chkHorQue = myrec("HOR-QU")
	
	ls_RepId = trim(lds_eleveur.object.id_rep[ll_nbrow])
	
	//Ajout du texte du représentant
	SELECT	non_rep
	INTO 		:ls_nomrep 
	FROM 		t_Eleveur_Rep
	WHERE 	Id_Rep = :ls_repid
	USING 	SQLCA;
	
	dw_bon_commande.object.t_rep.text = ls_nomrep
	
	//chkhorsque
	ll_hors = lds_eleveur.object.t_regionagri_hor_qu[ll_nbrow]
	IF ll_hors = 1 THEN
		dw_bon_commande.object.chkhorque[ll_row] = 1
	ELSE
		dw_bon_commande.object.chkhorque[ll_row] = 0
	END IF
	
ELSE
	//Mettre tout à null
	dw_bon_commande.object.t_livraison.visible = FALSE
	dw_bon_commande.object.t_livraison.text = ""
	dw_bon_commande.object.t_exception.visible = FALSE
	
	//dw_bon_commande.object.t_prix.text = ""
	dw_bon_commande.object.t_codetransport.text = ""
	
	dw_bon_commande.object.cc_client[ll_row] = ""
	
	dw_bon_commande.object.cc_gedis[ll_row] = 0
	
	dw_bon_commande.object.idtransporteur[ll_row] = ll_null
	dw_bon_commande.object.cc_codetransport[ll_row] = ls_null
	//dw_bon_commande.object.cc_transporteur[ll_row] = ll_null
	//dw_bon_commande.object.codetransport[ll_row] = ls_null
	
	dw_bon_commande.object.t_rep.text = ""
	dw_bon_commande.object.chkhorque[ll_row] = 0
	
END IF
end subroutine

public subroutine of_setcodetransport (string as_code_transport);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_setcodetransport
//
//	Accès:  			Public
//
//	Argument:		code de transport
//
//	Retourne:  		Rien
//
// Description:	Fonction pour retrouver les valeurs des codes et des prix
//						en fonction du code
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-10-15	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

datawindowchild 	ldwc_codetransport

decimal		ldec_prix
long			ll_row_dwc, ll_row
string		ls_trans

dw_bon_commande.AcceptText()

ll_row = dw_bon_commande.GetRow()
dw_bon_commande.GetChild('cc_codetransport', ldwc_codetransport)
ldwc_codetransport.setTransObject(SQLCA)

ll_row_dwc = ldwc_codetransport.Find("codetransport = '" + as_code_transport + "'", 1, ldwc_codetransport.RowCount())
IF ll_row_dwc > 0 THEN
	ls_trans = ldwc_codetransport.GetItemString(ll_row_dwc,"codetransport")
	ldec_prix = ldwc_codetransport.GetItemDecimal(ll_row_dwc,"prix")
	
	//dw_bon_commande.object.t_prix.text = string(ldec_prix, "#,##0.00 $; (#,##0.00 $)")
	dw_bon_commande.object.t_codetransport.text = ls_trans
	
	IF ls_trans = "LC" OR ls_trans = "LSPE" OR ls_trans = "LP" OR ls_trans = "LV" THEN
		dw_bon_commande.object.ampm[ll_row] = "AM"
	ELSE
		dw_bon_commande.object.ampm[ll_row] = "PM"
	END IF
	
	//Checker le dicom
	IF ls_trans = "LV" THEN
		dw_bon_commande.object.dicom[ll_row] = 1
	ELSE
		dw_bon_commande.object.dicom[ll_row] = 0
	END IF
	
ELSE
	//dw_commande.object.t_prix.text = ""
	dw_bon_commande.object.t_codetransport.text = ""

END IF
end subroutine

public function integer of_changer_client (long al_no_client, long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_changerclient
//
//	Accès:  			Public
//
//	Argument:		no client
//						row
//
//	Retourne:  		Integer
//
// Description:	Fonction appelée quand la dddw client est changée
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-09	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

//Charger les informations de ce client
long		ll_noeleveur
string	ls_cie

IF ib_insertion_temp THEN RETURN 0

ll_noeleveur = al_no_client

THIS.of_afficherclient( ll_noeleveur)
ls_cie = gnv_app.of_getcompagniedefaut()

dw_bon_commande.AcceptText()

//Charger les items - requery
dw_bon_commande_item.event pfc_retrieve()

RETURN 1
end function

public function long of_recupererprochainnumero (string as_cie);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainno
//
//	Accès:  			Public
//
//	Argument:		String - Nom du centre
//
//	Retourne:  		Prochain no de commande
//
// Description:	Fonction pour le prochain no de commande
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-10-15	Mathieu Gendron	Création
// 2008-11-03	Mathieu Gendron	Modification de la façon de faire
//
//////////////////////////////////////////////////////////////////////////////

long		ll_no, ll_retour
//n_ds		lds_no_auto
//
//lds_no_auto = CREATE n_ds
//lds_no_auto.Dataobject = "ds_statfacture_no_auto"
//lds_no_auto.of_settransobject(SQLCA)
//
//ll_retour = lds_no_auto.Retrieve(as_cie)
//IF ll_retour > 0 THEN
//	ll_no = lds_no_auto.object.cc_maximum[1]
//	IF IsNull(ll_no) OR ll_no = 0 THEN ll_no = 1
//ELSE
//	ll_no = 1
//END IF
//
//IF IsValid(lds_no_auto) THEN Destroy(lds_no_auto)

ll_no = gnv_app.of_getnextlivno("110")

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

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
for ll_row = 1 to dw_bon_commande_item.rowCount()
	if lb_produit_pg1 then exit
	
	ls_noproduit = dw_bon_commande_item.object.prod_no[ll_row]

	// 2010-07-13 - Sébastien - On ne valide plus la quantité
//	ll_qte = dw_bon_commande_item.object.qte_exp[ll_row]
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

on w_bon_livraison.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_bon_livraison_facturation" then this.MenuID = create m_bon_livraison_facturation
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_fin=create uo_fin
this.dw_bon_commande=create dw_bon_commande
this.gb_1=create gb_1
this.rr_1=create rr_1
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_bon_commande_item=create dw_bon_commande_item
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar_bas
this.Control[iCurrent+2]=this.uo_fin
this.Control[iCurrent+3]=this.dw_bon_commande
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.rr_1
this.Control[iCurrent+6]=this.uo_toolbar_haut
this.Control[iCurrent+7]=this.dw_bon_commande_item
end on

on w_bon_livraison.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar_bas)
destroy(this.uo_fin)
destroy(this.dw_bon_commande)
destroy(this.gb_1)
destroy(this.rr_1)
destroy(this.uo_toolbar_haut)
destroy(this.dw_bon_commande_item)
end on

event open;call super::open;ib_insertion_temp = TRUE
dw_bon_commande.event pfc_insertrow()
dw_bon_commande.SetFocus()
ib_insertion_temp = FALSE


uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un item", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer cet item", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un bon", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_displaytext(true)

uo_fin.of_settheme("classic")
uo_fin.of_DisplayBorder(true)
uo_fin.of_AddItem("Enregistrer et imprimer", "Save!")
uo_fin.of_AddItem("Fermer", "Exit!")
uo_fin.of_displaytext(true)

end event

type st_title from w_sheet_frame`st_title within w_bon_livraison
integer x = 215
integer y = 44
integer width = 1239
string text = "Bon de livraison pour facturation"
end type

type p_8 from w_sheet_frame`p_8 within w_bon_livraison
integer x = 55
integer y = 40
integer width = 101
integer height = 84
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\bons.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_bon_livraison
integer y = 24
integer height = 112
end type

type uo_toolbar_bas from u_cst_toolbarstrip within w_bon_livraison
event destroy ( )
string tag = "resize=frbsr"
integer x = 123
integer y = 2016
integer width = 4261
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un item"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_bon_commande_item.SetFocus()		
			dw_bon_commande_item.event pfc_insertrow()
		END IF
		
	CASE "Supprimer cet item"
		dw_bon_commande_item.event pfc_deleterow()

END CHOOSE

end event

type uo_fin from u_cst_toolbarstrip within w_bon_livraison
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

event ue_buttonclicked;call super::ue_buttonclicked;long		ll_row, ll_nb_ligne
string	ls_bon, ls_client, ls_cie

CHOOSE CASE as_button

	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Enregistrer et imprimer"
		
		IF PARENT.event pfc_save() >= 0 THEN
			if of_livraison_sans_produit() = 2 then return
			
			ll_row = dw_bon_commande.GetRow()
			
			IF ll_row > 0 THEN
				IF dw_bon_commande_item.RowCount() = 0 THEN
					gnv_app.inv_error.of_message("CIPQ0069")
					RETURN
				END IF
				
				ls_bon = dw_bon_commande.object.liv_no[ll_row]
				gnv_app.inv_error.of_message("CIPQ0071",{ls_bon})
				ls_cie = dw_bon_commande.object.cie_no[ll_row]
				ls_client = dw_bon_commande.object.cc_client[ll_row]
				
				//Ouvrir le rapport
				//w_r_bon_commande	lw_fen
				n_ds	lds_bon
				
				lds_bon = CREATE n_ds
				lds_bon.dataobject = "d_r_bon_commande"
				lds_bon.of_setTransobject(SQLCA)
				ll_nb_ligne = lds_bon.Retrieve(ls_cie, ls_bon)

				IF ll_nb_ligne > 0 THEN
					lds_bon.object.cc_client[1] = ls_client
				END IF
				
				lds_bon.Print(FALSE,FALSE)
				
				//gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien bon cie", ls_cie)
				//gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien bon liv", ls_bon)
				//gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien bon client", ls_client)
				//OpenSheet(lw_fen, gnv_app.of_GetFrame(), 6, layered!)

				IF IsValid(lds_bon) THEN DESTROY lds_bon
				
				dw_bon_commande.Post Event pfc_insertrow()
				dw_bon_commande.Post setfocus()
				
			END IF
	
		END IF
		
END CHOOSE
end event

type dw_bon_commande from u_dw within w_bon_livraison
event ue_processenter pbm_dwnprocessenter
integer x = 59
integer y = 176
integer width = 4466
integer height = 1096
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_bon_commande"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)

THIS.of_setpremierecolonneinsertion("liv_date")
end event

event pfc_insertrow;call super::pfc_insertrow;
IF AncestorReturnValue > 0 THEN
	THIS.object.cie_no[AncestorReturnValue] = "110"
	//THIS.object.liv_date[AncestorReturnValue] = date(today())
END IF

RETURN AncestorReturnValue
end event

event buttonclicked;call super::buttonclicked;long	ll_eleveur

CHOOSE CASE dwo.name
		
	CASE "b_code"
		
		w_eleveur_codehebergeur	lw_wind
		ll_eleveur = THIS.object.no_eleveur[row]
		
		IF not isnull(ll_eleveur) AND ll_eleveur > 0 THEN
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur code hebergeur", string(ll_eleveur))
			Open(lw_wind)
		END IF
		
	
	CASE "b_recherche"
		w_eleveur_rech	lw_wind_rech
		long	ll_no_eleveur

		//Vérifier s'il y a des items
		IF dw_bon_commande_item.RowCount() > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0043")
			RETURN 
		END IF
		
		IF ib_en_insertion THEN
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "oui")
		ELSE
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "non")
		END IF
		
		Open(lw_wind_rech)
		
		ll_no_eleveur = long(gnv_app.inv_entrepotglobal.of_retournedonnee("retour eleveur rech"))
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("insertion eleveur rech", "")
		
		IF not isnull(ll_no_eleveur) AND ll_no_eleveur > 0 THEN
			dw_bon_commande.object.no_eleveur[row] = ll_no_eleveur
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour eleveur rech", "")
			
			parent.of_changer_client(ll_no_eleveur,row)
		END IF
		
END CHOOSE
end event

event itemchanged;call super::itemchanged;long	ll_null

SetNull(ll_null)

Choose case dwo.name
	
	CASE "no_eleveur"
		
		long	ll_no_eleveur_old
		
		ll_no_eleveur_old = THIS.object.no_eleveur[row]
		
		//On peut changer le client sauf quand il y a des items de facturation
		IF dw_bon_commande_item.RowCount() > 0 THEN
			gnv_app.inv_error.of_message("CIPQ0056")
			THIS.object.no_eleveur[row] = ll_no_eleveur_old
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 2
		END IF
			
		//Vérifier si le no du client est dans la liste
		Datawindowchild	ldwc_eleveur
		long	ll_rowdddw
		
		THIS.GetChild('no_eleveur', ldwc_eleveur)
		ldwc_eleveur.setTransObject(SQLCA)
		ll_rowdddw = ldwc_eleveur.Find("no_eleveur = " + data , 1, ldwc_eleveur.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw = 0 THEN		
			gnv_app.inv_error.of_message("PRO0011")
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.SetColumn("no_eleveur")
			SetText("")
			RETURN 1
		END IF
		
		//Charger les informations de ce client
		long		ll_noeleveur
		
		IF Not IsNull(data) AND data <> "" THEN
			ll_noeleveur = long(data)
			parent.of_changer_client(ll_noeleveur,row)
		END IF
		
	case "liv_date"
		// 2009-03-09 Sébastien Tremblay - Empêcher de créer ou de modifier un bon avant la date de la dernière facturation
		datetime ldt_derniere_fact
		
		select 	max(fact_date)
		into		:ldt_derniere_fact
		from 		t_statfacture 
		where 	fact_date is not null;
		
		if date(data) <= date(ldt_derniere_fact) then
			gnv_app.inv_error.of_message("CIPQ0129", {string(relativedate(date(ldt_derniere_fact), 1))})
			return 1
		end if
		
END CHOOSE


end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_cie, ls_commande
long		ll_noeleveur

IF CurrentRow > 0 THEN
	
	ls_cie = THIS.object.cie_no[currentrow]
	ls_commande = THIS.object.liv_no[currentrow]
	
	IF ib_en_insertion = FALSE THEN
		//Charger les informations de ce client
		ll_noeleveur = THIS.object.no_eleveur[currentrow]
		IF Not IsNull(ll_noeleveur) AND ll_noeleveur <> 0 THEN
			parent.of_changer_client(ll_noeleveur, currentrow)
		END IF
	
		dw_bon_commande_item.Retrieve(ls_cie, ls_commande)
		
		dw_bon_commande.Setitemstatus( currentrow, 0, Primary!, NotModified!)
		
	ELSE
		SetNull(ll_noeleveur)
		parent.of_changer_client(ll_noeleveur, currentrow)
	END IF
	
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_row
string	ls_no

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	ls_no = dw_bon_commande.object.liv_no[ll_row]
	IF IsNull(ls_no) THEN
		ls_no = string(of_recupererprochainnumero("110"))
		dw_bon_commande.object.liv_no[ll_row] = ls_no
	END IF
END IF

RETURN AncestorReturnValue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyS!) THEN
		uo_fin.event ue_buttonclicked("Enregistrer")
	END IF
	IF KeyDown(KeyQ!) THEN
		IF parent.event pfc_save() >= 0 THEN
			dw_bon_commande_item.POST EVENT pfc_insertrow()
			dw_bon_commande_item.SetFocus()
		END IF
	END IF	
END IF
end event

event dropdown;call super::dropdown;datawindowchild 	ldwc_client
long					ll_rowdddw, ll_eleveur

IF THIS.GetRow() > 0 THEN
	
	CHOOSE CASE THIS.GetColumnName()
		CASE "no_eleveur"
			
			ll_eleveur = THIS.object.no_eleveur[THIS.GetRow()]

			IF GetChild( "no_eleveur", ldwc_client) = 1 THEN
				  //Sélectionner la rangée
				  ll_rowdddw = ldwc_client.Find("no_eleveur = " + string(ll_eleveur), 1, ldwc_client.RowCount())
				  IF ll_rowdddw > 0 THEN
					  ldwc_client.SetRow(ll_rowdddw)
					  ldwc_client.ScrollToRow(ll_rowdddw)
				END IF
			END IF
			
	END CHOOSE

END IF
end event

event rowfocuschanging;call super::rowfocuschanging;if getcolumnname() = 'boncommandeclient' then return 1
end event

type gb_1 from groupbox within w_bon_livraison
integer x = 73
integer y = 1264
integer width = 4379
integer height = 900
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Items"
end type

type rr_1 from roundrectangle within w_bon_livraison
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 1073741824
integer x = 23
integer y = 156
integer width = 4549
integer height = 2048
integer cornerheight = 40
integer cornerwidth = 46
end type

type uo_toolbar_haut from u_cst_toolbarstrip within w_bon_livraison
event destroy ( )
string tag = "resize=frbsr"
boolean visible = false
integer x = 123
integer y = 1104
integer width = 4261
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un bon"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_bon_commande.SetFocus()		
			ib_insertion_temp = TRUE
			dw_bon_commande.event pfc_insertrow()
			ib_insertion_temp = FALSE
		END IF

END CHOOSE
end event

type dw_bon_commande_item from u_dw within w_bon_livraison
integer x = 123
integer y = 1352
integer width = 4288
integer height = 660
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_bon_commande_detail"
boolean ib_insertion_a_la_fin = true
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_bon_commande)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("cie_no","cie_no")
this.inv_linkage.of_Register("liv_no","liv_no")

SetRowFocusindicator(Hand!)

THIS.of_setpremierecolonneinsertion("qte_exp")

end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_iddepot, ll_row, ll_no, ll_count, ll_qte
date		ld_dateexpedie
string	ls_codeverrat, ls_noproduit
boolean	lb_produit_pg1 = false

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	//Vérifier que si [Id_Depot] existe, [Date_Expedie_Depot] ne soit pas null
	ll_iddepot = THIS.object.id_depot[ll_row]
	ld_dateexpedie = date(THIS.object.date_expedie_depot[ll_row])
	
	IF Not IsNull(ll_iddepot) AND IsNull(ld_dateexpedie) THEN
		IF gnv_app.inv_error.of_message("CIPQ0070") = 1 THEN 
			RETURN FAILURE
		END IF
	END IF
	
	ll_no = THIS.object.ligne_no[ll_row]
	IF IsNull(ll_no) THEN
		ll_no = PARENT.of_recupererprochainnumeroitem()
		THIS.object.ligne_no[ll_row] = ll_no
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

event itemchanged;call super::itemchanged;string 				ls_desc, ls_null
long					ll_rowdddw, ll_qte
datawindowchild 	ldwc_verrat, ldwc_noproduit
date					ld_cur, ld_unmois
n_cst_datetime		lnv_datetime
SetNull(ls_null)

CHOOSE CASE dwo.name
		
	CASE "qte_exp"
		IF IsNull(data) or data = "" THEN 
			ll_qte = 0
		ELSE
			ll_qte = long(data)
		END IF
		THIS.object.qte_comm[row] = ll_qte
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
			THIS.object.verrat_no[row] = ls_null
			RETURN 1
		END IF
		
		THIS.object.prod_no[row] = ls_null
		
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
			//Vérifier si le focus est dans la zone
			gnv_app.inv_error.of_message("CIPQ0055")
			SetNull(data)
			THIS.object.prod_no[row] = ls_null
			THIS.ib_suppression_message_itemerror = TRUE
			RETURN 1
		END IF
		
		If (Not IsNull(ls_TempValue) AND ls_TempValue <> "") or ls_produit <> data Then
			RETURN 2
		END IF
		
	CASE "id_depot"
		//Vérifier si le depot est dans la liste
		Datawindowchild	ldwc_depot
		
		THIS.GetChild('id_depot', ldwc_depot)
		ldwc_depot.setTransObject(SQLCA)
		ll_rowdddw = ldwc_depot.Find("id_depot = " + data , 1, ldwc_depot.RowCount())		
		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw = 0 THEN		
			gnv_app.inv_error.of_message("PRO0011")
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.SetColumn("id_depot")
			SetText("")
			RETURN 1
		END IF		
		
	CASE "date_expedie_depot"
		
		ld_cur = date(data)
		IF Not IsNull(data) AND data <> "" THEN
			//Vérifier si la date saisie est <= à la date du jour
			IF ld_cur > today() THEN
				Messagebox("Attention", "Il est impossible de spécifier une date plus grande que la date du jour.")
				THIS.ib_suppression_message_itemerror = TRUE
				SetText("")
				RETURN 1
			END IF
			//Vérifier si la date saisie est pas plus vieille qu'un mois
			ld_unmois = lnv_datetime.of_relativemonth( date(today()), -2)
			IF ld_cur < ld_unmois THEN
				Messagebox("Attention", "Il est impossible de spécifier une date plus vieille que deux mois.")
				SetText("")
				THIS.ib_suppression_message_itemerror = TRUE
				RETURN 1
			END IF
			
		END IF	
		
END CHOOSE


end event

event itemfocuschanged;call super::itemfocuschanged;//datawindowchild 	ldwc_verrat, ldwc_noproduit
//string 				ls_select_str, ls_column, ls_rtn, ls_codeverrat
//n_cst_eleveur		lnv_eleveur
//long					ll_row_parent, ll_eleveur
//boolean				lb_gedis = FALSE
//
//IF Row > 0 THEN
//	
//	ll_row_parent = dw_bon_commande.GetRow()
//	
//	ll_eleveur = dw_bon_commande.object.no_eleveur[ll_row_parent]
//	
//	lb_gedis = lnv_eleveur.of_formationgedis(ll_eleveur)	
//	IF isnull(lb_gedis) THEN lb_gedis = FALSE
//
//	CHOOSE CASE dwo.name 
//		CASE "prod_no"
//			
//			ls_codeverrat = THIS.object.verrat_no[row]
//			
//			IF GetChild( "prod_no", ldwc_noproduit ) = 1 THEN
//
//				IF is_sql_original_dddw = "" THEN
//					is_sql_original_dddw = ldwc_noproduit.describe( "DataWindow.Table.Select")
//				END IF
//								
//				If Not IsNull(ls_codeverrat) AND ls_codeverrat <> "" Then
//					//Filtre par no de verrat
//					ls_select_str = "SELECT DISTINCT t_Produit.NoProduit, t_Produit.NomProduit, t_Produit.NoClasse, t_Produit.PrixUnitaire " + &
//						" FROM t_Produit INNER JOIN t_Verrat_Produit ON upper(t_Produit.NoProduit) = upper(t_Verrat_Produit.NoProduit) "
//						
//					If lb_gedis = TRUE Then
//						ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + "'))"
//					Else
//						ls_select_str = ls_select_str + "WHERE ((upper(t_Verrat_Produit.CodeVerrat)='" + upper(ls_codeverrat) + &
//							"') AND ((Right(t_Produit.NoProduit,3))<>'-GS'))"
//					End If				
//							
//				ELSE
//					//Pas de verrat spécifié
//					ls_select_str = gnv_app.of_findsqlproduit( ll_eleveur, FALSE, FALSE)
//					//ls_select_str = is_sql_original_dddw  
//				END IF
//	
//				ls_rtn = ldwc_noproduit.modify( "DataWindow.Table.Select=~"" + ls_select_str + "~"" )
//				
//				//Nouveau retrieve parce que la dddw n'était pas toujours bien chargée
//				ldwc_noproduit.setTransObject(SQLCA)
//				ldwc_noproduit.Retrieve()
//				
//			END IF
//	END CHOOSE
//
//END IF
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

event pro_enter;IF THIS.GetColumnName() = "melange" THEN
	IF parent.event pfc_save() >= 0 THEN
		THIS.POST EVENT pfc_insertrow()
	END IF
ELSE
	CALL SUPER::pro_enter
END IF

end event

event pfc_retrieve;call super::pfc_retrieve;// Pour filtrer la liste de verrats - Sébastien 2008-10-31
// 2010-03-16 - Sébastien - Désactivé, la personne qui fait des modifications ici doit savoir ce qu'elle fait

//datawindowchild ldwc_verrat
//
//if this.getChild("verrat_no", ldwc_verrat) = 1 then
//	return this.event pfc_populatedddw("verrat_no", ldwc_verrat)
//else
//	return -1
//end if

return AncestorReturnValue
end event

event pfc_populatedddw;call super::pfc_populatedddw;if as_colname = 'verrat_no' then
	if dw_bon_commande.getRow() > 0 then
		adwc_obj.setTransObject(SQLCA)
		adwc_obj.setSQLSelect(gnv_app.of_sqllisteverrats(dw_bon_commande.object.no_eleveur[dw_bon_commande.getRow()]))
		return adwc_obj.retrieve()
	else
		adwc_obj.reset()
		return 0
	end if
end if
end event

