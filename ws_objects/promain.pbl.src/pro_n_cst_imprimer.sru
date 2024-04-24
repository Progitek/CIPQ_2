$PBExportHeader$pro_n_cst_imprimer.sru
forward
global type pro_n_cst_imprimer from nonvisualobject
end type
end forward

global type pro_n_cst_imprimer from nonvisualobject
end type
global pro_n_cst_imprimer pro_n_cst_imprimer

type variables
w_master 	iw_requestor
u_dw 			idw_requestor
n_ds 			ids_sp_input

String 		is_titre_original
String 		is_zoomin_cur = "zoomin.cur"
String 		is_zoomout_cur = "zoomout.cur"

Long 			il_zoom_value
Long 			il_firstrowonpage[]
Long 			il_nbpages = 0

Boolean 		ib_StoreProc

end variables

forward prototypes
public subroutine of_apercu ()
public function boolean of_isresetpage ()
public function long of_nopagecourant ()
public subroutine of_populearray ()
public function integer of_setcurseur (long al_value, long al_other_value)
public function integer of_setpage (long al_page)
public function integer of_setrequestor (w_master aw_requestor, u_dw adw_requestor)
public function integer of_setstoreproc (boolean ab_switch)
public subroutine of_zoomclick ()
public subroutine of_zoomvalue ()
public subroutine of_majnopage ()
public function integer of_gopage ()
public function integer of_pagecount ()
end prototypes

public subroutine of_apercu ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_apercu  				
//
//	Accès:  			Public
//
//	Argument:  		aucun
//
//	Retourne:  		Integer
//
//	Description:	Initialise l'apercu 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

Pointer lptr_anc

lptr_anc = SetPointer( Hourglass! )

idw_requestor.inv_PrintPreview.of_SetEnabled( True )

idw_requestor.inv_PrintPreview.of_SetZoom( il_zoom_value )

idw_requestor.Modify( "datawindow.pointer='" + is_zoomout_cur + "'" )

//idw_requestor.Tag = "Visualisation du rapport à l'écran"

THIS.of_majnopage()

SetPointer( lptr_anc )

idw_requestor.SetFocus()
end subroutine

public function boolean of_isresetpage ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode: 		of_isresetpage
//
//	Accès:  			Public
//
//	Argument:		aucun  
//
//	Retourne:  		TRUE - Il s'agit d'un rapport possédant au moins un group avec la
//								 propriété "Reset page number on group break"
//						FALSE - Ne possède aucun groupe de ce type
//
//	Description:	Détecte s'il y a un groupe avec Reset page number
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long		ll_pos_reset

ll_pos_reset = POS(lower(idw_requestor.Object.DataWindow.syntax), "resetpagecount=yes")

IF ll_pos_reset = 0 THEN
	RETURN FALSE
ELSE
	RETURN TRUE
END IF
end function

public function long of_nopagecourant ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_nopagecourant  				
//
//	Accès:  			Public
//
//	Arguments  		Aucun
//
//	Retourne:  		Numéro de la page affichée à l'écran
//
//	Description:	Trouve et retourne le numéro de la page affichée à l'écran.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

String 	ls_first_row_on_page, ls_page_expr, ls_value
Pointer	lptr_anc
Long		ll_first_row_on_page, ll_compteur

ls_first_row_on_page = idw_requestor.Describe("datawindow.firstrowonpage")
ll_first_row_on_page = long(ls_first_row_on_page)

IF THIS.Of_IsResetPage() = FALSE THEN
	
	//Pour les rapports sans reset page number
	ls_page_expr = "evaluate('Page()'," + ls_first_row_on_page + ")"
	ls_value = idw_requestor.Describe( ls_page_expr )

	Return Long( ls_value )
	
ELSE
	
	//Pour les rapports avec reset page number
	IF il_nbpages <> 0 THEN
		FOR ll_compteur = 1 TO il_nbpages

			IF il_firstrowonpage[ll_compteur] = ll_first_row_on_page THEN
				RETURN ll_compteur
			ELSEIF il_firstrowonpage[ll_compteur] > ll_first_row_on_page THEN
				//Se produit seulement après avoir généré un PDF, le nombre de pages
				//pouvant changé étant donné que le marges 
				RETURN ll_compteur
			END IF
			
		NEXT
	ELSE
		RETURN 1
	END IF
			
END IF

RETURN 1
end function

public subroutine of_populearray ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode: 		of_populearray
//
//	Accès:  			Public
//
//	Argument:		aucun  
//
//	Retourne:  		Rien
//
//	Description:	Popule, pour les rapport avec un reset page number on group break,
//						un tableau contenant tous les first row on page et leur numéro de page
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long		ll_nopage, ll_retour, ll_retour_anc, ll_row_initiale, ll_first_row_on_page
pointer	lptr_anc

