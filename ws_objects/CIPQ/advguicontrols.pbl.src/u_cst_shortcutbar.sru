$PBExportHeader$u_cst_shortcutbar.sru
forward
global type u_cst_shortcutbar from userobject
end type
type uo_header from u_cst_shortcutheader within u_cst_shortcutbar
end type
type uo_icontray from u_cst_icontray within u_cst_shortcutbar
end type
type uo_32 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_31 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_30 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_29 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_28 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_27 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_26 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_25 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_24 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_23 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_22 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_21 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_20 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_19 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_18 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_17 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_16 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_15 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_14 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_13 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_12 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_11 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_10 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_9 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_8 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_7 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_6 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_5 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_4 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_3 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_2 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type uo_1 from u_cst_shortcutitem within u_cst_shortcutbar
end type
type st_back from statictext within u_cst_shortcutbar
end type
type uo_splitbar from u_cst_shortcutsplitbar within u_cst_shortcutbar
end type
type st_1 from statictext within u_cst_shortcutbar
end type
end forward

global type u_cst_shortcutbar from userobject
integer width = 859
integer height = 1024
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize pbm_size
event ue_selectionchanged ( string as_text,  string as_image )
uo_header uo_header
uo_icontray uo_icontray
uo_32 uo_32
uo_31 uo_31
uo_30 uo_30
uo_29 uo_29
uo_28 uo_28
uo_27 uo_27
uo_26 uo_26
uo_25 uo_25
uo_24 uo_24
uo_23 uo_23
uo_22 uo_22
uo_21 uo_21
uo_20 uo_20
uo_19 uo_19
uo_18 uo_18
uo_17 uo_17
uo_16 uo_16
uo_15 uo_15
uo_14 uo_14
uo_13 uo_13
uo_12 uo_12
uo_11 uo_11
uo_10 uo_10
uo_9 uo_9
uo_8 uo_8
uo_7 uo_7
uo_6 uo_6
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
st_back st_back
uo_splitbar uo_splitbar
st_1 st_1
end type
global u_cst_shortcutbar u_cst_shortcutbar

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
FUNCTION unsignedlong GetSysColor(int nIndex) LIBRARY "user32.dll"
end prototypes

type variables
Boolean ib_startsplit = FALSE
Boolean ib_move = FALSE
String is_ini
Boolean ib_ini
Boolean ib_vistastyle
Boolean ib_shadowtext
Boolean ib_headerimage

n_cst_shortcutbar_gradient	in_gradient

u_cst_shortcutitem iuo_items[]
u_cst_shortcutitem iuo_useditems[]
DragObject iuo_objects[]

u_cst_shortcutitem old_item
u_cst_shortcutitem current_item

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

CONSTANT Long NOPATTERN = 0
CONSTANT Long SOLIDCIRCLE = 1
CONSTANT Long HOLLOWCIRCLE = 2
CONSTANT Long SOLIDSQUARE = 3
CONSTANT Long HOLLOWSQUARE = 4
CONSTANT Long STAR = 6
CONSTANT Long WAVE = 7
CONSTANT Long BAR = 8
CONSTANT Long DIAMOND = 9

CONSTANT Long SMALL = 16
CONSTANT Long LARGE = 24

Long il_CurrentSize = SMALL
Long il_CurrentPattern = NOPATTERN
Long il_CurrentStyle = XP
Long il_CurrentTheme = BLUE
end variables

forward prototypes
public function integer of_setselected (u_cst_shortcutitem auo_item)
public function integer of_selectitem (long al_item)
public function integer of_hideitem (long al_item)
public function integer of_hideitem (string as_text)
public function integer of_showitem (string as_text)
public function integer of_showitem (long al_item)
public function integer of_additem (dragobject a_object, string as_text, string as_image)
public function long of_getcolor (string as_color)
public function window of_getparentwindow ()
public function integer of_showfewer ()
public function integer of_showmore ()
public function integer of_selectitem (string as_text)
public function integer of_setini (string as_ini)
public function integer of_loadsettings ()
public function integer of_savesettings ()
public function integer of_hideall ()
public function integer of_showall ()
public function boolean of_settingsexist ()
public function integer of_settheme (long al_color)
public function long of_gettheme ()
public function integer of_settheme (string as_color)
public function integer of_displayheaderimage (boolean ab_switch)
public function integer of_setstyle (integer ai_style)
public function integer of_getstyle ()
public function boolean of_shadowtext ()
public function integer of_setshadowtext (boolean ab_switch)
public function integer of_setpattern (long al_pattern)
public function integer of_getpattern ()
public function integer of_setsize (long al_size)
public function boolean of_displayclosebutton (boolean ab_display)
public function integer of_setenabled (long al_item, boolean ab_enabled)
public function integer of_setenabled (string as_text, boolean ab_enabled)
end prototypes

