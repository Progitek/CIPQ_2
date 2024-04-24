$PBExportHeader$u_cst_toolbarstripbutton.sru
forward
global type u_cst_toolbarstripbutton from u_cst_toolbarstripitem
end type
type lv_imagelist from listview within u_cst_toolbarstripbutton
end type
end forward

global type u_cst_toolbarstripbutton from u_cst_toolbarstripitem
integer width = 105
integer height = 88
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
event lbuttondown pbm_lbuttondown
lv_imagelist lv_imagelist
end type
global u_cst_toolbarstripbutton u_cst_toolbarstripbutton

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function Boolean TrackMouseEvent ( ref trackmouseevent lpTrackMouseEvent ) Library 'user32.dll' alias for "TrackMouseEvent;Ansi"

Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
Function boolean ImageList_DrawEx(long himl, long i, long hdcDst, long lx, long ly, long lwidth, long lheight, long lback, long lfore , ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"
Function boolean ImageList_SetOverlayImage(Long himl, Long iImage, Long iOverlay ) Library "comctl32.dll"

FUNCTION unsignedlong GetSysColor(int nIndex) LIBRARY "user32.dll"
end prototypes

type variables
u_cst_toolbarstrip iuo_parent
n_cst_toolbarstrip_gradient in_Gradient
n_cst_tooltip  inv_tooltip

String is_text
String is_image

Boolean ib_selected
Boolean ib_mousecaptured
Boolean ib_mouseleave
Boolean ib_mousedown
Boolean ib_mouseover
Boolean ib_displaytext = FALSE
Boolean ib_enabled = TRUE

Long il_oldwidth = 0

Long il_imagelistsmall

Long il_ID

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0
CONSTANT Long ILD_BLEND50 = 4
CONSTANT Long ILD_BLEND25 = 2

CONSTANT Long XP = 0
CONSTANT Long VISTAEMBOSSED = 1
CONSTANT Long VISTAORIGINAL = 2
CONSTANT Long VISTAGLASS = 3
CONSTANT Long CUSTOM = 4

CONSTANT Long BUTTON = 1
CONSTANT Long OBJECT = 2

Long il_CurrentStyle = XP
Long il_currenttype = BUTTON

DragObject ido_object
trackmouseevent istr_TRACKMOUSEEVENT

constant ulong WM_MOUSELEAVE = 675 
constant uLong TME_LEAVE = 2 
end variables

forward prototypes
public function integer of_setimage (string as_image)
public function integer of_settext (string as_text)
public function integer of_setparent (u_cst_toolbarstrip auo_parent)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_displaytext (boolean ab_display)
public function integer of_settype (integer ai_type)
public function integer of_setobject (dragobject ado_object)
public function integer of_setenabled (boolean ab_switch)
public function string of_gettext ()
public function integer of_setstyle (long al_style)
public function string of_getimage ()
end prototypes

event mouseenter();Long li_X, li_Y, ll_return

IF il_Id > 0 THEN
	li_X = 0//UnitsToPixels( Integer( X ),XUnitsToPixels! )
	li_Y = 0//UnitsToPixels( Integer( Y ), YUnitsToPixels! )
	inv_tooltip.of_UpdatetipRect( This, il_ID, &
									li_x, li_y, &
									li_x + UnitsToPixels( Integer( Width ), XUnitsToPixels! ), &
									li_y + UnitsToPixels( Integer( Height ), YUnitsToPixels! ) )
		
	
	inv_tooltip.Of_SetTipText( This, il_Id, is_text) 
END IF

TrackMouseEvent(istr_TRACKMOUSEEVENT) 

//TriggerEvent("paint")
SetRedraw(TRUE)

// trigger event on parent
If il_currenttype = BUTTON Then
	iuo_parent.Event ue_MouseEnter(is_text)
Else
	iuo_parent.Event ue_MouseEnter(ido_object.ClassName())
End If

end event

event mouseleave();ib_mouseover = FALSE
ib_mousecaptured = FALSE
ib_selected = FALSE

SetRedraw(TRUE)

// trigger event on parent
If il_currenttype = BUTTON Then
	iuo_parent.Event ue_MouseLeave(is_text)
Else
	iuo_parent.Event ue_MouseLeave(ido_object.ClassName())
End If

end event

event mousemove;if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
	
else
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
		
		IF NOT ib_selected THEN
			of_releasemouse()
			
			this.event post mouseleave()
		ELSE
			ib_mouseleave = TRUE
			SetRedraw(TRUE)
		END IF
	ELSE
		IF ib_selected THEN
			ib_mouseleave = FALSE
			SetRedraw(TRUE)
		END IF
	end if
	
end if

// trigger event on parent
If il_currenttype = BUTTON Then
	iuo_parent.Event ue_MouseMove(is_text, xpos, ypos)
Else
	iuo_parent.Event ue_MouseMove(ido_object.ClassName(), xpos, ypos)
End If

end event

event lbuttonup;Boolean ib_click

IF ib_selected AND NOT ib_mouseleave THEN
	ib_click = TRUE
END IF

ib_selected = FALSE
ib_mouseleave = FALSE
of_ReleaseMouse()
SetRedraw(TRUE)

IF ib_click THEN
	iuo_parent.Event ue_ButtonClicked(is_text)
END IF
end event

event lbuttondown;ib_mousedown = TRUE
ib_selected = TRUE
SetRedraw(TRUE)
end event

public function integer of_setimage (string as_image);is_image = as_image

lv_imagelist.DeleteLargePictures ( )

IF Len(Trim(is_image)) > 0 THEN
	lv_imagelist.AddLargePicture ( is_image )
END IF

il_imagelistsmall = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)