lptr_anc = SetPointer(Hourglass!)
idw_requestor.SetRedraw(FALSE)

IF THIS.of_IsResetPage() = TRUE THEN

	ll_row_initiale = long(idw_requestor.Describe("datawindow.firstrowonpage"))
	idw_requestor.inv_PrintPreview.of_FirstPage()
	ll_nopage = 1
	il_firstrowonpage[ll_nopage] = ll_row_initiale
	ll_retour_anc = ll_row_initiale
	
	DO WHILE TRUE
		
		ll_retour = idw_requestor.ScrollNextPage()
		
		IF ll_retour = ll_retour_anc THEN EXIT
		
		ll_nopage += 1
		ll_first_row_on_page = long(idw_requestor.Describe("datawindow.firstrowonpage"))
		il_firstrowonpage[ll_nopage] = ll_first_row_on_page
		ll_retour_anc = ll_retour
		
	LOOP
	
	il_nbpages = ll_nopage
	idw_requestor.ScrollToRow(ll_row_initiale)
	
END IF

SetPointer(lptr_anc)
idw_requestor.SetRedraw(TRUE)
end subroutine

public function integer of_setcurseur (long al_value, long al_other_value);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_setcurseur  				
//
//	Accès:  			Public
//
//	Arguments:  	al_value 		- Nouvelle valeur de zoom
//						al_other_value	- Ancienne valeur de zoom
//
//	Retourne:  		-1 erreur de paramètre
//
//	Description:	Affiche le curseur approprié en fonction des valeurs
//						de zoom sélectionnées.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

If isnull(al_value) or isnull(al_other_value) Then
	Return -1
End If

If al_value > al_other_value Then
	idw_requestor.Modify( "datawindow.pointer='" + is_zoomout_cur + "'" )
Else
	idw_requestor.Modify( "datawindow.pointer='" + is_zoomin_cur + "'" )	
End If

Return 1
end function

public function integer of_setpage (long al_page);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_setpage  				
//
//	Accès:  			Public
//
//	Argument:  		al_page - Page pour laquelle on veut changer
//
//	Retourne:  		-1 Erreur de paramètre
//
//	Description:	Cette fonction effectue le changement de page en fonction
// 					du numéro de page reçu en paramêtre.
//	
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long 		ll_boucle
pointer 	lptr_anc

if isnull( al_page) then
	return -1
end if

lptr_anc = SetPointer( Hourglass! )

idw_requestor.inv_PrintPreview.of_FirstPage()

For ll_boucle = 1 to (al_page - 1)
	idw_requestor.ScrollNextPage()
Next

THIS.of_MajNoPage()
SetPointer( lptr_anc )

Return 1
end function