event resize;Long ll_index, ll_loop, ll_count, ll_visible
u_cst_shortcutitem luo_previtem

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	IF iuo_useditems[ll_index].Visible THEN
		ll_visible++
	END IF
NEXT

uo_header.Width = Width - 2

uo_icontray.Resize(Width - 2, uo_icontray.Height)
uo_icontray.TriggerEvent('Resize')
uo_icontray.Y = Height - uo_icontray.Height
//uo_splitbar.Y = uo_icontray.Y - uo_splitbar.Height - (ll_visible * 100)
IF il_CurrentSize = SMALL THEN
	uo_splitbar.Y = uo_icontray.Y - uo_splitbar.Height - (ll_visible * 122) + (ll_visible * 2)
ELSE
	uo_splitbar.Y = uo_icontray.Y - uo_splitbar.Height - (ll_visible * 134) + (ll_visible * 2)
END IF

uo_splitbar.Width = uo_header.Width - 10

st_back.Resize(Width - 2, Height)

FOR ll_index = ll_loop TO 1 STEP -1
	IF iuo_useditems[ll_index].Visible THEN
		ll_count++
		iuo_useditems[ll_index].Width = Width - 2
		IF IsValid(luo_previtem) THEN
			iuo_useditems[ll_index].Y = luo_previtem.Y - iuo_useditems[ll_index].Height + 5
		ELSE
			iuo_useditems[ll_index].Y = uo_icontray.Y - iuo_useditems[ll_index].Height + 5
		END IF
		
		luo_previtem = iuo_useditems[ll_index]
		
	END IF
	
	iuo_useditems[ll_index].of_Position(5, uo_header.Height, Width - 15, uo_splitbar.Y - uo_header.Height - 3)
NEXT
end event

public function integer of_setselected (u_cst_shortcutitem auo_item);
// Render old selected item to unselected
IF IsValid(old_item) THEN
	old_item.ib_selected = FALSE
	//old_item.TriggerEvent('paint')
	old_item.iuo_object.Visible = FALSE
END IF

// Render new selected item
auo_item.ib_selected = TRUE
//auo_item.TriggerEvent('paint')

// Render Selected object to front
auo_item.iuo_object.Visible = TRUE
auo_item.iuo_object.SetPosition(ToTop!)
auo_item.iuo_object.SetFocus()

IF ib_headerimage THEN
	uo_header.of_SetImage(auo_item.of_GetImage(), uo_header.LEFT)
ELSE
	uo_header.of_SetImage('', uo_header.LEFT)
END IF

uo_header.of_SetImage(auo_item.of_GetImage(), uo_header.LEFT)
uo_header.of_SetText(auo_item.of_GetText(), uo_header.LEFT)

// Trigger event for the selected item
Event ue_SelectionChanged(auo_item.of_GetText(), auo_item.of_GetImage())

uo_icontray.of_Refresh()

old_item = auo_item
current_item = auo_item

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_selectitem (long al_item);IF al_item > UpperBound(iuo_useditems) THEN
	RETURN 0
ELSE
	RETURN of_SetSelected(iuo_useditems[al_item])
END IF
end function

public function integer of_hideitem (long al_item);SetRedraw(FALSE)
iuo_useditems[al_item].Visible = FALSE
iuo_useditems[al_item].ib_mousecaptured = FALSE
uo_icontray.of_AddItem(iuo_useditems[al_item], al_item)
TriggerEvent('resize')
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_hideitem (string as_text);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	
	IF Lower(iuo_useditems[ll_index].of_GetText()) = Lower(as_text) THEN
		of_HideItem(ll_index)
		RETURN 1
	END IF
	
NEXT

RETURN 0
end function

public function integer of_showitem (string as_text);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	
	IF Lower(iuo_useditems[ll_index].of_GetText()) = Lower(as_text) THEN
		of_ShowItem(ll_index)
		RETURN 1
	END IF
	
NEXT

RETURN 0
end function

