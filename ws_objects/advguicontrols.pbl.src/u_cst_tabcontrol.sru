$PBExportHeader$u_cst_tabcontrol.sru
forward
global type u_cst_tabcontrol from userobject
end type
type uo_navigation from u_cst_tabstripnavigate within u_cst_tabcontrol
end type
type lv_imagelist from listview within u_cst_tabcontrol
end type
type uo_tabs from u_cst_tabstrip within u_cst_tabcontrol
end type
type st_1 from statictext within u_cst_tabcontrol
end type
type size from structure within u_cst_tabcontrol
end type
type trackmouseevent from structure within u_cst_tabcontrol
end type
end forward

type size from structure
	long		cx
	long		cy
end type

global type u_cst_tabcontrol from userobject
integer width = 759
integer height = 332
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize pbm_size
event selectionchanging pbm_tcnselchanging
event selectionchanged pbm_tcnselchanged
event type long tabclosing ( long index )
event tabclosed ( long index )
event rightclicked ( long index )
event paint pbm_paint
uo_navigation uo_navigation
lv_imagelist lv_imagelist
uo_tabs uo_tabs
st_1 st_1
end type
global u_cst_tabcontrol u_cst_tabcontrol

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
FUNCTION unsignedlong GetSysColor(int nIndex) LIBRARY "user32.dll"

Function ulong GetDC ( &
	ulong hWnd &
	) Library "user32.dll"

Function ulong SelectObject ( &
	ulong hdc, &
	ulong hWnd &
	) Library "gdi32.dll"

Function boolean GetTextExtentPoint32 ( &
	ulong hdcr, &
	string lpString, &
	long nCount, &
	Ref SIZE size &
	) Library "gdi32.dll" Alias For "GetTextExtentPoint32W"

Function long ReleaseDC ( &
	ulong hWnd, &
	ulong hdcr &
	) Library "user32.dll"
end prototypes

type variables
n_cst_tabstrip_gradient in_Gradient
tabstrip ist_tabs[]
window iw_parent

Long il_index
Long il_selected

Boolean ib_boldselected
Boolean ib_closing
Boolean ib_dirty
Boolean ib_hidearrows
Boolean ib_hideclosebutton

Long il_imagelistsmall
String is_images[]

CONSTANT Long TOP = 1
CONSTANT Long BOTTOM = 2

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0

CONSTANT Long BLUE = RGB(185,210,248)
CONSTANT Long SILVER = RGB(232,232,240)
CONSTANT Long OLIVE = RGB(234,234,207)
CONSTANT Long CLASSIC = RGB(242,243,246)
CONSTANT Long DEFAULT = 0

CONSTANT Long REGULAR = 0
CONSTANT Long EXCEL = 1
CONSTANT Long VS2005 = 2

Constant Integer WM_GETFONT = 49

Long il_CurrentPosition = TOP
Long il_CurrentStyle = REGULAR
Long il_CurrentTheme = BLUE

Long il_firstvisible = 1
Long il_lastvisible = 1
end variables

forward prototypes
public function integer of_getwindow ()
public function integer of_updatepoints ()
public function integer of_indexfrompoint (long xpos, long ypos)
public function integer of_selecttab (long al_selected)
public function integer of_addimage (string as_image)
public function long of_getcolor (string as_color)
public function integer of_setstyle (long al_style)
public function integer of_excel ()
public function integer of_regular ()
public function integer of_settabposition (long al_position)
public function long of_gettextwidth (string as_text)
public function integer of_setenabled (long al_index, boolean ab_switch)
public function integer of_boldselected (boolean ab_bold)
public function integer of_settheme (long al_color)
public function integer of_settheme (string as_color)
public function integer of_vs2005 ()
public function integer of_scrollleft ()
public function integer of_scrollright ()
public function integer of_closetab (long al_index)
public function integer of_closeselectedtab ()
public function long of_getselectedtab ()
public function integer of_closealltabs ()
public function long of_gettabcount ()
public function userobject of_getobject (long al_index)
public function integer of_settext (long al_index, string as_text)
public function String of_gettext (long al_index)
public function integer of_closetab (u_cst_tabpage auo_tabpage)
public function integer of_mouseover (long al_index)
public function integer of_mouseleave ()
public function integer of_setimage (long al_index, long al_image)
public function integer of_settext (u_cst_tabpage auo_tabpage, string as_text)
public function integer of_setimage (u_cst_tabpage auo_tabpage, long al_image)
public function integer of_showclosebutton ()
public function integer of_setenabled (u_cst_tabpage auo_tabpage, boolean ab_switch)
public function string of_gettext (u_cst_tabpage auo_tabpage)
public function integer of_settiptext (long al_index, string as_text)
public function integer of_settiptext (u_cst_tabpage auo_tabpage, string as_text)
public function string of_gettiptext (long al_index)
public function integer of_settextcolor (u_cst_tabpage auo_tabpage, long al_color)
public function integer of_settextcolor (long al_index, long al_color)
public function integer of_setvisible (long al_index, boolean ab_switch)
public function integer of_setvisible (u_cst_tabpage auo_tabpage, boolean ab_switch)
public function boolean of_isvisible (long al_index)
public function boolean of_isvisible (u_cst_tabpage auo_tabpage)
public function boolean of_isenabled (long al_index)
public function boolean of_isenabled (u_cst_tabpage auo_tabpage)
public function integer of_hideclosebutton ()
public function integer of_hidearrows ()
public function integer of_showarrows ()
public function long of_opentab (ref u_cst_tabpage a_object, string as_text, long al_picindex)
public function integer of_selecttab (u_cst_tabpage auo_tabpage)
end prototypes

