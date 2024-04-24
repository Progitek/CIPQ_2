HA$PBExportHeader$w_impression_etiquette.srw
forward
global type w_impression_etiquette from w_sheet
end type
type dw_impression_etiquette from u_dw within w_impression_etiquette
end type
type p_1 from picture within w_impression_etiquette
end type
type st_1 from statictext within w_impression_etiquette
end type
type uo_toolbar from u_cst_toolbarstrip within w_impression_etiquette
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_impression_etiquette
end type
type rr_1 from roundrectangle within w_impression_etiquette
end type
type rr_2 from roundrectangle within w_impression_etiquette
end type
end forward

global type w_impression_etiquette from w_sheet
string tag = "menu=m_commandesprevisionnelles"
integer width = 1262
integer height = 1252
string title = "Commandes pr$$HEX1$$e900$$ENDHEX$$visionnelles"
dw_impression_etiquette dw_impression_etiquette
p_1 p_1
st_1 st_1
uo_toolbar uo_toolbar
uo_toolbar_gauche uo_toolbar_gauche
rr_1 rr_1
rr_2 rr_2
end type
global w_impression_etiquette w_impression_etiquette

on w_impression_etiquette.create
int iCurrent
call super::create
this.dw_impression_etiquette=create dw_impression_etiquette
this.p_1=create p_1
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_impression_etiquette
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_toolbar
this.Control[iCurrent+5]=this.uo_toolbar_gauche
this.Control[iCurrent+6]=this.rr_1
this.Control[iCurrent+7]=this.rr_2
end on

on w_impression_etiquette.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_impression_etiquette)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar_gauche)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar_gauche.POST of_displaytext(true)

dw_impression_etiquette.insertrow(0)
end event

event pfc_postopen;call super::pfc_postopen;string ls_imprimantes, ls_listeimps[], ls_defaut, ls_imptmp
long ll_imp, ll_nbimps

ls_imprimantes = printGetPrinters()
ls_defaut = printGetPrinter()

ll_nbimps = gnv_app.inv_string.of_parsetoarray(ls_imprimantes, '~n', ls_listeimps)
ls_imprimantes = ''

for ll_imp = 1 to ll_nbimps
	ls_imptmp = left(ls_listeimps[ll_imp], pos(ls_listeimps[ll_imp], '~t') - 1)
	ls_imprimantes += ls_imptmp + '~t' + ls_imptmp + '/'
next

if ls_imprimantes <> '' then ls_imprimantes = left(ls_imprimantes, len(ls_imprimantes) - 1)

dw_impression_etiquette.modify("printer.values='" + ls_imprimantes + "'")

// S'il y a une imprimante par d$$HEX1$$e900$$ENDHEX$$faut, la s$$HEX1$$e900$$ENDHEX$$lectionner
if ls_defaut <> '' then dw_impression_etiquette.object.printer[1] = left(ls_defaut, pos(ls_defaut, '~t') - 1)//rep(rep(ls_defaut, '~t', '|'), "'", "~~'")
end event

type dw_impression_etiquette from u_dw within w_impression_etiquette
integer x = 55
integer y = 252
integer width = 1111
integer height = 636
integer taborder = 10
string dataobject = "d_impression_etiquette"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;long	ll_nbpages
choose case dwo.name
		
	case "nb_pages"
		IF IsNull(data) THEN
			this.object.st_page.text = "Aucune $$HEX1$$e900$$ENDHEX$$tiquette"
		ELSE
			ll_nbpages = long(data) * 22
			
			this.object.st_page.text = "Pages pour : " + string(ll_nbpages) + " $$HEX1$$e900$$ENDHEX$$tiquettes"
		END IF		
		
END CHOOSE
end event

