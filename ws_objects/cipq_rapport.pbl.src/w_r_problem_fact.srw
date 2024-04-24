$PBExportHeader$w_r_problem_fact.srw
forward
global type w_r_problem_fact from w_rapport
end type
end forward

global type w_r_problem_fact from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Problème (facturation)"
end type
global w_r_problem_fact w_r_problem_fact

on w_r_problem_fact.create
call super::create
end on

on w_r_problem_fact.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_preview.Retrieve()



end event

type dw_preview from w_rapport`dw_preview within w_r_problem_fact
string dataobject = "d_r_problem_fact"
end type

