$PBExportHeader$u_cst_icontray.sru
forward
global type u_cst_icontray from u_canvas
end type
type uo_chevron from u_cst_chevron within u_cst_icontray
end type
type uo_32 from u_cst_icon within u_cst_icontray
end type
type uo_31 from u_cst_icon within u_cst_icontray
end type
type uo_30 from u_cst_icon within u_cst_icontray
end type
type uo_29 from u_cst_icon within u_cst_icontray
end type
type uo_28 from u_cst_icon within u_cst_icontray
end type
type uo_27 from u_cst_icon within u_cst_icontray
end type
type uo_26 from u_cst_icon within u_cst_icontray
end type
type uo_25 from u_cst_icon within u_cst_icontray
end type
type uo_24 from u_cst_icon within u_cst_icontray
end type
type uo_23 from u_cst_icon within u_cst_icontray
end type
type uo_22 from u_cst_icon within u_cst_icontray
end type
type uo_21 from u_cst_icon within u_cst_icontray
end type
type uo_20 from u_cst_icon within u_cst_icontray
end type
type uo_19 from u_cst_icon within u_cst_icontray
end type
type uo_18 from u_cst_icon within u_cst_icontray
end type
type uo_17 from u_cst_icon within u_cst_icontray
end type
type uo_16 from u_cst_icon within u_cst_icontray
end type
type uo_15 from u_cst_icon within u_cst_icontray
end type
type uo_14 from u_cst_icon within u_cst_icontray
end type
type uo_13 from u_cst_icon within u_cst_icontray
end type
type uo_12 from u_cst_icon within u_cst_icontray
end type
type uo_11 from u_cst_icon within u_cst_icontray
end type
type uo_10 from u_cst_icon within u_cst_icontray
end type
type uo_9 from u_cst_icon within u_cst_icontray
end type
type uo_8 from u_cst_icon within u_cst_icontray
end type
type uo_7 from u_cst_icon within u_cst_icontray
end type
type uo_6 from u_cst_icon within u_cst_icontray
end type
type uo_5 from u_cst_icon within u_cst_icontray
end type
type uo_4 from u_cst_icon within u_cst_icontray
end type
type uo_3 from u_cst_icon within u_cst_icontray
end type
type uo_2 from u_cst_icon within u_cst_icontray
end type
type uo_1 from u_cst_icon within u_cst_icontray
end type
end forward

global type u_cst_icontray from u_canvas
integer width = 581
integer height = 124
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event paint pbm_paint
event clicked pbm_lbuttonup
event resize pbm_size
uo_chevron uo_chevron
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
end type
global u_cst_icontray u_cst_icontray

type variables
Boolean ib_selected
Boolean ib_painting
n_cst_shortcutbar_gradient	in_gradient

Long il_BorderColor

u_cst_shortcutbar iuo_parent

u_cst_icon iuo_items[]
u_cst_icon iuo_used[]


Long il_highlight1 = RGB(251,230,148)
Long il_highlight2 = RGB(238,150,21)
Long il_backcolor1 = RGB(203,225,252)
Long il_backcolor2 = RGB(126,166,225)
end variables

forward prototypes
public function integer of_setparent (u_cst_shortcutbar auo_parent)
public function integer of_refresh ()
public function integer of_additem (u_cst_shortcutitem auo_object, long al_index)
public function integer of_removeitem (u_cst_shortcutitem auo_object, long al_index)
public function integer of_setbackcolor (long al_color)
end prototypes

event resize;Long ll_index, ll_loop, ll_count

ll_loop = UpperBound(iuo_used)

uo_chevron.X = Width - uo_chevron.Width - 10

FOR ll_index = ll_loop TO 1 STEP -1
	
	IF IsValid(iuo_used[ll_index]) THEN
		ll_count++
		iuo_used[ll_index].X = uo_chevron.X - (iuo_used[ll_index].Width * ll_count)
	END IF
	
NEXT
end event

