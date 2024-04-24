$PBExportHeader$u_cst_tabpage.sru
forward
global type u_cst_tabpage from userobject
end type
end forward

global type u_cst_tabpage from userobject
integer width = 1536
integer height = 896
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event selectionchanging pbm_tcnselchanging
event selectionchanged pbm_tcnselchanged
event resize pbm_size
event ue_postconstructor ( )
end type
global u_cst_tabpage u_cst_tabpage

forward prototypes
public subroutine of_settheme (string as_color)
end prototypes

event selectionchanging;// -----------------------------------------------------------------------------
// SCRIPT:		u_cst_tabpage.SelectionChanging
//
// PURPOSE:		Occurs when another tab page is about to be selected.
//
// ARGUMENTS:	oldindex - The index of the currently selected tab.
//					newindex - The index of the tab that is about to be selected.
//
// RETURN:		0 = Allow the selection to change.
//					1 = Prevent the selection from changing.
// -----------------------------------------------------------------------------

Return 0

end event

event selectionchanged;// -----------------------------------------------------------------------------
// SCRIPT:		u_cst_tabpage.SelectionChanged
//
// PURPOSE:		Occurs when the tab page is selected.
//
// ARGUMENTS:	oldindex - The index of the tab that was previously selected.
//					newindex - The index of the tab that has become selected.
//
// RETURN:		0 = Continue processing.
// -----------------------------------------------------------------------------

Return 0

end event

event resize;// -----------------------------------------------------------------------------
// SCRIPT:		u_cst_tabpage.Resize
//
// PURPOSE:		Occurs when the tab page is resized.
//
// ARGUMENTS:	sizetype  - Only applies to Windows
//					newwidth  - New width of the control in PB units
//					newheight - New height of the control in PB units
//
// RETURN:		0 = Continue processing.
// -----------------------------------------------------------------------------

Return 0

end event

event ue_postconstructor();// -----------------------------------------------------------------------------
// SCRIPT:		u_cst_tabpage.ue_PostConstructor
//
// PURPOSE:		Occurs after the tab page is created.
//
// RETURN:		None
// -----------------------------------------------------------------------------

end event

public subroutine of_settheme (string as_color);// -----------------------------------------------------------------------------
// SCRIPT:		u_cst_tabpage.of_SetTheme
//
// PURPOSE:		This function can be called from the window object for
//					all tabpages. Within each tabpage, call of_SetTheme on
//					each advanced GUI control.
//
// ARGUMENTS:	as_color - Name of the theme
//
// RETURN:		None
// -----------------------------------------------------------------------------

end subroutine

on u_cst_tabpage.create
end on

on u_cst_tabpage.destroy
end on

event constructor;// -----------------------------------------------------------------------------
// SCRIPT:		u_cst_tabpage.Constructor
//
// PURPOSE:		Occurs when the tab page is created.
//
// RETURN:		0 = Continue processing.
// -----------------------------------------------------------------------------

this.Post Event ue_PostConstructor()

Return 0

end event

