$PBExportHeader$w_classe_produit.srw
forward
global type w_classe_produit from w_sheet_frame
end type
type dw_classe_produit from u_dw within w_classe_produit
end type
type dw_classe_produit_compte from u_dw within w_classe_produit
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_classe_produit
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_classe_produit
end type
type uo_toolbar from u_cst_toolbarstrip within w_classe_produit
end type
type gb_1 from u_gb within w_classe_produit
end type
type rr_1 from roundrectangle within w_classe_produit
end type
end forward

global type w_classe_produit from w_sheet_frame
string tag = "menu=m_classesdeproduits"
dw_classe_produit dw_classe_produit
dw_classe_produit_compte dw_classe_produit_compte
uo_toolbar_haut uo_toolbar_haut
uo_toolbar_bas uo_toolbar_bas
uo_toolbar uo_toolbar
gb_1 gb_1
rr_1 rr_1
end type
global w_classe_produit w_classe_produit

on w_classe_produit.create
int iCurrent
call super::create
this.dw_classe_produit=create dw_classe_produit
this.dw_classe_produit_compte=create dw_classe_produit_compte
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar=create uo_toolbar
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_classe_produit
this.Control[iCurrent+2]=this.dw_classe_produit_compte
this.Control[iCurrent+3]=this.uo_toolbar_haut
this.Control[iCurrent+4]=this.uo_toolbar_bas
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_classe_produit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_classe_produit)
destroy(this.dw_classe_produit_compte)
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event open;call super::open;dw_classe_produit_compte.inv_linkage.of_SetMaster(dw_classe_produit)
dw_classe_produit_compte.inv_Linkage.of_SetStyle(dw_classe_produit_compte.inv_Linkage.RETRIEVE)
dw_classe_produit_compte.inv_linkage.of_Register("noclasse","noclasse")

dw_classe_produit.inv_linkage.of_SetTransObject(SQLCA)


uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter une classe", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Rechercher une classe...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un compte", "AddWatch5!")
uo_toolbar_bas.of_displaytext(true)
end event

event pfc_postopen;call super::pfc_postopen;long	ll_no_classe, ll_retour

ll_no_classe = long(gnv_app.inv_entrepotglobal.of_retournedonnee( "lien classe"))
IF dw_classe_produit.event pfc_retrieve() > 0 THEN
	IF IsNull(ll_no_classe) = FALSE AND ll_no_classe > 0 THEN
		gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien classe", "")
		ll_retour = dw_classe_produit.Find("noclasse = " + string(ll_no_classe), 1, dw_classe_produit.RowCount())
		IF ll_retour > 0 THEN
			dw_classe_produit.SetRow(ll_retour)
			dw_classe_produit.ScrollToRow(ll_retour)
		END IF
	END IF
END IF

end event

type st_title from w_sheet_frame`st_title within w_classe_produit
integer height = 80
string text = "Classes de produits"
end type

type p_8 from w_sheet_frame`p_8 within w_classe_produit
integer x = 78
integer y = 56
integer height = 64
string picturename = "C:\ii4net\CIPQ\images\listview_userobject.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_classe_produit
end type

type dw_classe_produit from u_dw within w_classe_produit
integer x = 101
integer y = 244
integer width = 4384
integer height = 216
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_classe_produit"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)

end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_noclasse

IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Classe", TRUE)
	
	ll_noclasse = this.object.noclasse[THIS.GetRow()]
	if isNull(ll_noclasse) then ll_noclasse = 0
	
	IF ll_noclasse <= 0 THEN
		n_ds lds_no_auto
		
		lds_no_auto = CREATE n_ds
		lds_no_auto.dataobject = "ds_classe_produit_no_auto"
		lds_no_auto.of_setTransobject(SQLCA)
		IF lds_no_auto.retrieve() > 0 THEN
			this.object.noclasse[THIS.GetRow()] = lds_no_auto.object.maximum[1]
		END IF
		
		IF IsValid(lds_no_auto) THEN Destroy(lds_no_auto)
	END IF	
END IF

RETURN AncestorReturnValue



end event

event pfc_insertrow;call super::pfc_insertrow;long ll_pr_no

if ancestorReturnValue <= 0 then return ancestorReturnValue

  select first no + 1
	 into :ll_pr_no
	 from (select min(no_cl)
				from (select noclasse,
								 count(1) over(order by noclasse asc range between 1 following and 1 following)
						  from t_classe) as prno(no_cl, ex)
			  where ex = 0
			 union all select 0
			  where not exists(select 1 from t_classe where noclasse = 1)) as pr_no(no)
order by no;

this.object.noclasse[ancestorReturnValue] = ll_pr_no
end event

type dw_classe_produit_compte from u_dw within w_classe_produit
integer x = 146
integer y = 736
integer width = 4279
integer height = 1192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_classe_produit_compte"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)

SetRowFocusindicator(Hand!)
end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_classe_produit
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 480
integer width = 4384
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter une classe"
		dw_classe_produit.event pfc_insertrow()
	CASE "Supprimer cette classe"
		dw_classe_produit.event pfc_deleterow()
	CASE "Rechercher une classe..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_classe_produit.RowCount() > 0 THEN
				dw_classe_produit.SetRow(1)
				dw_classe_produit.ScrollToRow(1)
				dw_classe_produit.event pfc_finddlg()
			END IF
		END IF
		
END CHOOSE

end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_classe_produit
event destroy ( )
string tag = "resize=frbsr"
integer x = 160
integer y = 1956
integer width = 4274
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un compte"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_classe_produit_compte.SetFocus()		
			dw_classe_produit_compte.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce compte"
		dw_classe_produit_compte.event pfc_deleterow()

END CHOOSE

end event

type uo_toolbar from u_cst_toolbarstrip within w_classe_produit
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2220
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

type gb_1 from u_gb within w_classe_produit
integer x = 105
integer y = 640
integer width = 4384
integer height = 1472
integer taborder = 0
long backcolor = 15793151
string text = "Compte pour comptabilité"
end type

type rr_1 from roundrectangle within w_classe_produit
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 180
integer width = 4549
integer height = 2000
integer cornerheight = 40
integer cornerwidth = 46
end type

