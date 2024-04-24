$PBExportHeader$w_cote_peremption.srw
forward
global type w_cote_peremption from w_sheet_frame
end type
type dw_cote_peremption from u_dw within w_cote_peremption
end type
type uo_toolbar from u_cst_toolbarstrip within w_cote_peremption
end type
type em_date from u_em within w_cote_peremption
end type
type st_date from statictext within w_cote_peremption
end type
type ddlb_centre from u_ddlb within w_cote_peremption
end type
type st_centre from statictext within w_cote_peremption
end type
type pb_go from picturebutton within w_cote_peremption
end type
type dw_rapport from u_dw within w_cote_peremption
end type
type rr_1 from roundrectangle within w_cote_peremption
end type
end forward

global type w_cote_peremption from w_sheet_frame
string tag = "menu=m_recolte-peremption"
string title = "Récolte - péremption"
dw_cote_peremption dw_cote_peremption
uo_toolbar uo_toolbar
em_date em_date
st_date st_date
ddlb_centre ddlb_centre
st_centre st_centre
pb_go pb_go
dw_rapport dw_rapport
rr_1 rr_1
end type
global w_cote_peremption w_cote_peremption

type variables
Protected:

date id_date_recolte
string is_centre
boolean ib_en_edition = FALSE
end variables

forward prototypes
public subroutine of_setedition (boolean ab_switch)
end prototypes

public subroutine of_setedition (boolean ab_switch);long ll_row, ll_rowCount, ll_cote

ib_en_edition = ab_switch

IF ib_en_edition = FALSE THEN
	//Barrer la dw
	dw_cote_peremption.object.datawindow.readonly = "Yes"
ELSE
	//Débarrer la dw (et toutes les lignes sans cote)
	dw_cote_peremption.object.datawindow.readonly = "No"
	
	ll_rowCount = dw_cote_peremption.rowCount()
	
	for ll_row = 1 to ll_rowCount
		ll_cote = dw_cote_peremption.object.cote[ll_row]
		
		if isnull(ll_cote) then
			dw_cote_peremption.object.cc_protect[ll_row] = 0
			dw_cote_peremption.object.preplaboid[ll_row] = gnv_app.il_id_user
		else
			//dw_cote_peremption.object.cc_protect[ll_row] = 1
			dw_cote_peremption.object.cc_protect[ll_row] = 0
		end if
	next
	
END IF
end subroutine

on w_cote_peremption.create
int iCurrent
call super::create
this.dw_cote_peremption=create dw_cote_peremption
this.uo_toolbar=create uo_toolbar
this.em_date=create em_date
this.st_date=create st_date
this.ddlb_centre=create ddlb_centre
this.st_centre=create st_centre
this.pb_go=create pb_go
this.dw_rapport=create dw_rapport
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cote_peremption
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.em_date
this.Control[iCurrent+4]=this.st_date
this.Control[iCurrent+5]=this.ddlb_centre
this.Control[iCurrent+6]=this.st_centre
this.Control[iCurrent+7]=this.pb_go
this.Control[iCurrent+8]=this.dw_rapport
this.Control[iCurrent+9]=this.rr_1
end on

on w_cote_peremption.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_cote_peremption)
destroy(this.uo_toolbar)
destroy(this.em_date)
destroy(this.st_date)
destroy(this.ddlb_centre)
destroy(this.st_centre)
destroy(this.pb_go)
destroy(this.dw_rapport)
destroy(this.rr_1)
end on

event open;call super::open;string ls_cie

ls_cie = gnv_app.of_getcompagniedefaut()

if ls_cie = "110" then
	setNull(is_centre)
	ddlb_centre.of_additem("Tous", is_centre)
	ddlb_centre.of_additem("111", "111")
	ddlb_centre.of_additem("112", "112")
	ddlb_centre.of_additem("113", "113")
else
	is_centre = ls_cie
	ddlb_centre.of_additem(is_centre, is_centre)