event resize;uo_tabs.Width = Width - uo_navigation.Width

uo_navigation.X = Width - uo_navigation.Width

IF ib_hidearrows THEN
	uo_navigation.uo_close.X = 5
ELSE
	uo_navigation.uo_close.X = 155
END IF

IF il_CurrentPosition = BOTTOM THEN
	uo_tabs.Move(0, Height - uo_tabs.Height)
	uo_navigation.Y = Height - uo_tabs.Height
END IF

IF il_selected > 0 AND il_selected <= UpperBound(ist_tabs) THEN
	IF il_CurrentPosition = TOP THEN
		ist_tabs[il_selected].ado_object.Y = uo_tabs.Height
	ELSE
		IF IsValid(ist_tabs[il_selected].ado_object) THEN
			ist_tabs[il_selected].ado_object.Y = 5
		END IF
	END IF
	
	ist_tabs[il_selected].ado_object.X = 4
	ist_tabs[il_selected].ado_object.Width = Width - 10
	ist_tabs[il_selected].ado_object.Height = Height - uo_tabs.Height - 4
END IF

ib_dirty = TRUE
SetRedraw(TRUE)
end event

event selectionchanging;// Trigger the event on the tabpage being selected
Return ist_tabs[newindex].ado_object.Event SelectionChanging(oldindex, newindex)

end event

event selectionchanged;// Trigger the event on the tabpage being selected
Return ist_tabs[newindex].ado_object.Event SelectionChanged(oldindex, newindex)

end event

event type long tabclosing(long index);//RETURN 0 to Prevent tab from closing
RETURN 1
end event

event paint;Long hRPen, ll_dc

ll_dc = GetDC(Handle(THIS))

hRPen = in_Gradient.CreatePen(0,0,of_GetColor('BORDER'))
in_Gradient.SelectObject(ll_dc, hRPen)
in_Gradient.Rectangle(ll_dc, 0, 0, UnitsToPixels(Width, XUnitsToPixels!), UnitsToPixels(Height, YUnitsToPixels!))
in_Gradient.DeleteObject(hRPen)

ReleaseDC(Handle(THIS), ll_dc)

RETURN 1
end event

public function integer of_getwindow ();PowerObject	lpo_parent
Window lw_window

// loop thru parents until a window is found
lpo_parent = GetParent()
Do While lpo_parent.TypeOf() <> Window! and IsValid(lpo_parent)
	lpo_parent = lpo_parent.GetParent()
Loop

// set return to the window or null if not found
If IsValid (lpo_parent) Then
	lw_window = lpo_parent
Else
	SetNull(lw_window)
End If

iw_parent = lw_window

RETURN 1
end function

public function integer of_updatepoints ();CHOOSE CASE il_CurrentStyle
	CASE EXCEL
		of_Excel()
	CASE REGULAR
		of_Regular()
	CASE VS2005
		of_VS2005()
END CHOOSE

Return 1
end function

public function integer of_indexfrompoint (long xpos, long ypos);//find out if a tab was clicked
long ll_count, ll_index
ulong lul_rgn
integer lix, liy

lix = UnitsToPixels(xpos, XUnitsToPixels!)
liy = UnitsToPixels(ypos, YUnitsToPixels!)

ll_count = UPPERBOUND(ist_tabs)
FOR ll_index = il_firstvisible to ll_count
	//skip if disabled
	IF NOT ist_tabs[ll_index].ab_enabled THEN CONTINUE
	lul_rgn = in_Gradient.CreatePolygonRgn(ist_tabs[ll_index].ast_point, UPPERBOUND(ist_tabs[ll_index].ast_point), 1)
	IF in_Gradient.PtInRegion(lul_rgn, lix, liy) <> 0 THEN
		in_Gradient.DeleteObject(lul_rgn)
		RETURN ll_index
	ELSE
		in_Gradient.DeleteObject(lul_rgn)
	END IF
NEXT

RETURN -1
end function

public function integer of_selecttab (long al_selected);Long ll_old, ll_index, ll_count

IF al_selected <= 0 THEN RETURN 0
IF NOT ist_tabs[al_selected].ab_Enabled THEN RETURN 0

IF Event SelectionChanging(il_selected, al_selected) = 0 THEN
	ll_old = il_selected
	il_selected = al_selected
	
	TriggerEvent('Resize')
	
	IF ll_old > 0 AND ll_old <= of_GetTabCount() THEN
		IF IsValid(ist_tabs[ll_old].ado_object) THEN
			ist_tabs[ll_old].ado_object.Hide()
		END IF
	END IF
	
	ist_tabs[il_selected].ado_object.Show()
	ist_tabs[il_selected].ado_object.BringToTop = TRUE
	
	IF il_selected < il_firstvisible THEN
		il_firstvisible = il_selected
	END IF
	
	IF il_selected > il_lastvisible THEN
		il_lastvisible = il_selected
	END IF
	
	ib_dirty = TRUE
	SetRedraw(TRUE)
	
	ll_count = al_selected - il_lastvisible
	
	IF ll_count > 0 THEN
		IF al_selected < il_firstvisible OR al_selected > il_lastvisible THEN
			FOR ll_index = 1 TO ll_count
				of_ScrollRight()
			NEXT
		END IF
	END IF
	
	EVENT SelectionChanged(ll_old, il_selected)
	
