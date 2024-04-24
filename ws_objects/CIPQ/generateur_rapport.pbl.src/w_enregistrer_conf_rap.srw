$PBExportHeader$w_enregistrer_conf_rap.srw
$PBExportComments$Fenêtre pour enregistrer les tris
forward
global type w_enregistrer_conf_rap from w_response
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_enregistrer_conf_rap
end type
type uo_toolbar from u_cst_toolbarstrip within w_enregistrer_conf_rap
end type
type pb_aide from u_pb within w_enregistrer_conf_rap
end type
type dw_liste_conf from u_dw within w_enregistrer_conf_rap
end type
type cb_ok from u_cb within w_enregistrer_conf_rap
end type
type cb_annuler from u_cb within w_enregistrer_conf_rap
end type
type sle_nom_conf from u_sle within w_enregistrer_conf_rap
end type
type ddlb_type from u_ddlb within w_enregistrer_conf_rap
end type
type st_type_t from statictext within w_enregistrer_conf_rap
end type
type st_nom_t from statictext within w_enregistrer_conf_rap
end type
type rr_1 from roundrectangle within w_enregistrer_conf_rap
end type
end forward

global type w_enregistrer_conf_rap from w_response
integer width = 2231
integer height = 1272
string title = "Enregistrer une personnalisation"
long backcolor = 15780518
event ue_ok ( )
event ue_annuler ( )
uo_toolbar2 uo_toolbar2
uo_toolbar uo_toolbar
pb_aide pb_aide
dw_liste_conf dw_liste_conf
cb_ok cb_ok
cb_annuler cb_annuler
sle_nom_conf sle_nom_conf
ddlb_type ddlb_type
st_type_t st_type_t
st_nom_t st_nom_t
rr_1 rr_1
end type
global w_enregistrer_conf_rap w_enregistrer_conf_rap

type variables
n_ds 								ids_sauv_detail

w_selectionner_champs_rapport_simple				iw_param

String 							is_types_ddlb[]
end variables

forward prototypes
public subroutine of_click ()
public function long of_recuperercriteres (long al_rangee)
public subroutine of_chargerddlb (string as_no_menu_win)
end prototypes

event ue_ok();//////////////////////////////////////////////////////////////////////////////
//
//	Évenement:  	ue_ok
//
//	Accès:  			Public
//
//	Argument:		aucun
//
//	Retourne:  		rien
//
//	Description:	Sauvegarde les criteres dans la BD
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string	ls_nom_conf, ls_type, ls_nom_rapport, ls_usager, ls_type_conf, &
			ls_code_syst, ls_login, ls_nom_col, ls_titre
long		ll_debug, ll_nb_ligne, ll_compteur, ll_nbrangees, ll_pos, ll_no_rapport
int		li_idx, li_question, li_loop, li_rangee, li_orientation, li_format
boolean	lb_existe = FALSE
date		ld_date
dec		ldec_taille

SetPointer(HourGlass!)

ls_code_syst = gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("Code application", FALSE)
ls_login = gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("Login usager", FALSE)

//Obtient le nom de la sauvegarde
sle_nom_conf.Text = TRIM(sle_nom_conf.Text)
ls_nom_conf = sle_nom_conf.Text

//Vérifier s'il y a un caractère :
ll_pos = POS(ls_nom_conf, ":")
IF ll_pos > 0 THEN 
	gnv_app.inv_Error.of_Message("PRO0002")
	sle_nom_conf.SetFocus()
	RETURN
ELSE
	ll_pos = POS(ls_nom_conf, "/")
	IF ll_pos > 0 THEN 
		gnv_app.inv_Error.of_Message("PRO0002")
		sle_nom_conf.SetFocus()
		RETURN
	END IF
END IF

//Vérifie s'il y a un nom
IF ls_nom_conf = "" OR IsNull(ls_nom_conf) THEN
	gnv_app.inv_Error.of_Message("PRO0003")
	sle_nom_conf.SetFocus()
	RETURN
END IF

ls_nom_rapport = iw_param.inv_param.is_dw_source

li_idx =  ddlb_type.FindItem( ddlb_type.Text, 0 ) 
ls_type = is_types_ddlb[li_idx]

