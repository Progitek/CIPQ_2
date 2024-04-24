$PBExportHeader$w_exportation.srw
forward
global type w_exportation from w_response
end type
type rb_pdf from u_rb within w_exportation
end type
type cb_annuler from u_cb within w_exportation
end type
type cb_ok from u_cb within w_exportation
end type
type rb_html from u_rb within w_exportation
end type
type rb_sql from u_rb within w_exportation
end type
type rb_csv from u_rb within w_exportation
end type
type rb_xls from u_rb within w_exportation
end type
type gb_1 from u_gb within w_exportation
end type
type rr_1 from roundrectangle within w_exportation
end type
end forward

global type w_exportation from w_response
integer x = 214
integer y = 221
integer width = 1623
integer height = 1040
string title = "Exportation"
long backcolor = 12639424
rb_pdf rb_pdf
cb_annuler cb_annuler
cb_ok cb_ok
rb_html rb_html
rb_sql rb_sql
rb_csv rb_csv
rb_xls rb_xls
gb_1 gb_1
rr_1 rr_1
end type
global w_exportation w_exportation

type variables
u_dw		idw_export
end variables

on w_exportation.create
int iCurrent
call super::create
this.rb_pdf=create rb_pdf
this.cb_annuler=create cb_annuler
this.cb_ok=create cb_ok
this.rb_html=create rb_html
this.rb_sql=create rb_sql
this.rb_csv=create rb_csv
this.rb_xls=create rb_xls
this.gb_1=create gb_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_pdf
this.Control[iCurrent+2]=this.cb_annuler
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.rb_html
this.Control[iCurrent+5]=this.rb_sql
this.Control[iCurrent+6]=this.rb_csv
this.Control[iCurrent+7]=this.rb_xls
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.rr_1
end on

on w_exportation.destroy
call super::destroy
destroy(this.rb_pdf)
destroy(this.cb_annuler)
destroy(this.cb_ok)
destroy(this.rb_html)
destroy(this.rb_sql)
destroy(this.rb_csv)
destroy(this.rb_xls)
destroy(this.gb_1)
destroy(this.rr_1)
end on

event pfc_preopen;call super::pfc_preopen;idw_export = Message.PowerObjectParm
end event

type rb_pdf from u_rb within w_exportation
integer x = 110
integer y = 504
integer width = 978
integer height = 68
long backcolor = 15793151
string text = "Convertir en PDF"
end type

type cb_annuler from u_cb within w_exportation
integer x = 818
integer y = 804
integer width = 475
integer taborder = 20
string text = "Annuler"
boolean cancel = true
boolean flatstyle = true
end type

event clicked;call super::clicked;CLOSE(parent)
end event

type cb_ok from u_cb within w_exportation
integer x = 297
integer y = 800
integer width = 475
integer taborder = 20
string text = "OK"
boolean default = true
boolean flatstyle = true
end type

event clicked;call super::clicked;blob 		lblb_data
n_cst_export	lnv_export

IF rb_xls.Checked = TRUE THEN
	idw_export.GetFullState (lblb_data)
	lnv_export.of_ExportExcel(lblb_data)
ELSEIF rb_csv.Checked = TRUE THEN
	lnv_export.of_exportcsv(idw_export)
ELSEIF rb_html.Checked = TRUE THEN
	lnv_export.of_exportHTML(idw_export)
ELSEIF rb_SQL.Checked = TRUE THEN
	lnv_export.of_exportSQL(idw_export)
ELSEIF rb_pdf.Checked = TRUE THEN
	lnv_export.of_exportPDF(idw_export)
END IF

CLOSE(parent)
end event

type rb_html from u_rb within w_exportation
integer x = 110
integer y = 612
integer width = 882
integer height = 68
long backcolor = 15793151
string text = "Tableau HTML"
end type

type rb_sql from u_rb within w_exportation
integer x = 110
integer y = 384
integer width = 882
integer height = 68
long backcolor = 15793151
string text = "Format d~'insertion SQL"
end type

type rb_csv from u_rb within w_exportation
integer x = 110
integer y = 264
integer width = 882
integer height = 68
long backcolor = 15793151
string text = "Texte séparé par des virgules (CSV)"
end type

type rb_xls from u_rb within w_exportation
integer x = 110
integer y = 152
integer width = 978
integer height = 68
long backcolor = 15793151
string text = "Format compatible Microsoft Excel (XLS)"
boolean checked = true
end type

type gb_1 from u_gb within w_exportation
integer x = 73
integer y = 44
integer width = 1458
integer height = 720
integer taborder = 10
long backcolor = 15793151
string text = "Choisissez le format d~'exportation"
end type

type rr_1 from roundrectangle within w_exportation
long linecolor = 10789024
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 20
integer width = 1577
integer height = 916
integer cornerheight = 40
integer cornerwidth = 46
end type

