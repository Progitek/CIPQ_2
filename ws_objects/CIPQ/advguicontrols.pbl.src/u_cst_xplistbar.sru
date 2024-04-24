$PBExportHeader$u_cst_xplistbar.sru
forward
global type u_cst_xplistbar from u_canvas
end type
type uo_scrolldown from u_cst_xplistbarscroll within u_cst_xplistbar
end type
type uo_scrollup from u_cst_xplistbarscroll within u_cst_xplistbar
end type
type st_1 from statictext within u_cst_xplistbar
end type
end forward

global type u_cst_xplistbar from u_canvas
integer width = 1006
integer height = 1292
integer unitsperline = 50
integer linesperpage = 500
event paint pbm_paint
event resize pbm_size
event itemselected ( string as_group,  string as_item )
uo_scrolldown uo_scrolldown
uo_scrollup uo_scrollup
st_1 st_1
end type
global u_cst_xplistbar u_cst_xplistbar

type prototypes
FUNCTION unsignedlong GetSysColor(int nIndex) LIBRARY "user32.dll"
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function Long GetDC (Long hwnd) Library 'user32'
Function Long ReleaseDC (Long hwnd, Long hdc1) Library 'user32'
end prototypes

type variables
n_cst_xplistbar_gradient in_gradient

window iw_parent
u_cst_xplistbargroup iuo_items[]

Long il_y
Boolean ib_smoothexpand = TRUE

CONSTANT Long BLUE = RGB(185,210,248)
CONSTANT Long SILVER = RGB(232,232,240)
CONSTANT Long OLIVE = RGB(234,234,207)
CONSTANT Long CLASSIC = RGB(242,243,246)
CONSTANT Long DEFAULT = 0

CONSTANT Long LINK = 1
CONSTANT Long LABEL = 2
CONSTANT Long LINE = 3
CONSTANT Long OBJECT = 4

CONSTANT Long SPECIAL = 1
CONSTANT Long NOARROW = 2
CONSTANT Long ORIGINAL = 3


Long il_CurrentTheme = BLUE

end variables

forward prototypes
public function integer of_additem (string as_label, string as_picture, long al_style, long al_parent)
public function integer of_settheme (long al_color)
public function long of_getcolor (string as_color)
public function integer of_getwindow ()
public function long of_addgroup (string as_label, string as_picture)
public function integer of_scrolldown ()
public function integer of_reorganize (long al_y)
public function integer of_scrollup ()
public function integer of_settheme (string as_color)
public function integer of_addline (long al_parent)
public function integer of_addlink (string as_label, string as_picture, long al_parent)
public function integer of_addlabel (string as_label, string as_picture, long al_parent)
public function integer of_collapseitem (long al_item)
public function integer of_expanditem (long al_item)
public function integer of_expanditem (string as_item)
public function integer of_collapseitem (string as_item)
public function integer of_collapseall ()
public function integer of_expandall ()
public function integer of_addobject (ref dragobject a_object, string as_picture, long al_parent)
public function long of_addgroup (string as_label, string as_picture, long al_style)
public function integer of_setsmoothexpand (boolean ab_smooth)
end prototypes

event resize;uo_scrollup.Width = Width
uo_scrolldown.Width = Width
uo_scrolldown.Y = Height - uo_scrolldown.height

Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	iuo_items[ll_index].Width = Width - 85
NEXT

of_Reorganize(il_y)

SetRedraw(TRUE)
end event

public function integer of_additem (string as_label, string as_picture, long al_style, long al_parent);SetRedraw(FALSE)
iuo_items[al_parent].of_AddItem(as_label, as_picture, al_style)
iuo_items[al_parent].TriggerEvent('Resize')
of_Reorganize(il_y)
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settheme (long al_color);Long ll_index, ll_loop