ll_nb_ligne = dw_liste_conf.RowCount()

//Vérification si cette config existe déjà (même nom)
FOR ll_compteur = 1 TO ll_nb_ligne
	IF dw_liste_conf.Object.nom_sauv_rapport_simple[ll_compteur] = sle_nom_conf.text AND &
	ls_type = dw_liste_conf.Object.type_sauv_rapport_simple[ll_compteur] THEN
		
		li_question = gnv_app.inv_error.of_Message("PRO0004")
		IF li_question = 2 THEN //Ne veut pas l'écraser
			sle_nom_conf.SetFocus()
			sle_nom_conf.SelectText(1,Len(sle_nom_conf.Text))
			RETURN
		ELSE
			lb_existe = TRUE
			EXIT
		END IF
		
	END IF
NEXT

IF ls_type = "SP" THEN
	ls_usager = gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("Login usager", FALSE)
ELSE
	SetNull(ls_usager)
END IF

ls_titre = iw_param.sle_titre.text 
ld_date = today()
IF iw_param.rb_portrait.checked = TRUE THEN
	li_orientation = 1
ELSE
	li_orientation = 2
END IF

IF iw_param.rb_811.checked = TRUE THEN
	li_format = 1
ELSE
	li_format = 2
END IF

IF lb_existe = FALSE THEN
	
	//Récupérer le no max des rapports simples
	SELECT max(no_rapport) 
	INTO :ll_no_rapport
	FROM SAUV_RAPPORT_SIMPLE
	USING SQLCA;
	
	IF IsNull(ll_no_rapport) THEN
		ll_no_rapport = 1
	ELSE
		ll_no_rapport++
	END IF


	//insert de la recherche	
	INSERT INTO SAUV_RAPPORT_SIMPLE  
	( no_rapport,
	  code_syst,   
	  rapport_simple, 
	  type_sauv_rapport_simple,
	  nom_sauv_rapport_simple, 
	  login_usager,
	  date_creation,
	  titre,   
	  orientation,
	  format_papier )  
	VALUES ( :ll_no_rapport, 
	  :ls_code_syst,   
	  :ls_nom_rapport,   
	  :ls_type,
	  :ls_nom_conf,
	  :ls_usager,   
	  :ld_date,
	  :ls_titre,
	  :li_orientation,
	  :li_format)  
	USING SQLCA;
	
	IF SQLCA.SQLCODE < 0 THEN
		gnv_app.inv_error.of_message("PRO0005", {SQLCA.SQLReturnData, SQLCA.SQLErrText})
		RETURN
	END IF

	
ELSE
	
	UPDATE 	SAUV_RAPPORT_SIMPLE SET titre = :ls_titre, 
				orientation = :li_orientation,
				format_papier = :li_format, 
				date_creation = :ld_date
	WHERE 	SAUV_RAPPORT_SIMPLE.code_syst = :ls_code_syst AND   
			   SAUV_RAPPORT_SIMPLE.rapport_simple = :ls_nom_rapport AND
				SAUV_RAPPORT_SIMPLE.type_sauv_rapport_simple = :ls_type AND
			   SAUV_RAPPORT_SIMPLE.login_usager = :ls_usager AND
			   SAUV_RAPPORT_SIMPLE.nom_sauv_rapport_simple = :ls_nom_conf
	USING SQLCA;

	IF SQLCA.SQLCODE < 0 THEN
		gnv_app.inv_error.of_message("PRO0005", {SQLCA.SQLReturnData, SQLCA.SQLErrText})
		RETURN
	END IF

	//destruction des anciens tris - regroupements
	ll_nbrangees = THIS.of_RecupererCriteres(ll_compteur)
	
	FOR ll_compteur = 1 TO ll_nbrangees 
		ids_sauv_detail.DeleteRow( 1 )
		
		//Rendre effectif les changements de TRI_GROUPE_LIGNE
		ll_debug = ids_sauv_detail.Update(TRUE, TRUE)
		
		Commit using SQLCA;
		IF SQLCA.SQLCODE < 0 THEN
			gnv_app.inv_error.of_message("PRO0005", {SQLCA.SQLReturnData, SQLCA.SQLErrText})
			RETURN
		END IF

		
	NEXT
	