public function integer of_showitem (long al_item);SetRedraw(FALSE)
iuo_useditems[al_item].Visible = TRUE
uo_icontray.of_RemoveItem(iuo_useditems[al_item], al_item)
TriggerEvent('resize')
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_additem (dragobject a_object, string as_text, string as_image);Long ll_index, ll_count, ll_loop

SetParent(Handle(a_object), Handle(THIS))

ll_count = UpperBound(iuo_objects)

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	IF NOT iuo_items[ll_index].ib_used THEN
		iuo_items[ll_index].ib_used = TRUE
		iuo_items[ll_index].iuo_object = a_object
		iuo_items[ll_index].of_SetText(as_text)
		iuo_items[ll_index].of_SetImage(as_image)
		iuo_items[ll_index].Show()
		iuo_useditems[ll_count + 1] = iuo_items[ll_index]
		EXIT
	END IF
NEXT

iuo_objects[ll_count + 1] = a_object

TriggerEvent('resize')

RETURN ll_count + 1
end function

public function long of_getcolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "BORDER"
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
	CASE "SPLITBAR1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(89,135,214)
			CASE SILVER
				ll_color = RGB(168,167,191)
			CASE OLIVE
				ll_color = RGB(120,142,111)
			CASE CLASSIC
				ll_color = RGB(212,208,200)
			CASE DEFAULT
				ll_color = GetSysColor(15)			
		END CHOOSE
	CASE "SPLITBAR2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(0,45,150)
			CASE SILVER
				ll_color = RGB(119,118,151)
			CASE OLIVE
				ll_color = RGB(73,91,67)
			CASE CLASSIC
				ll_color = RGB(142,141,140)
			CASE DEFAULT
				ll_color = GetSysColor (16) //GetSysColor(12)				
		END CHOOSE
	CASE "HOVER1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,255,220)
			CASE SILVER
				ll_color = RGB(255,255,220)
			CASE OLIVE
				ll_color = RGB(255,255,220)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
			CASE DEFAULT
				ll_color = 16777215
		END CHOOSE
	CASE "HOVER2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(247,192,91)
			CASE SILVER
				ll_color = RGB(247,192,91)
			CASE OLIVE
				ll_color = RGB(247,192,91)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
			CASE DEFAULT
				ll_color = 16777215
		END CHOOSE
	CASE "BACKCOLOR1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(203,225,252)
			CASE SILVER
				ll_color = RGB(225,226,236)
			CASE OLIVE
				ll_color = RGB(234,240,207)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
			CASE DEFAULT
				ll_color = GetSysColor (0)
		END CHOOSE
	CASE "BACKCOLOR2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(126,166,225)
			CASE SILVER
				ll_color = RGB(149,147,177)
			CASE OLIVE
				ll_color = RGB(177,192,140)
			CASE CLASSIC
				ll_color = RGB(213,209,201)
			CASE DEFAULT
				ll_color = GetSysColor (15)				
		END CHOOSE
	CASE "HOVERSELECTED1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(232,127,8)
			CASE SILVER
				ll_color = RGB(232,127,8)
			CASE OLIVE
				ll_color = RGB(232,127,8)
			CASE CLASSIC
				ll_color = RGB(133,146,181)
			CASE DEFAULT
				ll_color = GetSysColor (11)		
		END CHOOSE
	CASE "HOVERSELECTED2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(247,219,124)
			CASE SILVER
				ll_color = RGB(247,219,124)
			CASE OLIVE
				ll_color = RGB(247,219,124)
			CASE CLASSIC
				ll_color = RGB(133,146,181)
			CASE DEFAULT
				ll_color = GetSysColor (11)				
		END CHOOSE
	CASE "SELECTED1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(247,219,124)
			CASE SILVER
				ll_color = RGB(251,230,148)
			CASE OLIVE
				ll_color = RGB(251,230,148)
			CASE CLASSIC
				ll_color = RGB(212,213,216)
			CASE DEFAULT
				ll_color = GetSysColor (0)		
		END CHOOSE
	CASE "SELECTED2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(238,150,21)
			CASE SILVER
				ll_color = RGB(238,150,21)
			CASE OLIVE
				ll_color = RGB(238,150,21)
			CASE CLASSIC
				ll_color = RGB(212,213,216)
			CASE DEFAULT
				ll_color = GetSysColor (0)			
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
	CASE "HEADERTEXT"
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
END CHOOSE

RETURN ll_color
end function

public function window of_getparentwindow ();PowerObject lpo

