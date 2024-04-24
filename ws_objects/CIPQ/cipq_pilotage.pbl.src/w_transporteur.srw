$PBExportHeader$w_transporteur.srw
forward
global type w_transporteur from w_sheet_frame
end type
type dw_transporteur from u_dw within w_transporteur
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_transporteur
end type
type uo_toolbar from u_cst_toolbarstrip within w_transporteur
end type
type dw_transporteur_livreur from u_dw within w_transporteur
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_transporteur
end type
type gb_1 from u_gb within w_transporteur
end type
type rr_1 from roundrectangle within w_transporteur
end type
end forward

global type w_transporteur from w_sheet_frame
string tag = "menu=m_transporteurs"
dw_transporteur dw_transporteur
uo_toolbar_haut uo_toolbar_haut
uo_toolbar uo_toolbar
dw_transporteur_livreur dw_transporteur_livreur
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
rr_1 rr_1
end type
global w_transporteur w_transporteur

on w_transporteur.create
int iCurrent
call super::create
this.dw_transporteur=create dw_transporteur
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar=create uo_toolbar
this.dw_transporteur_livreur=create dw_transporteur_livreur
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_transporteur
this.Control[iCurrent+2]=this.uo_toolbar_haut
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.dw_transporteur_livreur
this.Control[iCurrent+5]=this.uo_toolbar_bas
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_transporteur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_transporteur)
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar)
destroy(this.dw_transporteur_livreur)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_transporteur.event pfc_retrieve()
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un transporteur", "C:\ii4net\CIPQ\images\ajout_personne.ico")
uo_toolbar_haut.of_AddItem("Supprimer ce transporteur", "C:\ii4net\CIPQ\images\suppr_personne.ico")
uo_toolbar_haut.of_AddItem("Rechercher un transporteur...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un livreur", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_bas.of_AddItem("Supprimer ce livreur", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_bas.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_transporteur
integer x = 219
integer height = 80
string text = "Transporteurs"
end type

type p_8 from w_sheet_frame`p_8 within w_transporteur
integer x = 55
integer y = 32
integer width = 137
integer height = 120
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\trans.gif"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_transporteur
integer height = 128
end type

type dw_transporteur from u_dw within w_transporteur
integer x = 73
integer y = 232
integer width = 4379
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_transporteur"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_trans

IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Transporteur", TRUE)
	
	ll_trans = this.object.idtransporteur[THIS.GetRow()]
	if isNull(ll_trans) then ll_trans = 0
	
	IF ll_trans <= 0 THEN
		n_ds lds_no_auto
		
		lds_no_auto = CREATE n_ds
		lds_no_auto.dataobject = "ds_transporteur_no_auto"
		lds_no_auto.of_setTransobject(SQLCA)
		IF lds_no_auto.retrieve() > 0 THEN
			this.object.idtransporteur[THIS.GetRow()] = lds_no_auto.object.maximum[1]
		END IF 
	END IF
END IF

RETURN AncestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;long ll_tr_no

if ancestorReturnValue <= 0 then return ancestorReturnValue

  select first no + 1
	 into :ll_tr_no
	 from (select min(no_cl)
				from (select idtransporteur,
								 count(1) over(order by idtransporteur asc range between 1 following and 1 following)
						  from t_transporteur) as trno(no_cl, ex)
			  where ex = 0
			 union all select 0
			  where not exists(select 1 from t_transporteur where idtransporteur = 1)) as tr_no(no)
order by no;

this.object.idtransporteur[ancestorReturnValue] = ll_tr_no
end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_transporteur
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 508
integer width = 4352
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un transporteur"
		dw_transporteur.event pfc_insertrow()
	CASE "Supprimer ce transporteur"
		dw_transporteur.event pfc_deleterow()
	CASE "Rechercher un transporteur..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_transporteur.RowCount() > 0 THEN
				dw_transporteur.SetRow(1)
				dw_transporteur.ScrollToRow(1)
				dw_transporteur.event pfc_finddlg()
			END IF
		END IF
		
END CHOOSE
end event

type uo_toolbar from u_cst_toolbarstrip within w_transporteur
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

type dw_transporteur_livreur from u_dw within w_transporteur
integer x = 165
integer y = 764
integer width = 4233
integer height = 1160
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_transporteur_livreur"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_transporteur)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("idtransporteur","idtransporteur")

SetRowFocusindicator(Hand!)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_TransporteurLivreur", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_transporteur
event destroy ( )
string tag = "resize=frbsr"
integer x = 151
integer y = 1952
integer width = 4261
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un livreur"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_transporteur_livreur.SetFocus()		
			dw_transporteur_livreur.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce livreur"
		dw_transporteur_livreur.event pfc_deleterow()

END CHOOSE

end event

type gb_1 from u_gb within w_transporteur
integer x = 105
integer y = 672
integer width = 4361
integer height = 1424
integer taborder = 0
long backcolor = 15793151
string text = "Livreurs"
end type

type rr_1 from roundrectangle within w_transporteur
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 196
integer width = 4549
integer height = 1976
integer cornerheight = 40
integer cornerwidth = 46
end type

