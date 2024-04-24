$PBExportHeader$w_produit.srw
forward
global type w_produit from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_produit
end type
type dw_produit from u_dw within w_produit
end type
type rr_1 from roundrectangle within w_produit
end type
end forward

global type w_produit from w_sheet_frame
string tag = "menu=m_produits"
integer x = 214
integer y = 221
uo_toolbar uo_toolbar
dw_produit dw_produit
rr_1 rr_1
end type
global w_produit w_produit

forward prototypes
public subroutine of_validationprod ()
end prototypes

public subroutine of_validationprod ();string ls_noproduit,ls_classe,ls_noclasse,ls_sqlclasse,ls_tabclasse[],ls_codehebergeur,ls_souscodeh,ls_newsyntax
string ls_sql, ls_errorfromsql, ls_codeverrat, ls_eco,ls_msg
long ll_eco, ll_count,i,ll_idprodspec
dec{2} ld_prix

ls_noproduit = dw_produit.getitemstring( dw_produit.getrow(),'noproduit') 

SELECT count(1) INTO :ll_count
FROM t_produit INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat
WHERE noproduit = :ls_noproduit;

IF ll_count > 0 THEN

	SELECT t_produit.codehebergeur, t_verrat.classe
		INTO :ls_codehebergeur, :ls_classe
	FROM t_produit INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat
	WHERE noproduit = :ls_noproduit;
	
	//PASSER TOUTES LES LIGNES AVEC LE BON CODE HÉBERGEUR
	DECLARE listhebergement CURSOR FOR
		
		SELECT id_prodspec,noclasse,codeverrat,prix,souscodehebergeur,economie FROM t_prodspec WHERE codehebergeur = :ls_codehebergeur;
	
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
		
		
		ls_sql = "SELECT count(1) FROM t_produit INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat WHERE noproduit = '"+string(ls_noproduit)+"' " + ls_sqlclasse + ls_codeverrat
		DECLARE list DYNAMIC CURSOR FOR SQLSA;
		PREPARE sqlsa FROM :ls_sql;
		
		OPEN list;
		
		FETCH list INTO :ll_count;
		
		DO WHILE SQLCA.SQLCode = 0 
		
			If ll_count > 0 Then
				//If isnull(ll_eco) Then ll_eco = 0
				//ls_msg = "Code hébergeur : " + ls_codehebergeur
				//ls_msg += "~r~nClasse : " +  ls_noclasse
				//ls_msg += "~r~n Souscode hébergeur : " + ls_souscodeh
				//ls_msg += "~r~n Économie : " + string(ll_eco)
				//ls_msg += "~r~n Prix : " + string(ld_prix)
				//ls_msg += "~r~n Voulez-vous appliquer le prix d'hébergement?"

				//If Messagebox("Avertissement",ls_msg, Exclamation!, YesNo!, 2) = 1 THEN
					dw_produit.setitem(dw_produit.getrow(), 'no_sch', ls_souscodeh)
					dw_produit.setitem(dw_produit.getrow(), 'noeconomievolume', ll_eco)
					dw_produit.setitem(dw_produit.getrow(), 'prixunitaire', ld_prix)
					dw_produit.setitem(dw_produit.getrow(), 'prixunitairesp', ld_prix)
				//End If
			End If
			
			FETCH list INTO :ll_count;
		
		LOOP
		
		CLOSE list;

	FETCH listhebergement INTO :ll_idprodspec,:ls_noclasse,:ls_codeverrat,:ld_prix,:ls_souscodeh,:ll_eco;
		
	LOOP
	
	CLOSE listhebergement;

END IF

end subroutine

on w_produit.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_produit=create dw_produit
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_produit
this.Control[iCurrent+3]=this.rr_1
end on

on w_produit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_produit)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_produit.event pfc_retrieve()

string	ls_produit
long		ll_retour

