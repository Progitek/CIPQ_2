$PBExportHeader$w_lot_verrats_isolement.srw
forward
global type w_lot_verrats_isolement from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_lot_verrats_isolement
end type
type tab_isolement from u_tab_isolement_lot within w_lot_verrats_isolement
end type
type tab_isolement from u_tab_isolement_lot within w_lot_verrats_isolement
end type
end forward

global type w_lot_verrats_isolement from w_sheet_frame
string tag = "menu=m_lotsdeverratsenisolement"
integer x = 214
integer y = 221
uo_toolbar uo_toolbar
tab_isolement tab_isolement
end type
global w_lot_verrats_isolement w_lot_verrats_isolement

type variables
long	il_nolot
end variables

on w_lot_verrats_isolement.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.tab_isolement=create tab_isolement
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.tab_isolement
end on

on w_lot_verrats_isolement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.tab_isolement)
end on

event open;call super::open;long	ll_row, ll_rowcount
string ls_tatouage

ls_tatouage = gnv_app.inv_entrepotglobal.of_retournedonnee("Tatoo isolement verrat")


ll_rowcount = THIS.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.event pfc_retrieve()

//Lien externe

IF Not IsNull(il_nolot) THEN
	//Pointer vers la bonne ligne
	ll_row = THIS.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.Find("nolot = " + string(il_nolot), 1, ll_rowcount)
	IF ll_row > 0 THEN
		THIS.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.SetRow(ll_row)
		THIS.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.ScrolltoRow(ll_row)
	END IF
END IF

if not isnull(ls_tatouage) then
	
	
	ll_row = this.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.find("tatouage = '" + ls_tatouage + "'", 1, ll_rowcount)
	if ll_row > 0 then
		this.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.setrow(ll_row)
		this.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.scrolltorow(ll_row)
		this.tab_isolement.tabpage_isolement_liste.dw_isolement_etat_physique.setrow(ll_row)
		this.tab_isolement.tabpage_isolement_liste.dw_isolement_etat_physique.scrolltorow(ll_row)
	end if
end if


end event

event pfc_postopen;call super::pfc_postopen;//Mettre les boutons
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Imprimer traitement", "RunReport5!")
uo_toolbar.of_AddItem("Imprimer état physique vierge", "Report!")
uo_toolbar.of_AddItem("Saisir état physique", "Cursor!")
uo_toolbar.of_AddItem("Imprimer les dossiers", "Print!")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")

tab_isolement.tabpage_isolement_principal.uo_toolbar_haut.of_AddItem("Ajouter un lot", "C:\ii4net\CIPQ\images\ajouter.ico")
tab_isolement.tabpage_isolement_liste.uo_toolbar_haut.of_AddItem("Ajouter un verrat", "C:\ii4net\CIPQ\images\ajouter.ico")
tab_isolement.tabpage_isolement_liste.uo_toolbar_haut.of_AddItem("Supprimer un verrat", "C:\ii4net\CIPQ\images\supprimer.ico")
tab_isolement.tabpage_isolement_liste.uo_toolbar_haut.of_AddItem("Imprimer le dossier", "Custom017!")

tab_isolement.tabpage_isolement_liste.uo_toolbar_bas.of_AddItem("Ajouter un état physique", "AddWatch5!")

tab_isolement.tabpage_isolement_principal.uo_toolbar_haut.of_displaytext(true)
tab_isolement.tabpage_isolement_liste.uo_toolbar_haut.of_displaytext(true)
tab_isolement.tabpage_isolement_liste.uo_toolbar_bas.of_displaytext(true)
uo_toolbar.of_displaytext(true)

end event

event pfc_preopen;call super::pfc_preopen;il_nolot = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien isolement verrat"))
end event

type st_title from w_sheet_frame`st_title within w_lot_verrats_isolement
string text = "Lot de verrat en isolement"
end type

type p_8 from w_sheet_frame`p_8 within w_lot_verrats_isolement
integer x = 73
integer y = 52
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\annuler.gif"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_lot_verrats_isolement
end type

type uo_toolbar from u_cst_toolbarstrip within w_lot_verrats_isolement
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2196
integer width = 4558
integer height = 108
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long		ll_row, ll_nolot
string	ls_annexe = "non"

ll_row = parent.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.GetRow()

CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Imprimer traitement"
		w_r_dihydro	lw_window_d
		
		IF ll_row > 0 THEN
			IF PARENT.event pfc_save() >= 0 THEN
				ll_nolot = parent.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.object.nolot[ll_row]
				IF parent.tab_isolement.tabpage_isolement_principal.cbx_annexer.checked = TRUE THEN
					ls_annexe = "oui"
				END IF
					
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot annexe", ls_annexe)
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(ll_nolot))
				OpenSheet(lw_window_d, gnv_app.of_GetFrame(), 6, layered!)
			END IF
		END IF
	
	CASE "Imprimer état physique vierge"
		w_r_etat_physique_isolement	lw_window_e
		
		IF ll_row > 0 THEN
			IF PARENT.event pfc_save() >= 0 THEN
				ll_nolot = parent.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.object.nolot[ll_row]
					
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(ll_nolot))
				OpenSheet(lw_window_e, gnv_app.of_GetFrame(), 6, layered!)
			END IF		
		END IF
	
	CASE "Saisir état physique"
		w_saisie_etat_physique	lw_window_s
		
		IF ll_row > 0 THEN
			IF PARENT.event pfc_save() >= 0 THEN
				if parent.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.rowCount() <= 0 then
					gnv_app.inv_error.of_message("CIPQ0018", {"Il doit y avoir au moins un verrat dans le lot d'isolement pour saisir un état physique."})
					return
				end if
				
				ll_nolot = parent.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.object.nolot[ll_row]
					
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(ll_nolot))
				OpenSheet(lw_window_s, gnv_app.of_GetFrame(), 6, layered!)
			END IF		
		END IF
		
	CASE "Imprimer les dossiers"
		//Même que sur le 3ieme onglet mais pour tous les verrats de ce lot

		w_r_dossier_verrat_isolement	lw_window_v
		
		IF ll_row > 0 THEN
			IF PARENT.event pfc_save() >= 0 THEN
				ll_nolot = parent.tab_isolement.tabpage_isolement_principal.dw_isolement_principal.object.nolot[ll_row]
					
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(ll_nolot))
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("type lien dossier", "lot")
				OpenSheet(lw_window_v, gnv_app.of_GetFrame(), 6, layered!)
			END IF				
		END IF
		
		
	CASE "Rechercher un lot..."
		IF parent.event pfc_save() >= 0 THEN
			IF tab_isolement.tabpage_isolement_principal.dw_isolement_principal.RowCount() > 0 THEN
				tab_isolement.tabpage_isolement_principal.dw_isolement_principal.SetRow(1)
				tab_isolement.tabpage_isolement_principal.dw_isolement_principal.ScrollToRow(1)
				tab_isolement.tabpage_isolement_principal.dw_isolement_principal.event pfc_finddlg()
			END IF
		END IF		
		
END CHOOSE

end event

type tab_isolement from u_tab_isolement_lot within w_lot_verrats_isolement
integer x = 37
integer y = 176
integer width = 4530
integer height = 1980
integer taborder = 11
boolean bringtotop = true
long backcolor = 12639424
end type

