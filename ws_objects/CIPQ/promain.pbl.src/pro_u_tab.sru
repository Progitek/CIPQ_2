$PBExportHeader$pro_u_tab.sru
$PBExportComments$(PRO) Extension Tab class
forward
global type pro_u_tab from pfc_u_tab
end type
end forward

global type pro_u_tab from pfc_u_tab
end type
global pro_u_tab pro_u_tab

event getfocus;call super::getfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			getfocus
//
//
//	Description:	Notify the parent window that this control got focus.
//
//////////////////////////////////////////////////////////////////////////////

w_master 	lw_parent
Long			ll_index_courant
u_tabpg		ltabpg_courant

THIS.of_GetParentWindow(lw_parent)
If IsValid(lw_parent) Then
	// Dynamic call to the parent window.
	lw_parent.dynamic event pfc_ControlGotFocus (this)
End If

// Met le focus sur le tabPg courant
//
ll_index_courant = This.SelectedTab
ltabpg_courant = This.control[ll_index_courant]
ltabpg_courant.EVENT POST pro_getfocus(ll_index_courant)
end event

event selectionchanging;call super::selectionchanging;u_tabpg 	ltabpg_Courant
w_master lw_parent
u_dw		ldw_active

//Les event sont redirigés vers l'onglet

// vérifier si la mise à jour est
// faite sans erreurs sinon empêcher changement d'onglet
this.of_GetParentWindow(lw_parent)

IF lw_parent.Event pfc_save() < 0 THEN
	RETURN 1
END IF

//Redirige l'évévenement vers l'onglet courant
if oldindex > 0 then
	ltabpg_Courant = Control[oldindex]
	ltabpg_Courant.EVENT pro_selectionchanging(oldindex,newindex)
end if

SetPointer(Hourglass!)
gnv_app.of_GetFrame().SetRedraw(FALSE)
end event

event selectionchanged;call super::selectionchanged;u_tabpg 				ltabpg_Courant
w_master 			lw_parent
n_cst_metaclass  	lnv_metaclass
classdefinition  	lcd_ancestor[ ]

SetPointer(Hourglass!)


//Les event sont redirigés vers l'onglet

// assigner la dw précédente
this.of_GetParentWindow(lw_parent)

//Redirige l'événement vers l'onglet courant
if newindex > 0 then
	ltabpg_Courant = Control[newindex]
	ltabpg_Courant.EVENT pro_selectionchanged(oldindex,newindex)
end if	

//Appel l'évènement pro_getfocus
if newindex > 0 then
	ltabpg_Courant = Control[newindex]
	ltabpg_Courant.EVENT POST pro_getfocus(oldindex)
end if	

// Traitement pour conserver l'indice de l'onglet courant
// (pour une fenêtre utilisant un treeview seulement)
lnv_metaclass.of_GetAncestorClasses (className(lw_parent), lcd_ancestor[ ])

gnv_app.of_GetFrame().SetRedraw(TRUE)
end event