il_currenttheme = al_color

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	iuo_items[ll_index].BackColor = of_GetColor('ITEMBACK1')
	iuo_items[ll_index].r_border.FillColor = of_GetColor('ITEMBACK1')
	
	IF al_color = CLASSIC THEN
		iuo_items[ll_index].r_border.LineColor = of_GetColor('HEADER1')
	ELSE
		iuo_items[ll_index].r_border.LineColor = RGB(255,255,255)
	END IF
NEXT

SetRedraw(TRUE)

RETURN 1
end function

public function long of_getcolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "SPECIALCIRCLEBORDER" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 14853494
			CASE SILVER
				ll_color = 15193293
			CASE OLIVE
				ll_color = 10342335
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE		
	CASE "SPECIALCIRCLEFILL" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 12804143
			CASE SILVER
				ll_color = 9925999
			CASE OLIVE
				ll_color = 5284994
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE			
	CASE "CIRCLEBORDER" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 14531765
			CASE SILVER
				ll_color = 13483967
			CASE OLIVE
				ll_color = 12506570
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE		
	CASE "CIRCLEFILL" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 16777215
			CASE SILVER
				ll_color = 16777215
			CASE OLIVE
				ll_color = 16777215
			CASE CLASSIC
				ll_color = 16777215
		END CHOOSE			
		
	CASE "SPECIALARROW" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 16764332
			CASE SILVER
				ll_color = 15132390
			CASE OLIVE
				ll_color = 12506570
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE		
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
		END CHOOSE
	CASE "BACKGROUND1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(122,161,230)
			CASE SILVER
				ll_color = RGB(196,200,212)
			CASE OLIVE
				ll_color = RGB(204,217,173)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE "BACKGROUND2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(99,117,214)
			CASE SILVER
				ll_color = RGB(177,179,200)
			CASE OLIVE
				ll_color = RGB(165,189,132)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE "HEADER1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,255,255)
			CASE SILVER
				ll_color = RGB(255,255,255)
			CASE OLIVE
				ll_color = RGB(255,252,236)
			CASE CLASSIC
				ll_color = RGB(212,208,200)
		END CHOOSE
	CASE "HEADER2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(199,212,247)
			CASE SILVER
				ll_color = RGB(214,215,224)
			CASE OLIVE
				ll_color = RGB(224,231,184)
			CASE CLASSIC
				ll_color = RGB(212,208,200)
		END CHOOSE
	CASE "HEADERSPECIAL1" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 13195552
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = 4230263
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE
	CASE "HEADERSPECIAL2" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 13195552
			CASE SILVER
				ll_color = 13088436
			CASE OLIVE
				ll_color = 6793366
			CASE CLASSIC
				ll_color = RGB(212,208,200)
		END CHOOSE		
	CASE 'ITEMBACK1'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(214,223,247)
			CASE SILVER
				ll_color = RGB(240,241,245)
			CASE OLIVE
				ll_color = RGB(246,246,236)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE 'ITEMBACK2'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(214,223,247)
			CASE SILVER
				ll_color = RGB(240,241,245)
			CASE OLIVE
				ll_color = RGB(246,246,236)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE 'HEADERSPECIALTEXT' // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,255,255)
			CASE SILVER
				ll_color = RGB(255,255,255)
			CASE OLIVE
				ll_color = RGB(255,255,255)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE		
	CASE 'ITEMTEXT'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(33,93,198)
			CASE SILVER
				ll_color = RGB(63,61,61)
			CASE OLIVE
				ll_color = RGB(86,102,45)
			CASE CLASSIC
				ll_color = 0
		END CHOOSE
	CASE 'ITEMTEXTSELECTED'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(66,142,255)
			CASE SILVER
				ll_color = RGB(126,124,124)
			CASE OLIVE
				ll_color = RGB(114,146,29)
			CASE CLASSIC
				ll_color = 0
		END CHOOSE
	CASE "HEADERSPECIALTEXTSELECTED" // Added by Serge
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(122,161,230)
			CASE SILVER
				ll_color = RGB(196,200,212)
			CASE OLIVE
				ll_color = RGB(204,217,173)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE 'SCROLLBAR'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(169,199,240)
			CASE SILVER
				ll_color = RGB(192,192,211)
			CASE OLIVE
				ll_color = RGB(197,212,159)
			CASE CLASSIC
				ll_color = RGB(212,208,200)
		END CHOOSE
	CASE 'SCROLLBARSELECTED'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,238,194)
			CASE SILVER
				ll_color = RGB(255,238,194)
			CASE OLIVE
				ll_color = RGB(255,238,194)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
		END CHOOSE
	CASE 'SCROLLBARBORDER'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(127,157,185)
			CASE SILVER
				ll_color = RGB(165,172,178)
			CASE OLIVE
				ll_color = RGB(164,185,127)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE
	CASE 'SCROLLBARSELECTEDBORDER'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(0,0,128)
			CASE SILVER
				ll_color = RGB(75,75,111)
			CASE OLIVE
				ll_color = RGB(63,93,56)
			CASE CLASSIC
				ll_color = RGB(10,36,106)
		END CHOOSE
	CASE 'LINE'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(122,161,230)
			CASE SILVER
				ll_color = RGB(196,200,212)
			CASE OLIVE
				ll_color = RGB(204,217,173)
			CASE CLASSIC
				ll_color = RGB(212,208,200)
		END CHOOSE
