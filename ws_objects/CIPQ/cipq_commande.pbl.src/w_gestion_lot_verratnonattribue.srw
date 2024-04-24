$PBExportHeader$w_gestion_lot_verratnonattribue.srw
forward
global type w_gestion_lot_verratnonattribue from w_response
end type
type dw_gestion_lot_verratnonattribue from u_dw within w_gestion_lot_verratnonattribue
end type
type uo_toolbar from u_cst_toolbarstrip within w_gestion_lot_verratnonattribue
end type
type rr_1 from roundrectangle within w_gestion_lot_verratnonattribue
end type
end forward

global type w_gestion_lot_verratnonattribue from w_response
string tag = "menu=m_gestiondeslotsdesrecoltes"
integer x = 214
integer y = 221
integer width = 3287
integer height = 2416
string title = "Verrat(s) ayant des doses non-distribuées"
long backcolor = 12639424
dw_gestion_lot_verratnonattribue dw_gestion_lot_verratnonattribue
uo_toolbar uo_toolbar
rr_1 rr_1
end type
global w_gestion_lot_verratnonattribue w_gestion_lot_verratnonattribue

on w_gestion_lot_verratnonattribue.create
int iCurrent
call super::create
this.dw_gestion_lot_verratnonattribue=create dw_gestion_lot_verratnonattribue
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gestion_lot_verratnonattribue
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.rr_1
end on

on w_gestion_lot_verratnonattribue.destroy
call super::destroy
destroy(this.dw_gestion_lot_verratnonattribue)
destroy(this.uo_toolbar)
destroy(this.rr_1)
end on

event open;call super::open;date	ld_cur

uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

ld_cur = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date nd"))

dw_gestion_lot_verratnonattribue.Retrieve(ld_cur)
end event

type dw_gestion_lot_verratnonattribue from u_dw within w_gestion_lot_verratnonattribue
integer x = 64
integer y = 40
integer width = 3141
integer height = 2132
integer taborder = 10
string dataobject = "d_gestion_lot_verratnonattribue"
end type

type uo_toolbar from u_cst_toolbarstrip within w_gestion_lot_verratnonattribue
event destroy ( )
integer x = 2729
integer y = 2216
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type rr_1 from roundrectangle within w_gestion_lot_verratnonattribue
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 3227
integer height = 2180
integer cornerheight = 40
integer cornerwidth = 46
end type

