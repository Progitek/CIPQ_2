$PBExportHeader$w_importation.srw
forward
global type w_importation from w_sheet_frame
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_importation
end type
type st_1 from statictext within w_importation
end type
type em_date from u_em within w_importation
end type
type st_table from statictext within w_importation
end type
type uo_pg from u_progressbar within w_importation
end type
type st_2 from statictext within w_importation
end type
type ddlb_centre from u_ddlb within w_importation
end type
type st_nbrfiles from statictext within w_importation
end type
type st_3 from statictext within w_importation
end type
type dw_fichiers_importes from u_dw within w_importation
end type
type cbx_pas_fact from u_cbx within w_importation
end type
type rr_1 from roundrectangle within w_importation
end type
end forward

global type w_importation from w_sheet_frame
uo_toolbar2 uo_toolbar2
st_1 st_1
em_date em_date
st_table st_table
uo_pg uo_pg
st_2 st_2
ddlb_centre ddlb_centre
st_nbrfiles st_nbrfiles
st_3 st_3
dw_fichiers_importes dw_fichiers_importes
cbx_pas_fact cbx_pas_fact
rr_1 rr_1
end type
global w_importation w_importation

forward prototypes
public subroutine of_setposition (integer ai_position)
public subroutine of_listefichier ()
end prototypes

public subroutine of_setposition (integer ai_position);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_SetPosition
//
//	Accès:			Public
//
//	Argument:		Position de la progression de la barre
//
//	Retourne: 		Rien
//
//	Description: 	Place la barre de progression à une certaine position
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date		   Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

uo_pg.visible = true

uo_pg.of_setposition(ai_position)
IF ai_position > 49 THEN
	uo_pg.of_SetTextColor(RGB(255,255,255))
ELSE
	uo_pg.of_SetTextColor(0)
END IF
end subroutine

public subroutine of_listefichier ();String   ls_currdir
Integer  li_cnt, li_entries
String   ls_import, ls_provenance
Long 		ll_upperbound, ll_cpt, ll_i, ll_pos[]
n_cst_dirattrib   lnv_dirlist[]
SetPointer(HourGlass!)

//Vérifier le répertoire de traitement des fichiers importés (défaut "Z:\CIPQ\recoie\")
ls_currdir = gnv_app.of_getvaleurini("IMPORT", "ImportDir")
IF LEN(ls_currdir) > 0 THEN
	IF NOT FileExists(ls_currdir) THEN
		gnv_app.inv_error.of_message("CIPQ0150")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0150")
	RETURN
END IF

IF RIGHT(ls_currdir, 1) <> "\" THEN ls_currdir += "\"

ls_currdir += "*.txt"
li_entries = gnv_app.inv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)

ll_i = 1
ll_upperbound = UpperBound(lnv_dirlist[])
For ll_cpt = 1 to ll_upperbound
	if Pos(Upper(lnv_dirlist[ll_cpt].is_filename), "T") = 4 then
		ll_pos[ll_i] = ll_cpt
		ll_i = ll_i + 1
	end if
end for
ll_upperbound = UpperBound(ll_pos[])
dw_fichiers_importes.reset()
For ll_cpt = 1 to ll_upperbound
	dw_fichiers_importes.insertrow(0)
	dw_fichiers_importes.object.filename[ll_cpt] = lnv_dirlist[ll_pos[ll_cpt]].is_filename
	dw_fichiers_importes.object.filedate[ll_cpt] = lnv_dirlist[ll_pos[ll_cpt]].id_lastwritedate
	ls_provenance = mid(lnv_dirlist[ll_pos[ll_cpt]].is_filename,4,4)
	dw_fichiers_importes.object.provenance[ll_cpt] = right(ls_provenance,3)
end for
dw_fichiers_importes.SetRedraw(false)
dw_fichiers_importes.SetSort("#3 A")
dw_fichiers_importes.sort()
dw_fichiers_importes.SetRedraw(true)
st_nbrfiles.text = string(ll_upperbound)

end subroutine

on w_importation.create
int iCurrent
call super::create
this.uo_toolbar2=create uo_toolbar2
this.st_1=create st_1
this.em_date=create em_date
this.st_table=create st_table
this.uo_pg=create uo_pg
this.st_2=create st_2
this.ddlb_centre=create ddlb_centre
this.st_nbrfiles=create st_nbrfiles
this.st_3=create st_3
this.dw_fichiers_importes=create dw_fichiers_importes
this.cbx_pas_fact=create cbx_pas_fact
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_date
this.Control[iCurrent+4]=this.st_table
this.Control[iCurrent+5]=this.uo_pg
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_centre
this.Control[iCurrent+8]=this.st_nbrfiles
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_fichiers_importes
this.Control[iCurrent+11]=this.cbx_pas_fact
this.Control[iCurrent+12]=this.rr_1
end on

on w_importation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar2)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.st_table)
destroy(this.uo_pg)
destroy(this.st_2)
destroy(this.ddlb_centre)
destroy(this.st_nbrfiles)
destroy(this.st_3)
destroy(this.dw_fichiers_importes)
destroy(this.cbx_pas_fact)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)
uo_toolbar2.of_AddItem("Importer", "Continue!")
uo_toolbar2.of_AddItem("Fermer", "Exit!")
uo_toolbar2.POST of_displaytext(true)

