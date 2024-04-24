$PBExportHeader$u_cst_tabstripnavigate.sru
forward
global type u_cst_tabstripnavigate from u_canvas
end type
type uo_close from u_cst_tabstripclose within u_cst_tabstripnavigate
end type
end forward

global type u_cst_tabstripnavigate from u_canvas
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
event lbuttondown pbm_lbuttondown
event doubleclick pbm_lbuttondblclk
uo_close uo_close
end type
global u_cst_tabstripnavigate u_cst_tabstripnavigate

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
end prototypes

type variables
Boolean ib_selected
Boolean ib_mousecaptured

Boolean ib_mouseoverleft
Boolean ib_mouseoverright

u_cst_tabcontrol iuo_parent

n_cst_tabstrip_gradient in_Gradient
end variables

forward prototypes
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_setparent (u_cst_tabcontrol auo_parent)
public function integer of_drawarrow (long ahdc)
public function integer of_drawchevron (long ahdc)
public function integer of_drawclose (long ahdc)
end prototypes

event mouseenter();SetRedraw(TRUE)
end event

event mouseleave();ib_mouseoverleft = FALSE
ib_mouseoverright = FALSE

SetRedraw(TRUE)
end event

event mousemove;Long ll_index

if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
		
else
	
	if xpos < 0 or ypos < 0 or xpos > uo_close.X or ypos > height then
	
		of_releasemouse()
		
		this.event post mouseleave()
	ELSE
		IF UnitsToPixels(xpos, XUnitsToPixels!) > 6 AND &
			UnitsToPixels(xpos, XUnitsToPixels!) < 18 AND &
			UnitsToPixels(ypos, YUnitsToPixels!) > 4 AND &
			UnitsToPixels(ypos, YUnitsToPixels!) < 18 THEN
			
			IF NOT ib_mouseoverleft THEN
				ib_mouseoverleft = TRUE
				ib_mouseoverright = FALSE
				SetRedraw(TRUE)
			END IF
			
	
		ELSE
	
			IF UnitsToPixels(xpos, XUnitsToPixels!) > 18 AND &
				UnitsToPixels(xpos, XUnitsToPixels!) < 30 AND &
				UnitsToPixels(ypos, YUnitsToPixels!) > 4 AND &
				UnitsToPixels(ypos, YUnitsToPixels!) < 18 THEN
				
				IF NOT ib_mouseoverright THEN
					ib_mouseoverleft = FALSE
					ib_mouseoverright = TRUE
					SetRedraw(TRUE)
				END IF
			
			ELSE
				IF ib_mouseoverright THEN
					ib_mouseoverright = FALSE
					SetRedraw(TRUE)
				END IF
				IF ib_mouseoverleft THEN
					ib_mouseoverleft = FALSE
					SetRedraw(TRUE)
				END IF
			END IF
		END IF
	end if

end if
end event

event lbuttondown;IF ib_mouseoverleft THEN
	IF iuo_parent.il_firstvisible > 1 THEN
		iuo_parent.of_ScrollLeft()
	END IF
END IF

IF ib_mouseoverright THEN
	IF iuo_parent.il_lastvisible < UpperBound(iuo_parent.ist_tabs) THEN
		iuo_parent.of_ScrollRight()
		SetRedraw(TRUE)
	END IF
END IF
end event

event doubleclick;IF ib_mouseoverleft THEN
	IF iuo_parent.il_firstvisible > 1 THEN
		iuo_parent.of_ScrollLeft()
	END IF
END IF

IF ib_mouseoverright THEN
	IF iuo_parent.il_lastvisible < UpperBound(iuo_parent.ist_tabs) THEN
		iuo_parent.of_ScrollRight()
		SetRedraw(TRUE)
	END IF
END IF
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

public function integer of_setparent (u_cst_tabcontrol auo_parent);iuo_parent = auo_parent

RETURN 1

end function

public function integer of_drawarrow (long ahdc);Long ll_x, ll_y
Long ll_index, hRgn, hRPen
Long ll_leftcolor, ll_rightcolor

ll_y = 7
ll_x = 10

IF iuo_parent.il_firstvisible = 1 THEN
	ll_leftcolor = RGB(100,100,100)
ELSE
	ll_leftcolor = 0
END IF

IF iuo_parent.il_lastvisible = UpperBound(iuo_parent.ist_tabs) OR &
   UpperBound(iuo_parent.ist_tabs) = 0 THEN
	ll_rightcolor = RGB(100,100,100)
ELSE
	ll_rightcolor = 0
END IF