end if

ddlb_centre.of_selectitem(1)

setredraw(true)
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Imprimer", "Print!")
uo_toolbar.of_AddItem("Édition", "EditStops5!")

uo_toolbar.of_AddItem("Enregistrer", "Save!")

uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

//Garder 1 an seulement
DELETE FROM t_recolte_cote_peremption WHERE dateadd(year, 1, date_recolte) < current date;
COMMIT USING SQLCA;
end event

event pfc_postupdate;call super::pfc_postupdate;if ancestorReturnValue >= 0 then of_setedition(false)

return ancestorReturnValue

end event

event pfc_print;call super::pfc_print;integer li_rc = 1

if dw_cote_peremption.rowCount() > 0 then
	dw_rapport.of_reset()
	dw_cote_peremption.rowsCopy(1, dw_cote_peremption.rowCount(), Primary!, dw_rapport, 1, Primary!)
	
	li_rc = dw_rapport.event pfc_print()
end if

return li_rc

end event

type st_title from w_sheet_frame`st_title within w_cote_peremption
string text = "Récolte - péremption"
end type

type p_8 from w_sheet_frame`p_8 within w_cote_peremption
integer x = 73
integer y = 56
integer width = 87
integer height = 64
boolean originalsize = false
string picturename = "Custom098!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_cote_peremption
end type

type dw_cote_peremption from u_dw within w_cote_peremption
integer x = 64
integer y = 216
integer width = 4471
integer height = 1900
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cote_peremption"
boolean ib_maj_ligne_par_ligne = false
end type

event pfc_retrieve;call super::pfc_retrieve;if not isNull(is_centre) and id_date_recolte <= today() then
	insert into t_recolte_cote_peremption (cie_no, date_recolte, famille, nolot, preplaboid, nbdoses)
	(select :is_centre,
			  T_Recolte_GestionLot_Lot.daterecolte,
			  T_Recolte_GestionLot_Lot.Famille,
			  T_Recolte_GestionLot_Lot.nolot,
			  :gnv_app.il_id_user,
			  isNull(sum(t_Recolte_GestionLot_Produit_QteDistribue.QteDistribue), 0)
		FROM T_Recolte_GestionLot_Lot LEFT OUTER JOIN (
			  t_Recolte_GestionLot_Produit inner join t_Recolte_GestionLot_Produit_QteDistribue
					on t_Recolte_GestionLot_Produit_QteDistribue.Famille = t_Recolte_GestionLot_Produit.Famille
				  and t_Recolte_GestionLot_Produit_QteDistribue.NoLot = t_Recolte_GestionLot_Produit.NoLot
				  and t_Recolte_GestionLot_Produit_QteDistribue.DateRecolte = t_Recolte_GestionLot_Produit.DateRecolte
				  and t_Recolte_GestionLot_Produit_QteDistribue.NoProduit = t_Recolte_GestionLot_Produit.NoProduit
				  and t_Recolte_GestionLot_Produit_QteDistribue.Compteur = t_Recolte_GestionLot_Produit.Compteur)
				on t_Recolte_GestionLot_Produit.Famille = T_Recolte_GestionLot_Lot.Famille
			  and t_Recolte_GestionLot_Produit.NoLot = T_Recolte_GestionLot_Lot.NoLot
			  and t_Recolte_GestionLot_Produit.DateRecolte = T_Recolte_GestionLot_Lot.DateRecolte			  
	  WHERE date(T_Recolte_GestionLot_Lot.DateRecolte) = :id_date_recolte
		 and not exists(select 1 from t_recolte_cote_peremption
							  where date_recolte = T_Recolte_GestionLot_Lot.daterecolte
								 and famille = T_Recolte_GestionLot_Lot.Famille
								 and nolot = T_Recolte_GestionLot_Lot.nolot)
	group by T_Recolte_GestionLot_Lot.daterecolte,
				T_Recolte_GestionLot_Lot.Famille,
				T_Recolte_GestionLot_Lot.nolot);