type p_1 from picture within w_impression_etiquette
integer x = 64
integer y = 36
integer width = 151
integer height = 128
string picturename = "C:\ii4net\CIPQ\images\listview_column.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_impression_etiquette
integer x = 251
integer y = 60
integer width = 914
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Impression d~'$$HEX1$$e900$$ENDHEX$$tiquettes"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_impression_etiquette
event destroy ( )
integer x = 690
integer y = 936
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_impression_etiquette
event destroy ( )
integer x = 18
integer y = 936
integer width = 507
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_code_verrat, ls_tatouage, ls_nom, ls_no_enr, ls_code_race, ls_sql, ls_cieno
long		ll_nb_pages, ll_nb_enreg, ll_cpt, ll_nb_row

dw_impression_etiquette.AcceptText()

ls_code_verrat = upper(dw_impression_etiquette.object.code_verrat[1])
ll_nb_pages = dw_impression_etiquette.object.nb_pages[1] 

IF IsNull(ls_code_verrat) THEN
	gnv_app.inv_error.of_message("CIPQ0130")
	RETURN
END IF

IF IsNull(ll_nb_pages) THEN
	gnv_app.inv_error.of_message("CIPQ0131")
	RETURN
END IF

SetPointer(HourGlass!)
//Effacer les donn$$HEX1$$e900$$ENDHEX$$es de la table
select count(1) into :ll_nb_row from #Tmp_PrintEtiquettes;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_PrintEtiquettes (cie_no varchar(3) not null,~r~n" + &
	                                            "CodeVerrat varchar(255) null,~r~n" + &
															  "Nom varchar(255) null,~r~n" + &
															  "Tatouage varchar(255) null,~r~n" + &
															  "CodeRace varchar(255) null,~r~n" + &
															  "NoReg varchar(255) null)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_PrintEtiquettes;
	commit using sqlca;
end if

//R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les valeurs
SELECT	cie_no, Nom, Tatouage, VraiRace, no_enreg
INTO		:ls_cieno, :ls_nom, :ls_tatouage, :ls_code_race, :ls_no_enr
FROM 		t_verrat
WHERE		upper(codeverrat) = :ls_code_verrat ;

//Pr$$HEX1$$e900$$ENDHEX$$parer la table
ll_nb_enreg = ll_nb_pages * 22

FOR ll_cpt = 1 TO ll_nb_enreg
	INSERT INTO #Tmp_PrintEtiquettes (cie_no,CodeVerrat, Nom, Tatouage, CodeRace, NoReg)
	VALUES	(:ls_cieno, :ls_code_verrat, :ls_nom, :ls_tatouage, :ls_code_race, :ls_no_enr) USING SQLCA;
END FOR

COMMIT USING SQLCA;

//Ouvrir le rapport
//w_r_etiquette_verrat	lw_sheet
//OpenSheet(lw_sheet, gnv_app.of_GetFrame(), 6, layered!)

//Chang$$HEX2$$e9002000$$ENDHEX$$pour impression directe
datastore		lds_etiquette

lds_etiquette = CREATE n_ds
lds_etiquette.dataobject = "d_r_etiquette_verrat_nup2"
lds_etiquette.setTransobject(SQLCA)
ll_nb_row = lds_etiquette.Retrieve()

lds_etiquette.Object.Datawindow.Print.Margin.Top = 0
lds_etiquette.Object.Datawindow.Print.Margin.Left = 0
lds_etiquette.Object.Datawindow.Print.Margin.Bottom = 0
lds_etiquette.Object.Datawindow.Print.Margin.Right = 0
lds_etiquette.Object.Datawindow.Print.PrinterName = dw_impression_etiquette.object.printer[1]

SetPointer(HourGlass!)
lds_etiquette.print(false,false)

IF IsValid(lds_etiquette) THEN Destroy(lds_etiquette)
end event

type rr_1 from roundrectangle within w_impression_etiquette
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 212
integer width = 1179
integer height = 692
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_impression_etiquette
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 1179
integer height = 172
integer cornerheight = 40
integer cornerwidth = 46
end type