IF ib_mouseoverleft AND ll_leftcolor = 0 THEN
	hRPen = in_Gradient.CreatePen(0,0,iuo_parent.of_GetColor('BACKCOLOR2'))
	hRgn = in_Gradient.CreateRectRgn( 6 , 5, 18 , 19)
	in_Gradient.FillRgn (ahdc, hRgn, hRPen) 

	in_Gradient.DeleteObject(hRPen)
	in_Gradient.DeleteObject(hRgn)
END IF

SetPixel(ahdc, ll_x, ll_y + 4, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_leftcolor)
ll_x++
SetPixel(ahdc, ll_x, ll_y + 3, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 4, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 6, ll_leftcolor)
ll_x++
SetPixel(ahdc, ll_x, ll_y + 2, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 3, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 4, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 6, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 7, ll_leftcolor)
ll_x++
SetPixel(ahdc, ll_x, ll_y + 1, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 2, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 3, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 4, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 6, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 7, ll_leftcolor)
SetPixel(ahdc, ll_x, ll_y + 8, ll_leftcolor)

IF ib_mouseoverright AND ll_rightcolor = 0 THEN
	hRPen = in_Gradient.CreatePen(0,0,iuo_parent.of_GetColor('BACKCOLOR2'))
	hRgn = in_Gradient.CreateRectRgn( 18 , 5, 30 , 19)
	in_Gradient.FillRgn (ahdc, hRgn, hRPen) 

	in_Gradient.DeleteObject(hRPen)
	in_Gradient.DeleteObject(hRgn)
END IF

ll_x += 9
SetPixel(ahdc, ll_x, ll_y + 1, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 2, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 3, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 4, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 6, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 7, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 8, ll_rightcolor)
ll_x++
SetPixel(ahdc, ll_x, ll_y + 2, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 3, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 4, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 6, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 7, ll_rightcolor)
ll_x++
SetPixel(ahdc, ll_x, ll_y + 3, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 4, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 6, ll_rightcolor)
ll_x++
SetPixel(ahdc, ll_x, ll_y + 4, ll_rightcolor)
SetPixel(ahdc, ll_x, ll_y + 5, ll_rightcolor)

RETURN 1
end function

public function integer of_drawchevron (long ahdc);Long ll_x, ll_y
Long ll_index

ll_y = 6
ll_x = 40

FOR ll_index = 1 TO 5
	SetPixel(ahdc, ll_x, ll_y, 0)
	SetPixel(ahdc, ll_x + 1, ll_y, 0)
	SetPixel(ahdc, ll_x + 3, ll_y, 0)
	SetPixel(ahdc, ll_x + 4, ll_y, 0)
	
	ll_y = ll_y + 1
	IF ll_index < 3 THEN
		ll_x = ll_x + 1
	ELSE
		ll_x = ll_x - 1
	END IF
	
NEXT

ll_y = ll_y + 2
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

RETURN 1
end function

public function integer of_drawclose (long ahdc);RETURN 1
end function

on u_cst_tabstripnavigate.create
int iCurrent
call super::create
this.uo_close=create uo_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_close
end on

on u_cst_tabstripnavigate.destroy
call super::destroy
destroy(this.uo_close)
end on

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

in_Gradient.of_VerticalGradient( iuo_parent.of_GetColor('TABBACK2'),  iuo_parent.of_GetColor('TABBACK1'), THIS)

IF NOT iuo_parent.ib_hidearrows THEN
	of_DrawArrow(hdc)
END IF
//of_DrawChevron(hdc)

Long ll_x1, ll_x2, ll_y1, ll_y2

IF iuo_parent.il_CurrentPosition = iuo_parent.Top THEN
	ll_x1 = 0
	ll_y1 = Height - 4
	ll_x2 = Width
	ll_y2 = Height - 4
ELSE
	ll_x1 = 0
	ll_y1 = 1
	ll_x2 = Width
	ll_y2 = 1
END IF

in_Gradient.of_DrawLine(ll_x1, ll_y1, ll_x2, ll_y2, iuo_parent.of_GetColor('BORDER'), FALSE)

RETURN 1
end event

type uo_close from u_cst_tabstripclose within u_cst_tabstripnavigate
integer x = 155
integer y = 20
integer width = 59
integer height = 52
integer taborder = 10
long backcolor = 255
end type

on uo_close.destroy
call u_cst_tabstripclose::destroy
end on

event lbuttonup;call super::lbuttonup;iuo_parent.iuo_parent.of_CloseSelectedTab()
end event

event constructor;call super::constructor;of_SetParent(PARENT)
end event

