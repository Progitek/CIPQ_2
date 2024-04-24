$PBExportHeader$u_cst_xpheader.sru
forward
global type u_cst_xpheader from u_canvas
end type
type st_1 from statictext within u_cst_xpheader
end type
type lv_imagelist from listview within u_cst_xpheader
end type
end forward

global type u_cst_xpheader from u_canvas
integer width = 603
integer height = 104
long backcolor = 67108864
string pointer = "Arrow!"
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event paint pbm_paint
event clicked pbm_lbuttonup
event mousewithin pbm_mousemove
event mouseenter ( )
event mouseleave ( )
event resize pbm_size
st_1 st_1
lv_imagelist lv_imagelist
end type
global u_cst_xpheader u_cst_xpheader

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"
FUNCTION unsignedlong GetSysColor(int nIndex) LIBRARY "user32.dll"
end prototypes

type variables
Long il_dc, il_imagelist

Boolean ib_shadowtext
String is_image
Long il_imagepos

n_cst_xpheader_gradient	in_gradient

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0
CONSTANT Long RIGHT = 1
CONSTANT Long LEFT = 2

CONSTANT Long BLUE = RGB(185,210,248)
CONSTANT Long SILVER = RGB(232,232,240)
CONSTANT Long OLIVE = RGB(234,234,207)
CONSTANT Long CLASSIC = RGB(242,243,246)
CONSTANT Long DEFAULT = 0

CONSTANT Long XP = 0
CONSTANT Long VISTAEMBOSSED = 1
CONSTANT Long VISTAORIGINAL = 2
CONSTANT Long VISTAGLASS = 3
CONSTANT Long CUSTOM = 4

Long il_CurrentStyle = XP
Long il_CurrentTheme = BLUE
Long il_Gradient1 = RGB(255,255,255)
Long il_Gradient2 = RGB(255,255,255)
Long il_bordercolor

Long il_rightwidth
Long il_leftwidth
Long il_leftx
Long il_rightcolor = 0
Long il_leftcolor = 0

String is_lefttext
String is_righttext

Boolean ib_Vista = FALSE


end variables

forward prototypes
public function string of_getimage ()
public function integer of_settext (string as_text, long al_pos)
public function string of_gettext (long al_pos)
public function long of_getcolor (string as_color)
public function integer of_settheme (long al_theme)
public function integer of_setcolor (long al_gradient1, long al_gradient2)
public function integer of_settextcolor (long al_color, long al_pos)
public function integer of_setimage (string as_image, integer ai_pos)
public function integer of_settheme (string as_color)
public function integer of_setstyle (integer ai_style)
public function integer of_setshadowtext (boolean ab_switch)
public function integer of_drawimage (long ahdc)
end prototypes

event resize;IF Len(Trim(is_image)) > 0 THEN
	CHOOSE CASE il_imagepos
		CASE RIGHT
			il_rightwidth = Width - 25 - 110
			il_leftx = 24
		CASE LEFT
			il_leftx = 110
			il_rightwidth = Width - 18 - 25
	END CHOOSE
	
ELSE
	il_rightwidth = Width - 18 - 25
END IF

il_leftwidth = Width - il_leftx - 10

//TriggerEvent('paint')
SetRedraw(TRUE)
end event

public function string of_getimage ();RETURN is_image//p_1.PictureName
end function

public function integer of_settext (string as_text, long al_pos);CHOOSE CASE al_pos
	CASE RIGHT
		is_righttext = as_text
	CASE LEFT
		is_lefttext = as_text
END CHOOSE

//TriggerEvent('paint')
SetRedraw(TRUE)

RETURN 1
end function

public function string of_gettext (long al_pos);CHOOSE CASE al_pos
	CASE RIGHT
		RETURN is_righttext
	CASE LEFT
		RETURN is_lefttext
	CASE ELSE
		RETURN ''
END CHOOSE
end function

public function long of_getcolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "HEADER1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(89,135,214)
			CASE SILVER
				ll_color = RGB(168,167,191)
			CASE OLIVE
				ll_color = RGB(175,192,130)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
			CASE DEFAULT
				ll_color = GetSysColor(16)
		END CHOOSE
	CASE "HEADER2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(4,56,148)
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = RGB(99,122,68)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
			CASE DEFAULT
				ll_color = GetSysColor(16)
		END CHOOSE
END CHOOSE

RETURN ll_color
end function

