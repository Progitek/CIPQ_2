$PBExportHeader$w_repartition_correction.srw
forward
global type w_repartition_correction from w_response
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_repartition_correction
end type
type dw_repartition_correction from u_dw within w_repartition_correction
end type
type p_1 from picture within w_repartition_correction
end type
type st_1 from statictext within w_repartition_correction
end type
type uo_toolbar from u_cst_toolbarstrip within w_repartition_correction
end type
type rr_1 from roundrectangle within w_repartition_correction
end type
type rr_2 from roundrectangle within w_repartition_correction
end type
end forward

global type w_repartition_correction from w_response
string tag = "menu=m_repartitiondesmarchandises"
integer width = 2130
integer height = 928
string title = "Correction"
long backcolor = 12639424
uo_toolbar_gauche uo_toolbar_gauche
dw_repartition_correction dw_repartition_correction
p_1 p_1
st_1 st_1
uo_toolbar uo_toolbar
rr_1 rr_1
rr_2 rr_2
end type
global w_repartition_correction w_repartition_correction

on w_repartition_correction.create
int iCurrent
call super::create
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.dw_repartition_correction=create dw_repartition_correction
this.p_1=create p_1
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar_gauche
this.Control[iCurrent+2]=this.dw_repartition_correction
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.rr_1
this.Control[iCurrent+7]=this.rr_2
end on

on w_repartition_correction.destroy
call super::destroy
destroy(this.uo_toolbar_gauche)
destroy(this.dw_repartition_correction)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.uo_toolbar)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("Exécuter", "C:\ii4net\CIPQ\images\rechercher.jpg")
uo_toolbar_gauche.POST of_displaytext(true)

dw_repartition_correction.InsertRow(0)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_repartition_correction
event destroy ( )
integer x = 18
integer y = 728
integer width = 507
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;//Procéder à la correction

string	ls_noproduit, ls_nolot, ls_sql, ls_null
long		ll_qte, ll_null, ll_compteur = 0, ll_rowdddw
datawindowchild 	ldwc_lot

dw_repartition_correction.AcceptText()

SetNull(ll_null)
SetNull(ls_null)

ls_noproduit = dw_repartition_correction.object.noproduit[1]
ls_nolot = dw_repartition_correction.object.nolot[1]
ll_qte = dw_repartition_correction.object.qte[1]

If IsNull(ls_noproduit) OR IsNull(ls_nolot) OR IsNull(ll_qte) Then RETURN

dw_repartition_correction.GetChild('nolot', ldwc_lot)
ldwc_lot.setTransObject(SQLCA)
ll_rowdddw = ldwc_lot.Find("t_recolte_gestionlot_produit_nolot = '" + ls_nolot + "'", 1, ldwc_lot.RowCount())		
//Vérifier s'il fait partie de la liste
IF ll_rowdddw > 0 THEN
	//Mettre à jour la description
	ll_compteur = ldwc_lot.GetItemNumber(ll_rowdddw,"t_recolte_gestionlot_produit_qtedistribue_compteur")
END IF

ls_sql = "UPDATE T_Recolte_GestionLot_Produit_QteDistribue " + &
	"SET T_Recolte_GestionLot_Produit_QteDistribue.QteDistribue = ( QteDistribue - " + string(ll_qte) + " ) " + &
    "WHERE t_Recolte_GestionLot_Produit_QteDistribue.Compteur = " + string(ll_compteur)

gnv_app.inv_audit.of_runsql_audit( ls_sql, "T_Recolte_GestionLot_Produit_QteDistribue", "Mise-à-jour", parent.title)

dw_repartition_correction.object.nolot[1] = ls_null
dw_repartition_correction.object.qte[1] = ll_null

gnv_app.inv_error.of_message("CIPQ0086")
end event

type dw_repartition_correction from u_dw within w_repartition_correction
integer x = 59
integer y = 284
integer width = 2011
integer height = 380
integer taborder = 10
string dataobject = "d_repartition_correction"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

event itemfocuschanged;call super::itemfocuschanged;string	ls_produit
long 		ll_rtn

IF dwo.name = "nolot" THEN

	IF Row > 0 THEN
		
		ls_produit = THIS.object.noproduit[1]
		
		//Retrieve de la dddw
		dataWindowChild ldwc_trans
		
		ll_rtn = THIS.GetChild('nolot', ldwc_trans)
		ldwc_trans.setTransObject(SQLCA)
		ll_rtn = ldwc_trans.retrieve(ls_produit)	
	END IF
	
END IF
end event

event constructor;call super::constructor;string	ls_null
long		ll_rtn

SetNull(ls_null)
//Retrieve de la dddw
dataWindowChild ldwc_trans

ll_rtn = THIS.GetChild('nolot', ldwc_trans)
ldwc_trans.setTransObject(SQLCA)
ll_rtn = ldwc_trans.retrieve(ls_null)	

end event

type p_1 from picture within w_repartition_correction
integer x = 69
integer y = 44
integer width = 137
integer height = 116
string picturename = "C:\ii4net\CIPQ\images\bons.bmp"
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_repartition_correction
integer x = 274
integer y = 36
integer width = 1787
integer height = 172
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Correction sur les quantités de produits distribuables selon leur No lot pour aujourd~'hui"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_repartition_correction
event destroy ( )
integer x = 1595
integer y = 728
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type rr_1 from roundrectangle within w_repartition_correction
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 248
integer width = 2085
integer height = 432
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_repartition_correction
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 2085
integer height = 208
integer cornerheight = 40
integer cornerwidth = 46
end type