END IF

RETURN 1
end function

public function integer of_addimage (string as_image);Long ll_item

ll_item = UpperBound(is_images) + 1

is_images[ll_item] = as_image

lv_imagelist.AddLargePicture ( as_image )

il_imagelistsmall = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)


RETURN 1
end function

public function long of_getcolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "BORDER"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(108,138,181)
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = RGB(99,122,68)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
			CASE DEFAULT
				ll_color = GetSysColor(16)
		END CHOOSE
	CASE "HOVER1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,244,204)
			CASE SILVER
				ll_color = RGB(255,244,204)
			CASE OLIVE
				ll_color = RGB(255,244,204)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
		END CHOOSE
	CASE "HOVER2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,208,145)
			CASE SILVER
				ll_color = RGB(255,208,145)
			CASE OLIVE
				ll_color = RGB(255,208,145)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
		END CHOOSE
	CASE "BACKCOLOR1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(221,236,254)
			CASE SILVER
				ll_color = RGB(243,244,250)
			CASE OLIVE
				ll_color = RGB(244,247,222)
			CASE CLASSIC
				ll_color = RGB(245,244,242)
			CASE DEFAULT
				ll_color = GetSysColor (0)
		END CHOOSE
	CASE "BACKCOLOR2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(129,169,226)
			CASE SILVER
				ll_color = RGB(153,151,181)
			CASE OLIVE
				ll_color = RGB(183,198,145)
			CASE CLASSIC
				ll_color = RGB(213,210,202)
			CASE DEFAULT
				ll_color = GetSysColor (15)				
		END CHOOSE
	CASE "SELECTED1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,255,255)
			CASE SILVER
				ll_color = RGB(255,255,255)
			CASE OLIVE
				ll_color = RGB(255,255,255)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
			CASE DEFAULT
				ll_color = RGB(255,255,255)			
		END CHOOSE
	CASE "SELECTED2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,255,255)
			CASE SILVER
				ll_color = RGB(255,255,255)
			CASE OLIVE
				ll_color = RGB(255,255,255)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
			CASE DEFAULT
				ll_color = RGB(255,255,255)			
		END CHOOSE
	CASE "ITEMTEXT"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 0
			CASE SILVER
				ll_color = 0
			CASE OLIVE
				ll_color = 0
			CASE CLASSIC
				ll_color = 0
			CASE DEFAULT
				ll_color = 0			
		END CHOOSE
	CASE "TABBACK1"
		ll_color = GetSysColor (15)
//		CHOOSE CASE il_CurrentTheme
//			CASE BLUE
//				ll_color = RGB(203,225,252)
//			CASE SILVER
//				ll_color = RGB(225,226,236)
//			CASE OLIVE
//				ll_color = RGB(234,240,207)
//			CASE CLASSIC
//				ll_color = RGB(255,255,255)
//			CASE DEFAULT
//				ll_color = GetSysColor (0)
//		END CHOOSE
	CASE "TABBACK2"
		ll_color = GetSysColor (15)
//		CHOOSE CASE il_CurrentTheme
//			CASE BLUE
//				ll_color = RGB(203,225,252)
//			CASE SILVER
//				ll_color = RGB(225,226,236)
//			CASE OLIVE
//				ll_color = RGB(234,240,207)
//			CASE CLASSIC
//				ll_color = RGB(255,255,255)
//			CASE DEFAULT
//				ll_color = GetSysColor (0)
//		END CHOOSE
END CHOOSE

RETURN ll_color
end function

public function integer of_setstyle (long al_style);il_CurrentStyle = al_style
ib_dirty = TRUE
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_excel ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth, ll_item
Point lp_empty[]

ll_count = UpperBound(ist_tabs)
ll_y = 0
ll_x = 3

