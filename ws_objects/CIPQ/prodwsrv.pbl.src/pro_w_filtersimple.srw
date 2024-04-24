$PBExportHeader$pro_w_filtersimple.srw
$PBExportComments$(PRO) Extension Simple-Style Filter dialog window
forward
global type pro_w_filtersimple from pfc_w_filtersimple
end type
type uo_toolbar from u_cst_toolbarstrip within pro_w_filtersimple
end type
type uo_toolbar2 from u_cst_toolbarstrip within pro_w_filtersimple
end type
type rr_1 from roundrectangle within pro_w_filtersimple
end type
end forward

global type pro_w_filtersimple from pfc_w_filtersimple
string tag = "exclure_securite"
integer x = 214
integer y = 221
integer width = 2935
integer height = 848
string title = "Filtre optionnel"
long backcolor = 12639424
uo_toolbar uo_toolbar
uo_toolbar2 uo_toolbar2
rr_1 rr_1
end type
global pro_w_filtersimple pro_w_filtersimple

on pro_w_filtersimple.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.uo_toolbar2=create uo_toolbar2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.uo_toolbar2
this.Control[iCurrent+3]=this.rr_1
end on

on pro_w_filtersimple.destroy
call super::destroy
destroy(this.uo_toolbar)
destroy(this.uo_toolbar2)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar2.POST of_displaytext(true)
end event

event pfc_default;call super::pfc_default;SetPointer(Hourglass!)
end event

type cb_delete from pfc_w_filtersimple`cb_delete within pro_w_filtersimple
integer x = 2505
integer y = 272
string text = "&Detruire"
boolean flatstyle = true
end type

event cb_delete::clicked;call super::clicked;is_prevchildcolumn = ""
end event

type cb_cancel from pfc_w_filtersimple`cb_cancel within pro_w_filtersimple
boolean visible = false
integer x = 2066
string text = "Annuler"
end type

type dw_filter from pfc_w_filtersimple`dw_filter within pro_w_filtersimple
integer x = 64
integer y = 60
integer width = 2437
integer height = 504
end type

event dw_filter::constructor;call super::constructor;ib_maj_ligne_par_ligne = FALSE
end event

event dw_filter::itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
		
	CASE "colname"
		//Si la colonne était vide, mettre =
		IF THIS.object.colname[row] = "" OR IsNull(THIS.object.colname[row]) THEN
			THIS.object.oper[row] = "="
			THIS.SetColumn("colvalue")
		END IF
		
END CHOOSE
end event

type mle_originalfilter from pfc_w_filtersimple`mle_originalfilter within pro_w_filtersimple
boolean visible = false
integer x = 3502
integer y = 148
end type

type gb_originalfilter from pfc_w_filtersimple`gb_originalfilter within pro_w_filtersimple
boolean visible = false
integer x = 3456
integer y = 88
string text = "Filtre original"
end type

type cb_add from pfc_w_filtersimple`cb_add within pro_w_filtersimple
integer x = 2505
integer y = 144
string text = "&Ajouter"
boolean flatstyle = true
end type

event cb_add::clicked;call super::clicked;is_prevchildcolumn = ""
end event

type gb_newfilter from pfc_w_filtersimple`gb_newfilter within pro_w_filtersimple
boolean visible = false
integer x = 3451
integer y = 392
string text = "Nouveau filtre"
end type

type cb_ok from pfc_w_filtersimple`cb_ok within pro_w_filtersimple
boolean visible = false
integer x = 1673
end type

event cb_ok::clicked;call super::clicked;SetPointer(Hourglass!)
end event

type cb_dlghelp from pfc_w_filtersimple`cb_dlghelp within pro_w_filtersimple
boolean visible = false
integer x = 23
integer y = 940
end type

type uo_toolbar from u_cst_toolbarstrip within pro_w_filtersimple
integer x = 1838
integer y = 636
integer width = 507
integer taborder = 40
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_ok.event clicked( )
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_toolbar2 from u_cst_toolbarstrip within pro_w_filtersimple
integer x = 2405
integer y = 636
integer width = 507
integer taborder = 50
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_cancel.event clicked( )
end event

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

type rr_1 from roundrectangle within pro_w_filtersimple
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 28
integer width = 2889
integer height = 580
integer cornerheight = 40
integer cornerwidth = 46
end type

