$PBExportHeader$u_cst_xplistbarscroll.sru
forward
global type u_cst_xplistbarscroll from u_canvas
end type
end forward

global type u_cst_xplistbarscroll from u_canvas
integer width = 699
integer height = 36
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
end type
global u_cst_xplistbarscroll u_cst_xplistbarscroll

type prototypes
Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"

Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"
end prototypes

type variables
u_cst_xplistbar iuo_parent
n_cst_xplistbar_gradient in_Gradient

Boolean ib_used
Boolean ib_selected
Boolean ib_mousecaptured

Boolean ib_arrowup
end variables

forward prototypes
public function integer of_drawarrow (long ahdc)
public function integer of_setparent (u_cst_xplistbar auo_parent)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_setarrow (string as_arrow)
end prototypes

event mouseenter();SetRedraw(TRUE)
end event

event mouseleave();SetRedraw(TRUE)
end event

event mousemove;
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

public function integer of_drawarrow (long ahdc);Long ll_x, ll_y
Long ll_index

//ll_start = UnitsToPixels(Width / 2, XUnitsToPixels!) - 16

ll_y = UnitsToPixels(0, YUnitsToPixels!)
ll_x = UnitsToPixels(Width / 2, XUnitsToPixels!) - 4

IF ib_arrowup THEN
	ll_y = ll_y + 2
	ll_x = ll_x + 3
	
	SetPixel(ahdc, ll_x, ll_y, 0)
	
	ll_y = ll_y + 1
	ll_x = ll_x - 2
	
	FOR ll_index = 1 TO 3
		SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
	NEXT
	
	ll_y = ll_y + 1
	ll_x = ll_x - 1
	
	FOR ll_index = 1 TO 5
		SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
	NEXT
	
	ll_y = ll_y + 1
	ll_x = ll_x - 1
	
	FOR ll_index = 1 TO 7
		SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
	NEXT
	
ELSE
	
	ll_y = ll_y + 2
	ll_x = ll_x + 1
	
	FOR ll_index = 1 TO 7
		SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
	NEXT
	
	ll_y = ll_y + 1
	ll_x = ll_x + 1
	
	FOR ll_index = 1 TO 5
		SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
	NEXT
	
	ll_y = ll_y + 1
	ll_x = ll_x + 1
	
	FOR ll_index = 1 TO 3
		SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
	NEXT
	
	ll_y = ll_y + 1
	ll_x = ll_x + 2
	
	SetPixel(ahdc, ll_x, ll_y, 0)
END IF

RETURN 1
end function

public function integer of_setparent (u_cst_xplistbar auo_parent);iuo_parent = auo_parent

RETURN 1
end function

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

public function integer of_setarrow (string as_arrow);CHOOSE CASE as_arrow
	CASE 'up'
		ib_arrowup = TRUE
	CASE 'down'
		ib_arrowup = FALSE
END CHOOSE

RETURN 1
end function

on u_cst_xplistbarscroll.create
call super::create
end on

on u_cst_xplistbarscroll.destroy
call super::destroy
end on

event onpaint;call super::onpaint;IF IsValid(iuo_parent) THEN
	in_Gradient.of_SetHDC(hdc)
	
	IF ib_mousecaptured THEN
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor('SCROLLBARSELECTED'), iuo_parent.of_GetColor('SCROLLBARSELECTED'), THIS,TRUE,iuo_parent.of_GetColor('SCROLLBARSELECTEDBORDER'), 0)
	ELSE
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor('SCROLLBAR'), iuo_parent.of_GetColor('SCROLLBAR'), THIS,TRUE,iuo_parent.of_GetColor('SCROLLBARBORDER'), 0)
	END IF
	
	
	of_DrawArrow(hdc)
END IF

RETURN 1
end event

