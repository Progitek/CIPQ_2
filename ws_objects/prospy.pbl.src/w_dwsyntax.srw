$PBExportHeader$w_dwsyntax.srw
forward
global type w_dwsyntax from w_response
end type
type tab_1 from tab within w_dwsyntax
end type
type tabpage_1 from userobject within tab_1
end type
type mle_syntax from multilineedit within tabpage_1
end type
type tabpage_1 from userobject within tab_1
mle_syntax mle_syntax
end type
type tabpage_2 from userobject within tab_1
end type
type dw_m from datawindow within tabpage_2
end type
type dw_d from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_m dw_m
dw_d dw_d
end type
type tab_1 from tab within w_dwsyntax
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_title from statictext within w_dwsyntax
end type
type uo_toolbar from u_cst_toolbarstrip within w_dwsyntax
end type
end forward

global type w_dwsyntax from w_response
integer x = 214
integer y = 221
tab_1 tab_1
st_title st_title
uo_toolbar uo_toolbar
end type
global w_dwsyntax w_dwsyntax

type variables
String	is_copy = "Copier Syntax"
String	is_clos = "Fermer"
Integer	ii_tab
end variables
event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem(is_copy, "Save!")
uo_toolbar.of_AddItem(is_clos, "Exit!")
uo_toolbar.of_displaytext(true)



end event

on w_dwsyntax.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_title=create st_title
this.uo_toolbar=create uo_toolbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_title
this.Control[iCurrent+3]=this.uo_toolbar
end on

on w_dwsyntax.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_title)
destroy(this.uo_toolbar)
end on

event pfc_preopen;call super::pfc_preopen;str_inputbox lstr

lstr = Message.PowerObjectParm

st_title.Text = lstr.as_title
tab_1.tabpage_1.mle_syntax.Text = lstr.as_question
end event

event pfc_postopen;call super::pfc_postopen;tab_1.tabpage_2.dw_m.Event RowFocusChanged(1)
end event

type tab_1 from tab within w_dwsyntax
event create ( )
event destroy ( )
integer x = 27
integer y = 124
integer width = 3611
integer height = 1648
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;ii_tab = newindex
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3575
integer height = 1520
long backcolor = 79741120
string text = "DW Syntax"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
mle_syntax mle_syntax
end type

on tabpage_1.create
this.mle_syntax=create mle_syntax
this.Control[]={this.mle_syntax}
end on

on tabpage_1.destroy
destroy(this.mle_syntax)
end on

type mle_syntax from multilineedit within tabpage_1
integer x = 18
integer y = 12
integer width = 3547
integer height = 1508
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3575
integer height = 1520
long backcolor = 79741120
string text = "Temp Table Syntax"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_m dw_m
dw_d dw_d
end type

on tabpage_2.create
this.dw_m=create dw_m
this.dw_d=create dw_d
this.Control[]={this.dw_m,&
this.dw_d}
end on

on tabpage_2.destroy
destroy(this.dw_m)
destroy(this.dw_d)
end on

type dw_m from datawindow within tabpage_2
integer x = 18
integer y = 12
integer width = 891
integer height = 1508
integer taborder = 31
string title = "none"
string dataobject = "d_tempdwselect"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;Long		ll_id
String	ls_Filter
If currentrow <= 0 Then Return

This.SelectRow(0, False)
This.SelectRow(currentrow, True)

ll_id = This.Object.TableId[currentrow]


ls_Filter = "Tableid = " + String(ll_id)
dw_d.SetFilter(ls_Filter)
dw_d.Filter( )


end event

type dw_d from datawindow within tabpage_2
integer x = 928
integer y = 12
integer width = 2629
integer height = 1508
integer taborder = 21
string title = "none"
string dataobject = "d_tempdw"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_title from statictext within w_dwsyntax
integer x = 27
integer y = 16
integer width = 3611
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_dwsyntax
integer x = 27
integer y = 1788
integer width = 3611
integer taborder = 20
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;String	ls_copy
Long		ll_Loop
Choose Case as_button
	Case is_copy
		Choose Case ii_tab
			Case 1
				ls_copy = tab_1.tabpage_1.mle_syntax.Text
			Case 2
				ls_copy = ""
				For ll_Loop = 1 to tab_1.tabpage_2.dw_d.RowCount()
					ls_copy += tab_1.tabpage_2.dw_d.Object.detailline[ll_Loop]
				Next
		End Choose
		::ClipBoard(ls_copy)
	Case is_clos
		Close(Parent)
End Choose

end event

