$PBExportHeader$w_prepose_recolte.srw
forward
global type w_prepose_recolte from w_sheet
end type
type uo_toolbar from u_cst_toolbarstrip within w_prepose_recolte
end type
type st_title from st_uo_transparent within w_prepose_recolte
end type
type p_8 from picture within w_prepose_recolte
end type
type dw_prepose_recolte from u_dw within w_prepose_recolte
end type
type dw_prepose_recolte_centre from u_dw within w_prepose_recolte
end type
type gb_1 from u_gb within w_prepose_recolte
end type
type rr_1 from roundrectangle within w_prepose_recolte
end type
type rr_infopat from roundrectangle within w_prepose_recolte
end type
type gb_2 from u_gb within w_prepose_recolte
end type
type uo_toolbar_bas from u_cst_toolbarstrip within w_prepose_recolte
end type
type uo_toolbar_haut from u_cst_toolbarstrip within w_prepose_recolte
end type
end forward

global type w_prepose_recolte from w_sheet
string tag = "menu=m_preposesauxrecoltes"
integer width = 3689
integer height = 2096
string title = "Préposés aux récoltes"
uo_toolbar uo_toolbar
st_title st_title
p_8 p_8
dw_prepose_recolte dw_prepose_recolte
dw_prepose_recolte_centre dw_prepose_recolte_centre
gb_1 gb_1
rr_1 rr_1
rr_infopat rr_infopat
gb_2 gb_2
uo_toolbar_bas uo_toolbar_bas
uo_toolbar_haut uo_toolbar_haut
end type
global w_prepose_recolte w_prepose_recolte

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

SELECT 	max(prepid) + 1
INTO		:ll_no
FROM		t_preprecolte
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_prepose_recolte.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.st_title=create st_title
this.p_8=create p_8
this.dw_prepose_recolte=create dw_prepose_recolte
this.dw_prepose_recolte_centre=create dw_prepose_recolte_centre
this.gb_1=create gb_1
this.rr_1=create rr_1
this.rr_infopat=create rr_infopat
this.gb_2=create gb_2
this.uo_toolbar_bas=create uo_toolbar_bas
this.uo_toolbar_haut=create uo_toolbar_haut
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.st_title
this.Control[iCurrent+3]=this.p_8
this.Control[iCurrent+4]=this.dw_prepose_recolte
this.Control[iCurrent+5]=this.dw_prepose_recolte_centre
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rr_1
this.Control[iCurrent+8]=this.rr_infopat
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.uo_toolbar_bas
this.Control[iCurrent+11]=this.uo_toolbar_haut
end on

on w_prepose_recolte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.st_title)
destroy(this.p_8)
destroy(this.dw_prepose_recolte)
destroy(this.dw_prepose_recolte_centre)
destroy(this.gb_1)
destroy(this.rr_1)
destroy(this.rr_infopat)
destroy(this.gb_2)
destroy(this.uo_toolbar_bas)
destroy(this.uo_toolbar_haut)
end on

event pfc_postopen;call super::pfc_postopen;dw_prepose_recolte.event pfc_retrieve()
end event

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

uo_toolbar_haut.of_settheme("classic")
uo_toolbar_haut.of_DisplayBorder(true)
uo_toolbar_haut.of_AddItem("Ajouter un préposé", "C:\ii4net\CIPQ\images\ajout_personne.ico")
uo_toolbar_haut.of_AddItem("Supprimer ce préposé", "C:\ii4net\CIPQ\images\suppr_personne.ico")
uo_toolbar_haut.of_AddItem("Rechercher...", "Search!")
uo_toolbar_haut.of_displaytext(true)