lpo = THIS.GetParent()

DO UNTIL lpo.TypeOf() = Window!
	lpo = lpo.GetParent()
LOOP

RETURN lpo
end function

public function integer of_showfewer ();Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = ll_loop TO 1 STEP -1
	IF iuo_useditems[ll_index].Visible THEN
		of_HideItem(ll_index)
		RETURN 1
	END IF
NEXT

RETURN 1
end function

public function integer of_showmore ();Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	IF NOT iuo_useditems[ll_index].Visible THEN
		of_ShowItem(ll_index)
		RETURN 1
	END IF
NEXT

RETURN 1

RETURN 1
end function

public function integer of_selectitem (string as_text);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	
	IF Lower(iuo_useditems[ll_index].of_GetText()) = Lower(as_text) THEN
		RETURN of_SelectItem(ll_index)
	END IF
	
NEXT

RETURN 0
end function

public function integer of_setini (string as_ini);Long ll_file

is_ini = as_ini

IF Lower(Right(is_ini, 4)) = '.ini' THEN
	ib_ini = TRUE
	IF NOT FileExists(is_ini) THEN
		ll_file = FileOpen(is_ini, LineMode!, Write!)
		FileClose(ll_file)
	END IF
ELSE
	
END IF

IF of_SettingsExist() THEN
	of_LoadSettings()
END IF

RETURN 1
end function

public function integer of_loadsettings ();String ls_state, ls_selected
Long ll_index, ll_count

IF Len(Trim(is_ini)) = 0 THEN
	RETURN 0
END IF

ll_count = UpperBound(iuo_useditems)


FOR ll_index = 1 TO ll_count
	
	IF ib_ini THEN
		ls_state = ProfileString(is_ini, 'shortcutbar', iuo_useditems[ll_index].of_GetText(), '2')
	ELSE
		IF RegistryGet(is_ini + 'shortcutbar', iuo_useditems[ll_index].of_GetText(), RegString!, ls_state) = - 1 THEN
			ls_state = '2'
		END IF
	END IF
	
	CHOOSE CASE ls_state
		CASE '0'
			IF iuo_useditems[ll_index].Visible THEN
				of_HideItem(iuo_useditems[ll_index].of_GetText())
			END IF
		CASE '1'
			IF NOT iuo_useditems[ll_index].Visible THEN
				of_ShowItem(iuo_useditems[ll_index].of_GetText())
			END IF
		CASE '2'
			//
	END CHOOSE
	
	IF ib_ini THEN
		ls_selected = ProfileString(is_ini, 'shortcutbar', 'SelItem', '')
	ELSE
		IF RegistryGet(is_ini + 'shortcutbar', 'SelItem', RegString!, ls_selected) = - 1 THEN
			ls_selected = ''
		END IF
	END IF
	
	IF Len(Trim(ls_selected)) > 0 THEN
		of_SelectItem(ls_selected)
	END IF
	
NEXT

RETURN 1
end function

public function integer of_savesettings ();Long ll_index, ll_count

IF Len(Trim(is_ini)) = 0 THEN
	RETURN 0
END IF

ll_count = UpperBound(iuo_useditems)


FOR ll_index = 1 TO ll_count
	
	CHOOSE CASE iuo_useditems[ll_index].Visible
		CASE FALSE
			IF ib_ini THEN
				SetProfileString(is_ini, 'shortcutbar', iuo_useditems[ll_index].of_GetText(), '0')
			ELSE
				RegistrySet(is_ini + 'shortcutbar', iuo_useditems[ll_index].of_GetText(), RegString!, '0')
			END IF
		CASE TRUE
			IF ib_ini THEN
				SetProfileString(is_ini, 'shortcutbar', iuo_useditems[ll_index].of_GetText(), '1')
			ELSE
				RegistrySet(is_ini + 'shortcutbar', iuo_useditems[ll_index].of_GetText(), RegString!, '1')
			END IF
	END CHOOSE
	
	IF iuo_useditems[ll_index].ib_selected THEN
		IF ib_ini THEN
			SetProfileString(is_ini, 'shortcutbar', 'SelItem', iuo_useditems[ll_index].of_GetText())			
		ELSE
			RegistrySet(is_ini + 'shortcutbar', 'SelItem', RegString!, iuo_useditems[ll_index].of_GetText())
		END IF
	END IF
	
NEXT

RETURN 1
end function

