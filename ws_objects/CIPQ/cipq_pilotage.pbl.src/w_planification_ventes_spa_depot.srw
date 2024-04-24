$PBExportHeader$w_planification_ventes_spa_depot.srw
forward
global type w_planification_ventes_spa_depot from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_planification_ventes_spa_depot
end type
type dw_planification_ventes_date from u_dw within w_planification_ventes_spa_depot
end type
type st_1 from statictext within w_planification_ventes_spa_depot
end type
type st_2 from statictext within w_planification_ventes_spa_depot
end type
type pb_copier from u_pb within w_planification_ventes_spa_depot
end type
type em_semaine from u_em within w_planification_ventes_spa_depot
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_planification_ventes_spa_depot
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_planification_ventes_spa_depot
end type
type gb_1 from u_gb within w_planification_ventes_spa_depot
end type
type rr_1 from roundrectangle within w_planification_ventes_spa_depot
end type
type dw_planification_ventes_par_depot from u_dw within w_planification_ventes_spa_depot
end type
end forward

global type w_planification_ventes_spa_depot from w_sheet_frame
string tag = "menu=m_planificationdesventes"
integer height = 2508
uo_toolbar uo_toolbar
dw_planification_ventes_date dw_planification_ventes_date
st_1 st_1
st_2 st_2
pb_copier pb_copier
em_semaine em_semaine
uo_toolbar_haut uo_toolbar_haut
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
rr_1 rr_1
dw_planification_ventes_par_depot dw_planification_ventes_par_depot
end type
global w_planification_ventes_spa_depot w_planification_ventes_spa_depot

on w_planification_ventes_spa_depot.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_planification_ventes_date=create dw_planification_ventes_date
this.st_1=create st_1
this.st_2=create st_2
this.pb_copier=create pb_copier
this.em_semaine=create em_semaine
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.rr_1=create rr_1
this.dw_planification_ventes_par_depot=create dw_planification_ventes_par_depot
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_planification_ventes_date
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.pb_copier
this.Control[iCurrent+6]=this.em_semaine
this.Control[iCurrent+7]=this.uo_toolbar_haut
this.Control[iCurrent+8]=this.uo_toolbar_bas
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.rr_1
this.Control[iCurrent+11]=this.dw_planification_ventes_par_depot
end on

on w_planification_ventes_spa_depot.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_planification_ventes_date)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.pb_copier)
destroy(this.em_semaine)
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.rr_1)
destroy(this.dw_planification_ventes_par_depot)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter une date de dépôt", "C:\ii4net\CIPQ\images\ajouter.ico")
//uo_toolbar_haut.of_AddItem("Supprimer cette date de dépôt", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_AddItem("Rechercher une date...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un dépôt", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer ce dépôt", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)
end event

event pfc_postopen;call super::pfc_postopen;dw_planification_ventes_date.event pfc_retrieve()
end event

type st_title from w_sheet_frame`st_title within w_planification_ventes_spa_depot
integer x = 192
integer width = 1792
integer height = 76
string text = "Planification des ventes de SPA dans les dépôts"
end type

type p_8 from w_sheet_frame`p_8 within w_planification_ventes_spa_depot
integer x = 50
integer y = 36
integer width = 123
integer height = 108
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\horaire.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_planification_ventes_spa_depot
end type

type uo_toolbar from u_cst_toolbarstrip within w_planification_ventes_spa_depot
event destroy ( )
string tag = "resize=frbsr"
integer x = 27
integer y = 2200
integer width = 4544
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type dw_planification_ventes_date from u_dw within w_planification_ventes_spa_depot
integer x = 41
integer y = 236
integer width = 4439
integer height = 212
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_planification_ventes_date"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.RETRIEVE()
end event

type st_1 from statictext within w_planification_ventes_spa_depot
integer x = 2990
integer y = 2088
integer width = 759
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "Copier la dernière semaine pour les"
boolean focusrectangle = false
end type

type st_2 from statictext within w_planification_ventes_spa_depot
integer x = 3963
integer y = 2088
integer width = 421
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "semaine(s) à venir"
boolean focusrectangle = false
end type

