$PBExportHeader$w_exportation_pilotage.srw
forward
global type w_exportation_pilotage from w_sheet_frame
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_exportation_pilotage
end type
type st_1 from statictext within w_exportation_pilotage
end type
type em_date from u_em within w_exportation_pilotage
end type
type st_table from statictext within w_exportation_pilotage
end type
type uo_pg from u_progressbar within w_exportation_pilotage
end type
type dw_table_export from u_dw within w_exportation_pilotage
end type
type rr_1 from roundrectangle within w_exportation_pilotage
end type
end forward

global type w_exportation_pilotage from w_sheet_frame
uo_toolbar2 uo_toolbar2
st_1 st_1
em_date em_date
st_table st_table
uo_pg uo_pg
dw_table_export dw_table_export
rr_1 rr_1
end type
global w_exportation_pilotage w_exportation_pilotage

forward prototypes
public subroutine of_setposition (integer ai_position)
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

on w_exportation_pilotage.create
int iCurrent
call super::create
this.uo_toolbar2=create uo_toolbar2
this.st_1=create st_1
this.em_date=create em_date
this.st_table=create st_table
this.uo_pg=create uo_pg
this.dw_table_export=create dw_table_export
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_date
this.Control[iCurrent+4]=this.st_table
this.Control[iCurrent+5]=this.uo_pg
this.Control[iCurrent+6]=this.dw_table_export
this.Control[iCurrent+7]=this.rr_1
end on

on w_exportation_pilotage.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar2)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.st_table)
destroy(this.uo_pg)
destroy(this.dw_table_export)
destroy(this.rr_1)
end on

event open;call super::open;uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)
uo_toolbar2.of_AddItem("Transfert", "Continue!")
uo_toolbar2.of_AddItem("Impression rapport", "Print!")
IF gnv_app.of_getcompagniedefaut( ) = "110" THEN
	uo_toolbar2.of_AddItem("Pour transférer toutes les tables", "Retrieve!")
	//em_date.text = string(date(today()),"yyyy-mm-dd")
END IF
uo_toolbar2.of_AddItem("Fermer", "Exit!")
uo_toolbar2.POST of_displaytext(true)

uo_pg.of_SetDisplayStyle (1)
uo_pg.of_SetFillColor(RGB(0,0,128))

if gnv_app.of_getcompagniedefaut( ) = '110' then
	dw_table_export.retrieve( )
else
	dw_table_export.visible = false
end if
end event

type st_title from w_sheet_frame`st_title within w_exportation_pilotage
integer x = 197
integer width = 1815
string text = "Exportation"
end type

type p_8 from w_sheet_frame`p_8 within w_exportation_pilotage
integer x = 59
integer y = 48
integer width = 101
integer height = 80
boolean originalsize = false
string picturename = "Export!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_exportation_pilotage
integer y = 24
integer width = 2085
end type

type uo_toolbar2 from u_cst_toolbarstrip within w_exportation_pilotage
integer x = 23
integer y = 1232
integer width = 2085
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;w_r_transfert_envoie	lw_r_transfert_envoie

CHOOSE CASE as_button
	CASE "Fermer"
		do while yield()
		loop
		Close(PARENT)
	
	CASE "Transfert"
		IF date(em_date.text) = date(today()) THEN
			SetNull(em_date.text )
		END IF
			
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("date transfert", em_date.text)
		gnv_app.inv_transfert_centre_adm.iw_exportation_pilotage = parent
		gnv_app.inv_transfert_centre_adm.of_transfert_adm( )
		
		IF gnv_app.of_getcompagniedefaut( ) <> "110" THEN
			//Impression de rapport automatique
			IF IsNull(em_date.text) OR em_date.text = "" THEN
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("date transfert", date(today()))
			ELSE
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("date transfert", em_date.text)
			END IF
			OpenSheet(lw_r_transfert_envoie, gnv_app.of_GetFrame(), 6, layered!)
		END IF
		
	CASE "Impression rapport"
		if not isnull(em_date.text) and not em_date.text = "" then
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("date transfert", em_date.text)
		else
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("date transfert", date(today()))
		end if
		OpenSheet(lw_r_transfert_envoie, gnv_app.of_GetFrame(), 6, layered!)
		
	CASE "Pour transférer toutes les tables"
		UPDATE T_TransfertAFaire SET afaire = 1;
		COMMIT USING SQLCA;
		
		Messagebox("Information","Procédure terminée")
		
END CHOOSE
end event

type st_1 from statictext within w_exportation_pilotage
integer x = 110
integer y = 240
integer width = 640
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Date d~'exportation:"
boolean focusrectangle = false
end type

type em_date from u_em within w_exportation_pilotage
integer x = 777
integer y = 236
integer width = 526
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type st_table from statictext within w_exportation_pilotage
integer x = 105
integer y = 888
integer width = 1938
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

type uo_pg from u_progressbar within w_exportation_pilotage
boolean visible = false
integer x = 87
integer y = 1056
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

type dw_table_export from u_dw within w_exportation_pilotage
integer x = 128
integer y = 380
integer width = 1865
integer height = 496
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_table_export"
boolean border = true
boolean ib_isupdateable = false
end type

type rr_1 from roundrectangle within w_exportation_pilotage
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 176
integer width = 2085
integer height = 1028
integer cornerheight = 40
integer cornerwidth = 46
end type