public function integer of_hideall ();Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = ll_loop TO 1 STEP -1
	IF iuo_useditems[ll_index].Visible THEN
		of_HideItem(ll_index)
	END IF
NEXT

RETURN 1
end function

public function integer of_showall ();Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	IF NOT iuo_useditems[ll_index].Visible THEN
		of_ShowItem(ll_index)
	END IF
NEXT

RETURN 1

RETURN 1
end function

public function boolean of_settingsexist ();String ls_item

IF ib_ini THEN
   ls_item = ProfileString(is_ini, "shortcutbar", "SelItem", "")
ELSE
   RegistryGet(is_ini + "shortcutbar", "SelItem", RegString!, ls_item)
END IF

IF ls_item = "" THEN
	Return False
ELSE
   Return True
END IF 
end function

public function integer of_settheme (long al_color);Long ll_index, ll_loop

il_currenttheme = al_color

THIS.BackColor = al_color

st_back.BorderColor = of_GetColor('BORDER')
st_back.SetRedraw(FALSE)
st_back.SetRedraw(TRUE)

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	iuo_items[ll_index].BackColor = THIS.BackColor
	//iuo_items[ll_index].TriggerEvent('paint')
NEXT

uo_header.BackColor = THIS.BackColor
uo_splitbar.BackColor = THIS.BackColor
uo_icontray.BackColor = THIS.BackColor
uo_icontray.of_SetBackColor(THIS.BackColor)

//uo_header.TriggerEvent('paint')
//uo_splitbar.TriggerEvent('paint')
//uo_icontray.TriggerEvent('paint')
//uo_icontray.of_Refresh()
SetRedraw(TRUE)

RETURN 1
end function

public function long of_gettheme ();RETURN il_CurrentTheme
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

public function integer of_displayheaderimage (boolean ab_switch);ib_headerimage = ab_switch

IF IsValid(uo_header) THEN
	uo_header.TriggerEvent('resize')
END IF

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setstyle (integer ai_style);il_CurrentStyle = ai_style
of_SetTheme(of_GetTheme())
RETURN 1
end function

public function integer of_getstyle ();RETURN il_CurrentStyle
end function

public function boolean of_shadowtext ();RETURN ib_shadowtext
end function

public function integer of_setshadowtext (boolean ab_switch);ib_shadowtext = ab_switch
of_SetTheme(of_GetTheme())
RETURN 1
end function

public function integer of_setpattern (long al_pattern);il_CurrentPattern = al_pattern
of_SetTheme(of_GetTheme())
RETURN 1
end function

public function integer of_getpattern ();RETURN il_CurrentPattern
end function

public function integer of_setsize (long al_size);Long ll_index

SetRedraw(FALSE)

il_CurrentSize = al_size

FOR ll_index = 1 TO 32
	iuo_items[ll_index].of_SetSize(al_size)
NEXT

TriggerEvent('Resize')
SetRedraw(TRUE)

RETURN 1
end function

public function boolean of_displayclosebutton (boolean ab_display);
Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	iuo_items[ll_index].ib_DisplayCloseButton = ab_display
NEXT

RETURN ab_display
end function

public function integer of_setenabled (long al_item, boolean ab_enabled);iuo_useditems[al_item].Enabled  = ab_enabled
iuo_useditems[al_item].of_Enabled (ab_enabled)

IF IsValid(uo_icontray.iuo_items[al_item]) Then
	uo_icontray.iuo_items[al_item].Enabled = ab_enabled
	uo_icontray.iuo_items[al_item].of_Enabled (ab_enabled)
END IF

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setenabled (string as_text, boolean ab_enabled);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_useditems)

FOR ll_index = 1 TO ll_loop
	
	IF Lower(iuo_useditems[ll_index].of_GetText()) = Lower(as_text) THEN
		of_SetEnabled(ll_index, ab_enabled)
		RETURN 1
	END IF
	
NEXT

RETURN 0
end function

