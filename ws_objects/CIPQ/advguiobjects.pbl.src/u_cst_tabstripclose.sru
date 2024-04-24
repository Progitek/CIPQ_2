$PBExportHeader$u_cst_tabstripclose.sru
forward
global type u_cst_tabstripclose from u_canvas
end type
end forward

global type u_cst_tabstripclose from u_canvas
integer width = 64
integer height = 56
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
end type
global u_cst_tabstripclose u_cst_tabstripclose

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
end prototypes

type variables
Boolean ib_selected
Boolean ib_mousecaptured

u_cst_tabstripnavigate iuo_parent

n_cst_tabstrip_gradient in_Gradient
end variables

forward prototypes
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_setparent (u_cst_tabstripnavigate auo_parent)
public function integer of_drawx (long ahdc)
end prototypes

event mouseenter();SetRedraw(TRUE)
end event

event mouseleave();SetRedraw(TRUE)
end event

event mousemove;Long ll_index

if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
		
else
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
	
		of_releasemouse()
		
		this.event post mouseleave()

	end if

end if
end event

public function integer of_capturemouse ();
if of_ismousecaptured() then Return -1

SetCapture(handle(this))

ib_mousecaptured = TRUE

return 1
end function

public function boolean of_ismousecaptured ();return ib_mousecaptured
end function

public function integer of_releasemouse ();
if NOT of_ismousecaptured() then return -1

ReleaseCapture()

ib_mousecaptured = FALSE

Return 1
end function

public function integer of_setparent (u_cst_tabstripnavigate auo_parent);iuo_parent = auo_parent

RETURN 1

end function

public function integer of_drawx (long ahdc);Long ll_y

ll_y = 3
SetPixel(ahdc, 3, ll_y, RGB(255,255,255))
SetPixel(ahdc, 4, ll_y, RGB(255,255,255))
SetPixel(ahdc, 8, ll_y, RGB(255,255,255))
SetPixel(ahdc, 9, ll_y, RGB(255,255,255))
ll_y++
SetPixel(ahdc, 4, ll_y, RGB(255,255,255))
SetPixel(ahdc, 5, ll_y, RGB(255,255,255))
SetPixel(ahdc, 7, ll_y, RGB(255,255,255))
SetPixel(ahdc, 8, ll_y, RGB(255,255,255))
ll_y++
SetPixel(ahdc, 5, ll_y, RGB(255,255,255))
SetPixel(ahdc, 6, ll_y, RGB(255,255,255))
SetPixel(ahdc, 7, ll_y, RGB(255,255,255))
ll_y++
SetPixel(ahdc, 6, ll_y, RGB(255,255,255))
ll_y++
SetPixel(ahdc, 5, ll_y, RGB(255,255,255))
SetPixel(ahdc, 6, ll_y, RGB(255,255,255))
SetPixel(ahdc, 7, ll_y, RGB(255,255,255))
ll_y++
SetPixel(ahdc, 4, ll_y, RGB(255,255,255))
SetPixel(ahdc, 5, ll_y, RGB(255,255,255))
SetPixel(ahdc, 7, ll_y, RGB(255,255,255))
SetPixel(ahdc, 8, ll_y, RGB(255,255,255))
ll_y++
SetPixel(ahdc, 3, ll_y, RGB(255,255,255))
SetPixel(ahdc, 4, ll_y, RGB(255,255,255))
SetPixel(ahdc, 8, ll_y, RGB(255,255,255))
SetPixel(ahdc, 9, ll_y, RGB(255,255,255))

RETURN 1

end function

on u_cst_tabstripclose.create
call super::create
end on

on u_cst_tabstripclose.destroy
call super::destroy
end on

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

in_Gradient.of_VerticalGradient(RGB(240,169,151), RGB(194,42,0), THIS, TRUE, RGB(167,25,15), 0)

of_drawx(hdc)

RETURN 1
end event

