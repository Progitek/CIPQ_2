﻿$PBExportHeader$w_sheet_frame.srw
forward
global type w_sheet_frame from w_sheet
end type
type st_title from st_uo_transparent within w_sheet_frame
end type
type p_8 from picture within w_sheet_frame
end type
type rr_infopat from roundrectangle within w_sheet_frame
end type
end forward

global type w_sheet_frame from w_sheet
integer width = 4713
integer height = 2568
st_title st_title
p_8 p_8
rr_infopat rr_infopat
end type
global w_sheet_frame w_sheet_frame

event open;call super::open;THIS.Title = st_title.text
end event

on w_sheet_frame.create
int iCurrent
call super::create
this.st_title=create st_title
this.p_8=create p_8
this.rr_infopat=create rr_infopat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
this.Control[iCurrent+2]=this.p_8
this.Control[iCurrent+3]=this.rr_infopat
end on

on w_sheet_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_title)
destroy(this.p_8)
destroy(this.rr_infopat)
end on

type st_title from st_uo_transparent within w_sheet_frame
string tag = "resize=frbsr"
integer x = 187
integer y = 48
integer width = 1161
integer height = 88
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
long backcolor = 15793151
string text = "Titre"
end type

type p_8 from picture within w_sheet_frame
string tag = "resize=frb"
integer x = 82
integer y = 60
integer width = 73
integer height = 52
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\listview_column.bmp"
boolean focusrectangle = false
end type

type rr_infopat from roundrectangle within w_sheet_frame
string tag = "resize=frbsr"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 28
integer width = 4549
integer height = 124
integer cornerheight = 75
integer cornerwidth = 75
end type
