$PBExportHeader$w_choixfusionner.srw
forward
global type w_choixfusionner from w_response
end type
type st_1 from statictext within w_choixfusionner
end type
type dw_fusionvet from datawindow within w_choixfusionner
end type
type uo_toolbar from u_cst_toolbarstrip within w_choixfusionner
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_choixfusionner
end type
type rr_3 from roundrectangle within w_choixfusionner
end type
end forward

global type w_choixfusionner from w_response
integer x = 214
integer y = 221
integer width = 1499
integer height = 1800
boolean titlebar = false
boolean controlmenu = false
long backcolor = 15793151
st_1 st_1
dw_fusionvet dw_fusionvet
uo_toolbar uo_toolbar
uo_toolbar2 uo_toolbar2
rr_3 rr_3
end type
global w_choixfusionner w_choixfusionner

type variables
string is_veterinaire
end variables

on w_choixfusionner.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_fusionvet=create dw_fusionvet
this.uo_toolbar=create uo_toolbar
this.uo_toolbar2=create uo_toolbar2
this.rr_3=create rr_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_fusionvet
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.uo_toolbar2
this.Control[iCurrent+5]=this.rr_3
end on

on w_choixfusionner.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_fusionvet)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar2)
destroy(this.rr_3)
end on

event open;call super::open;string ls_veterinaire[], ls_nom
integer i 

uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fusionner", "Custom038!")
uo_toolbar.of_displaytext(true)
//-----------------------------------------
uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)
uo_toolbar2.of_AddItem("Fermer", "Exit!")
uo_toolbar2.of_displaytext(true)

dw_fusionvet.settransobject(SQLCA)
dw_fusionvet.retrieve( )

/*is_veterinaire = gnv_app.inv_entrepotglobal.of_retournedonnee('listveterinaire')
ls_veterinaire = split(is_veterinaire,',')
for i = 1 to upperbound(ls_veterinaire)
	SELECT nom INTO :ls_nom FROM t_veterinaire WHERE id_veterinaire = :ls_veterinaire[i];
	lb_veterinaire.additem(ls_nom)
	next*/





end event

type st_1 from statictext within w_choixfusionner
integer x = 50
integer y = 28
integer width = 558
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 12639424
string text = "Fusionner vétérinaire"
boolean focusrectangle = false
end type

type dw_fusionvet from datawindow within w_choixfusionner
integer x = 37
integer y = 100
integer width = 1403
integer height = 1504
integer taborder = 10
string title = "none"
string dataobject = "d_fusionvet"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_toolbar from u_cst_toolbarstrip within w_choixfusionner
integer x = 37
integer y = 1628
integer width = 507
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;integer i
long ll_listafusion[], ll_fusionavec[]
string ls_listafusion

for i = 1 to dw_fusionvet.rowcount( )
	if dw_fusionvet.getitemnumber( i, 'fusionavec') = 1 then 
		ll_fusionavec[1] = dw_fusionvet.getitemnumber( i, 'id_veterinaire')
	end if
next

if upperbound(ll_fusionavec) <> 1 then return 

if messagebox("Avertissement","Voulez-vous fusionner ?", Question!,YesNo!,2) = 1 then
	for i = 1 to dw_fusionvet.rowcount( )
		if dw_fusionvet.getitemnumber( i, 'fusionner') = 1 then 
			ll_listafusion[i] = dw_fusionvet.getitemnumber( i, 'id_veterinaire')
			UPDATE t_isolementlot SET id_veterinaire = :ll_fusionavec[1] WHERE id_veterinaire = :ll_listafusion[i];
			If SQLCA.sqlcode = 0 then
				COMMIT USING SQLCA;
				DELETE FROM t_veterinaire WHERE id_veterinaire = :ll_listafusion[i];
				dw_fusionvet.retrieve( )
			Else
				ROLLBACK USING SQLCA;
			End if
		end if
	next
end if


end event

type uo_toolbar2 from u_cst_toolbarstrip within w_choixfusionner
integer x = 928
integer y = 1628
integer width = 507
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;if isvalid(w_veterinaire) then w_veterinaire.dw_veterinaire.retrieve( ) 
close(w_choixfusionner)


end event

type rr_3 from roundrectangle within w_choixfusionner
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 12639424
integer x = 14
integer width = 1454
integer height = 1764
integer cornerheight = 75
integer cornerwidth = 75
end type

type p_logo from w_logon`p_logo within w_choixfusionner
boolean visible = false
integer x = 521
integer y = 748
end type

type st_help from w_logon`st_help within w_choixfusionner
boolean visible = false
integer x = 393
integer y = 708
integer width = 896
integer height = 116
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 32768
long backcolor = 12639424
string text = "Veuillez spécifier un usager et un mot de passe:"
end type

type cb_ok from w_logon`cb_ok within w_choixfusionner
integer x = 123
integer y = 716
end type

type cb_cancel from w_logon`cb_cancel within w_choixfusionner
integer x = 123
integer y = 828
string text = "Annuler"
end type

type sle_userid from w_logon`sle_userid within w_choixfusionner
integer x = 832
integer y = 208
integer width = 411
integer height = 88
borderstyle borderstyle = stylebox!
end type

type sle_password from w_logon`sle_password within w_choixfusionner
event ue_keypress pbm_keydown
integer x = 832
integer width = 411
integer height = 88
borderstyle borderstyle = stylebox!
end type

type st_2 from w_logon`st_2 within w_choixfusionner
integer x = 375
integer y = 212
integer width = 329
long backcolor = 12639424
string text = "Usager:"
alignment alignment = left!
end type

type st_3 from w_logon`st_3 within w_choixfusionner
integer x = 375
integer y = 304
integer width = 329
long backcolor = 12639424
string text = "Mot de passe:"
alignment alignment = left!
end type

