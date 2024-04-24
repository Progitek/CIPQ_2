HA$PBExportHeader$w_eleveur.srw
forward
global type w_eleveur from w_sheet_frame
end type
type tab_eleveur from u_tab_eleveur within w_eleveur
end type
type tab_eleveur from u_tab_eleveur within w_eleveur
end type
type uo_toolbar from u_cst_toolbarstrip within w_eleveur
end type
type st_nbreleveur from statictext within w_eleveur
end type
end forward

global type w_eleveur from w_sheet_frame
string tag = "menu=m_eleveurs"
string title = "$$HEX1$$c900$$ENDHEX$$leveurs"
tab_eleveur tab_eleveur
uo_toolbar uo_toolbar
st_nbreleveur st_nbreleveur
end type
global w_eleveur w_eleveur

type variables
long		il_lgannee = 0 , il_lgannee_tot = 0 , il_lgmois = 0 , il_lgmois_tot = 0, il_nbjours = 0
dec		idec_tinteret = 0.00
string	is_filtre = "", is_sql_original = "", is_where_plus = ""
end variables

on w_eleveur.create
int iCurrent
call super::create
this.tab_eleveur=create tab_eleveur
this.uo_toolbar=create uo_toolbar
this.st_nbreleveur=create st_nbreleveur
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_eleveur
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.st_nbreleveur
end on

on w_eleveur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_eleveur)
destroy(this.uo_toolbar)
destroy(this.st_nbreleveur)
end on

event open;call super::open;//R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les param$$HEX1$$e800$$ENDHEX$$tres
SELECT LivGratuiteAnnee, LivGratuitemois, LivGratuiteAnneeTot, LivGratuitemoisTot, TInteret, NbrJour 
INTO :il_lgannee, :il_lgmois, :il_lgannee_tot, :il_lgmois_tot, :idec_tinteret, :il_nbjours
FROM t_Parametre
USING SQLCA;

Long ll_any

ll_any = THIS.tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.event pfc_retrieve()

st_nbreleveur.text = "Nombre d'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$veurs: " + string(ll_any)
end event

event pfc_postopen;call super::pfc_postopen;

//Mettre les boutons
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

//uo_toolbar.of_AddItem("Imprimer la liste", "Print!")
uo_toolbar.of_AddItem("Rechercher un $$HEX1$$e900$$ENDHEX$$leveur...", "Search!")
uo_toolbar.of_AddItem("Filtrer...", "BrowseClasses!")
uo_toolbar.of_AddItem("Imprimer l'$$HEX1$$e900$$ENDHEX$$cran", "Preview!")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

tab_eleveur.tabpage_eleveur_info.uo_toolbar_haut_gauche.of_AddItem("Ajouter un t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone", "AddWatch5!")
tab_eleveur.tabpage_eleveur_info.uo_toolbar_haut_gauche.of_AddItem("Supprimer un t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone", "DeleteWatch5!")
tab_eleveur.tabpage_eleveur_info.uo_toolbar_haut_gauche.of_displaytext(TRUE)

tab_eleveur.tabpage_eleveur_info.uo_toolbar_haut_droite.of_AddItem("Ajouter un code", "C:\ii4net\CIPQ\images\ajouter.ico")
tab_eleveur.tabpage_eleveur_info.uo_toolbar_haut_droite.of_AddItem("Supprimer un code", "C:\ii4net\CIPQ\images\supprimer.ico")
tab_eleveur.tabpage_eleveur_info.uo_toolbar_haut_droite.of_displaytext(TRUE)

tab_eleveur.tabpage_eleveur_info.uo_toolbar_bas.of_AddItem("Ajouter un $$HEX1$$e900$$ENDHEX$$leveur", "C:\ii4net\CIPQ\images\ajout_personne.ico")
tab_eleveur.tabpage_eleveur_info.uo_toolbar_bas.of_AddItem("Supprimer un $$HEX1$$e900$$ENDHEX$$leveur", "C:\ii4net\CIPQ\images\suppr_personne.ico")
tab_eleveur.tabpage_eleveur_info.uo_toolbar_bas.of_displaytext(TRUE)

end event

