$PBExportHeader$u_cst_xplistbarheader.sru
forward
global type u_cst_xplistbarheader from u_canvas
end type
type lv_imagelist from listview within u_cst_xplistbarheader
end type
end forward

global type u_cst_xplistbarheader from u_canvas
integer height = 100
string pointer = "HyperLink!"
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
lv_imagelist lv_imagelist
end type
global u_cst_xplistbarheader u_cst_xplistbarheader

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
Function Long GetPixel(Long ahdc, int aX, int aY) Library "Gdi32.dll"
end prototypes

type variables
n_cst_xplistbar_gradient in_Gradient

u_cst_xplistbargroup iuo_parent

Boolean ib_selected
Boolean ib_mousecaptured

Boolean ib_used

String is_text
String is_image

Long il_imagelistsmall
Long il_GroupStyle

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0
end variables

forward prototypes
public function integer of_setparent (u_cst_xplistbargroup auo_parent)
public function integer of_settext (string as_text)
public function integer of_setimage (string as_image)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function string of_gettext ()
public function integer of_drawarrow (long ahdc)
public function integer of_drawcorners (long ahdc)
public function integer of_setstyle (long al_style)
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
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height OR &
	   (iuo_parent.iuo_parent.PointerY() < iuo_parent.iuo_parent.uo_scrolldown.Height) OR &
		(iuo_parent.iuo_parent.PointerY() > iuo_parent.iuo_parent.uo_scrolldown.Y) then
	
		of_releasemouse()
		
		this.event post mouseleave()
		
	end if

end if
end event

public function integer of_setparent (u_cst_xplistbargroup auo_parent);iuo_parent = auo_parent
	
RETURN 1
end function

public function integer of_settext (string as_text);is_text = as_text

RETURN 1
end function

public function integer of_setimage (string as_image);is_image = as_image

lv_imagelist.DeleteLargePictures ( )

IF Len(Trim(is_image)) > 0 THEN
	lv_imagelist.AddLargePicture ( is_image )
END IF

il_imagelistsmall = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)


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

public function string of_gettext ();RETURN is_text
end function

public function integer of_drawarrow (long ahdc);Long ll_color
Long ll_x, ll_y

IF ib_mousecaptured THEN
	choose case il_GroupStyle
		case 1 // SPECIAL
			ll_color = iuo_parent.iuo_parent.of_GetColor('SPECIALARROW')
		case 2 // FREEZED
			// FREEZED style does not display an arrow
		case else // ORIGINAL
			ll_color = iuo_parent.iuo_parent.of_GetColor('ITEMTEXTSELECTED')
	end choose

ELSE
	IF il_GroupStyle = 1 THEN
		ll_color = RGB(255,255,255)
	ELSE
		ll_color = iuo_parent.iuo_parent.of_GetColor('ITEMTEXT')
	END IF
END IF


ll_x = UnitsToPixels(Width, XUnitsToPixels!) - 11
ll_y = 8

IF il_GroupStyle = 1 THEN // Added by Serge Samson for Special Groups
	in_Gradient.of_DrawCircle(ll_x - 11, 5, ll_x + 4, 20, iuo_parent.iuo_parent.of_GetColor('SPECIALCIRCLEBORDER'),iuo_parent.iuo_parent.of_GetColor('SPECIALCIRCLEFILL'))
ELSE
	in_Gradient.of_DrawCircle(ll_x - 11, 5, ll_x + 4, 20, iuo_parent.iuo_parent.of_GetColor('CIRCLEBORDER'),iuo_parent.iuo_parent.of_GetColor('CIRCLEFILL'))
END IF

IF iuo_parent.ib_expanded THEN
	//Up Arrow
	
	ll_x = ll_x - 4
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	ll_x = ll_x - 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 2, ll_y, ll_color)
	ll_x = ll_x - 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 3, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 4, ll_y, ll_color)
	ll_x = ll_x - 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 5, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 6, ll_y, ll_color)
	
	ll_x = UnitsToPixels(Width, XUnitsToPixels!) - 11
	
	ll_x = ll_x - 4
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	ll_x = ll_x - 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 2, ll_y, ll_color)
	ll_x = ll_x - 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 3, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 4, ll_y, ll_color)
	ll_x = ll_x - 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 5, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 6, ll_y, ll_color)
	
ELSE
	//Down Arrow
	ll_x = ll_x - 7
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 5, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 6, ll_y, ll_color)
	ll_x = ll_x + 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 3, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 4, ll_y, ll_color)
	ll_x = ll_x + 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 2, ll_y, ll_color)
	ll_x = ll_x + 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	
	ll_x = UnitsToPixels(Width, XUnitsToPixels!) - 11
	
	ll_x = ll_x - 7
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 5, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 6, ll_y, ll_color)
	ll_x = ll_x + 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 3, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 4, ll_y, ll_color)
	ll_x = ll_x + 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 1, ll_y, ll_color)
	SetPixel(ahdc, ll_x + 2, ll_y, ll_color)
	ll_x = ll_x + 1
	ll_y = ll_y + 1
	SetPixel(ahdc, ll_x, ll_y, ll_color)
	