END CHOOSE

RETURN ll_color
end function

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

public function long of_addgroup (string as_label, string as_picture);RETURN of_AddGroup(as_label, as_picture, ORIGINAL)
end function

public function integer of_scrolldown ();Long ll_index

DO UNTIL NOT uo_scrolldown.ib_mousecaptured OR NOT uo_scrolldown.Visible
	
	DO WHILE Yield()
		//
	LOOP
	
	of_Reorganize(il_y - 15)
	
LOOP

RETURN 1
end function

public function integer of_reorganize (long al_y);Long ll_index, ll_count, ll_y

ll_count = UpperBound(iuo_items)

il_y = al_y
ll_y = al_y

FOR ll_index = 1 TO ll_count
	
	iuo_items[ll_index].Y = ll_y
	
	ll_y = iuo_items[ll_index].Y + iuo_items[ll_index].Height + 40
	
NEXT

IF ll_y > Height THEN
	uo_scrolldown.Show()
ELSE
	uo_scrolldown.Hide()	
END IF

IF il_y < 40 THEN
	uo_scrollup.Show()
ELSE
	uo_scrollup.Hide()
END IF

RETURN 1
end function

public function integer of_scrollup ();Long ll_index

DO UNTIL NOT uo_scrollup.ib_mousecaptured OR NOT uo_scrollup.Visible
	
	DO WHILE Yield()
		//
	LOOP
	
	of_Reorganize(il_y + 15)
	
LOOP

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

public function integer of_addline (long al_parent);of_AddItem('', '', LINE, al_parent)

RETURN 1
end function

public function integer of_addlink (string as_label, string as_picture, long al_parent);of_AddItem(as_label, as_picture, LINK, al_parent)

RETURN 1
end function

public function integer of_addlabel (string as_label, string as_picture, long al_parent);of_AddItem(as_label, as_picture, LABEL, al_parent)

RETURN 1
end function

public function integer of_collapseitem (long al_item);iuo_items[al_item].of_Collapse()

RETURN 1
end function

public function integer of_expanditem (long al_item);iuo_items[al_item].of_Expand()

RETURN 1
end function

public function integer of_expanditem (string as_item);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	IF Upper(iuo_items[ll_index].of_GetText()) = Upper(as_item) THEN
		of_ExpandItem(ll_index)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_collapseitem (string as_item);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	IF Upper(iuo_items[ll_index].of_GetText()) = Upper(as_item) THEN
		of_CollapseItem(ll_index)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_collapseall ();Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	of_CollapseItem(ll_index)
NEXT

RETURN 1
end function

public function integer of_expandall ();Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	of_ExpandItem(ll_index)
NEXT