type st_title from w_sheet_frame`st_title within w_eleveur
integer x = 206
string text = "$$HEX1$$c900$$ENDHEX$$leveurs"
end type

type p_8 from w_sheet_frame`p_8 within w_eleveur
integer x = 59
integer y = 32
integer width = 123
integer height = 120
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\boss.gif"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_eleveur
integer y = 24
integer height = 136
end type

type tab_eleveur from u_tab_eleveur within w_eleveur
integer x = 27
integer y = 168
integer width = 4517
integer height = 2020
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 12639424
end type

event selectionchanged;call super::selectionchanged;parent.tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.event rowfocuschanged(parent.tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.getrow())
end event

type uo_toolbar from u_cst_toolbarstrip within w_eleveur
event destroy ( )
string tag = "resize=frbsr"
integer x = 32
integer y = 2200
integer width = 3707
integer height = 108
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long		ll_row, ll_nolot, ll_rc
string	ls_annexe = "non"
Long ll_any

ll_row = parent.tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.GetRow()

CHOOSE CASE as_button
	CASE "Imprimer l'$$HEX1$$e900$$ENDHEX$$cran"
		long ll_Job

		ll_Job = PrintOpen("$$HEX1$$c900$$ENDHEX$$cran", TRUE)
		PrintScreen(ll_Job,1,1,8125,6250)

		PrintClose(ll_Job)	

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Rechercher un $$HEX1$$e900$$ENDHEX$$leveur..."
		if tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.of_AcceptText(true) < 1 then return
		IF tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.inv_linkage.of_getUpdatesPending() > 0 THEN
			choose case gnv_app.inv_error.of_message("pfc_dwlinkage_rowchanging")
				case 1
					IF event pfc_save() < 0 THEN return
				case 2
					tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.inv_linkage.of_undomodified(true)
				case 3
					return
			end choose
		end if
		
		IF tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.RowCount() > 0 THEN
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.SetRow(1)
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.ScrolltoRow(1)
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.event pfc_finddlg()
		END IF
		
	CASE "Filtrer..."
		w_filtre_eleveur	lw_window_d
		string				ls_filtre, ls_null, ls_sql
		long					ll_retour
		
		IF event pfc_save() >= 0 THEN
		
			IF is_sql_original = "" THEN
				is_sql_original = PARENT.tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.GetSqlSelect()
			END IF
			
			SetNull(ls_null)
			
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien filtre eleveur", is_filtre)
	
			Open(lw_window_d)
			
			ls_filtre = trim(gnv_app.inv_entrepotglobal.of_retournedonnee("lien filtre eleveur"))
			
			IF ls_filtre = "annuler" THEN RETURN
			
			IF ls_filtre = "" OR IsNull(ls_filtre) THEN
				tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.SetFilter("")
				tab_eleveur.tabpage_eleveur_adresse.dw_eleveur_liv.SetFilter("")
				ls_filtre = ""
			ELSE
				//Appliquer le filtre
				tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.SetFilter(ls_filtre)
				tab_eleveur.tabpage_eleveur_adresse.dw_eleveur_liv.SetFilter(ls_filtre)
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien filtre eleveur", "")
			END IF
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.Filter()	
			tab_eleveur.tabpage_eleveur_adresse.dw_eleveur_liv.Filter()
			is_filtre = ls_filtre
	
			//Changer le SQL pour mettre la sous-requete
			ls_sql = gnv_app.inv_entrepotglobal.of_retournedonnee("lien filtre eleveur sql")
			IF ls_sql = "" OR IsNull(ls_sql) THEN
				ll_retour = tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.SetSqlSelect(is_sql_original)
				is_where_plus = ""
			ELSE
				is_where_plus = ls_sql
				ls_sql = is_sql_original + is_where_plus
				ll_retour = tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.SetSqlSelect(ls_sql)
			END IF
			
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.SetTransObject(SQLCA)
			
			//Lancer le linkage
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.event pfc_retrieve()
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.post sort()
			tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.post event rowfocuschanged(tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.GetRow())
			
			ll_any = tab_eleveur.tabpage_eleveur_info.dw_eleveur_info.rowcount()
			st_nbreleveur.text = "Nombre d'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$veurs: " + string(ll_any)
		END IF
END CHOOSE
end event

type st_nbreleveur from statictext within w_eleveur
integer x = 3762
integer y = 2228
integer width = 777
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
alignment alignment = center!
boolean focusrectangle = false
end type

