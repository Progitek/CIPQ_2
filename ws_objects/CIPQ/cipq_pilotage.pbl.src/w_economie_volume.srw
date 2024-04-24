﻿$PBExportHeader$w_economie_volume.srw
forward
global type w_economie_volume from w_sheet_frame
end type
type dw_economie_volume from u_dw within w_economie_volume
end type
type uo_toolbar from u_cst_toolbarstrip within w_economie_volume
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_economie_volume
end type
type dw_economie_volume_detail from u_dw within w_economie_volume
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_economie_volume
end type
type gb_1 from u_gb within w_economie_volume
end type
type rr_1 from roundrectangle within w_economie_volume
end type
end forward

global type w_economie_volume from w_sheet_frame
string tag = "menu=m_economiedevolume"
integer x = 214
integer y = 221
dw_economie_volume dw_economie_volume
uo_toolbar uo_toolbar
uo_toolbar_haut uo_toolbar_haut
dw_economie_volume_detail dw_economie_volume_detail
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
rr_1 rr_1
end type
global w_economie_volume w_economie_volume

forward prototypes
public function long of_recupererprochainnumero ()
end prototypes

public function long of_recupererprochainnumero ();//////////////////////////////////////////////////////////////////////////////
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
//	Date			Programmeur				Description
//	2009-10-16	Sébastien Tremblay	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	min(noeconomievolume) + 1
INTO		:ll_no
FROM		t_economievolume
WHERE not exists (select 1 from t_economievolume ev where ev.noeconomievolume = t_economievolume.noeconomievolume + 1)
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_economie_volume.create
int iCurrent
call super::create
this.dw_economie_volume=create dw_economie_volume
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_economie_volume_detail=create dw_economie_volume_detail
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_economie_volume
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.uo_toolbar_haut
this.Control[iCurrent+4]=this.dw_economie_volume_detail
this.Control[iCurrent+5]=this.uo_toolbar_bas
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_economie_volume.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_economie_volume)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_haut)
destroy(this.dw_economie_volume_detail)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_noeconomievolume, ll_retour

ll_noeconomievolume = long(gnv_app.inv_entrepotglobal.of_retournedonnee( "lien econo"))
IF dw_economie_volume.event pfc_retrieve() > 0 THEN
	IF IsNull(ll_noeconomievolume) = FALSE AND ll_noeconomievolume > 0 THEN
		gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien econo", "")
		ll_retour = dw_economie_volume.Find("noeconomievolume = " + string(ll_noeconomievolume), 1, dw_economie_volume.RowCount())
		IF ll_retour > 0 THEN
			dw_economie_volume.SetRow(ll_retour)
			dw_economie_volume.ScrollToRow(ll_retour)
		END IF
	END IF
END IF
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter une économie", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Supprimer cette économie", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_AddItem("Rechercher une économie...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un prix", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer ce prix", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_economie_volume
integer x = 206
integer y = 60
string text = "Économie de volume"
end type

type p_8 from w_sheet_frame`p_8 within w_economie_volume
integer x = 59
integer y = 40
integer width = 123
integer height = 128
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\dol.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_economie_volume
integer height = 148
end type

type dw_economie_volume from u_dw within w_economie_volume
integer x = 101
integer y = 268
integer width = 4384
integer height = 276
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_economie_volume"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN This.Retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_EconomieVolume", TRUE)
END IF

RETURN AncestorReturnValue


IF AncestorReturnValue > 0 AND ib_en_insertion THEN
	n_ds lds_no_auto
	
	lds_no_auto = CREATE n_ds
	lds_no_auto.dataobject = "ds_classe_economie_no_auto"
	lds_no_auto.of_setTransobject(SQLCA)
	IF lds_no_auto.retrieve() > 0 THEN
		this.object.noeconomievolume[AncestorReturnValue] = lds_no_auto.object.maximum[1]
	END IF 
END IF

RETURN AncestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no

	//Pousser la valeur de la clé primaire
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.noeconomievolume[AncestorReturnValue] = ll_no
	
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from u_cst_toolbarstrip within w_economie_volume
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

type uo_toolbar_haut from u_cst_toolbarstrip within w_economie_volume
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 576
integer width = 4384
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter une économie"
		dw_economie_volume.event pfc_insertrow()
	CASE "Supprimer cette économie"
		dw_economie_volume.event pfc_deleterow()
	CASE "Rechercher une économie..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_economie_volume.RowCount() > 0 THEN
				dw_economie_volume.SetRow(1)
				dw_economie_volume.ScrollToRow(1)
				dw_economie_volume.event pfc_finddlg()
			END IF
		END IF		
		
END CHOOSE

end event

type dw_economie_volume_detail from u_dw within w_economie_volume
integer x = 160
integer y = 788
integer width = 4274
integer height = 1136
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_economie_volume_detail"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_economie_volume)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("noeconomievolume","noeconomievolume")

SetRowFocusindicator(Hand!)
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_EconomieVolumeDetail", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_economie_volume
event destroy ( )
string tag = "resize=frbsr"
integer x = 151
integer y = 1956
integer width = 4283
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un prix"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_economie_volume_detail.SetFocus()		
			dw_economie_volume_detail.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce prix"
		dw_economie_volume_detail.event pfc_deleterow()

END CHOOSE

end event

type gb_1 from u_gb within w_economie_volume
integer x = 105
integer y = 720
integer width = 4389
integer height = 1384
integer taborder = 0
long backcolor = 15793151
string text = "Prix pour un certain volume"
end type

type rr_1 from roundrectangle within w_economie_volume
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 204
integer width = 4549
integer height = 1968
integer cornerheight = 40
integer cornerwidth = 46
end type