RETURN 1
end function

public function integer of_settext (string as_text);is_text = as_text

RETURN 1
end function

public function integer of_setparent (u_cst_toolbarstrip auo_parent);iuo_parent = auo_parent

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

public function integer of_displaytext (boolean ab_display);ib_displaytext = ab_display

IF NOT ib_displaytext THEN
	IF IsValid(ido_object) THEN
		Width = ido_object.Width
	ELSE
		Width = 104
	END IF
	il_oldwidth = 0
END IF

IF IsValid(iuo_parent) THEN
	iuo_parent.of_Reorganize()
END IF

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settype (integer ai_type);il_currenttype = ai_type

RETURN 1
end function

public function integer of_setobject (dragobject ado_object);ido_object = ado_object

RETURN 1
end function

public function integer of_setenabled (boolean ab_switch);ib_enabled = ab_switch
Enabled = ib_enabled

SetRedraw(TRUE)

RETURN 1
end function

public function string of_gettext ();RETURN is_text
end function

public function integer of_setstyle (long al_style);il_CurrentStyle = al_style

RETURN 1
end function

public function string of_getimage ();RETURN is_image
end function

on u_cst_toolbarstripbutton.create
int iCurrent
call super::create
this.lv_imagelist=create lv_imagelist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_imagelist
end on

on u_cst_toolbarstripbutton.destroy
call super::destroy
destroy(this.lv_imagelist)
end on

event onpaint;call super::onpaint;Long ll_parm, ll_textcolor

IF IsValid(iuo_parent) THEN

	in_Gradient.of_SetHDC(hdc)
	IF ib_mousecaptured AND il_currenttype <> OBJECT THEN
		IF ib_selected AND NOT ib_mouseleave THEN
			in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("SELECTED1"), iuo_parent.of_GetColor("SELECTED2"), THIS,TRUE,iuo_parent.of_GetColor("HIGHLIGHTBORDER"), il_CurrentStyle)			
		ELSE
			in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("HIGHLIGHT1"), iuo_parent.of_GetColor("HIGHLIGHT2"), THIS,TRUE,iuo_parent.of_GetColor("HIGHLIGHTBORDER"), il_CurrentStyle)			
		END IF
	ELSE
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("BACKGROUND1"), iuo_parent.of_GetColor("BACKGROUND2"), THIS,FALSE,0, il_CurrentStyle)	
	END IF
	
	IF ib_enabled THEN
		ll_textcolor = 0
		ll_parm = ILD_TRANSPARENT
		ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(12, XUnitsToPixels!), UnitsToPixels(12, YUnitsToPixels!), ll_parm )
	ELSE
		ll_textcolor = RGB(100,100,100)
		ll_parm = in_Gradient.of_BitWiseOR(ILD_TRANSPARENT, ILD_BLEND50)

		ImageList_DrawEx(il_imagelistsmall, 0, hdc, UnitsToPixels(12, XUnitsToPixels!), UnitsToPixels(12, YUnitsToPixels!), 16,16, 4294967295, RGB(128,128,128), ll_parm )
		//ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(11, XUnitsToPixels!), UnitsToPixels(12, YUnitsToPixels!), ll_parm )
	END IF

	
	IF (ib_displaytext) OR Len(Trim(is_image)) = 0 THEN
		
		long ll_grosseur = 11
//		IF IsValid(gnv_app) THEN
//			IF IsValid(gnv_app.inv_options) THEN
//				ll_grosseur = long(gnv_app.inv_options.of_recuperer_option("grosseur_font_toolbarstrip"))
//			END IF
//		END IF
		IF IsNull(ll_grosseur) THEN 
			ll_grosseur = 11
		END IF

		IF is_image = '' THEN
			in_Gradient.of_DrawText(THIS, is_text, ll_textcolor, 'Tahoma', ll_grosseur, FALSE, in_Gradient.ALIGN_LEFT, 20, 15, Width - 60, 72,FALSE, FALSE, FALSE, FALSE) 
		ELSE
			in_Gradient.of_DrawText(THIS, is_text, ll_textcolor, 'Tahoma', ll_grosseur, FALSE, in_Gradient.ALIGN_LEFT, 100, 15, Width - 60, 72,FALSE, FALSE, FALSE, FALSE) 
		END IF
				
		IF in_Gradient.il_NewWidth <> il_oldwidth THEN
			il_oldwidth = in_Gradient.il_NewWidth
			
			IF is_text = '' AND il_currenttype <> OBJECT THEN
				Width = 104
			ELSE
				Width = il_oldwidth + 20
			END IF
			
			IF il_currenttype = OBJECT THEN
				Width = Width + ido_object.Width
				ido_object.Y = 2
				ido_object.X = in_Gradient.il_NewWidth + 8
			END IF
			
			iuo_parent.of_Reorganize()
		END IF
	END IF

END IF


RETURN 1
end event

event constructor;call super::constructor;il_ID = inv_ToolTip.of_AddTool( THIS, "" , inv_ToolTip.TTF_SUBCLASS ) 

istr_TrackMouseEvent.cbSize = 16
istr_TrackMouseEvent.dwFlags = TME_LEAVE
istr_TrackMouseEvent.hwndTrack = Handle (THIS) 
istr_TrackMouseEvent.dwHoverTime = 0

end event

event other;call super::other;CHOOSE CASE Message.Number 
	CASE WM_MOUSELEAVE
		this.Event MouseLeave() 
END CHOOSE
end event

type lv_imagelist from listview within u_cst_toolbarstripbutton
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