END IF

//Vider la liste de criteres
ids_sauv_detail.Reset()

IF ls_type = "SP" THEN
	ls_type_conf = "personnelle"
ELSE
	ls_type_conf = "générale"
END IF

FOR li_rangee = 1 TO iw_param.dw_dropped.RowCount()
	
	ls_nom_col = iw_param.dw_dropped.Object.colonne[li_rangee]
	ldec_taille = iw_param.dw_dropped.Object.taille[li_rangee]
	
	INSERT INTO SAUV_RAPPORT_SIMPLE_DETAIL  
	VALUES (
		:ls_code_syst,   
		:ls_nom_rapport,   
		:ls_type,
		:ls_nom_conf, 
		:ls_usager,
		:li_rangee,
		:ls_nom_col,
		:ldec_taille
	) USING SQLCA;
	
	IF SQLCA.SQLCODE < 0 THEN
		gnv_app.inv_error.of_message("PRO0005", {SQLCA.SQLReturnData, SQLCA.SQLErrText})
		RETURN
	END IF
	
END FOR

iw_param.is_nom_conf = ls_nom_conf
iw_param.is_type_conf = ls_type_conf
iw_param.ib_conf_enr_modifie = FALSE
iw_param.title = "Impression d'un rapport simple - " + ls_nom_conf + " (" + ls_type_conf + ")"

Close(This)
end event

event ue_annuler;//Fermer la fenetre
Close(This)
end event

public subroutine of_click ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_Click
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
//	Description:	Fonction lancée lors du click d'une rangée (popule les
//						champs du haut)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string	ls_nom, ls_type
long		ll_row

ll_row = dw_liste_conf.GetRow()

IF ll_row > 0 THEN
	ls_nom = dw_liste_conf.GetItemString( ll_row, "nom_sauv_rapport_simple" )
	ls_type = dw_liste_conf.Describe( &
		"evaluate('lookupdisplay(type_sauv_rapport_simple)'," &
			+ string( ll_row ) + ")" )

	sle_nom_conf.text = ls_nom
	IF ddlb_type.FindItem( ls_type, 0 )  >= 0 THEN
		ddlb_type.Text = ls_type
	ELSE
		dw_liste_conf.SelectRow( 0, FALSE )
	END IF
	sle_nom_conf.SetFocus()
	sle_nom_conf.SelectText(1,Len(sle_nom_conf.Text))
	
END IF
end subroutine

public function long of_recuperercriteres (long al_rangee);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_RecupererCriteres
//
//	Accès:  			Public
//
//	Argument:		al_rangee - rangée à retriever les critères
//
//	Retourne:  		nb de rangees criteres trouvées
//
//	Description:	Fonction pour charger les critères de la recherche 
//						sélectionnées
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

long		ll_nbrangee
string	ls_rapport, ls_type_conf, ls_nom_conf

ls_nom_conf = dw_liste_conf.GetItemString( al_rangee, "nom_sauv_rapport_simple" )
ls_type_conf = dw_liste_conf.GetItemString( al_rangee, "type_sauv_rapport_simple" )

ls_rapport = iw_param.inv_param.is_dw_source

ll_nbrangee = ids_sauv_detail.Retrieve( gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("Code application", FALSE), &
 ls_rapport, & 
 ls_type_conf, &
 ls_nom_conf, &
 gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("Login usager", FALSE))
 
RETURN ll_nbrangee
end function

public subroutine of_chargerddlb (string as_no_menu_win);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_chargerddlb 
//
//	Accès:  			Public
//
//	Argument:		as_no_menu_win - numéro menu
//
//	Retourne:  		rien
//
//	Description:	Rempli le ddlb avec les modes correspondants
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////


ddlb_type.Reset()

//RU
ddlb_type.AddItem( "Personnelle" )
is_types_ddlb[1] = "SP"

//RS
IF gnv_app.ib_administrateur = TRUE THEN
	ddlb_type.AddItem( "Générale" )
	is_types_ddlb[2] = "SG"
END IF

RETURN
end subroutine

