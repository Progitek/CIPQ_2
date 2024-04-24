HA$PBExportHeader$u_tabpg_isolement_principal.sru
forward
global type u_tabpg_isolement_principal from u_tabpg
end type
type cbx_annexer from u_cbx within u_tabpg_isolement_principal
end type
type uo_toolbar_haut from u_cst_toolbarstrip within u_tabpg_isolement_principal
end type
type dw_isolement_principal from u_dw within u_tabpg_isolement_principal
end type
end forward

global type u_tabpg_isolement_principal from u_tabpg
integer width = 4425
integer height = 1828
long backcolor = 15793151
long tabbackcolor = 15793151
cbx_annexer cbx_annexer
uo_toolbar_haut uo_toolbar_haut
dw_isolement_principal dw_isolement_principal
end type
global u_tabpg_isolement_principal u_tabpg_isolement_principal

forward prototypes
public function integer of_recupererprochainnumero ()
end prototypes

public function integer of_recupererprochainnumero ();//////////////////////////////////////////////////////////////////////////////
//
//	M$$HEX1$$e900$$ENDHEX$$thode:  		of_recupererprochainnumero
//
//	Acc$$HEX1$$e800$$ENDHEX$$s:  			Public
//
//	Argument:		String - Nom du centre
//
//	Retourne:  		Prix
//
// Description:	Fonction pour trouver la valeur du prochain num$$HEX1$$e900$$ENDHEX$$ro de 
//						lot
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-10-04	Mathieu Gendron	Cr$$HEX1$$e900$$ENDHEX$$ation
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(nolot) + 1
INTO		:ll_no
FROM		t_isolementlot
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on u_tabpg_isolement_principal.create
int iCurrent
call super::create
this.cbx_annexer=create cbx_annexer
this.uo_toolbar_haut=create uo_toolbar_haut
this.dw_isolement_principal=create dw_isolement_principal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_annexer
this.Control[iCurrent+2]=this.uo_toolbar_haut
this.Control[iCurrent+3]=this.dw_isolement_principal
end on

on u_tabpg_isolement_principal.destroy
call super::destroy
destroy(this.cbx_annexer)
destroy(this.uo_toolbar_haut)
destroy(this.dw_isolement_principal)
end on

type cbx_annexer from u_cbx within u_tabpg_isolement_principal
integer x = 32
integer y = 1748
integer width = 654
integer height = 68
long backcolor = 15793151
string text = "Annexer la liste de verrats"
end type

type uo_toolbar_haut from u_cst_toolbarstrip within u_tabpg_isolement_principal
event destroy ( )
string tag = "resize=frbsr"
integer x = 78
integer y = 1596
integer width = 4160
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_haut.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Ajouter un lot"
		dw_isolement_principal.event pfc_insertrow()
END CHOOSE
end event

type dw_isolement_principal from u_dw within u_tabpg_isolement_principal
integer x = 5
integer y = 32
integer width = 4416
integer height = 1800
integer taborder = 10
string dataobject = "d_isolement_principal"
end type

event constructor;call super::constructor;THIS.of_setfind( true)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.retrieve()
end event

event clicked;call super::clicked;long	ll_site
menu	lm_item, lm_menu
n_cst_menu	lnv_menu
datetime	ld_sortie

lm_menu = gnv_app.of_getframe().MenuID

IF row > 0 THEN
	
	CHOOSE CASE dwo.name 
		CASE "p_file"
			// ON REMPLACE LE CODE VERRAT PAR LE NOLOT JUSTE POUR LES VERRATS EN ISOLEMENT !!! 
			gnv_app.inv_entrepotglobal.of_ajoutedonnee('nolot', dw_isolement_principal.object.nolot[dw_isolement_principal.getrow( )])
			OpenSheet(w_savefile,gnv_app.of_GetFrame(),6,layered!)
		CASE "p_site"
			ll_site = THIS.object.nosite[row]
			IF ll_site <> 0 AND IsNull(ll_site) = FALSE THEN
	
				IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
					gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien site", string(ll_site))
					IF lnv_menu.of_GetMenuReference (lm_menu,"m_sitesdesverratsenisolement", lm_item) > 0 THEN
						IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
							lm_item.event clicked()
						END IF
					END IF 
				END IF
				
			END IF
			
			
	END CHOOSE	
END IF
end event

event pfc_insertrow;call super::pfc_insertrow;long 	ll_no
w_lot_verrats_isolement	lw_window

IF AncestorReturnValue > 0 THEN
	//THIS.object.dateentre[AncestorReturnValue] = Today()
	
	ll_no = PARENT.of_recupererprochainnumero( )
	THIS.object.nolot[AncestorReturnValue] = ll_no	
	
	lw_window = this.of_getfenetreparent()
	
	lw_window.tab_isolement.tabpage_isolement_calendrier.visible = FALSE
	lw_window.tab_isolement.tabpage_isolement_calendrier_avril2007.visible = FALSE
	lw_window.tab_isolement.tabpage_isolement_calendrier_aout2009.visible = FALSE
	lw_window.tab_isolement.tabpage_isolement_calendrier_fevrier2010.visible = FALSE
	
END IF

RETURN AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF


long		ll_row
datetime	ld_entree, ld_sortie, ld_acceptation

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	
	ld_entree = THIS.object.dateentre[ll_row]
	ld_sortie = THIS.object.datesortie[ll_row]
	ld_acceptation = THIS.object.dateacceptationveterinaire[ll_row]
	
	IF ld_sortie < ld_entree THEN
		gnv_app.inv_error.of_message("CIPQ0039")
		RETURN FAILURE
	END IF
	
	IF ld_acceptation < ld_entree THEN
		gnv_app.inv_error.of_message("CIPQ0040")
		RETURN FAILURE
	END IF
		
END IF
RETURN ancestorreturnvalue
end event

event itemchanged;call super::itemchanged;datetime	ld_sortie, ld_sortie_verrat
long		ll_nbrow, ll_cpt
w_lot_verrats_isolement	lw_wind

IF row > 0 THEN
	CHOOSE CASE dwo.name
		CASE "datesortie"
			ld_sortie = datetime(data)
			//Mettre $$HEX2$$e0002000$$ENDHEX$$jour les dates de sortie de verrat
			lw_wind = THIS.of_getfenetreparent()
			ll_nbrow = lw_wind.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.RowCount()
			FOR ll_cpt = 1 TO ll_nbrow
				ld_sortie_verrat = lw_wind.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.object.datesortieverrat[row]
				IF IsNull(ld_sortie_verrat) THEN
					lw_wind.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.object.datesortieverrat[row] = ld_sortie
					lw_wind.tab_isolement.tabpage_isolement_liste.dw_isolement_verrat.AcceptText()
				END IF
			END FOR
		CASE "dateentre"
			lw_wind = THIS.of_getfenetreparent()
			
			lw_wind.tab_isolement.tabpage_isolement_calendrier.visible = false
			lw_wind.tab_isolement.tabpage_isolement_calendrier_avril2007.visible = false
			lw_wind.tab_isolement.tabpage_isolement_calendrier_aout2009.visible = false
			lw_wind.tab_isolement.tabpage_isolement_calendrier_fevrier2010.visible = false
			
			choose case date(data)
				case is < 2007-04-01
					lw_wind.tab_isolement.tabpage_isolement_calendrier.visible = TRUE
				case is < 2009-08-01
					lw_wind.tab_isolement.tabpage_isolement_calendrier_avril2007.visible = TRUE
				case is < 2010-03-23
					lw_wind.tab_isolement.tabpage_isolement_calendrier_aout2009.visible = TRUE
				case is >= 2010-03-23
					lw_wind.tab_isolement.tabpage_isolement_calendrier_fevrier2010.visible = TRUE
			end choose
	END CHOOSE
END IF
			

end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
	datetime 					ldt_entree
	w_lot_verrats_isolement	lw_window
	
	ldt_entree = THIS.object.dateentre[currentrow]
	if isNull(ldt_entree) then ldt_entree = THIS.object.dateacceptationveterinaire[currentrow]
	
	parent.of_getparentwindow( lw_window)
	
	lw_window.tab_isolement.tabpage_isolement_calendrier.visible = false
	lw_window.tab_isolement.tabpage_isolement_calendrier_avril2007.visible = false
	lw_window.tab_isolement.tabpage_isolement_calendrier_aout2009.visible = false
	lw_window.tab_isolement.tabpage_isolement_calendrier_fevrier2010.visible = false
	
	//D$$HEX1$$e900$$ENDHEX$$sactiver le tabpg en fonction de la date
	IF ib_en_insertion = FALSE THEN
		choose case date(ldt_entree)
			case is < 2007-04-01
				lw_window.tab_isolement.tabpage_isolement_calendrier.visible = TRUE
			case is < 2009-08-01
				lw_window.tab_isolement.tabpage_isolement_calendrier_avril2007.visible = TRUE
			case is < 2010-03-23
				lw_window.tab_isolement.tabpage_isolement_calendrier_aout2009.visible = TRUE
			case is >= 2010-03-23
				lw_window.tab_isolement.tabpage_isolement_calendrier_fevrier2010.visible = TRUE
		end choose
	END IF
	
END IF
end event

event pfc_postupdate;call super::pfc_postupdate;	
//Rafraichir les dw des autres onglets
w_lot_verrats_isolement	lw_window
long ll_row, ll_nolot

ll_row = THIS.GetRow()

IF ll_row > 0 THEN
	parent.of_getparentwindow( lw_window)
	ll_nolot = THIS.object.nolot[ll_row]
	
	lw_window.tab_isolement.tabpage_isolement_calendrier.dw_isolement_calendrier.retrieve(ll_nolot)
	lw_window.tab_isolement.tabpage_isolement_calendrier_avril2007.dw_isolement_calendrier_avril2007.retrieve(ll_nolot)
	lw_window.tab_isolement.tabpage_isolement_calendrier_aout2009.dw_isolement_calendrier_aout2009.retrieve(ll_nolot)
	lw_window.tab_isolement.tabpage_isolement_calendrier_fevrier2010.dw_isolement_calendrier_fevrier2010.retrieve(ll_nolot)
END IF
	
RETURN AncestorReturnValue
end event