FOR ll_index = il_firstvisible TO ll_count
	IF NOT ist_tabs[ll_index].ab_visible THEN CONTINUE
	
	ll_item++
	ist_tabs[ll_index].ast_point = lp_empty
	st_1.Weight = 400
	
	IF il_index = ll_index THEN
		ist_tabs[ll_index].ab_mouseover = TRUE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('HOVER1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('HOVER2')
	ELSE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('BACKCOLOR1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('BACKCOLOR2')
	END IF
	
	IF il_selected = ll_index THEN
		ist_tabs[ll_index].ab_selected = TRUE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('SELECTED2')
		
		IF ib_boldselected THEN
			st_1.Weight = 700
		END IF
		
	ELSE
		ist_tabs[ll_index].ab_selected = FALSE
	END IF
	
	ll_textwidth = of_GetTextWidth(ist_tabs[ll_index].as_tab_text)
	ist_tabs[ll_index].al_textwidth = ll_textwidth
	
	IF ist_tabs[ll_index].al_pic_index > 0 THEN
		ll_textwidth += 16
	ELSE
		ll_textwidth += 2
	END IF
	
	IF il_CurrentPosition = TOP THEN
		IF ll_item = 1 OR ist_tabs[ll_index].ab_selected THEN
			
			IF ist_tabs[ll_index].ab_selected AND ll_item <> 1 THEN
				ll_x -= 12
			END IF
			
			ist_tabs[ll_index].al_textx = ll_x + 12
			ll_textwidth += 8
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = ll_y + 22 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x + 11//Top left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 2//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + ll_textwidth + 3//Top right corner
			ist_tabs[ll_index].ast_point[3].py = ll_y + 2//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 14//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = ll_y + 22 //bottom right corner
		
			ll_x += ll_textwidth + 14
			
		ELSE
			ist_tabs[ll_index].al_textx = ll_x
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = ll_y + 22 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x - 6 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 11 //Bottom left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x - 1//Top left corner
			ist_tabs[ll_index].ast_point[3].py = ll_y + 2//Top left corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 0//Top right corner
			ist_tabs[ll_index].ast_point[4].py = ll_y + 2//Top right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 10//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = ll_y + 22 //bottom right corner
		
			ll_x += ll_textwidth + 10
		END IF
	ELSE
		IF ll_item = 1 OR ist_tabs[ll_index].ab_selected THEN
			
			IF ist_tabs[ll_index].ab_selected AND ll_item <> 1 THEN
				ll_x -= 13
			END IF
			
			ist_tabs[ll_index].al_textx = ll_x + 12
			ll_textwidth += 8
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = 1 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x + 12//Top left corner
			ist_tabs[ll_index].ast_point[2].py = 20//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + ll_textwidth + 5//Top right corner
			ist_tabs[ll_index].ast_point[3].py = 20//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 15//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = 1 //bottom right corner
		
			ll_x += ll_textwidth + 15
			
		ELSE
			ist_tabs[ll_index].al_textx = ll_x
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = 1 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x - 5 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 12 //Bottom left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x - 1//Top left corner
			ist_tabs[ll_index].ast_point[3].py = 20//Top left corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 0//Top right corner
			ist_tabs[ll_index].ast_point[4].py = 20//Top right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 11//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = 1 //bottom right corner
		
			ll_x += ll_textwidth + 11
		END IF
	END IF
	
	IF ll_x < UnitsToPixels(uo_tabs.Width, XUnitsToPixels!) THEN
		il_lastvisible = ll_index
	END IF
	
NEXT

RETURN 1
end function

public function integer of_regular ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth
Point lp_empty[]

ll_count = UpperBound(ist_tabs)
ll_y = 0
ll_x = 4

FOR ll_index = il_firstvisible TO ll_count
	IF NOT ist_tabs[ll_index].ab_visible THEN CONTINUE
	
	ist_tabs[ll_index].ast_point = lp_empty
	st_1.Weight = 400
	
	IF il_index = ll_index THEN
		ist_tabs[ll_index].ab_mouseover = TRUE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('HOVER1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('HOVER2')
	ELSE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('BACKCOLOR1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('BACKCOLOR2')
	END IF
	
	IF il_selected = ll_index THEN
		ist_tabs[ll_index].ab_selected = TRUE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('SELECTED2')
		
		IF ib_boldselected THEN
			st_1.Weight = 700
		END IF
		
	ELSE
		ist_tabs[ll_index].ab_selected = FALSE
	END IF
	
	ll_textwidth = of_GetTextWidth(ist_tabs[ll_index].as_tab_text)
	ist_tabs[ll_index].al_textwidth = ll_textwidth
	
	IF ist_tabs[ll_index].al_pic_index > 0 THEN
		ll_textwidth += 16
	ELSE
		ll_textwidth += 2
	END IF
	
	IF il_CurrentPosition = TOP THEN
		IF ist_tabs[ll_index].ab_selected THEN
			
			ist_tabs[ll_index].al_textx = ll_x
			
			ll_x -= 1
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = ll_y + 22 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x//Top left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 4//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 2//Top right corner
			ist_tabs[ll_index].ast_point[3].py = ll_y + 2//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 0//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = ll_y + 2//bottom right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = ll_y + 4 //bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = ll_y + 22 //bottom right corner
		
			ll_x += ll_textwidth + 3
			
		ELSE
			ist_tabs[ll_index].al_textx = ll_x
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = ll_y + 22 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x//Top left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 4//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 2//Top right corner
			ist_tabs[ll_index].ast_point[3].py = ll_y + 2//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 0//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = ll_y + 2 //bottom right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = ll_y + 4 //bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = ll_y + 22 //bottom right corner
			
			ll_x += ll_textwidth + 4
		END IF
	ELSE
		IF ist_tabs[ll_index].ab_selected THEN
			
			ist_tabs[ll_index].al_textx = ll_x
			
			ll_x -= 1
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = 1 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x//Top left corner
			ist_tabs[ll_index].ast_point[2].py = 18//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 2//Top right corner
			ist_tabs[ll_index].ast_point[3].py = 18 + 2//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 0//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = 18 + 2 //bottom right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = 18  //bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = 1 //bottom right corner
			
			ll_x += ll_textwidth + 3
			
		ELSE
			ist_tabs[ll_index].al_textx = ll_x
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = 1 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x//Top left corner
			ist_tabs[ll_index].ast_point[2].py = 18//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 2//Top right corner
			ist_tabs[ll_index].ast_point[3].py = 18 + 2//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 0//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = 18 + 2 //bottom right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = 18  //bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 2//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = 0 //bottom right corner
			
			ll_x += ll_textwidth + 4
		END IF
		
	END IF
	
	IF ll_x < UnitsToPixels(uo_tabs.Width, XUnitsToPixels!) THEN
		il_lastvisible = ll_index
	END IF
	
NEXT

RETURN 1
end function

public function integer of_settabposition (long al_position);Long ll_index, ll_count

SetRedraw(FALSE)

ll_count = UpperBound(ist_tabs)

il_CurrentPosition = al_position

CHOOSE CASE al_position
	CASE TOP
		uo_tabs.Move(0,0)
		uo_navigation.Move(Width - uo_navigation.Width,0)
	CASE BOTTOM
		uo_tabs.Move(0, Height - uo_tabs.Height)
		uo_navigation.Move(Width - uo_navigation.Width, Height - uo_tabs.Height - 2)
END CHOOSE

FOR ll_index = 1 TO ll_count
	IF al_position = BOTTOM THEN
		ist_tabs[ll_index].ado_object.Move(4,5)	
	ELSE
		ist_tabs[ll_index].ado_object.Move(4,uo_tabs.Height)	
	END IF
NEXT
ib_dirty = TRUE
SetRedraw(TRUE)
RETURN 1
end function

public function long of_gettextwidth (string as_text);ULong lul_Handle, lul_hDC, lul_hFont
SIZE lstr_size

lul_Handle = Handle(st_1)
lul_hDC = GetDC(lul_Handle)
// get handle to the font used by statictext
lul_hFont = Send(lul_Handle, WM_GETFONT, 0, 0)
// Select it into the device context
SelectObject(lul_hDC, lul_hFont)

GetTextExtentPoint32(lul_hDC, as_text, Len(as_text), lstr_Size)
ReleaseDC(lul_Handle, lul_hDC)

RETURN lstr_Size.cx + 4
 
end function

public function integer of_setenabled (long al_index, boolean ab_switch);IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ist_tabs[al_index].ab_enabled = ab_switch
ist_tabs[al_index].ado_object.Enabled = ab_switch
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_boldselected (boolean ab_bold);ib_boldselected = ab_bold
ib_dirty = TRUE
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_settheme (long al_color);Long ll_index, ll_loop

il_currenttheme = al_color
ib_dirty = TRUE
SetRedraw(TRUE)

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

public function integer of_vs2005 ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth, ll_item
Point lp_empty[]

ll_count = UpperBound(ist_tabs)
ll_y = 0
ll_x = 9

FOR ll_index = il_firstvisible TO ll_count
	IF NOT ist_tabs[ll_index].ab_visible THEN CONTINUE
	
	ll_item++
	
	ist_tabs[ll_index].ast_point = lp_empty
	st_1.Weight = 400
	
	IF il_index = ll_index THEN
		ist_tabs[ll_index].ab_mouseover = TRUE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('HOVER1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('HOVER2')
	ELSE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('BACKCOLOR1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('BACKCOLOR2')
	END IF
	
	IF il_selected = ll_index THEN
		ist_tabs[ll_index].ab_selected = TRUE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('SELECTED2')
		
		IF ib_boldselected THEN
			st_1.Weight = 700
		END IF
		
	ELSE
		ist_tabs[ll_index].ab_selected = FALSE
	END IF
	
	ll_textwidth = of_GetTextWidth(ist_tabs[ll_index].as_tab_text)
	ist_tabs[ll_index].al_textwidth = ll_textwidth
	
	IF ist_tabs[ll_index].al_pic_index > 0 THEN
		ll_textwidth += 16
	ELSE
		ll_textwidth += 2
	END IF
	
	IF il_CurrentPosition = TOP THEN
		IF ll_item = 1 OR ist_tabs[ll_index].ab_selected THEN
			
			ll_x -= 9
			
			ist_tabs[ll_index].al_textx = ll_x + 20
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = ll_y + 22 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x + 17//Top left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 5//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 21//Top right corner
			ist_tabs[ll_index].ast_point[3].py = ll_y + 2//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 22//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = ll_y + 2//bottom right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 24//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = ll_y + 4 //bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 24//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = ll_y + 22 //bottom right corner
		
			ll_x += ll_textwidth + 24
			
		ELSE

			ist_tabs[ll_index].al_textx = ll_x + 11
			
			//ll_x -= 9
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = ll_y + 22 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[2].py = ll_y + 13 //Bottom left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 8//Top left corner
			ist_tabs[ll_index].ast_point[3].py = ll_y + 5//Top left corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + 12//Top right corner
			ist_tabs[ll_index].ast_point[4].py = ll_y + 2//Top right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 13//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = ll_y + 2//bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 15//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = ll_y + 4 //bottom right corner
			ist_tabs[ll_index].ast_point[7].px = ll_x + ll_textwidth + 15//bottom right corner
			ist_tabs[ll_index].ast_point[7].py = ll_y + 22 //bottom right corner
		
			ll_x += ll_textwidth + 15
		END IF
	ELSE
		IF ll_item = 1 OR ist_tabs[ll_index].ab_selected THEN
			
			ll_x -= 9
			
			ist_tabs[ll_index].al_textx = ll_x + 22
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = 1 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x + 17//Top left corner
			ist_tabs[ll_index].ast_point[2].py = 18//Top left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 21//Top right corner
			ist_tabs[ll_index].ast_point[3].py = 20//Top right corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + ll_textwidth + 22//bottom right corner
			ist_tabs[ll_index].ast_point[4].py = 20//bottom right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 24//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = 18 //bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 24//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = 1 //bottom right corner
		
			ll_x += ll_textwidth + 24
			
		ELSE

			ist_tabs[ll_index].al_textx = ll_x + 11
			
			//ll_x -= 9
			
			ist_tabs[ll_index].ast_point[1].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[1].py = 1 //Bottom left corner
			ist_tabs[ll_index].ast_point[2].px = ll_x //Bottom left corner
			ist_tabs[ll_index].ast_point[2].py = 10 //Bottom left corner
			ist_tabs[ll_index].ast_point[3].px = ll_x + 8//Top left corner
			ist_tabs[ll_index].ast_point[3].py = 18//Top left corner
			ist_tabs[ll_index].ast_point[4].px = ll_x + 12//Top right corner
			ist_tabs[ll_index].ast_point[4].py = 20//Top right corner
			ist_tabs[ll_index].ast_point[5].px = ll_x + ll_textwidth + 13//bottom right corner
			ist_tabs[ll_index].ast_point[5].py = 20//bottom right corner
			ist_tabs[ll_index].ast_point[6].px = ll_x + ll_textwidth + 15//bottom right corner
			ist_tabs[ll_index].ast_point[6].py = 18 //bottom right corner
			ist_tabs[ll_index].ast_point[7].px = ll_x + ll_textwidth + 15//bottom right corner
			ist_tabs[ll_index].ast_point[7].py = 1 //bottom right corner
		
			ll_x += ll_textwidth + 15
		END IF
		
	END IF
	
	IF ll_x < UnitsToPixels(uo_tabs.Width, XUnitsToPixels!) THEN
		il_lastvisible = ll_index
	END IF
	
NEXT

RETURN 1
end function

public function integer of_scrollleft ();il_firstvisible --
ib_dirty = TRUE
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_scrollright ();il_firstvisible ++
ib_dirty = TRUE
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_closetab (long al_index);Long ll_newselected, ll_oldselected, ll_index, ll_count, ll_item
TabStrip lst_tabs[]
UserObject luo_selected

IF al_index <= 0 THEN RETURN 0
IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ll_oldselected = il_selected

IF NOT ib_closing THEN
	IF Event TabClosing(al_index) = 0 THEN
		RETURN 0
	END IF
	
	luo_selected = of_GetObject(il_selected)
	
END IF

IF IsValid(ist_tabs[al_index].ado_object) THEN
	ist_tabs[al_index].ado_object.Hide()
	SetParent(Handle(ist_tabs[al_index].ado_object), Handle(iw_parent))
	iw_parent.CloseUserObject(ist_tabs[al_index].ado_object)
END IF

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ll_index <> al_index THEN
		ll_item++
		lst_tabs[ll_item] = ist_tabs[ll_index]
	END IF
NEXT

ist_tabs = lst_tabs
il_index = 0
ib_dirty = TRUE

SetRedraw(TRUE)
Event TabClosed(al_index)

IF NOT ib_closing THEN
	IF al_index = il_selected THEN
		IF UpperBound(ist_tabs) > 0 THEN
		
			IF ll_oldselected < UpperBound(ist_tabs) THEN
				IF ist_tabs[il_selected].ab_Enabled THEN
					of_SelectTab(il_selected)
				ELSE
					il_selected = 0
					SetRedraw(TRUE)
				END IF
			ELSE
				IF ist_tabs[UpperBound(ist_tabs)].ab_Enabled THEN
					IF il_selected = al_index THEN
						il_selected = 0
					END IF
					of_SelectTab(UpperBound(ist_tabs))
				ELSE
					il_selected = 0
					SetRedraw(TRUE)
				END IF
			END IF
		ELSE
			il_selected = 0
			SetRedraw(TRUE)
		END IF
	ELSE
		IF IsValid(luo_selected) THEN
			of_SelectTab(luo_selected)
		END IF
	END IF
END IF

RETURN 1
end function

public function integer of_closeselectedtab ();RETURN of_CloseTab(il_selected)

end function

public function long of_getselectedtab ();RETURN il_selected
end function

public function integer of_closealltabs ();Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	of_CloseTab(1)
NEXT

RETURN 1
end function

public function long of_gettabcount ();RETURN UpperBound(ist_tabs)
end function

public function userobject of_getobject (long al_index);RETURN ist_tabs[al_index].ado_object
end function

public function integer of_settext (long al_index, string as_text);IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ist_tabs[al_index].as_tab_text = as_text
ib_dirty = TRUE
SetRedraw(TRUE)
RETURN 1
end function

public function String of_gettext (long al_index);RETURN ist_tabs[al_index].as_tab_text
end function

public function integer of_closetab (u_cst_tabpage auo_tabpage);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_CloseTab(ll_index)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_mouseover (long al_index);IF al_index > 0 THEN
	IF il_selected = al_index THEN
		ist_tabs[al_index].ab_selected = TRUE
		ist_tabs[al_index].ab_mouseover = FALSE
		ist_tabs[al_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_tabs[al_index].al_backcolor2 = of_GetColor('SELECTED2')
	ELSE
		ist_tabs[al_index].ab_mouseover = TRUE
		ist_tabs[al_index].al_backcolor1 = of_GetColor('HOVER1')
		ist_tabs[al_index].al_backcolor2 = of_GetColor('HOVER2')
	END IF
END IF

IF il_index > 0 THEN
	IF il_selected = il_index THEN
		ist_tabs[il_index].ab_selected = TRUE
		ist_tabs[il_index].ab_mouseover = FALSE
		ist_tabs[il_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_tabs[il_index].al_backcolor2 = of_GetColor('SELECTED2')
	ELSE
		ist_tabs[il_index].ab_mouseover = FALSE
		ist_tabs[il_index].al_backcolor1 = of_GetColor('BACKCOLOR1')
		ist_tabs[il_index].al_backcolor2 = of_GetColor('BACKCOLOR2')
	END IF
END IF

il_index = al_index

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_mouseleave ();Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF il_selected = ll_index THEN
		ist_tabs[ll_index].ab_selected = TRUE
		ist_tabs[il_selected].ab_mouseover = FALSE
		ist_tabs[il_selected].al_backcolor1 = of_GetColor('SELECTED1')
		ist_tabs[il_selected].al_backcolor2 = of_GetColor('SELECTED2')
	ELSE
		ist_tabs[ll_index].ab_selected = FALSE
		ist_tabs[ll_index].ab_mouseover = FALSE
		ist_tabs[ll_index].al_backcolor1 = of_GetColor('BACKCOLOR1')
		ist_tabs[ll_index].al_backcolor2 = of_GetColor('BACKCOLOR2')
	END IF
NEXT

il_index = 0

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setimage (long al_index, long al_image);IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ist_tabs[al_index].al_pic_index = al_image
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_settext (u_cst_tabpage auo_tabpage, string as_text);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SetText(ll_index, as_text)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_setimage (u_cst_tabpage auo_tabpage, long al_image);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SetImage(ll_index, al_image)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_showclosebutton ();IF ib_hideclosebutton THEN
	uo_navigation.Width = uo_navigation.Width + 89
	ib_hideclosebutton = FALSE
END IF
TriggerEvent('resize')
RETURN 1
end function

public function integer of_setenabled (u_cst_tabpage auo_tabpage, boolean ab_switch);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SetEnabled(ll_index, ab_switch)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function string of_gettext (u_cst_tabpage auo_tabpage);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		RETURN of_GetText(ll_index)
	END IF
NEXT

RETURN ''
end function

public function integer of_settiptext (long al_index, string as_text);IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ist_tabs[al_index].as_tooltip = as_text
RETURN 1
end function

public function integer of_settiptext (u_cst_tabpage auo_tabpage, string as_text);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SetTipText(ll_index, as_text)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function string of_gettiptext (long al_index);RETURN ist_tabs[al_index].as_tooltip
end function

public function integer of_settextcolor (u_cst_tabpage auo_tabpage, long al_color);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SetTextColor(ll_index, al_color)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_settextcolor (long al_index, long al_color);IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ist_tabs[al_index].al_textcolor = al_color
ib_dirty = TRUE
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_setvisible (long al_index, boolean ab_switch);IF al_index > UpperBound(ist_tabs) THEN RETURN 0

ib_dirty = TRUE
ist_tabs[al_index].ab_visible = ab_switch
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_setvisible (u_cst_tabpage auo_tabpage, boolean ab_switch);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SetVisible(ll_index, ab_switch)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function boolean of_isvisible (long al_index);IF al_index > UpperBound(ist_tabs) THEN RETURN FALSE

RETURN ist_tabs[al_index].ab_visible
end function

public function boolean of_isvisible (u_cst_tabpage auo_tabpage);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		RETURN of_IsVisible(ll_index)
		EXIT
	END IF
NEXT

RETURN FALSE
end function

public function boolean of_isenabled (long al_index);IF al_index > UpperBound(ist_tabs) THEN RETURN FALSE

RETURN ist_tabs[al_index].ab_enabled
end function

public function boolean of_isenabled (u_cst_tabpage auo_tabpage);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		RETURN of_IsEnabled(ll_index)
		EXIT
	END IF
NEXT

RETURN FALSE
end function

public function integer of_hideclosebutton ();IF NOT ib_hideclosebutton THEN
	uo_navigation.Width = uo_navigation.Width - 89
	ib_hideclosebutton = TRUE
END IF
TriggerEvent('resize')
RETURN 1
end function

public function integer of_hidearrows ();IF NOT ib_hidearrows THEN
	uo_navigation.Width = uo_navigation.Width - 151
	ib_hidearrows = TRUE
END IF
TriggerEvent('resize')
RETURN 1
end function

public function integer of_showarrows ();IF ib_hidearrows THEN
	uo_navigation.Width = uo_navigation.Width + 151
	ib_hidearrows = FALSE
END IF

TriggerEvent('resize')
RETURN 1
end function

public function long of_opentab (ref u_cst_tabpage a_object, string as_text, long al_picindex);Long ll_item

ll_item = UpperBound(ist_tabs) + 1

ist_tabs[ll_item].as_tab_text = as_text
ist_tabs[ll_item].al_pic_index = al_picindex
ist_tabs[ll_item].ab_enabled = TRUE
ist_tabs[ll_item].ab_visible = TRUE

iw_parent.OpenUserObject(a_object)
SetParent(Handle(a_object), Handle(THIS))

IF il_CurrentPosition = TOP THEN
	a_object.Y = uo_tabs.Height
ELSE
	a_object.Y = 5
END IF

a_object.X = 4
a_object.Width = Width - 8
a_object.Height = Height - uo_tabs.Height - 4
a_object.Hide()

ist_tabs[ll_item].ado_object = a_object

of_UpdatePoints()

Return ll_item

end function

public function integer of_selecttab (u_cst_tabpage auo_tabpage);Long ll_index, ll_count

ll_count = UpperBound(ist_tabs)

FOR ll_index = 1 TO ll_count
	IF ist_tabs[ll_index].ado_object = auo_tabpage THEN
		of_SelectTab(ll_index)
		EXIT
	END IF
NEXT

RETURN 1

end function

on u_cst_tabcontrol.create
this.uo_navigation=create uo_navigation
this.lv_imagelist=create lv_imagelist
this.uo_tabs=create uo_tabs
this.st_1=create st_1
this.Control[]={this.uo_navigation,&
this.lv_imagelist,&
this.uo_tabs,&
this.st_1}
end on

on u_cst_tabcontrol.destroy
destroy(this.uo_navigation)
destroy(this.lv_imagelist)
destroy(this.uo_tabs)
destroy(this.st_1)
end on

event constructor;n_cst_theme lnv_Theme
Long ll_color1
Long ll_color2
message l_message

l_message = CREATE Message
l_message.Handle = Message.Handle
l_message.Number = Message.Number
l_message.WordParm = Message.WordParm
l_message.LongParm = Message.LongParm
l_message.DoubleParm = Message.DoubleParm
l_message.StringParm = Message.StringParm
l_message.PowerObjectParm = Message.PowerObjectParm
l_message.Processed = Message.Processed
l_message.ReturnValue = Message.ReturnValue

of_GetWindow()

If lnv_Theme.of_IsAppThemed() And lnv_Theme.of_IsWindowsXp() Then
	ll_Color1 = lnv_Theme.of_GetColor( 1, 1, 3821 )
	ll_Color2 = lnv_Theme.of_GetColor( 1, 1, 3805 )
	Choose Case ll_Color1
		Case 15029248	// Blue
			of_SetTheme(BLUE)
		Case 12493732	//	Silver
			of_SetTheme(SILVER)
		Case 8829098	// olive green
			of_SetTheme(OLIVE)
		Case Else
			of_SetTheme(CLASSIC)
	End Choose
Else
	of_SetTheme(CLASSIC)
End If

TriggerEvent('resize')

Message.Handle = l_message.Handle
Message.Number = l_message.Number
Message.WordParm = l_message.WordParm
Message.LongParm = l_message.LongParm
Message.DoubleParm = l_message.DoubleParm
Message.StringParm = l_message.StringParm
Message.PowerObjectParm = l_message.PowerObjectParm
Message.Processed = l_message.Processed
Message.ReturnValue = l_message.ReturnValue
DESTROY l_message
end event

event destructor;ib_closing = TRUE
of_CloseAllTabs()
end event

type uo_navigation from u_cst_tabstripnavigate within u_cst_tabcontrol
integer x = 558
integer width = 242
integer height = 92
integer taborder = 30
end type

on uo_navigation.destroy
call u_cst_tabstripnavigate::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
end event

type lv_imagelist from listview within u_cst_tabcontrol
boolean visible = false
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type uo_tabs from u_cst_tabstrip within u_cst_tabcontrol
event lbuttondown pbm_lbuttondown
event paint pbm_paint
integer width = 1184
integer height = 92
integer taborder = 10
end type

event lbuttondown;IF il_index > 0 THEN
	of_SelectTab(il_index)
END IF
end event

on uo_tabs.destroy
call u_cst_tabstrip::destroy
end on

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

in_Gradient.of_VerticalGradient( of_GetColor('TABBACK2'),  of_GetColor('TABBACK1'), THIS)
IF ib_dirty THEN
	of_UpdatePoints()
	uo_navigation.SetRedraw(TRUE)
	ib_dirty = FALSE
END IF
in_Gradient.of_DrawTabs(THIS, ist_tabs, UnitsToPixels(Width, XUnitsToPixels!), UnitsToPixels(Height, YUnitsToPixels!), of_GetColor('BORDER'), il_imagelistsmall, il_CurrentPosition = BOTTOM, ib_boldselected, il_firstvisible)

RETURN 1
end event

event constructor;call super::constructor;of_SetParent(PARENT)
end event

event rbuttondown;call super::rbuttondown;PARENT.Event RightClicked(il_index)
end event

type st_1 from statictext within u_cst_tabcontrol
integer width = 10002
integer height = 10000
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "  Tab Control"
boolean focusrectangle = false
end type

event constructor;Hide()
TextSize = 13
end event

