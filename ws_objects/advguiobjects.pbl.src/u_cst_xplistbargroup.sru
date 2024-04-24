$PBExportHeader$u_cst_xplistbargroup.sru
forward
global type u_cst_xplistbargroup from userobject
end type
type uo_header from u_cst_xplistbarheader within u_cst_xplistbargroup
end type
type r_border from rectangle within u_cst_xplistbargroup
end type
end forward

global type u_cst_xplistbargroup from userobject
integer width = 841
integer height = 100
long backcolor = 16777215
event resize pbm_size
event clicked pbm_lbuttonclk
uo_header uo_header
r_border r_border
end type
global u_cst_xplistbargroup u_cst_xplistbargroup

type prototypes

end prototypes

type variables
n_cst_xplistbar_gradient in_Gradient

u_cst_xplistbar iuo_parent

u_cst_xplistbaritem iuo_items[]

Boolean ib_used = FALSE
Boolean ib_expanded = TRUE

Long il_GroupStyle
Long il_OrigHeight

end variables

forward prototypes
public function integer of_setparent (u_cst_xplistbar auo_parent)
public function integer of_settext (string as_text)
public function integer of_setimage (string as_image)
public function integer of_additem (string as_text, string as_image, long al_style)
public function integer of_expand ()
public function integer of_collapse ()
public function string of_gettext ()
public function integer of_reorganize ()
public function integer of_additem (ref dragobject a_object, string as_image)
public function integer of_setstyle (long al_style)
end prototypes

event resize;Long ll_index, ll_count

uo_header.Width = Width

r_border.Width = Width
r_border.Height = Height - r_border.Y

ll_count = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_count
	iuo_items[ll_index].Width = Width - 20
NEXT
end event

