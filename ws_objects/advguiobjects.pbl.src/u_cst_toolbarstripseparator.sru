$PBExportHeader$u_cst_toolbarstripseparator.sru
forward
global type u_cst_toolbarstripseparator from u_cst_toolbarstripitem
end type
end forward

global type u_cst_toolbarstripseparator from u_cst_toolbarstripitem
integer width = 27
integer height = 88
end type
global u_cst_toolbarstripseparator u_cst_toolbarstripseparator

type variables
u_cst_toolbarstrip iuo_parent
n_cst_toolbarstrip_gradient in_Gradient

CONSTANT Long XP = 0
CONSTANT Long VISTAEMBOSSED = 1
CONSTANT Long VISTAORIGINAL = 2
CONSTANT Long VISTAGLASS = 3
CONSTANT Long CUSTOM = 4

Long il_CurrentSytle = XP
end variables

forward prototypes
public function integer of_drawline ()
public function integer of_setparent (u_cst_toolbarstrip auo_parent)
public function integer of_setstyle (long al_style)
end prototypes

public function integer of_drawline ();Long ll_x1, ll_x2, ll_y1, ll_y2

ll_x1 = 10
ll_y1 = 10
ll_x2 = 10
ll_y2 = 70

in_Gradient.of_DrawVerticalLine(ll_x1, ll_y1, ll_x2, ll_y2, iuo_parent.of_GetColor('SEPARATOR'))

RETURN 1

end function

public function integer of_setparent (u_cst_toolbarstrip auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_setstyle (long al_style);il_CurrentSytle = al_style

RETURN 1
end function

on u_cst_toolbarstripseparator.create
call super::create
end on

on u_cst_toolbarstripseparator.destroy
call super::destroy
end on

event onpaint;IF IsValid(iuo_parent) THEN

	in_Gradient.of_SetHDC(hdc)
	in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("BACKGROUND1"), iuo_parent.of_GetColor("BACKGROUND2"), THIS,FALSE,0, il_CurrentSytle)	
	of_DrawLine()
END IF

RETURN 1
end event

