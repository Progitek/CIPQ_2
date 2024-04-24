﻿$PBExportHeader$w_r_audit.srw
forward
global type w_r_audit from w_rapport
end type
type ddlb_fenetre from u_ddlb within w_r_audit
end type
type st_1 from statictext within w_r_audit
end type
end forward

global type w_r_audit from w_rapport
string title = "Rapport d~'audit"
ddlb_fenetre ddlb_fenetre
st_1 st_1
end type
global w_r_audit w_r_audit

type variables
string	is_fenetre
end variables

on w_r_audit.create
int iCurrent
call super::create
this.ddlb_fenetre=create ddlb_fenetre
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_fenetre
this.Control[iCurrent+2]=this.st_1
end on

on w_r_audit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_fenetre)
destroy(this.st_1)
end on

type dw_preview from w_rapport`dw_preview within w_r_audit
integer width = 3813
integer taborder = 20
string dataobject = "d_r_audit"
end type

event dw_preview::retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	THIS.object.cc_criteres[1] = ddlb_fenetre.text
END IF
end event

type ddlb_fenetre from u_ddlb within w_r_audit
integer x = 3867
integer y = 184
integer width = 777
integer height = 432
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;//Construire la liste des fenêtres

string ls_fenetre

DECLARE listfenetre CURSOR FOR select distinct nom_fenetre from t_audit ORDER by nom_fenetre;
OPEN listfenetre;

FETCH listfenetre INTO :ls_fenetre;

DO WHILE SQLCA.SQLCode = 0
	addItem(ls_fenetre)
	FETCH listfenetre INTO :ls_fenetre;
LOOP

CLOSE listfenetre;
end event

event selectionchanged;call super::selectionchanged;//Retriever la dw

string	ls_fen

ls_fen = THIS.Text

dw_preview.retrieve(ls_fen)
dw_preview.SetFocus()
end event

type st_1 from statictext within w_r_audit
integer x = 3877
integer y = 20
integer width = 677
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Sélectionnez la fenêtre voulue:"
boolean focusrectangle = false
end type