END IF


RETURN 1
end function

public function integer of_drawcorners (long ahdc);Long ll_color
Long ll_dc
Long ll_width

ll_dc = GetDC(Handle(iuo_parent.iuo_parent))

ll_color = GetPixel(ll_dc, 5, UnitsToPixels(iuo_parent.Y, YUnitsToPixels!))

ll_width = UnitsToPixels(Width, XUnitsToPixels!)

SetPixel(ahdc, 0, 0, ll_color)
SetPixel(ahdc, 1, 0, ll_color)
SetPixel(ahdc, 0, 1, ll_color)

SetPixel(ahdc, ll_width - 1, 0, ll_color)
SetPixel(ahdc, ll_width - 2, 0, ll_color)
SetPixel(ahdc, ll_width - 1, 1, ll_color)

ReleaseDC (Handle(iuo_parent.iuo_parent), ll_dc)


RETURN 1
end function

public function integer of_setstyle (long al_style);il_GroupStyle = al_style
SetRedraw(TRUE)

RETURN 1

end function

on u_cst_xplistbarheader.create
int iCurrent
call super::create
this.lv_imagelist=create lv_imagelist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_imagelist
end on

on u_cst_xplistbarheader.destroy
call super::destroy
destroy(this.lv_imagelist)
end on

event onpaint;call super::onpaint;IF IsValid(iuo_parent) THEN
	IF IsValid(iuo_parent.iuo_parent) THEN
		in_Gradient.of_SetHDC(hdc)

		choose case il_GroupStyle // added by Serge Samson
			case 1 // SPECIAL
				in_Gradient.of_HorizontalGradient(iuo_parent.iuo_parent.of_GetColor('HEADERSPECIAL1'), iuo_parent.iuo_parent.of_GetColor('HEADERSPECIAL2'), THIS, FALSE)
			case else
				in_Gradient.of_HorizontalGradient(iuo_parent.iuo_parent.of_GetColor('HEADER1'), iuo_parent.iuo_parent.of_GetColor('HEADER2'), THIS, FALSE)
		end choose

		IF ib_mousecaptured THEN
			IF is_image = '' THEN
				IF il_GroupStyle = 1 THEN
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('HEADERSPECIALTEXTSELECTED'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 30, 25, Width - 140, 70,FALSE, TRUE, FALSE, FALSE) 					
				ELSE
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('ITEMTEXTSELECTED'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 30, 25, Width - 140, 70,FALSE, TRUE, FALSE, FALSE) 
				END IF
			ELSE
				IF il_GroupStyle = 1 THEN
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('HEADERSPECIALTEXTSELECTED'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 130, 25, Width - 240, 70,FALSE, TRUE, FALSE, FALSE) 
					ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(25, XUnitsToPixels!), UnitsToPixels(18, YUnitsToPixels!), ILD_TRANSPARENT )
				ELSE		
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('ITEMTEXTSELECTED'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 130, 25, Width - 240, 70,FALSE, TRUE, FALSE, FALSE) 
					ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(25, XUnitsToPixels!), UnitsToPixels(18, YUnitsToPixels!), ILD_TRANSPARENT )
				END IF
			END IF
		ELSE
			IF is_image = '' THEN
				IF il_GroupStyle = 1 THEN
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('HEADERSPECIALTEXT'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 30, 25, Width - 140, 70,FALSE, TRUE, FALSE, FALSE) 
				ELSE
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('ITEMTEXT'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 30, 25, Width - 140, 70,FALSE, TRUE, FALSE, FALSE) 
				END IF
			ELSE
				IF il_GroupStyle = 1 THEN
					in_Gradient.of_DrawText(THIS, is_text, 16777215, 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 130, 25, Width - 240, 70,FALSE, TRUE, FALSE, FALSE) 
					ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(25, XUnitsToPixels!), UnitsToPixels(18, YUnitsToPixels!), ILD_TRANSPARENT )					
				ELSE
					in_Gradient.of_DrawText(THIS, is_text, iuo_parent.iuo_parent.of_GetColor('ITEMTEXT'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 130, 25, Width - 240, 70,FALSE, TRUE, FALSE, FALSE) 
					ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(25, XUnitsToPixels!), UnitsToPixels(18, YUnitsToPixels!), ILD_TRANSPARENT )
				END IF
			END IF
		END IF
		
		IF il_groupstyle <> iuo_parent.iuo_parent.NOARROW THEN
			of_DrawArrow(hdc)
		END IF
		
		of_DrawCorners(hdc)
		
	END IF
END IF

RETURN 0
end event

event constructor;call super::constructor;of_SetParent(PARENT)
end event

type lv_imagelist from listview within u_cst_xplistbarheader
boolean visible = false
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer largepicturewidth = 16
integer largepictureheight = 16
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event constructor;//THIS.LargePictureHeight = 24
//THIS.LargePictureWidth = 24
end event