ls_produit = gnv_app.inv_entrepotglobal.of_retournedonnee("produit par verrat")
IF NOT(IsNull(ls_produit) OR ls_produit = "") THEN 
	ll_retour = dw_produit.Find("upper(noproduit) = '" + upper(ls_produit) + "'", 1, dw_produit.RowCount())	
	IF ll_retour > 0 THEN
		dw_produit.SetRow(ll_retour)
		dw_produit.ScrollToRow(ll_retour)
	END IF
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("produit par verrat","")
END IF
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Rechercher...", "Search!")
uo_toolbar.of_AddItem("Imprimer l'écran", "Preview!")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_addseparator( )
uo_toolbar.of_AddItem("Économie de volume", "Custom048!")
uo_toolbar.of_AddItem("Classe", "C:\ii4net\CIPQ\images\listview_userobject.bmp")
uo_toolbar.of_addseparator( )
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_produit
string text = "Produits"
end type

type p_8 from w_sheet_frame`p_8 within w_produit
integer x = 73
integer y = 52
integer width = 82
integer height = 72
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\autreinfo.jpg"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_produit
end type

type uo_toolbar from u_cst_toolbarstrip within w_produit
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2196
integer width = 4549
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long 			ll_row, ll_classe, ll_economie
n_cst_menu	lnv_menu
menu			lm_item, lm_menu

ll_row = dw_produit.GetRow()

CHOOSE CASE as_button
	CASE "Add","Ajouter"
		dw_produit.event pfc_insertrow()
	CASE "Supprimer", "Delete"
		dw_produit.event pfc_deleterow()
	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		//of_validationprod( )
		dw_produit.accepttext( )
		event pfc_save()
	CASE "Rechercher..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_produit.RowCount() > 0 THEN
				dw_produit.SetRow(1)
				dw_produit.ScrollToRow(1)
				dw_produit.event pfc_finddlg()
			END IF
		END IF		

	CASE "Imprimer l'écran"
		long ll_Job

		ll_Job = PrintOpen("Écran", TRUE)
		PrintScreen(ll_Job,1,1,8125,6250)

		PrintClose(ll_Job)	
		
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Économie de volume"
		IF ll_row > 0 THEN
			ll_economie = dw_produit.object.noeconomievolume[ll_row]
			lm_menu = gnv_app.of_getframe().MenuID
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,"m_economiedevolume", lm_item) > 0 THEN
					IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
						gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien econo", string(ll_economie))
						lm_item.event clicked()
					END IF
				END IF 
			END IF
		END IF
		
	CASE "Classe"
		IF ll_row > 0 THEN
			ll_classe = dw_produit.object.noclasse[ll_row]
			lm_menu = gnv_app.of_getframe().MenuID
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,"m_classesdeproduits", lm_item) > 0 THEN
					IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
						gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien classe", string(ll_classe))
						lm_item.event clicked()
					END IF
				END IF 
			END IF
		END IF
		
END CHOOSE

end event

type dw_produit from u_dw within w_produit
integer x = 73
integer y = 216
integer width = 4448
integer height = 1860
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_produit"
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event constructor;call super::constructor;SetRowFocusIndicator(Hand!)

THIS.of_setfind(TRUE)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

string	ls_noproduit
long		ll_row, ll_actif

ll_row = THIS.GetRow()
IF ll_row > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_produit", TRUE)
	
	//2008-12-11 Mathieu Gendron	Validation/Avertissement sur les codes "HEB-"
	ls_noproduit = dw_produit.object.noproduit[ll_row]
	
	ll_actif = dw_produit.object.actif[ll_row]
	
	IF Left(ls_noproduit,4) = "HEB-" AND ll_actif = 1 THEN
		Messagebox("Avertissement", "Vous avez spécifié un code de produit de type hébergement et le produit devrait être indiqué comme inactif.")
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	
	CASE "noproduit"

		//Vérifier s'il y a un espace dans le numéro de produit
		string	ls_produit
		
		ls_produit = trim(data)
		if ls_produit <> data then
			THIS.object.noproduit[row] = ls_produit
			return 2
		end if
		
END CHOOSE
end event

type rr_1 from roundrectangle within w_produit
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 184
integer width = 4549
integer height = 1956
integer cornerheight = 40
integer cornerwidth = 46
end type