on u_cst_shortcutbar.create
this.uo_header=create uo_header
this.uo_icontray=create uo_icontray
this.uo_32=create uo_32
this.uo_31=create uo_31
this.uo_30=create uo_30
this.uo_29=create uo_29
this.uo_28=create uo_28
this.uo_27=create uo_27
this.uo_26=create uo_26
this.uo_25=create uo_25
this.uo_24=create uo_24
this.uo_23=create uo_23
this.uo_22=create uo_22
this.uo_21=create uo_21
this.uo_20=create uo_20
this.uo_19=create uo_19
this.uo_18=create uo_18
this.uo_17=create uo_17
this.uo_16=create uo_16
this.uo_15=create uo_15
this.uo_14=create uo_14
this.uo_13=create uo_13
this.uo_12=create uo_12
this.uo_11=create uo_11
this.uo_10=create uo_10
this.uo_9=create uo_9
this.uo_8=create uo_8
this.uo_7=create uo_7
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
this.st_back=create st_back
this.uo_splitbar=create uo_splitbar
this.st_1=create st_1
this.Control[]={this.uo_header,&
this.uo_icontray,&
this.uo_32,&
this.uo_31,&
this.uo_30,&
this.uo_29,&
this.uo_28,&
this.uo_27,&
this.uo_26,&
this.uo_25,&
this.uo_24,&
this.uo_23,&
this.uo_22,&
this.uo_21,&
this.uo_20,&
this.uo_19,&
this.uo_18,&
this.uo_17,&
this.uo_16,&
this.uo_15,&
this.uo_14,&
this.uo_13,&
this.uo_12,&
this.uo_11,&
this.uo_10,&
this.uo_9,&
this.uo_8,&
this.uo_7,&
this.uo_6,&
this.uo_5,&
this.uo_4,&
this.uo_3,&
this.uo_2,&
this.uo_1,&
this.st_back,&
this.uo_splitbar,&
this.st_1}
end on

on u_cst_shortcutbar.destroy
destroy(this.uo_header)
destroy(this.uo_icontray)
destroy(this.uo_32)
destroy(this.uo_31)
destroy(this.uo_30)
destroy(this.uo_29)
destroy(this.uo_28)
destroy(this.uo_27)
destroy(this.uo_26)
destroy(this.uo_25)
destroy(this.uo_24)
destroy(this.uo_23)
destroy(this.uo_22)
destroy(this.uo_21)
destroy(this.uo_20)
destroy(this.uo_19)
destroy(this.uo_18)
destroy(this.uo_17)
destroy(this.uo_16)
destroy(this.uo_15)
destroy(this.uo_14)
destroy(this.uo_13)
destroy(this.uo_12)
destroy(this.uo_11)
destroy(this.uo_10)
destroy(this.uo_9)
destroy(this.uo_8)
destroy(this.uo_7)
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.st_back)
destroy(this.uo_splitbar)
destroy(this.st_1)
end on

event constructor;Long ll_color1, ll_color2
n_cst_theme lnv_Theme

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

iuo_items[1] = uo_1
iuo_items[2] = uo_2
iuo_items[3] = uo_3
iuo_items[4] = uo_4
iuo_items[5] = uo_5
iuo_items[6] = uo_6
iuo_items[7] = uo_7
iuo_items[8] = uo_8
iuo_items[9] = uo_9
iuo_items[10] = uo_10
iuo_items[11] = uo_11
iuo_items[12] = uo_12
iuo_items[13] = uo_13
iuo_items[14] = uo_14
iuo_items[15] = uo_15
iuo_items[16] = uo_16
iuo_items[17] = uo_17
iuo_items[18] = uo_18
iuo_items[19] = uo_19
iuo_items[20] = uo_20
iuo_items[21] = uo_21
iuo_items[22] = uo_22
iuo_items[23] = uo_23
iuo_items[24] = uo_24
iuo_items[25] = uo_25
iuo_items[26] = uo_26
iuo_items[27] = uo_27
iuo_items[28] = uo_28
iuo_items[29] = uo_29
iuo_items[30] = uo_30
iuo_items[31] = uo_31
iuo_items[32] = uo_32

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

event destructor;IF Len(Trim(is_ini)) > 0 THEN
	of_SaveSettings()
END IF
end event

type uo_header from u_cst_shortcutheader within u_cst_shortcutbar
event destroy ( )
integer width = 850
integer taborder = 30
end type

on uo_header.destroy
call u_cst_shortcutheader::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
of_SetTextColor(RGB(255,255,255), LEFT)
end event

type uo_icontray from u_cst_icontray within u_cst_shortcutbar
integer y = 928
integer width = 850
integer taborder = 20
end type

on uo_icontray.destroy
call u_cst_icontray::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
end event

type uo_32 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_32.destroy
call u_cst_shortcutitem::destroy
end on

type uo_31 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_31.destroy
call u_cst_shortcutitem::destroy
end on