on w_enregistrer_conf_rap.create
int iCurrent
call super::create
this.uo_toolbar2=create uo_toolbar2
this.uo_toolbar=create uo_toolbar
this.pb_aide=create pb_aide
this.dw_liste_conf=create dw_liste_conf
this.cb_ok=create cb_ok
this.cb_annuler=create cb_annuler
this.sle_nom_conf=create sle_nom_conf
this.ddlb_type=create ddlb_type
this.st_type_t=create st_type_t
this.st_nom_t=create st_nom_t
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar2
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.pb_aide
this.Control[iCurrent+4]=this.dw_liste_conf
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_annuler
this.Control[iCurrent+7]=this.sle_nom_conf
this.Control[iCurrent+8]=this.ddlb_type
this.Control[iCurrent+9]=this.st_type_t
this.Control[iCurrent+10]=this.st_nom_t
this.Control[iCurrent+11]=this.rr_1
end on

on w_enregistrer_conf_rap.destroy
call super::destroy
destroy(this.uo_toolbar2)
destroy(this.uo_toolbar)
destroy(this.pb_aide)
destroy(this.dw_liste_conf)
destroy(this.cb_ok)
destroy(this.cb_annuler)
destroy(this.sle_nom_conf)
destroy(this.ddlb_type)
destroy(this.st_type_t)
destroy(this.st_nom_t)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;string 	ls_rapport, ls_type_conf
long		ll_ligne
boolean	lb_trouve = FALSE

This.SetRedraw(False)

dw_liste_conf.Event Pfc_Retrieve( )

ls_rapport = iw_param.inv_param.is_dw_source

THIS.of_chargerddlb( ls_rapport )

dw_liste_conf.SelectRow ( 1, FALSE )

IF iw_param.is_nom_conf = "" THEN
	
	ddlb_type.SelectItem( ddlb_type.TotalItems())

	sle_nom_conf.text = iw_param.sle_titre.Text
	sle_nom_conf.SelectText(1,LEN(iw_param.sle_titre.Text))
	
ELSE
	IF iw_param.is_type_conf = "personnelle" THEN
		ls_type_conf = "SP"
	ELSE
		ls_type_conf = "SG"
	END IF	
	
	//Resauvegarde d'une recherche après modification
	//Trouver la bonne ligne
	FOR ll_ligne = 1 TO dw_liste_conf.RowCount()
		IF dw_liste_conf.object.nom_sauv_rapport_simple[ll_ligne] = iw_param.is_nom_conf AND &
			dw_liste_conf.object.type_sauv_rapport_simple[ll_ligne] = ls_type_conf THEN
			IF ddlb_type.FindItem( iw_param.is_type_conf, 0 )  >= 0 THEN
				dw_liste_conf.SelectRow ( ll_ligne, TRUE )
				dw_liste_conf.SetRow(ll_ligne)
				THIS.of_click()
				lb_trouve = TRUE
				EXIT
			ELSE
				ddlb_type.SelectItem( ddlb_type.TotalItems())
				lb_trouve = TRUE
				EXIT
			END IF
		END IF
	NEXT
	
	IF lb_trouve = FALSE THEN
		IF iw_param.is_nom_conf <> "" THEN
		
			sle_nom_conf.text = iw_param.is_nom_conf
			IF ddlb_type.FindItem( iw_param.is_type_conf, 0 )  >= 0 THEN
				ddlb_type.Text = iw_param.is_type_conf
			ELSE
				ddlb_type.SelectItem( ddlb_type.TotalItems())
			END IF
					
		END IF
	END IF
	
END IF

sle_nom_conf.POST SetFocus()

This.SetRedraw(True)

uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar2.POST of_displaytext(true)
end event

event close;call super::close;If IsValid(ids_sauv_detail) Then Destroy ids_sauv_detail
end event

event pfc_preopen;call super::pfc_preopen;//Obtient la datawindow en parametres
iw_param = Message.PowerObjectParm

//this.inv_base.of_Center()

ids_sauv_detail = create n_ds
ids_sauv_detail.dataobject = "d_liste_sauv_rap_detail"

