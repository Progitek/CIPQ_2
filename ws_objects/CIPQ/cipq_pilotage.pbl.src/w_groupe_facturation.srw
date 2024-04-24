$PBExportHeader$w_groupe_facturation.srw
forward
global type w_groupe_facturation from w_sheet_frame
end type
type dw_groupe_facturation from u_dw within w_groupe_facturation
end type
type dw_groupe_facturation_secondaire from u_dw within w_groupe_facturation
end type
type uo_toolbar from u_cst_toolbarstrip within w_groupe_facturation
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_groupe_facturation
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_groupe_facturation
end type
type gb_1 from u_gb within w_groupe_facturation
end type
type rr_1 from roundrectangle within w_groupe_facturation
end type
end forward

global type w_groupe_facturation from w_sheet_frame
string tag = "menu=m_groupedefacturation"
dw_groupe_facturation dw_groupe_facturation
dw_groupe_facturation_secondaire dw_groupe_facturation_secondaire
uo_toolbar uo_toolbar
uo_toolbar_haut uo_toolbar_haut
uo_toolbar_bas uo_toolbar_bas
gb_1 gb_1
rr_1 rr_1
end type
global w_groupe_facturation w_groupe_facturation

forward prototypes
public function integer of_recupererprochainnumero ()
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
//	2008-11-12	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(idgroupsecondaire) + 1
INTO		:ll_no
FROM		t_eleveur_groupsecondaire
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_groupe_facturation.create
int iCurrent
call super::create
this.dw_groupe_facturation=create dw_groupe_facturation
this.dw_groupe_facturation_secondaire=create dw_groupe_facturation_secondaire
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_haut=create uo_toolbar_haut
this.uo_toolbar_bas=create uo_toolbar_bas
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_groupe_facturation
this.Control[iCurrent+2]=this.dw_groupe_facturation_secondaire
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.uo_toolbar_haut
this.Control[iCurrent+5]=this.uo_toolbar_bas
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
end on

on w_groupe_facturation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_groupe_facturation)
destroy(this.dw_groupe_facturation_secondaire)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_haut)
destroy(this.uo_toolbar_bas)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_groupe_facturation.event pfc_retrieve()
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un groupe", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_haut.of_AddItem("Supprimer ce groupe", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_haut.of_AddItem("Rechercher un groupe...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un sous-groupe", "AddWatch5!")
uo_toolbar_bas.of_AddItem("Supprimer ce sous-groupe", "DeleteWatch5!")
uo_toolbar_bas.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_groupe_facturation
string text = "Groupe de facturation"
end type

type p_8 from w_sheet_frame`p_8 within w_groupe_facturation
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_groupe_facturation
end type

type dw_groupe_facturation from u_dw within w_groupe_facturation
integer x = 73
integer y = 232
integer width = 4402
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_groupe_facturation"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_ELEVEUR_Group", TRUE)
END IF

IF AncestorReturnValue > 0 AND ib_en_insertion THEN
	n_ds lds_no_auto
	
	lds_no_auto = CREATE n_ds
	lds_no_auto.dataobject = "ds_groupe_facturation_no_auto"
	lds_no_auto.of_setTransobject(SQLCA)
	IF lds_no_auto.retrieve() > 0 THEN
		this.object.idgroup[AncestorReturnValue] = lds_no_auto.object.maximum[1]
	END IF 
END IF

RETURN AncestorReturnValue
end event

type dw_groupe_facturation_secondaire from u_dw within w_groupe_facturation
integer x = 160
integer y = 848
integer width = 4283
integer height = 1136
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_groupe_facturation_secondaire"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_groupe_facturation)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("idgroup","idgroup")

SetRowFocusindicator(Hand!)
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.idgroupsecondaire[AncestorReturnValue] = ll_no
	
END IF


RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_ELEVEUR_GroupSecondaire", TRUE)
END IF
end event

type uo_toolbar from u_cst_toolbarstrip within w_groupe_facturation
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2220
integer width = 4544
integer taborder = 40
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

type uo_toolbar_haut from u_cst_toolbarstrip within w_groupe_facturation
event destroy ( )
string tag = "resize=frbsr"
integer x = 110
integer y = 616
integer width = 4375
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un groupe"
		dw_groupe_facturation.event pfc_insertrow()
	CASE "Supprimer ce groupe"
		dw_groupe_facturation.event pfc_deleterow()
	CASE "Rechercher un groupe..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_groupe_facturation.RowCount() > 0 THEN
				dw_groupe_facturation.SetRow(1)
				dw_groupe_facturation.ScrollToRow(1)
				dw_groupe_facturation.event pfc_finddlg()
			END IF
		END IF		
		
END CHOOSE

end event

type uo_toolbar_bas from u_cst_toolbarstrip within w_groupe_facturation
event destroy ( )
string tag = "resize=frbsr"
integer x = 151
integer y = 1956
integer width = 4283
integer taborder = 50
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un sous-groupe"
		IF PARENT.event pfc_save() >= 0 THEN
			dw_groupe_facturation_secondaire.SetFocus()		
			dw_groupe_facturation_secondaire.event pfc_insertrow()
		END IF
		
	CASE "Supprimer ce sous-groupe"
		dw_groupe_facturation_secondaire.event pfc_deleterow()

END CHOOSE

end event

type gb_1 from u_gb within w_groupe_facturation
integer x = 110
integer y = 776
integer width = 4384
integer height = 1324
integer taborder = 0
long backcolor = 15793151
string text = "Sous-groupes"
end type

type rr_1 from roundrectangle within w_groupe_facturation
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 184
integer width = 4549
integer height = 1992
integer cornerheight = 40
integer cornerwidth = 46
end type

