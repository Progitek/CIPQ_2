$PBExportHeader$u_cst_shortcutheader.sru
forward
global type u_cst_shortcutheader from u_canvas
end type
type lv_imagelist from listview within u_cst_shortcutheader
end type
end forward

global type u_cst_shortcutheader from u_canvas
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
lv_imagelist lv_imagelist
end type
global u_cst_shortcutheader u_cst_shortcutheader

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

String is_image
Long il_imagepos

n_cst_shortcutbar_gradient	in_gradient
u_cst_shortcutbar iuo_parent

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0
CONSTANT Long RIGHT = 1
CONSTANT Long LEFT = 2

Long il_rightwidth
Long il_leftwidth
Long il_leftx
Long il_rightcolor = 0
Long il_leftcolor = 0

String is_lefttext
String is_righttext


end variables

forward prototypes
public function string of_getimage ()
public function integer of_settext (string as_text, long al_pos)
public function string of_gettext (long al_pos)
public function integer of_settextcolor (long al_color, long al_pos)
public function integer of_setimage (string as_image, integer ai_pos)
public function integer of_setparent (u_cst_shortcutbar auo_parent)
public function integer of_drawimage (long ahdc)
end prototypes

event resize;IF IsValid(iuo_parent) THEN
	IF iuo_parent.ib_headerimage THEN
		CHOOSE CASE il_imagepos
			CASE RIGHT
				il_rightwidth = Width - 25 - 110
				il_leftx = 24
			CASE LEFT
				il_leftx = 110
				il_rightwidth = Width - 18 - 25
		END CHOOSE
		
	ELSE
		il_leftx = 24
		il_rightwidth = Width - 18 - 25
	END IF
	
	il_leftwidth = Width - il_leftx - 10
END IF

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

TriggerEvent('paint')

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

public function integer of_settextcolor (long al_color, long al_pos);CHOOSE CASE al_pos
	CASE RIGHT
		il_rightcolor = al_color
	CASE LEFT
		il_leftcolor = al_color
END CHOOSE

TriggerEvent('paint')

RETURN 1
end function

public function integer of_setimage (string as_image, integer ai_pos);is_image = as_image
il_imagepos = ai_pos

lv_imagelist.DeleteLargePictures ( )
IF Len(Trim(is_image )) > 0 THEN
	lv_imagelist.AddLargePicture ( is_image )
END IF

il_imagelist = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)

TriggerEvent('resize')

RETURN 1
end function

public function integer of_setparent (u_cst_shortcutbar auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_drawimage (long ahdc);IF iuo_parent.ib_headerimage THEN
	CHOOSE CASE il_imagepos
		CASE RIGHT
			ImageList_Draw(il_imagelist, 0, ahdc, UnitsToPixels(width - 90, XUnitsToPixels!), UnitsToPixels(16, YUnitsToPixels!), ILD_TRANSPARENT )
		CASE LEFT
			ImageList_Draw(il_imagelist, 0, ahdc, UnitsToPixels(16, XUnitsToPixels!), UnitsToPixels(16, YUnitsToPixels!), ILD_TRANSPARENT )
	END CHOOSE
END IF

RETURN 1
end function

on u_cst_shortcutheader.create
int iCurrent
call super::create
this.lv_imagelist=create lv_imagelist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_imagelist
end on

on u_cst_shortcutheader.destroy
call super::destroy
destroy(this.lv_imagelist)
end on

event constructor;POST EVENT Resize(0, Width, Height)
end event

event onpaint;call super::onpaint;IF IsValid(iuo_parent) THEN
	
	in_Gradient.of_SetHDC(hdc)
	
	in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("HEADER1"), iuo_parent.of_GetColor("HEADER2"), THIS, TRUE, iuo_parent.of_GetColor("BORDER"), iuo_parent.of_GetStyle())

	in_Gradient.of_DrawText(THIS, is_lefttext, il_leftcolor, 'Arial', 16, TRUE, in_Gradient.ALIGN_LEFT, il_leftx, 10, il_leftwidth, 80, FALSE) 
	in_Gradient.of_DrawText(THIS, is_righttext, il_rightcolor, 'Tahoma', 12, FALSE, in_Gradient.ALIGN_RIGHT, 18, 20, il_rightwidth, 80, FALSE) 
	
	of_DrawImage(hdc)
END IF

RETURN 1
end event

type lv_imagelist from listview within u_cst_shortcutheader
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