dw_liste_conf.SetTransObject( SQLCA )
ids_sauv_detail.SetTransObject( SQLCA )

dw_liste_conf.POST SetFocus()
end event

type uo_toolbar2 from u_cst_toolbarstrip within w_enregistrer_conf_rap
event destroy ( )
integer x = 1664
integer y = 1052
integer width = 507
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;PARENT.cb_annuler.Event Clicked()
end event

type uo_toolbar from u_cst_toolbarstrip within w_enregistrer_conf_rap
event destroy ( )
integer x = 1115
integer y = 1052
integer width = 507
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;PARENT.cb_ok.Event Clicked()
end event

type pb_aide from u_pb within w_enregistrer_conf_rap
integer x = 55
integer y = 1248
integer width = 96
integer taborder = 30
boolean bringtotop = true
string text = ""
boolean originalsize = false
string picturename = "aide.bmp"
string disabledname = "aide_dis.bmp"
string powertiptext = "Afficher l~'aide sur l~'enregistrement de tris / regroupements"
end type

event clicked;call super::clicked;Run("hh " + gnv_app.of_GetHelpFile() + "::/04.02%20Enregistrer%20rapport%20personnalise.htm",Normal!)
end event

type dw_liste_conf from u_dw within w_enregistrer_conf_rap
integer x = 87
integer y = 264
integer width = 2030
integer height = 708
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_liste_sauv_rap"
boolean border = true
end type

event constructor;call super::constructor;This.of_SetSort(True)

inv_sort.of_Setstyle(INV_SORT.SIMPLE)
inv_sort.of_Setcolumndisplaynamestyle(INV_SORT.HEADER)
inv_sort.of_Setcolumnheader(True)

THIS.SetRowFocusIndicator(Off!)
THIS.of_SetRowSelect(TRUE)
This.of_SetRowManager(True)


end event

event pfc_retrieve;call super::pfc_retrieve;string	ls_rapport

ls_rapport = iw_param.inv_param.is_dw_source

RETURN dw_liste_conf.Retrieve( gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("Code application", FALSE), &
	ls_rapport, gnv_app.inv_EntrepotGlobal.of_RetourneDonnee("login usager", FALSE))
	
end event

event rbuttonup;//
end event

event clicked;call super::clicked;Parent.of_Click()
end event

event doubleclicked;call super::doubleclicked;IF row = 0 THEN RETURN

parent.of_Click()

parent.POST EVENT ue_ok()
end event

type cb_ok from u_cb within w_enregistrer_conf_rap
integer x = 1051
integer y = 1276
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "&Enregistrer"
boolean default = true
end type

event clicked;call super::clicked;Parent.TriggerEvent("ue_ok")
end event

type cb_annuler from u_cb within w_enregistrer_conf_rap
integer x = 1454
integer y = 1272
integer taborder = 50
boolean bringtotop = true
string text = "Annuler"
boolean cancel = true
end type

event clicked;call super::clicked;Parent.TriggerEvent("ue_annuler")
end event

type sle_nom_conf from u_sle within w_enregistrer_conf_rap
integer x = 87
integer y = 144
integer width = 978
integer height = 84
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean autohscroll = true
integer limit = 40
end type

event modified;call super::modified;dw_liste_conf.SelectRow( dw_liste_conf.GetRow(), FALSE )
end event

type ddlb_type from u_ddlb within w_enregistrer_conf_rap
integer x = 1074
integer y = 144
integer width = 370
integer height = 312
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 1090519039
string text = "Recherche Usager"
boolean sorted = false
end type

event selectionchanged;call super::selectionchanged;dw_liste_conf.SelectRow( dw_liste_conf.GetRow(), FALSE )
end event

type st_type_t from statictext within w_enregistrer_conf_rap
integer x = 1074
integer y = 64
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "Type"
boolean focusrectangle = false
end type

type st_nom_t from statictext within w_enregistrer_conf_rap
integer x = 87
integer y = 64
integer width = 718
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "Nom de la personnalisation"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_enregistrer_conf_rap
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 1073741824
integer x = 32
integer y = 28
integer width = 2144
integer height = 984
integer cornerheight = 40
integer cornerwidth = 46
end type

