$PBExportHeader$u_cst_chevron.sru
forward
global type u_cst_chevron from u_canvas
end type
end forward

global type u_cst_chevron from u_canvas
integer width = 82
integer height = 100
long backcolor = 67108864
string pointer = "HyperLink!"
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event mousewithin pbm_mousemove
event mouseenter ( )
event mouseleave ( )
event paint pbm_paint
event clicked pbm_lbuttonup
end type
global u_cst_chevron u_cst_chevron

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
end prototypes

type variables
u_cst_icontray iuo_parent

n_cst_shortcutbar_gradient in_Gradient

Boolean ib_mousecaptured

Long il_hover1 = RGB(255,255,220)
Long il_hover2 = RGB(247,192,91)
Long il_backcolor1 = RGB(203,225,252)
Long il_backcolor2 = RGB(126,166,225)
end variables

forward prototypes
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_setparent (u_cst_icontray auo_parent)
public function integer of_drawchevron (long ahdc)
end prototypes

event mousewithin;if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
		
else
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
	
		of_releasemouse()
		
		this.event post mouseleave()
		
	end if

end if
end event

event mouseenter();//TriggerEvent("paint")
SetRedraw(TRUE)
end event

event mouseleave();//TriggerEvent("paint")
SetRedraw(TRUE)
end event

event clicked;m_shortcutoptions lm_menu

CHOOSE CASE iuo_parent.iuo_parent.il_CurrentTheme
	CASE iuo_parent.iuo_parent.BLUE
		lm_menu = CREATE m_shortcutoptions_blue
	CASE iuo_parent.iuo_parent.SILVER
		lm_menu = CREATE m_shortcutoptions_silver
	CASE iuo_parent.iuo_parent.OLIVE
		lm_menu = CREATE m_shortcutoptions_olive
	CASE ELSE
		lm_menu = CREATE m_shortcutoptions_classic
END CHOOSE

lm_menu.iuo_parent = iuo_parent.iuo_parent
lm_menu.of_LoadMenu()

IF IsValid(iuo_parent.iuo_parent.of_GetParentWindow().ParentWindow()) THEN
	lm_menu.m_options.PopMenu (iuo_parent.iuo_parent.of_GetParentWindow().ParentWindow().PointerX() + (Width - xpos) + 5, iuo_parent.iuo_parent.of_GetParentWindow().ParentWindow().PointerY() + (Height - ypos) - 590)
ELSE
	lm_menu.m_options.PopMenu (iuo_parent.iuo_parent.of_GetParentWindow().PointerX() + (Width - xpos) + 5, iuo_parent.iuo_parent.of_GetParentWindow().PointerY() + (Height - ypos) - 590)
END IF

of_releasemouse()
this.event post mouseleave()
end event

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

public function integer of_setparent (u_cst_icontray auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_drawchevron (long ahdc);Long ll_x, ll_y
Long ll_index

//ll_start = UnitsToPixels(Width / 2, XUnitsToPixels!) - 16

ll_y = UnitsToPixels(35, YUnitsToPixels!)
ll_x = UnitsToPixels(27, XUnitsToPixels!)

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

ll_y = ll_y + 4
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

on u_cst_chevron.create
call super::create
end on

on u_cst_chevron.destroy
call super::destroy
end on

event onpaint;call super::onpaint;IF IsValid(iuo_parent) THEN
	IF IsValid(iuo_parent.iuo_parent) THEN
		
		in_Gradient.of_SetHDC(hdc)
		
		IF ib_mousecaptured THEN
			in_Gradient.of_VerticalGradient (iuo_parent.iuo_parent.of_GetColor("HOVER1"), iuo_parent.iuo_parent.of_GetColor("HOVER2"), THIS, FALSE, 0, iuo_parent.iuo_parent.of_GetStyle())
		ELSE
			in_Gradient.of_VerticalGradient (iuo_parent.iuo_parent.of_GetColor("BACKCOLOR1"), iuo_parent.iuo_parent.of_GetColor("BACKCOLOR2"), THIS, FALSE, 0, iuo_parent.iuo_parent.of_GetStyle())
		END IF
		
		of_DrawChevron(hdc)
		//in_Gradient.of_DrawText(THIS, '»', 0, 'Courier', 8, TRUE, in_Gradient.ALIGN_LEFT, 30, 10, 59, 84, FALSE) 
		//in_Gradient.of_DrawText(THIS, 'u', 0, 'Marlett', 8, TRUE, in_Gradient.ALIGN_LEFT, 35, 58, 59, 84, FALSE) 
	END IF
END IF

RETURN 1
end event