uo_toolbar_bas.of_settheme("classic")
uo_toolbar_bas.of_DisplayBorder(true)
uo_toolbar_bas.of_AddItem("Ajouter un centre associé", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar_bas.of_AddItem("Supprimer ce centre associé", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar_bas.of_displaytext(true)
end event

type uo_toolbar from u_cst_toolbarstrip within w_prepose_recolte
event destroy ( )
string tag = "resize=frbsr"
integer x = 9
integer y = 1716
integer width = 3538
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Rechercher..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_prepose_recolte.RowCount() > 0 THEN
				dw_prepose_recolte.SetRow(1)
				dw_prepose_recolte.ScrollToRow(1)
				dw_prepose_recolte.event pfc_finddlg()
			END IF
		END IF		
		
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type st_title from st_uo_transparent within w_prepose_recolte
string tag = "resize=frbsr"
integer x = 160
integer y = 52
integer width = 1161
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
long backcolor = 15793151
string text = "Préposés aux récoltes"
end type

type p_8 from picture within w_prepose_recolte
string tag = "resize=frb"
integer x = 55
integer y = 52
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\people2.bmp"
boolean focusrectangle = false
end type

type dw_prepose_recolte from u_dw within w_prepose_recolte
integer x = 91
integer y = 260
integer width = 3351
integer height = 284
integer taborder = 10
string dataobject = "d_prepose_recolte"
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.RETRIEVE()
end event

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.prepid[AncestorReturnValue] = ll_no
	
END IF


RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_PrepRecolte", TRUE)
END IF

RETURN AncestorReturnValue
end event

type dw_prepose_recolte_centre from u_dw within w_prepose_recolte
integer x = 101
integer y = 836
integer width = 3351
integer height = 656
integer taborder = 20
string dataobject = "d_prepose_recolte_centre"
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
this.inv_linkage.of_SetMaster(dw_prepose_recolte)
this.inv_linkage.of_SetTransObject(SQLCA)
this.inv_Linkage.of_SetStyle(this.inv_Linkage.RETRIEVE)
this.inv_linkage.of_Register("prepid","prepid_d")

THIS.SetRowFocusIndicator ( Hand! )
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_PrepCentre", TRUE)
END IF

RETURN AncestorReturnValue
end event

type gb_1 from u_gb within w_prepose_recolte
integer x = 64
integer y = 196
integer width = 3438
integer height = 508
integer taborder = 0
long backcolor = 15793151
string text = "Préposé"
end type

type rr_1 from roundrectangle within w_prepose_recolte
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 160
integer width = 3525
integer height = 1528
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_infopat from roundrectangle within w_prepose_recolte
string tag = "resize=frbsr"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 36
integer width = 3529
integer height = 100
integer cornerheight = 75
integer cornerwidth = 75
end type

type gb_2 from u_gb within w_prepose_recolte
integer x = 64
integer y = 720
integer width = 3438
integer height = 924
integer taborder = 0
long backcolor = 15793151
string text = "Centres associés"
end type

type uo_toolbar_bas from u_cst_toolbarstrip within w_prepose_recolte
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 1512
integer width = 3342
boolean bringtotop = true
end type

on uo_toolbar_bas.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Ajouter un centre associé"
		
		IF PARENT.event pfc_save() >= 0 THEN
			dw_prepose_recolte_centre.SetFocus()
			dw_prepose_recolte_centre.event pfc_insertrow()
		END IF
	CASE "Supprimer ce centre associé"
		dw_prepose_recolte_centre.event pfc_deleterow()

END CHOOSE

end event

type uo_toolbar_haut from u_cst_toolbarstrip within w_prepose_recolte
event destroy ( )
string tag = "resize=frbsr"
integer x = 105
integer y = 564
integer width = 3342
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un préposé"
		dw_prepose_recolte.event pfc_insertrow()
		dw_prepose_recolte.SetFocus()
	CASE "Supprimer ce préposé"
		dw_prepose_recolte.event pfc_deleterow()
	CASE "Rechercher..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_prepose_recolte.RowCount() > 0 THEN
				dw_prepose_recolte.SetRow(1)
				dw_prepose_recolte.ScrollToRow(1)
				dw_prepose_recolte.event pfc_finddlg()
			END IF
		END IF		
				
END CHOOSE

end event