type pb_copier from u_pb within w_planification_ventes_spa_depot
integer x = 4393
integer y = 2060
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
string text = ""
string picturename = "C:\ii4net\CIPQ\images\rechercher.jpg"
end type

event clicked;call super::clicked;long		ll_rep, ll_save, ll_nbsemaine, ll_cpt, ll_ajout
string	ls_message[]
date		ld_calcul

//Lancer une sauvegarde avant
ll_save = parent.event pfc_save()

IF ll_save >= 0 THEN
	ls_message[1] = string(em_semaine.text)
	ll_nbsemaine = long(ls_message[1])
	
	IF ls_message[1] <> "0" AND IsNull(ls_message[1]) = FALSE THEN
		ll_rep = gnv_app.inv_error.of_message("CIPQ0024", {ls_message[1]}) 
		
		IF ll_rep = 1 THEN
			//Procéder
			//Récupérer le dernier dimanche dans la table, il servira de base pour calculer la semaine à copier
			SELECT TOP 1 t_Depot_DatePlanification.DateDepot INTO :ld_calcul FROM t_Depot_DatePlanification
			WHERE (DOW(DateDepot))=1 ORDER BY t_Depot_DatePlanification.DateDepot DESC;
			
			FOR ll_cpt = 1 TO ll_nbsemaine
				
				ll_ajout = ll_cpt * 7
				
				//Créer le dimanche dans t_Depot_DatePlanification
				INSERT INTO t_Depot_DatePlanification ( DateDepot ) 
				SELECT DateAdd(day, :ll_ajout, :ld_calcul)  AS DateDepo ;	
				COMMIT USING SQLCA;

				//Créer le dimanche dans t_Depot_Planification
				INSERT INTO t_Depot_Planification ( DateDepot, Id_Depot, Qte_Planifie )
				SELECT DateAdd(day, :ll_ajout, :ld_calcul)  AS DateDepo, 
				t_Depot_Planification.Id_Depot, t_Depot_Planification.Qte_Planifie 	
				FROM t_Depot_Planification 
				WHERE t_Depot_Planification.DateDepot = :ld_calcul;
				COMMIT USING SQLCA;

				//Créer le lundi dans t_Depot_DatePlanification
				INSERT INTO t_Depot_DatePlanification ( DateDepot ) 
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 1, :ld_calcul))  AS DateDepo ;	
				COMMIT USING SQLCA;

				//Créer le lundi dans t_Depot_Planification
				INSERT INTO t_Depot_Planification ( DateDepot, Id_Depot, Qte_Planifie )
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 1, :ld_calcul))  AS DateDepo, 
				t_Depot_Planification.Id_Depot, t_Depot_Planification.Qte_Planifie 	
				FROM t_Depot_Planification 
				WHERE t_Depot_Planification.DateDepot = DateAdd(day, 1, :ld_calcul);
				COMMIT USING SQLCA;
				
				//Créer le mardi dans t_Depot_DatePlanification
				INSERT INTO t_Depot_DatePlanification ( DateDepot ) 
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 2, :ld_calcul))  AS DateDepo ;	
				COMMIT USING SQLCA;

				//Créer le mardi dans t_Depot_Planification
				INSERT INTO t_Depot_Planification ( DateDepot, Id_Depot, Qte_Planifie )
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 2, :ld_calcul))  AS DateDepo, 
				t_Depot_Planification.Id_Depot, t_Depot_Planification.Qte_Planifie 	
				FROM t_Depot_Planification 
				WHERE t_Depot_Planification.DateDepot = DateAdd(day, 2, :ld_calcul);
				COMMIT USING SQLCA;
				
				//Créer le mercredi dans t_Depot_DatePlanification
				INSERT INTO t_Depot_DatePlanification ( DateDepot ) 
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 3, :ld_calcul))  AS DateDepo ;	
				COMMIT USING SQLCA;

				//Créer le mercredi dans t_Depot_Planification
				INSERT INTO t_Depot_Planification ( DateDepot, Id_Depot, Qte_Planifie )
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 3, :ld_calcul))  AS DateDepo, 
				t_Depot_Planification.Id_Depot, t_Depot_Planification.Qte_Planifie 	
				FROM t_Depot_Planification 
				WHERE t_Depot_Planification.DateDepot = DateAdd(day, 3, :ld_calcul);
				COMMIT USING SQLCA;
				
				//Créer le jeudi dans t_Depot_DatePlanification
				INSERT INTO t_Depot_DatePlanification ( DateDepot ) 
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 4, :ld_calcul))  AS DateDepo ;	
				COMMIT USING SQLCA;

				//Créer le jeudi dans t_Depot_Planification
				INSERT INTO t_Depot_Planification ( DateDepot, Id_Depot, Qte_Planifie )
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 4, :ld_calcul))  AS DateDepo, 
				t_Depot_Planification.Id_Depot, t_Depot_Planification.Qte_Planifie 	
				FROM t_Depot_Planification 
				WHERE t_Depot_Planification.DateDepot = DateAdd(day, 4, :ld_calcul);
				COMMIT USING SQLCA;

				//Créer le vendredi dans t_Depot_DatePlanification
				INSERT INTO t_Depot_DatePlanification ( DateDepot ) 
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 5, :ld_calcul))  AS DateDepo ;	
				COMMIT USING SQLCA;

				//Créer le vendredi dans t_Depot_Planification
				INSERT INTO t_Depot_Planification ( DateDepot, Id_Depot, Qte_Planifie )
				SELECT DateAdd(day, :ll_ajout, DateAdd(day, 5, :ld_calcul))  AS DateDepo, 
				t_Depot_Planification.Id_Depot, t_Depot_Planification.Qte_Planifie 	
				FROM t_Depot_Planification 
				WHERE t_Depot_Planification.DateDepot = DateAdd(day, 5, :ld_calcul);
				COMMIT USING SQLCA;

			END FOR

			//Ménage pour enlever les pères sans fils
			DELETE t_Depot_DatePlanification  
			FROM t_Depot_DatePlanification LEFT JOIN t_Depot_Planification ON 
			t_Depot_DatePlanification.DateDepot = t_Depot_Planification.DateDepot 
			WHERE t_Depot_Planification.DateDepot Is Null;

			COMMIT USING SQLCA;

			gnv_app.inv_error.of_message("CIPQ0025")
			dw_planification_ventes_date.event pfc_retrieve()
		END IF
		
	END IF