end if

RETURN THIS.Retrieve(id_date_recolte, is_centre)
end event

event constructor;call super::constructor;SetRowFocusIndicator(HAnd!)

end event

event pro_postconstructor;call super::pro_postconstructor;parent.of_setEdition(false)
end event

event itemchanged;call super::itemchanged;string ls_nolot, ls_cote, ls_famille
long ll_row
date ldt_daterecolte

choose case dwo.name
	case "cote", "remarque"
		// Gestion des données pour le transfert
		// Mettre le TransDate à null
		datetime	ldt_null
		
		SetNull(ldt_null)
		this.object.TransDate[row] = ldt_null
end choose

IF dwo.name = "cote" THEN
	ll_row = dw_cote_peremption.getrow()
	ls_cote = data
	IF ll_row > 0 THEN
		IF ls_cote = '3' OR ls_cote = '4' THEN
			ls_nolot = THIS.object.nolot[ll_row]
			ldt_daterecolte = date(THIS.object.date_recolte[ll_row])
			ls_famille = This.object.famille[ll_row]
			IF IsNull(ls_nolot) = FALSE AND ls_nolot <> "" AND (ls_cote = '3' OR ls_cote = '4') THEN
				w_recolte_peremption_coms	lw_window
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("cote_peremption_coms", ls_nolot)
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("daterecolte", ldt_daterecolte)
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("famille",ls_famille)
				Open(lw_window)
				IF IsValid(lw_window) THEN Destroy(lw_window)
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("cote_peremption_coms", "")
			END IF
		END IF
	END IF
END IF 
end event

type uo_toolbar from u_cst_toolbarstrip within w_cote_peremption
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2216
integer width = 4558
integer height = 108
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		IF ib_en_edition THEN
			PARENT.event pfc_save()
		END IF
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Imprimer"
		parent.event pfc_print()
		
	CASE "Édition"
		parent.of_setEdition(true)
		
END CHOOSE

end event

type em_date from u_em within w_cote_peremption
integer x = 3319
integer y = 48
integer width = 411
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

event modified;call super::modified;IF parent.event pfc_save() >= 0 then
	this.getData(id_date_recolte)
//	if id_date_recolte >= today() then
//		gnv_app.inv_error.of_message("CIPQ0018", {"Le jour des récoltes doit être passé."})
//		SetNull(id_date_recolte)
//	else
		IF id_date_recolte = 1900-01-01 THEN SetNull(id_date_recolte)
//	end if
	dw_cote_peremption.of_retrieve()
end if
end event

type st_date from statictext within w_cote_peremption
integer x = 2661
integer y = 56
integer width = 654
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Afficher les récoltes du:"
boolean focusrectangle = false
end type

type ddlb_centre from u_ddlb within w_cote_peremption
integer x = 4023
integer y = 48
integer width = 320
integer height = 280
integer taborder = 11
boolean bringtotop = true
end type

event selectionchanged;call super::selectionchanged;IF parent.event pfc_save() >= 0 then
	is_centre = string(this.of_getdata(index))
	dw_cote_peremption.of_retrieve()
end if
end event

type st_centre from statictext within w_cote_peremption
integer x = 3790
integer y = 56
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Centre:"
boolean focusrectangle = false
end type

type pb_go from picturebutton within w_cote_peremption
integer x = 4379
integer y = 48
integer width = 101
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\ii4net\CIPQ\images\rechercher.jpg"
alignment htextalign = left!
end type

type dw_rapport from u_dw within w_cote_peremption
boolean visible = false
integer x = 439
integer y = 1212
integer width = 183
integer height = 132
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_r_cote_peremption"
end type

type rr_1 from roundrectangle within w_cote_peremption
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 176
integer width = 4549
integer height = 1980
integer cornerheight = 75
integer cornerwidth = 75
end type

