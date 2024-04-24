$PBExportHeader$w_code_taxes.srw
forward
global type w_code_taxes from w_sheet_pilotage
end type
end forward

global type w_code_taxes from w_sheet_pilotage
string tag = "menu=m_codesdetaxe"
end type
global w_code_taxes w_code_taxes

on w_code_taxes.create
int iCurrent
call super::create
end on

on w_code_taxes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_code_taxes
integer y = 40
integer width = 78
integer height = 80
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\dol.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_code_taxes
end type

type st_title from w_sheet_pilotage`st_title within w_code_taxes
string text = "Codes de taxe"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_code_taxes
string dataobject = "d_code_taxes"
end type

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_code_taxes
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_code_taxes
end type