END IF
end event

type em_semaine from u_em within w_planification_ventes_spa_depot
integer x = 3771
integer y = 2072
integer width = 169
integer height = 84
integer taborder = 30
boolean bringtotop = true
string mask = "##0"
boolean spin = true
end type

type uo_toolbar_haut from u_cst_toolbarstrip within w_planification_ventes_spa_depot
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 480
integer width = 4384
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter une date de dépôt"
		dw_planification_ventes_date.event pfc_insertrow()
	CASE "Supprimer cette date de dépôt"
		dw_planification_ventes_date.event pfc_deleterow()
	CASE "Rechercher une date..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_planification_ventes_date.RowCount() > 0 THEN
				dw_planification_ventes_date.SetRow(1)
				dw_planification_ventes_date.ScrollToRow(1)
				dw_planification_ventes_date.event pfc_finddlg()
			END IF
		END IF		
		
END CHOOSE

end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_planification_ventes_spa_depot
event destroy ( )
string tag = "resize=frbsr"
integer x = 192
integer y = 1892
integer width = 4261
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un dépôt"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_planification_ventes_par_depot.SetFocus()		
			dw_planification_ventes_par_depot.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce dépôt"
		dw_planification_ventes_par_depot.event pfc_deleterow()

END CHOOSE

end event

type gb_1 from u_gb within w_planification_ventes_spa_depot
integer x = 91
integer y = 616
integer width = 4411
integer height = 1416
integer taborder = 0
long backcolor = 15793151
string text = "Planification par dépôt"
end type

type rr_1 from roundrectangle within w_planification_ventes_spa_depot
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 176
integer width = 4549
integer height = 2004
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_planification_ventes_par_depot from u_dw within w_planification_ventes_spa_depot
integer x = 142
integer y = 708
integer width = 4293
integer height = 1148
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_planification_ventes_par_depot"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_planification_ventes_date)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("datedepot","datedepot")

THIS.SetRowFocusIndicator ( Hand! )
end event