public function integer of_setparent (u_cst_shortcutbar auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_refresh ();Long ll_index, ll_loop

//ll_loop = UpperBound(iuo_used)
//
//FOR ll_index = 1 TO ll_loop
//	
//	IF IsValid(iuo_used[ll_index]) THEN
//		iuo_used[ll_index].TriggerEvent('paint')
//	END IF
//	
//NEXT
//
//uo_chevron.TriggerEvent('paint')
//
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_additem (u_cst_shortcutitem auo_object, long al_index);iuo_used[al_index] = iuo_items[al_index]

iuo_used[al_index].iuo_shortcutitem = auo_object
IF iuo_used[al_index].is_image = '' THEN
	iuo_used[al_index].of_SetImage(auo_object.of_GetImage())
END IF

iuo_used[al_index].Show()

TriggerEvent('resize')

RETURN 1
end function

public function integer of_removeitem (u_cst_shortcutitem auo_object, long al_index);u_cst_icon luo_empty

iuo_items[al_index].Hide()
iuo_used[al_index] = luo_empty

TriggerEvent('resize')

RETURN 1
end function

public function integer of_setbackcolor (long al_color);Long ll_index, ll_loop

ll_loop = UpperBound(iuo_items)

FOR ll_index = 1 TO ll_loop
	
	iuo_items[ll_index].BackColor =al_color
	
NEXT

uo_chevron.BackColor =al_color

RETURN 1
end function

on u_cst_icontray.create
int iCurrent
call super::create
this.uo_chevron=create uo_chevron
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_chevron
this.Control[iCurrent+2]=this.uo_32
this.Control[iCurrent+3]=this.uo_31
this.Control[iCurrent+4]=this.uo_30
this.Control[iCurrent+5]=this.uo_29
this.Control[iCurrent+6]=this.uo_28
this.Control[iCurrent+7]=this.uo_27
this.Control[iCurrent+8]=this.uo_26
this.Control[iCurrent+9]=this.uo_25
this.Control[iCurrent+10]=this.uo_24
this.Control[iCurrent+11]=this.uo_23
this.Control[iCurrent+12]=this.uo_22
this.Control[iCurrent+13]=this.uo_21
this.Control[iCurrent+14]=this.uo_20
this.Control[iCurrent+15]=this.uo_19
this.Control[iCurrent+16]=this.uo_18
this.Control[iCurrent+17]=this.uo_17
this.Control[iCurrent+18]=this.uo_16
this.Control[iCurrent+19]=this.uo_15
this.Control[iCurrent+20]=this.uo_14
this.Control[iCurrent+21]=this.uo_13
this.Control[iCurrent+22]=this.uo_12
this.Control[iCurrent+23]=this.uo_11
this.Control[iCurrent+24]=this.uo_10
this.Control[iCurrent+25]=this.uo_9
this.Control[iCurrent+26]=this.uo_8
this.Control[iCurrent+27]=this.uo_7
this.Control[iCurrent+28]=this.uo_6
this.Control[iCurrent+29]=this.uo_5
this.Control[iCurrent+30]=this.uo_4
this.Control[iCurrent+31]=this.uo_3
this.Control[iCurrent+32]=this.uo_2
this.Control[iCurrent+33]=this.uo_1
end on

on u_cst_icontray.destroy
call super::destroy
destroy(this.uo_chevron)
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
end on

event constructor;Long ll_index

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

FOR ll_index = 1 TO 32
	iuo_items[ll_index].of_SetParent(THIS)
NEXT
end event

event onpaint;call super::onpaint;IF IsValid(iuo_parent) THEN
	in_Gradient.of_SetHDC(hdc)
	in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("BACKCOLOR1"), iuo_parent.of_GetColor("BACKCOLOR2"), THIS,TRUE,iuo_parent.of_GetColor("BORDER"), iuo_parent.of_GetStyle())
END IF

RETURN 1
end event

type uo_chevron from u_cst_chevron within u_cst_icontray
integer x = 507
integer y = 8
integer width = 78
integer height = 108
integer taborder = 20
end type

on uo_chevron.destroy
call u_cst_chevron::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
end event

type uo_32 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_32.destroy
call u_cst_icon::destroy
end on

type uo_31 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_31.destroy
call u_cst_icon::destroy
end on

type uo_30 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_30.destroy
call u_cst_icon::destroy
end on

type uo_29 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_29.destroy
call u_cst_icon::destroy
end on

type uo_28 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_28.destroy
call u_cst_icon::destroy
end on

type uo_27 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_27.destroy
call u_cst_icon::destroy
end on

type uo_26 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_26.destroy
call u_cst_icon::destroy
end on

type uo_25 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_25.destroy
call u_cst_icon::destroy
end on

type uo_24 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_24.destroy
call u_cst_icon::destroy
end on

type uo_23 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_23.destroy
call u_cst_icon::destroy
end on

type uo_22 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_22.destroy
call u_cst_icon::destroy
end on

type uo_21 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_21.destroy
call u_cst_icon::destroy
end on

type uo_20 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_20.destroy
call u_cst_icon::destroy
end on

type uo_19 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_19.destroy
call u_cst_icon::destroy
end on

type uo_18 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_18.destroy
call u_cst_icon::destroy
end on

type uo_17 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_17.destroy
call u_cst_icon::destroy
end on

type uo_16 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_16.destroy
call u_cst_icon::destroy
end on

type uo_15 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_15.destroy
call u_cst_icon::destroy
end on

type uo_14 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_14.destroy
call u_cst_icon::destroy
end on

type uo_13 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_13.destroy
call u_cst_icon::destroy
end on

type uo_12 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_12.destroy
call u_cst_icon::destroy
end on

type uo_11 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_11.destroy
call u_cst_icon::destroy
end on

type uo_10 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_10.destroy
call u_cst_icon::destroy
end on

type uo_9 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_9.destroy
call u_cst_icon::destroy
end on

type uo_8 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_8.destroy
call u_cst_icon::destroy
end on

type uo_7 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_7.destroy
call u_cst_icon::destroy
end on

type uo_6 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_6.destroy
call u_cst_icon::destroy
end on

type uo_5 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_5.destroy
call u_cst_icon::destroy
end on

type uo_4 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_4.destroy
call u_cst_icon::destroy
end on

type uo_3 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_3.destroy
call u_cst_icon::destroy
end on

type uo_2 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_2.destroy
call u_cst_icon::destroy
end on

type uo_1 from u_cst_icon within u_cst_icontray
boolean visible = false
integer x = 393
integer y = 8
integer width = 101
integer height = 108
integer taborder = 10
end type

on uo_1.destroy
call u_cst_icon::destroy
end on