type uo_30 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_30.destroy
call u_cst_shortcutitem::destroy
end on

type uo_29 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_29.destroy
call u_cst_shortcutitem::destroy
end on

type uo_28 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_28.destroy
call u_cst_shortcutitem::destroy
end on

type uo_27 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_27.destroy
call u_cst_shortcutitem::destroy
end on

type uo_26 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_26.destroy
call u_cst_shortcutitem::destroy
end on

type uo_25 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_25.destroy
call u_cst_shortcutitem::destroy
end on

type uo_24 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_24.destroy
call u_cst_shortcutitem::destroy
end on

type uo_23 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_23.destroy
call u_cst_shortcutitem::destroy
end on

type uo_22 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_22.destroy
call u_cst_shortcutitem::destroy
end on

type uo_21 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_21.destroy
call u_cst_shortcutitem::destroy
end on

type uo_20 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_20.destroy
call u_cst_shortcutitem::destroy
end on

type uo_19 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_19.destroy
call u_cst_shortcutitem::destroy
end on

type uo_18 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_18.destroy
call u_cst_shortcutitem::destroy
end on

type uo_17 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_17.destroy
call u_cst_shortcutitem::destroy
end on

type uo_16 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_16.destroy
call u_cst_shortcutitem::destroy
end on

type uo_15 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_15.destroy
call u_cst_shortcutitem::destroy
end on

type uo_14 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_14.destroy
call u_cst_shortcutitem::destroy
end on

type uo_13 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_13.destroy
call u_cst_shortcutitem::destroy
end on

type uo_12 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_12.destroy
call u_cst_shortcutitem::destroy
end on

type uo_11 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_11.destroy
call u_cst_shortcutitem::destroy
end on

type uo_10 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_10.destroy
call u_cst_shortcutitem::destroy
end on

type uo_9 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_9.destroy
call u_cst_shortcutitem::destroy
end on

type uo_8 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_8.destroy
call u_cst_shortcutitem::destroy
end on

type uo_7 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_7.destroy
call u_cst_shortcutitem::destroy
end on

type uo_6 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_6.destroy
call u_cst_shortcutitem::destroy
end on

type uo_5 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_5.destroy
call u_cst_shortcutitem::destroy
end on

type uo_4 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_4.destroy
call u_cst_shortcutitem::destroy
end on

type uo_3 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_3.destroy
call u_cst_shortcutitem::destroy
end on

type uo_2 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_2.destroy
call u_cst_shortcutitem::destroy
end on

type uo_1 from u_cst_shortcutitem within u_cst_shortcutbar
boolean visible = false
integer y = 360
integer width = 850
integer height = 124
integer taborder = 10
end type

on uo_1.destroy
call u_cst_shortcutitem::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
end event

type st_back from statictext within u_cst_shortcutbar
integer width = 850
integer height = 1024
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type uo_splitbar from u_cst_shortcutsplitbar within u_cst_shortcutbar
integer x = 5
integer y = 900
integer width = 850
integer taborder = 20
boolean bringtotop = true
string pointer = "SizeNS!"
end type

event constructor;call super::constructor;of_SetParent(PARENT)
end event

on uo_splitbar.destroy
call u_cst_shortcutsplitbar::destroy
end on

event mousewithin;call super::mousewithin;Long ll_size


IF NOT ib_move THEN
	IF ib_startsplit THEN
		
		CHOOSE CASE il_CurrentSize
			CASE SMALL
				ll_size = 128
			CASE LARGE
				ll_size = 134
		END CHOOSE
		
		IF (PointerY() + THIS.Y + (ll_size / 2)) > (THIS.Y + THIS.Height + ll_size) THEN
			ib_move = TRUE
			of_ShowFewer()
			ib_move = FALSE
		ELSE
			IF (THIS.Y + PointerY() - (ll_size / 2)) < (THIS.Y - ll_size) THEN
				ib_move = TRUE
				of_ShowMore()
				ib_move = FALSE
			END IF
		END IF
	END IF
END IF
end event

event lbuttonup;call super::lbuttonup;ReleaseCapture()
ib_startsplit = FALSE
end event

event lbuttondown;call super::lbuttondown;SetCapture(Handle(THIS))
ib_startsplit = TRUE
end event

type st_1 from statictext within u_cst_shortcutbar
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
string text = "  Outlook 2003 Shortcutbar"
boolean focusrectangle = false
end type

event constructor;Hide()
end event

