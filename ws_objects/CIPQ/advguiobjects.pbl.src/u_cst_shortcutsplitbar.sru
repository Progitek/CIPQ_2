$PBExportHeader$u_cst_shortcutsplitbar.sru
forward
global type u_cst_shortcutsplitbar from u_canvas
end type
end forward

global type u_cst_shortcutsplitbar from u_canvas
integer width = 581
integer height = 24
long backcolor = 16711680
string pointer = "HyperLink!"
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event paint pbm_paint
event clicked pbm_lbuttonup
event mousewithin pbm_mousemove
event mouseenter ( )
event mouseleave ( )
event resize pbm_size
event lbuttonup pbm_lbuttonup
event lbuttondown pbm_lbuttondown
end type
global u_cst_shortcutsplitbar u_cst_shortcutsplitbar

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
end prototypes

type variables
Boolean ib_selected
Boolean ib_used
Boolean ib_mousecaptured

n_cst_shortcutbar_gradient	in_gradient

u_cst_shortcutbar iuo_parent

DragObject iuo_object
end variables

forward prototypes
public function integer of_setparent (u_cst_shortcutbar auo_parent)
public function integer of_settext (string as_text)
public function string of_gettext ()
public function integer of_position (long al_x, long al_y, long al_width, long al_height)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_drawgrabbers (long ahdc)
end prototypes

public function integer of_setparent (u_cst_shortcutbar auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_settext (string as_text);//_text.Text = as_text

RETURN 1
end function

public function string of_gettext ();RETURN ''//st_text.Text
end function

public function integer of_position (long al_x, long al_y, long al_width, long al_height);iuo_object.Move(al_x, al_y)
iuo_object.Resize(al_width, al_height)

RETURN 1
end function

public function integer of_capturemouse ();
if of_ismousecaptured() then Return -1

SetCapture(handle(this))

ib_mousecaptured = TRUE

return 1
end function

public function boolean of_ismousecaptured ();
return ib_mousecaptured
end function

public function integer of_releasemouse ();
if NOT of_ismousecaptured() then return -1

ReleaseCapture()

ib_mousecaptured = FALSE

Return 1
end function

public function integer of_drawgrabbers (long ahdc);Long ll_start
Long ll_index

ll_start = UnitsToPixels(Width / 2, XUnitsToPixels!) - 16

FOR ll_index = 1 TO 9
	SetPixel(ahdc, ll_start, 2, RGB(255,255,255))
	SetPixel(ahdc, ll_start + 1, 2, RGB(255,255,255))
	SetPixel(ahdc, ll_start, 3, RGB(255,255,255))
	SetPixel(ahdc, ll_start + 1, 3, RGB(255,255,255))
	
	SetPixel(ahdc, ll_start - 1, 1, RGB(40,50,71))
	SetPixel(ahdc, ll_start, 1, RGB(40,50,71))
	SetPixel(ahdc, ll_start - 1, 2, RGB(40,50,71))
	SetPixel(ahdc, ll_start, 2, RGB(97,116,152))
	
	ll_start = ll_start + 4
	
NEXT

RETURN 1
end function

on u_cst_shortcutsplitbar.create
call super::create
end on

on u_cst_shortcutsplitbar.destroy
call super::destroy
end on

event onpaint;call super::onpaint;IF IsValid(iuo_parent) THEN
	
	in_Gradient.of_SetHDC(hdc)
	
	in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("SPLITBAR1"), iuo_parent.of_GetColor("SPLITBAR2"), THIS, FALSE, 0, iuo_parent.XP)
	
	of_DrawGrabbers(hdc)
	//st_text.TriggerEvent("paint")
	//st_text2.TriggerEvent("paint")
END IF

RETURN 1
end event

