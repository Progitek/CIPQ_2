$PBExportHeader$pro_u_tabpg.sru
$PBExportComments$(PRO) Extension TabPage class
forward
global type pro_u_tabpg from pfc_u_tabpg
end type
end forward

global type pro_u_tabpg from pfc_u_tabpg
integer width = 1975
integer height = 1220
event pro_getfocus ( integer ai_oldindex )
event pro_selectionchanging ( integer ai_oldindex,  integer ai_newindex )
event pro_selectionchanged ( integer ai_oldindex,  integer ai_newindex )
end type
global pro_u_tabpg pro_u_tabpg

type variables
u_tab	 	itab_Parent
end variables

forward prototypes
public function integer of_getparentwindow (ref w_master aw_parent)
public function integer of_getparentuo (ref userobject auo_parent)
public function integer of_getparenttab (u_tab atab_parent)
public subroutine of_focussuronglet ()
end prototypes

event pro_getfocus(integer ai_oldindex);w_master 	lw_parent
m_master		lm_menu
menu			lm_item

THIS.of_GetParentWindow(lw_parent)

lw_parent.EVENT pfc_controlgotfocus( itab_Parent)


THIS.of_FocusSurOnglet()
end event

public function integer of_getparentwindow (ref w_master aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetParentWindow
//
//	Accès:  			Public
//
//	Arguments:		w_parent aw_parent par référence
//
//	Retourne:		1
//
//	Description:	Retourne un pointeur de la fenêtre
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

graphicobject	lgo_object

lgo_object = this

DO
	lgo_object = GetParent(lgo_object)
LOOP WHILE TypeOf(lgo_object) <> Window!

aw_Parent = lgo_object

return 1
end function

public function integer of_getparentuo (ref userobject auo_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetParentUo
//
//	Accès:  			Public
//
//	Arguments:		userobject auo_parent par référence
//
//	Retourne:		-1 erreur
//
//	Description:	Retourne un pointeur du UserObject parent du tab parent
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

u_tab	lgo_tab
GraphicObject lgo_parent

THIS.of_GetParentTab(lgo_tab)

lgo_parent = lgo_tab.GetParent()

IF lgo_parent.TypeOf() = UserObject! THEN
	auo_parent = lgo_parent
	RETURN 1
ELSE
	RETURN -1
END IF

RETURN 1
end function

public function integer of_getparenttab (u_tab atab_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_GetParentTab
//
//	Accès:  			Public
//
//	Arguments:		u_tab au_tab par référence
//
//	Retourne:		-1 erreur
//
//	Description:	Retourne un pointeur du tab parent
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

graphicobject	lgo_tab

lgo_tab = GetParent()

IF lgo_tab.TypeOf() = Tab! THEN
	atab_parent = lgo_tab
	RETURN 1
ELSE
	RETURN -1
END IF

return 1
end function

public subroutine of_focussuronglet ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_FocusSurOnglet
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:		Rien
//
//	Description:	Mettre le focus sur la première DW de l'onglet courant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

Int		li_boucle, li_nb_ctrl
Long		ll_rangee
u_dw		ldw_present_pfc, ldw_Master, ldw_Root, ldw_focus
w_master lw_parent
u_tab		ltab_parent

// Trouver l'objet TAB parent
// Ainsi que la fenêtre parent
ltab_parent = This.GetParent()
ltab_parent.of_GetParentWindow( lw_parent )

// On boucle sur tous les controle de l'onglet
// afin de trouver une DW
//
li_nb_ctrl = UpperBound( This.Control[] )

FOR li_boucle=1 TO li_nb_ctrl
	If This.Control[ li_boucle ].typeOf() = DataWindow! Then
		// Vérifie si la DW est de type PFC (u_dw)
		//

		ldw_present_pfc = This.Control[ li_boucle ]
		
		// Verifie si la DW utilise le service de Linkage
		//
		If IsValid( ldw_present_pfc.inv_linkage ) Then
			// Trouve la DW ROOT
			//
			ldw_present_pfc.inv_linkage.of_FindRoot( ldw_Root )
			
			// On cherche la DW racine pour la DW courante
			//
			If ldw_present_pfc.inv_linkage.of_GetMaster( ldw_Master ) = 1 Then
				If ldw_Root = ldw_Master Then
					// Si la DW racine est la DW ROOt, on laisse le focus
					// sur la DW courante.
					//
					ldw_focus = ldw_present_pfc
				Else
					// On met le focus sur la DW racine.
					//
					ldw_focus = ldw_Master
				End If
			Else
				// La DW courante est la DW racine
				//
				ldw_focus = ldw_present_pfc
			End If
		Else
			// Le service de linkage n'est pas utilisé, donc on met le
			// focus sur la DW courante.
			//
			ldw_focus = ldw_present_pfc
		End If
		
		ldw_focus.SetFocus()
		
		ldw_focus.POST EVENT GetFocus()
		
		IF ll_rangee > 0 THEN
			ldw_focus.Event ItemFocusChanged(ldw_focus.GetRow(), ldw_focus.idwo_current)
		END IF
		Return
	End If
NEXT

This.SetFocus()

Return
end subroutine

on pro_u_tabpg.create
call super::create
end on

on pro_u_tabpg.destroy
call super::destroy
end on

event constructor;call super::constructor;THIS.of_GetParentTab(itab_Parent)

end event