RETURN 1
end function

public function integer of_addobject (ref dragobject a_object, string as_picture, long al_parent);SetRedraw(FALSE)
iuo_items[al_parent].of_AddItem(a_object, as_picture)
iuo_items[al_parent].TriggerEvent('Resize')
of_Reorganize(il_y)
SetRedraw(TRUE)

RETURN 1
end function

public function long of_addgroup (string as_label, string as_picture, long al_style);Long ll_index, ll_count, ll_loop, ll_item

SetRedraw(FALSE)

ll_item = UpperBound(iuo_items) + 1
iw_parent.OpenUserObject(iuo_items[ll_item])

SetParent(Handle(iuo_items[ll_item]), Handle(THIS))

iuo_items[ll_item].of_SetText(as_label)
iuo_items[ll_item].of_SetImage(as_picture)
iuo_items[ll_item].X = 40
iuo_items[ll_item].Width = THIS.Width - 85
iuo_items[ll_item].BackColor = of_GetColor('ITEMBACK1')
iuo_items[ll_item].r_border.FillColor = of_GetColor('ITEMBACK1')
iuo_items[ll_item].of_SetStyle(al_style)

IF il_CurrentTheme = CLASSIC THEN
	iuo_items[ll_item].r_border.LineColor = of_GetColor('HEADER1')
ELSE
	iuo_items[ll_item].r_border.LineColor = RGB(255,255,255)
END IF
	
iuo_items[ll_item].of_SetParent(THIS)

IF ll_item = 1 THEN
	il_y = 40
END IF

of_Reorganize(il_y)

SetRedraw(TRUE)

RETURN ll_item
end function

public function integer of_setsmoothexpand (boolean ab_smooth);ib_smoothexpand = ab_smooth

RETURN 1
end function

on u_cst_xplistbar.create
int iCurrent
call super::create
this.uo_scrolldown=create uo_scrolldown
this.uo_scrollup=create uo_scrollup
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_scrolldown
this.Control[iCurrent+2]=this.uo_scrollup
this.Control[iCurrent+3]=this.st_1
end on

on u_cst_xplistbar.destroy
call super::destroy
destroy(this.uo_scrolldown)
destroy(this.uo_scrollup)
destroy(this.st_1)
end on

event constructor;call super::constructor;Long ll_color1, ll_color2, ll_index
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

event destructor;call super::destructor;Long ll_index, ll_count

ll_count = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_count
	IF IsValid(iuo_items[ll_index]) THEN
		SetParent(Handle(iuo_items[ll_index]), Handle(iw_parent))
		iw_parent.CloseUserObject(iuo_items[ll_index])
	END IF
	
NEXT
end event

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

in_Gradient.of_VerticalGradient (of_GetColor("BACKGROUND1"), of_GetColor("BACKGROUND2"), THIS,TRUE,of_GetColor("BORDER"), 0)

RETURN 1
end event

type uo_scrolldown from u_cst_xplistbarscroll within u_cst_xplistbar
boolean visible = false
integer y = 1268
integer taborder = 20
end type

on uo_scrolldown.destroy
call u_cst_xplistbarscroll::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
of_SetArrow('down')
end event

event mouseenter;call super::mouseenter;of_ScrollDown()
end event

event mouseleave;call super::mouseleave;PARENT.SetRedraw(TRUE)
end event

type uo_scrollup from u_cst_xplistbarscroll within u_cst_xplistbar
boolean visible = false
integer taborder = 10
end type

on uo_scrollup.destroy
call u_cst_xplistbarscroll::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
of_SetArrow('up')
end event

event mouseenter;call super::mouseenter;of_ScrollUp()
end event

event mouseleave;call super::mouseleave;PARENT.SetRedraw(TRUE)
end event

type st_1 from statictext within u_cst_xplistbar
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
string text = "  XPListBar"
boolean focusrectangle = false
end type

event constructor;Hide()
end event