public function integer of_settheme (long al_theme);il_CurrentTheme = al_theme
CHOOSE CASE il_CurrentTheme
	CASE BLUE
		il_bordercolor = RGB(4,56,148)
	CASE SILVER
		il_bordercolor = RGB(112,111,145)
	CASE OLIVE
		il_bordercolor = RGB(99,122,68)
	CASE CLASSIC
		il_bordercolor = RGB(128,128,128)				
END CHOOSE
//TriggerEvent("paint")
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setcolor (long al_gradient1, long al_gradient2);il_Gradient1 = al_gradient1
il_Gradient2 = al_gradient2
il_CurrentTheme = 0

//TriggerEvent('paint')
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settextcolor (long al_color, long al_pos);CHOOSE CASE al_pos
	CASE RIGHT
		il_rightcolor = al_color
	CASE LEFT
		il_leftcolor = al_color
END CHOOSE

//TriggerEvent('paint')
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setimage (string as_image, integer ai_pos);is_image = as_image
il_imagepos = ai_pos

lv_imagelist.DeleteLargePictures ( )
lv_imagelist.AddLargePicture ( is_image )

il_imagelist = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)

TriggerEvent('resize')

RETURN 1
end function

public function integer of_settheme (string as_color);CHOOSE CASE Upper(as_color)
	CASE 'BLUE'
		of_SetTheme(BLUE)
	CASE 'SILVER'
		of_SetTheme(SILVER)
	CASE 'OLIVE'
		of_SetTheme(OLIVE)
	CASE 'CLASSIC'
		of_SetTheme(CLASSIC)
	CASE 'DEFAULT'
		of_SetTheme(DEFAULT)
	CASE ELSE
		of_SetTheme(CLASSIC)
END CHOOSE
		
RETURN 1
end function

public function integer of_setstyle (integer ai_style);il_CurrentStyle = ai_style
//TriggerEvent('paint')
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_setshadowtext (boolean ab_switch);ib_shadowtext = ab_switch
//TriggerEvent('paint')
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_drawimage (long ahdc);CHOOSE CASE il_imagepos
	CASE RIGHT
		ImageList_Draw(il_imagelist, 0, ahdc, UnitsToPixels(width - 90, XUnitsToPixels!), UnitsToPixels(16, YUnitsToPixels!), ILD_TRANSPARENT )
	CASE LEFT
		ImageList_Draw(il_imagelist, 0, ahdc, UnitsToPixels(16, XUnitsToPixels!), UnitsToPixels(16, YUnitsToPixels!), ILD_TRANSPARENT )
END CHOOSE

RETURN 1
end function

on u_cst_xpheader.create
int iCurrent
call super::create
this.st_1=create st_1
this.lv_imagelist=create lv_imagelist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.lv_imagelist
end on

on u_cst_xpheader.destroy
call super::destroy
destroy(this.st_1)
destroy(this.lv_imagelist)
end on

event constructor;Long ll_color1, ll_color2
n_cst_theme lnv_Theme

If lnv_Theme.of_IsAppThemed() And lnv_Theme.of_IsWindowsXp() Then
	ll_Color1 = lnv_Theme.of_GetColor( 1, 1, 3821 )
	ll_Color2 = lnv_Theme.of_GetColor( 1, 1, 3805 )
	Choose Case ll_Color1
			 Case 15029248   // Blue
						of_SetTheme(BLUE)
			 Case 12493732   // Silver
						of_SetTheme(SILVER)
			 Case 8829098    // olive green
						of_SetTheme(OLIVE)
			 Case Else
						of_SetTheme(CLASSIC)
	End Choose
Else
	of_SetTheme(CLASSIC)
End If 

POST EVENT Resize(0, Width, Height)
end event

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

in_Gradient.of_VerticalGradient (of_GetColor("HEADER1"), of_GetColor("HEADER2"), THIS, TRUE, il_bordercolor, il_CurrentStyle)

in_Gradient.of_DrawText(THIS, is_lefttext, il_leftcolor, 'Arial', 16, TRUE, in_Gradient.ALIGN_LEFT, il_leftx, 10, il_leftwidth, 80, ib_shadowtext) 
in_Gradient.of_DrawText(THIS, is_righttext, il_rightcolor, 'Tahoma', 12, FALSE, in_Gradient.ALIGN_RIGHT, 18, 20, il_rightwidth, 80, ib_shadowtext) 

of_DrawImage(hdc)

RETURN 1
end event

type st_1 from statictext within u_cst_xpheader
integer width = 10002
integer height = 10000
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "  Gradient Header"
boolean focusrectangle = false
end type

event constructor;Hide()
end event

type lv_imagelist from listview within u_cst_xpheader
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
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