public function integer of_setrequestor (w_master aw_requestor, u_dw adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_SetRequestor
//
//	Accès:  			Public
//
//	Arguments:		aw_Requestor  - La fenêtre et
//						adw_requestor - la DW qui demandent le service
//
//	Retourne:  		-1 Erreur
//
//	Description:	Permet d'assigner la fenêtre et la DW à la classe de
//						rapport.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

If (IsNull(aw_requestor) or Not IsValid(aw_requestor)) or &
   (IsNull(adw_requestor) or Not IsValid(adw_requestor)) Then
	Return -1
End If

iw_Requestor   = aw_Requestor
idw_requestor  = adw_requestor

return 1
end function

public function integer of_setstoreproc (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_SetStoreProc 				
//
//	Accès:  			Public
//
//	Arguments:  	ab_switch - TRUE mettre le service à ON
//
//	Retourne:  		-1 erreur de paramètre
//
//	Description:	Désactive le mode de recherche automatique dans le cas
//						ou le rapport utilise une Store Proc comme source de 
//						données.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

If isnull( ab_switch ) Then
	Return -1
End If

If ab_switch Then
	ib_storeproc = ab_switch
	
	// Désactive le Mode de recherche sur la DW_PREVIEW
	//iw_requestor.inv_recherche.of_SetAutomatique( FALSE )
End If

Return 1
end function

public subroutine of_zoomclick ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_ZoomClick  				
//
//	Accès:  			Public
//
//	Argument:  		Aucun
//
//	Retourne:  		Rien
//
//	Description:	Effectue le changement de zoom du rapport.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

Long ll_value, ll_other_value, ll_page_courant, ll_first_row_on_page

ll_page_courant = THIS.of_nopagecourant()

ll_value = Long( idw_requestor.Describe( "datawindow.print.preview.zoom" ) )

If ll_value <> 100 Then
	ll_other_value = 100
Else
	ll_other_value = il_zoom_value
End If

iw_requestor.SetRedraw( False )
idw_requestor.inv_PrintPreview.of_SetZoom( ll_other_value )
THIS.of_SetCurseur( ll_value, ll_other_value )

IF THIS.of_IsResetPage() = FALSE THEN
	THIS.of_setpage( ll_page_courant )
ELSE
	ll_first_row_on_page = long(idw_requestor.Describe("datawindow.firstrowonpage"))
	idw_requestor.ScrollToRow(ll_first_row_on_page)
END IF

iw_requestor.SetRedraw( TRUE )
end subroutine

public subroutine of_zoomvalue ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_ZoomValue  				
//
//	Accès:  			Public
//
//	Argument:  		Aucun
//
//	Retourne:  		Rien
//
//	Description:	Détermine les valeurs de zoom par défaut en fonction
//						du format du rapport.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

String ls_orientation, ls_format

ls_orientation = idw_requestor.Describe( "datawindow.print.Orientation" )
ls_format      = idw_requestor.Describe( "datawindow.print.Paper.Size" )

// Valeur par défaut 8 1/2 par 11 portrait
il_zoom_value = 40

If ls_orientation = "1" Then
	il_zoom_value = 56
Else
	CHOOSE CASE ls_format
		CASE "1"
			il_zoom_value = 43
		CASE "5"
			il_zoom_value = 34
	END CHOOSE
End If
end subroutine

public subroutine of_majnopage ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:			of_majnopage  				
//
//	Accès:  			Public
//
//	Argument:  		aucun
//
//	Retourne:  		Rien
//
//	Description:	Modifie le titre du rapport afin d'actualiser le numero
//						de page.
//	
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

String 	ls_value
Long		ll_page, ll_nbpages

ll_page = THIS.of_nopagecourant ( )
ll_nbpages = THIS.of_PageCount()

ls_value = "Page " + String( ll_page ) + " de " + String( ll_nbpages )

IF iw_requestor.ClassName() <> "w_rapport_atm_simple" THEN
	iw_requestor.title = is_titre_original + "      " + ls_value
END IF

//IF IsValid(idw_requestor.im_fin) THEN
//	IF ll_page >= ll_nbpages THEN
//		//Dernière rangée
//		idw_requestor.im_fin.Enabled = FALSE
//		idw_requestor.im_suivant.enabled = FALSE
//	ELSE
//		idw_requestor.im_fin.Enabled = TRUE
//		idw_requestor.im_suivant.enabled = TRUE
//	END IF
//	
//	IF ll_page <= 1 THEN
//		//Permière rangée
//		idw_requestor.im_debut.enabled = FALSE
//		idw_requestor.im_precedent.enabled = FALSE
//	ELSE
//		idw_requestor.im_debut.enabled = TRUE
//		idw_requestor.im_precedent.enabled = TRUE
//	END IF
//END IF
end subroutine

public function integer of_gopage ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode: 		of_gopage 				
//
//	Accès:  			Public
//
//	Argument:		aucun  
//
//	Retourne:  		Integer
//
//	Description:	Gère la fonctionnalitée d'accès direct à une page.
//	
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

Long    ll_nb_page
String  ls_page
Pointer lptr_anc

ll_nb_page = THIS.of_PageCount()

IF ll_nb_page = 1 THEN RETURN 1

//OpenWithParm( w_GoPage_PFC, ll_nb_page )

ls_page = Message.StringParm

If IsNumber( ls_page ) Then
	lptr_anc = SetPointer( Hourglass! )
	idw_requestor.SetRedraw( False )
	THIS.of_SetPage( Long( ls_page ) )
	idw_requestor.SetRedraw( True )
	SetPointer( lptr_anc )
Else
	Return -1
End If

Return 1
end function

public function integer of_pagecount ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode: 		of_pagecount 				
//
//	Accès:  			Public
//
//	Argument:		aucun  
//
//	Retourne:  		Nombre de page réel du rapport
//
//	Description:	Retourne le nombre de pages réelle du rapport (le pagecount des PFC
//						fonctionnait mal lorsqu'il y avait un reset page number on group break
//						sur au moins un groupe
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

IF IsNull(idw_requestor) OR not IsValid (idw_requestor) THEN
	RETURN -1
END IF

IF THIS.of_IsResetPage() = FALSE THEN

	IF idw_requestor.RowCount() > 0 THEN
		RETURN idw_requestor.inv_PrintPreview.of_PageCount()
	ELSE
		RETURN 1
	END IF
ELSE
	IF il_nbpages = 0 THEN
		RETURN 1
	ELSE
		RETURN il_nbpages
	END IF
END IF
end function

on pro_n_cst_imprimer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pro_n_cst_imprimer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