public function integer of_setparent (u_cst_xplistbar auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_settext (string as_text);uo_header.of_SetText(as_text)

RETURN 1
end function

public function integer of_setimage (string as_image);uo_header.of_SetImage(as_image)

RETURN 1
end function

public function integer of_additem (string as_text, string as_image, long al_style);Long ll_height, ll_item

SetRedraw(FALSE)

ll_item = UpperBound(iuo_items) + 1
iuo_parent.iw_parent.OpenUserObject(iuo_items[ll_item])

iuo_parent.SetParent(Handle(iuo_items[ll_item]), Handle(THIS))

iuo_items[ll_item].of_SetParent(THIS)
iuo_items[ll_item].of_SetText(as_text)
iuo_items[ll_item].of_SetImage(as_image)
iuo_items[ll_item].X = 5
iuo_items[ll_item].Width = THIS.Width - 20
iuo_items[ll_item].Y = uo_header.Height + 20 + ll_height//((ll_index - 1) * iuo_items[ll_index].Height)
iuo_items[ll_item].il_style = al_style

CHOOSE CASE al_style
	CASE iuo_parent.LINE, iuo_parent.Label
		iuo_items[ll_item].Pointer = 'Arrow!'
END CHOOSE

of_Reorganize()

SetRedraw(TRUE)

RETURN ll_item
end function

public function integer of_expand ();Long li_counter, ll_index

IF ib_expanded THEN RETURN 0

ib_expanded = TRUE

IF iuo_parent.ib_smoothexpand THEN
	// Rewritten by Serge Samson to create a smooth effect
	
	FOR li_counter = 0 to il_OrigHeight STEP 20
		THIS.Height = THIS.Height + li_counter
		IF THIS.height +li_counter > il_OrigHeight THEN EXIT
		iuo_parent.of_Reorganize(iuo_parent.il_y)
		Yield()
	NEXT
	
	THIS.Height = il_OrigHeight
	
	iuo_parent.of_Reorganize(iuo_parent.il_y)
	
ELSE

	Height = il_OrigHeight
	
	iuo_parent.of_Reorganize(iuo_parent.il_y)
	
END IF

RETURN 1
end function

public function integer of_collapse ();Long li_counter, ll_index

IF NOT ib_expanded THEN RETURN 0

IF iuo_parent.ib_smoothexpand THEN

	il_OrigHeight = THIS.Height
	
	FOR li_counter = 0 to THIS.Height step 20
		THIS.Height = THIS.Height - li_counter
		IF THIS.Height  - li_counter < uo_header.Height THEN EXIT
		iuo_parent.of_Reorganize(iuo_parent.il_y)
		Yield()
	NEXT
	
	ib_expanded = FALSE
	Height = uo_header.Height
	
	iuo_parent.of_Reorganize(iuo_parent.il_y)

ELSE
	
	ib_expanded = FALSE
	il_OrigHeight = Height
	Height = uo_header.Height
	
	iuo_parent.of_Reorganize(iuo_parent.il_y)
	
END IF

RETURN 1
end function

public function string of_gettext ();RETURN uo_header.of_GetText()
end function

public function integer of_reorganize ();Long ll_index, ll_count, ll_loop, ll_height

SetRedraw(FALSE)

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	iuo_items[ll_index].Y = uo_header.Height + 20 + ll_height	
	ll_height = ll_height + iuo_items[ll_index].Height
		
NEXT

THIS.Height = uo_header.Height + ll_height + 60

iuo_parent.of_Reorganize(iuo_parent.il_y)

SetRedraw(TRUE)

RETURN ll_index
end function

public function integer of_additem (ref dragobject a_object, string as_image);//Serge Samson
Long ll_height, ll_item

SetRedraw(FALSE)

ll_item = UpperBound(iuo_items) + 1
iuo_parent.iw_parent.OpenUserObject(iuo_items[ll_item])

iuo_parent.SetParent(Handle(iuo_items[ll_item]), Handle(THIS))

//SetParent(Handle(a_object), Handle(THIS))
iuo_parent.SetParent(Handle(a_object), Handle(iuo_items[ll_item]))

iuo_items[ll_item].iuo_object = a_object
iuo_items[ll_item].of_SetParent(THIS)

//iuo_items[ll_item].of_SetText(as_text)
iuo_items[ll_item].X = 12
iuo_items[ll_item].Width = THIS.Width

iuo_items[ll_item].Y = uo_header.Height + 20 + ll_height
iuo_items[ll_item].Height = 100

iuo_items[ll_item].Pointer = 'Arrow!'

IF LEN(as_image) > 0 THEN
	iuo_items[ll_item].of_SetImage(as_image)
	iuo_items[ll_item].iuo_object.X = 160
	iuo_items[ll_item].iuo_object.Y =  2
	iuo_items[ll_item].iuo_object.Width = THIS.Width - 220
ELSE	
	iuo_items[ll_item].iuo_object.X = 40
	iuo_items[ll_item].iuo_object.Y =  2
	iuo_items[ll_item].iuo_object.Width = THIS.Width - 100
END IF

iuo_items[ll_item].il_style = iuo_parent.OBJECT
iuo_items[ll_item].iuo_object.Show()

of_Reorganize()

SetRedraw(TRUE)

RETURN ll_item //ll_count + 1
end function

public function integer of_setstyle (long al_style);il_GroupStyle = al_style

IF al_style = iuo_parent.NOARROW THEN
	uo_header.Pointer = 'Arrow!' 
END IF

RETURN uo_header.of_SetStyle(al_style)
end function

on u_cst_xplistbargroup.create
this.uo_header=create uo_header
this.r_border=create r_border
this.Control[]={this.uo_header,&
this.r_border}
end on

on u_cst_xplistbargroup.destroy
destroy(this.uo_header)
destroy(this.r_border)
end on

event constructor;//TriggerEvent('resize')
end event

event destructor;Long ll_index, ll_count

ll_count = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_count
	IF IsValid(iuo_items[ll_index]) THEN
		iuo_parent.SetParent(Handle(iuo_items[ll_index]), Handle(iuo_parent.iw_parent))
		iuo_parent.iw_parent.CloseUserObject(iuo_items[ll_index])
	END IF
	
NEXT
end event

type uo_header from u_cst_xplistbarheader within u_cst_xplistbargroup
integer width = 841
integer taborder = 20
end type

on uo_header.destroy
call u_cst_xplistbarheader::destroy
end on

event lbuttonup;call super::lbuttonup;IF il_groupstyle <> iuo_parent.iuo_parent.NOARROW THEN
	IF ib_expanded THEN
		of_Collapse()
	ELSE
		of_Expand()
	END IF
END IF
end event

type r_border from rectangle within u_cst_xplistbargroup
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 1073741824
integer y = 96
integer width = 837
integer height = 228
end type