em_date.text = string(date(today()),"yyyy-mm-dd")
ddlb_centre.text = "110"

uo_pg.of_SetDisplayStyle (1)
uo_pg.of_SetFillColor(RGB(0,0,128))

this.post of_listefichier()

// Quoi ?!?! Pas rapport ! - 2009-11-25 Sébastien Tremblay
//UpperBound(ddlb_centre.item)

if not this.of_droitautres('', {''}) or gnv_app.of_getcompagniedefaut() <> '110' then
	cbx_pas_fact.visible = false
end if
end event

type st_title from w_sheet_frame`st_title within w_importation
integer x = 197
integer width = 1815
string text = "Importation"
end type

type p_8 from w_sheet_frame`p_8 within w_importation
integer x = 59
integer y = 48
integer width = 101
integer height = 80
boolean originalsize = false
string picturename = "import!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_importation
integer y = 24
integer width = 2085
end type

type uo_toolbar2 from u_cst_toolbarstrip within w_importation
integer x = 23
integer y = 1364
integer width = 2085
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;boolean lb_retour = FALSE

CHOOSE CASE as_button
	CASE "Fermer"
		Close(PARENT)
	
	CASE "Importer"
		// 2009-11-25 Sébastien Tremblay - Ne pas se servir des contrôles de centre et de date, juste le nom du fichier
		IF dw_fichiers_importes.getRow() <= 0 THEN
//		IF IsNull(em_date.text) OR em_date.text = "00-00-0000" THEN
			gnv_app.inv_error.of_message("pfc_requiredmissing",{"Fichier d'importation"})
		ELSE
//			gnv_app.inv_entrepotglobal.of_ajoutedonnee("date transfert", em_date.text)
//			gnv_app.inv_entrepotglobal.of_ajoutedonnee("provenance transfert", ddlb_centre.text)
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("fichier importation transfert", dw_fichiers_importes.object.filename[dw_fichiers_importes.getRow()])
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("ne pas importer bons transfert", cbx_pas_fact.checked)
			gnv_app.inv_transfert_centre_adm.iw_importation = parent
			SetPointer(HourGlass!)
			lb_retour = gnv_app.inv_transfert_centre_adm.of_importer( )
			//Ouvrir le rapport automatiquement pour 110
//			IF gnv_app.of_getcompagniedefaut( ) = "110" AND lb_retour = TRUE THEN
//				w_r_transferts_importes		lw_sheet	
//				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", string(date(today())))
//				OpenSheet(lw_sheet, gnv_app.of_GetFrame(), 6, layered!)
//			END IF
		END IF
		
		of_listefichier()
				
END CHOOSE
end event

type st_1 from statictext within w_importation
boolean visible = false
integer x = 91
integer y = 240
integer width = 754
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Date d~'importation:"
boolean focusrectangle = false
end type

type em_date from u_em within w_importation
boolean visible = false
integer x = 869
integer y = 236
integer width = 526
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
string facename = "Tahoma"
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type st_table from statictext within w_importation
integer x = 87
integer y = 1112
integer width = 1947
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
boolean focusrectangle = false
end type

type uo_pg from u_progressbar within w_importation
boolean visible = false
integer x = 87
integer y = 1228
integer width = 1947
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean border = true
long backcolor = 15793151
end type

on uo_pg.destroy
call u_progressbar::destroy
end on

type st_2 from statictext within w_importation
boolean visible = false
integer x = 91
integer y = 352
integer width = 754
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Provenance:"
boolean focusrectangle = false
end type

type ddlb_centre from u_ddlb within w_importation
boolean visible = false
integer x = 869
integer y = 348
integer width = 347
integer height = 512
integer taborder = 11
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string item[] = {"110","111","112","113","115"}
end type

type st_nbrfiles from statictext within w_importation
integer x = 1819
integer y = 1008
integer width = 206
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
boolean focusrectangle = false
end type

type st_3 from statictext within w_importation
integer x = 1065
integer y = 1008
integer width = 745
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Nombre de fichiers:"
boolean focusrectangle = false
end type

type dw_fichiers_importes from u_dw within w_importation
integer x = 64
integer y = 312
integer width = 2007
integer height = 684
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fichiers_importes"
boolean border = true
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;//Integer li_pos
//String ls_date
//
//li_pos = ddlb_centre.SelectItem(dw_fichiers_importes.getitemstring(row,"provenance"),0)
//
//ls_date = left(right(String(dw_fichiers_importes.getitemstring( row, "filename")),8),4)
//
////2009-01-05 Mathieu Gendron
////Changer la date pour considérer le changement d'année
//IF month(today()) = 1 AND right(ls_date,2) = "12" THEN
//	em_date.text = string(year(today()) - 1) + "-" + right(ls_date,2) + "-" + left(ls_date,2)
//ELSE
//	em_date.text = string(year(today())) + "-" + right(ls_date,2) + "-" + left(ls_date,2)
//END IF
end event

event constructor;call super::constructor;setRowfocusindicator(Hand!)
end event

type cbx_pas_fact from u_cbx within w_importation
integer x = 59
integer y = 212
integer width = 2002
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 32768
long backcolor = 15793151
string text = "Ne pas importer les bons de livraison"
end type

type rr_1 from roundrectangle within w_importation
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 176
integer width = 2085
integer height = 1168
integer cornerheight = 40
integer cornerwidth = 46
end type

