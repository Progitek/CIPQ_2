$PBExportHeader$w_selectionner_champs_rapport_simple.srw
forward
global type w_selectionner_champs_rapport_simple from w_response
end type
type uo_toolbar from u_cst_toolbarstrip within w_selectionner_champs_rapport_simple
end type
type cb_1 from commandbutton within w_selectionner_champs_rapport_simple
end type
type dw_apercu from u_dw within w_selectionner_champs_rapport_simple
end type
type shl_2 from statichyperlink within w_selectionner_champs_rapport_simple
end type
type p_2 from u_picturebutton within w_selectionner_champs_rapport_simple
end type
type p_1 from u_picturebutton within w_selectionner_champs_rapport_simple
end type
type shl_1 from statichyperlink within w_selectionner_champs_rapport_simple
end type
type dw_dropped from u_dw within w_selectionner_champs_rapport_simple
end type
type rb_814 from u_rb within w_selectionner_champs_rapport_simple
end type
type rb_811 from u_rb within w_selectionner_champs_rapport_simple
end type
type sle_titre from u_sle within w_selectionner_champs_rapport_simple
end type
type st_2 from u_st within w_selectionner_champs_rapport_simple
end type
type rb_paysage from u_rb within w_selectionner_champs_rapport_simple
end type
type rb_portrait from u_rb within w_selectionner_champs_rapport_simple
end type
type dw_selection from u_dw within w_selectionner_champs_rapport_simple
end type
type gb_1 from u_gb within w_selectionner_champs_rapport_simple
end type
type gb_2 from u_gb within w_selectionner_champs_rapport_simple
end type
type gb_3 from u_gb within w_selectionner_champs_rapport_simple
end type
type gb_6 from u_gb within w_selectionner_champs_rapport_simple
end type
type gb_5 from u_gb within w_selectionner_champs_rapport_simple
end type
type gb_apercu from u_gb within w_selectionner_champs_rapport_simple
end type
type rr_1 from roundrectangle within w_selectionner_champs_rapport_simple
end type
end forward

global type w_selectionner_champs_rapport_simple from w_response
string tag = "exclure_securite"
integer x = 214
integer y = 221
integer width = 4471
integer height = 2480
string title = "Impression d~'une liste simple"
long backcolor = 15780518
uo_toolbar uo_toolbar
cb_1 cb_1
dw_apercu dw_apercu
shl_2 shl_2
p_2 p_2
p_1 p_1
shl_1 shl_1
dw_dropped dw_dropped
rb_814 rb_814
rb_811 rb_811
sle_titre sle_titre
st_2 st_2
rb_paysage rb_paysage
rb_portrait rb_portrait
dw_selection dw_selection
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_6 gb_6
gb_5 gb_5
gb_apercu gb_apercu
rr_1 rr_1
end type
global w_selectionner_champs_rapport_simple w_selectionner_champs_rapport_simple

type variables
n_cst_param_rapport_simple inv_param

string is_nom_conf = ""
string is_type_conf = ""
boolean ib_conf_enr_modifie = FALSE

string is_syntaxe_initiale = ""

long	il_rendu = 0

string is_type_from_menu = ""
end variables

forward prototypes
public function integer of_calcul_taille_max ()
public function integer of_valide_taille ()
public function integer of_ajouter_colonne (string as_colonne, string as_texte, decimal adec_taille)
public function integer of_changer_apercu ()
public function integer of_ajouter_dropped ()
public subroutine of_enleverdropped ()
end prototypes

public function integer of_calcul_taille_max ();long ll_rangee
ll_rangee = dw_dropped.getrow()
dw_dropped.accepttext()
IF ll_rangee > 0 THEN
	IF rb_portrait.checked THEN 
		dw_dropped.object.taille_max[1] = 19.600
	ELSE
		IF rb_811.checked THEN
			dw_dropped.object.taille_max[1] = 26.300
		ELSE
			dw_dropped.object.taille_max[1] = 33.900
		END IF 
	END IF 
END IF 


RETURN 1
end function

public function integer of_valide_taille ();RETURN 1
end function

public function integer of_ajouter_colonne (string as_colonne, string as_texte, decimal adec_taille);String 	ls_column_syntax, ls_text_syntax, ls_dw_syntax, ls_new_dw_syntax, &
			ls_x, ls_evaluate, ls_colonne, ls_mod = ""
long 		ll_column_datawindow, ll_acc, ll_acc2, ll_rtn, ll_rendu, ll_nb_rangees
decimal 	ldec_taille

ldec_taille = adec_taille * 1000

//ls_sql_limit = "set rowcount 10"
//EXECUTE IMMEDIATE :ls_sql_limit USING SQLCA;

//Get the current datawindow syntax
ls_dw_syntax = dw_apercu.Describe('Datawindow.syntax')
IF is_syntaxe_initiale = "" THEN
	is_syntaxe_initiale = ls_dw_syntax
END IF

ll_column_datawindow = long(dw_apercu.Object.DataWindow.Column.Count)

Long ll_table_begin_pos, ll_table_end_pos
ll_table_begin_pos = pos(ls_dw_syntax, 'text(', 1)

If ll_table_begin_pos = 0 Then
	 ll_table_begin_pos = pos(ls_dw_syntax, 'table(', 1)
	 ls_new_dw_syntax = left(ls_dw_syntax, ll_table_begin_pos + len('table')) + 'column=(type=char(50) updatewhereclause=yes name=' + as_colonne + ' dbname="' + as_colonne + '" )' + right(ls_dw_syntax, len(ls_dw_syntax) - ll_table_begin_pos - len('table'))
Else
	 ls_new_dw_syntax = left(ls_dw_syntax, ll_table_begin_pos - len('text') ) + 'column=(type=char(50) updatewhereclause=yes name=' + as_colonne + ' dbname="' + as_colonne + '" )' + right(ls_dw_syntax, len(ls_dw_syntax) - ll_table_begin_pos + len('text'))
End If
dw_apercu.create( ls_new_dw_syntax)

// Prendre le X et le Y de la plus éloigné des colonnes.
ls_colonne = dw_apercu.describe('#' + string(ll_column_datawindow) + ".name")
IF ll_column_datawindow = 0 THEN
	ls_x = '4'
ELSE
	ls_x = string(long(dw_apercu.Describe(ls_colonne + ".X")) + long(dw_apercu.Describe(ls_colonne + ".width"))) 
END IF 

ls_column_syntax = '' + &
'column(' + &
'band=detail id=' + string(ll_column_datawindow + 1) + ' alignment="0" tabsequence=1 border="0" ' + &
'color="0" x="' + ls_x + '" y="4" height="423" width="' +string(ldec_taille) + '"  ' + &
'name=' + as_colonne + ' ' + &
' font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" ' + &
'background.mode="1" background.color="553648127" edit.displayonly=yes protect="0~t1")'
dw_apercu.modify('create ' + ls_column_syntax )

ls_text_syntax = '' + &
'text(' + &
'band=header alignment="0" text="' + as_texte + '" border="6" ' + &
'name=' + as_colonne + '_t ' + &
'color="33554432" x="'+ ls_x +  '" y="8" height="500" width="' +string(ldec_taille) + '"  ' + &
'font.face="Arial" font.height="-10" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" ' + &
'background.mode="2" background.color="16777215" )'
dw_apercu.modify('create ' + ls_text_syntax)

For ll_acc = 1 to dw_dropped.rowcount()
	If dw_dropped.object.colonne_db[ll_acc] = as_colonne THEN
		dw_dropped.object.x[ll_acc] = long(ls_x)
		EXIT
	END IF 
next

// faire un minirafraichir de données pour la présentation
n_ds lds_datawindow

lds_datawindow = CREATE n_ds
lds_datawindow.dataobject = inv_param.is_dw_source
lds_datawindow.settransobject(SQLCA)

// 2010-04-16 - Sébastien - limiter autrement le nombre de rangées parce que ça limitait aussi les dddw
ll_nb_rangees = lds_datawindow.retrieve()
IF ll_nb_rangees > 0 THEN
	if ll_nb_rangees > 10 then ll_nb_rangees = 10
	For ll_acc = 1 to ll_nb_rangees
		ll_rtn = dw_apercu.insertrow(0)
		IF il_rendu = 0 THEN
			ll_rendu = dw_dropped.rowcount()
		ELSE
			ll_rendu = il_rendu
		END IF
			
		For ll_acc2 = 1 to ll_rendu
			ls_colonne =dw_dropped.object.colonne_db[ll_acc2]
			
			IF string( lds_datawindow.Describe( ls_colonne + ".Checkbox.3D" )) = "yes" THEN
				ls_mod +=		ls_colonne + '.Checkbox.3D="Yes"'
				ls_mod +=	ls_colonne + '.Values="' + lds_datawindow.Describe( ls_colonne + ".Values" ) + '"' 
				ls_mod +=	ls_colonne + ".alignment='2'"
			END IF
			
			
			ls_evaluate = lds_datawindow.describe("Evaluate('lookupdisplay(" + ls_colonne +")'," + string(ll_acc) + ")")
			IF ls_evaluate <> "!" THEN 
				dw_apercu.SetItem(ll_rtn,ls_colonne, ls_evaluate)
			ELSE
				dw_apercu.SetItem(ll_rtn,ls_colonne, "Évaluation erronée")
			END IF 
		next
	next
END IF 
IF IsValid(lds_datawindow) THEN Destroy lds_datawindow

dw_apercu.Modify(ls_mod)

dw_apercu.SetPosition(ToTop!)

//ls_sql_limit = "set rowcount 0"
//EXECUTE IMMEDIATE :ls_sql_limit USING SQLCA;

Return 0
end function

public function integer of_changer_apercu ();long ll_acc, ll_acc2
string ls_name
For ll_acc = 1 to long(dw_apercu.Object.DataWindow.Column.Count)
	ls_name = dw_apercu.Describe("#" + string(ll_acc) + ".name")
	For ll_acc2 = 1 to dw_dropped.rowcount()
		IF ls_name = dw_dropped.object.colonne_db[ll_acc2] THEN
			dw_dropped.object.taille[ll_acc2] = dec(dw_apercu.Describe(ls_name + ".Width"))/1000			
			dw_dropped.object.x[ll_acc2] =  long(dw_apercu.Describe(ls_name + ".X"))
			EXIT
		END IF 
	next
next 

dw_dropped.sort()

IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	THIS.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF

RETURN 1
end function

public function integer of_ajouter_dropped ();long ll_acc, ll_rangee_selection, ll_rtn
boolean lb_ok = TRUE
ll_rangee_selection = dw_selection.getrow()
	
For ll_acc = 1 to dw_dropped.rowcount()
	IF dw_dropped.object.colonne_db[ll_acc] = dw_selection.object.colonne_db[ll_rangee_selection] THEN
		lb_ok = false
	END IF 
next 
IF lb_ok THEN 
	ll_rtn = dw_dropped.insertrow(0)
	dw_dropped.object.colonne[ll_rtn] = dw_selection.object.colonne[ll_rangee_selection]
	dw_dropped.object.colonne_db[ll_rtn] = dw_selection.object.colonne_db[ll_rangee_selection]
	dw_dropped.object.taille[ll_rtn] = 3.000		
	THIS.SetRedraw(FALSE)
	of_ajouter_colonne(dw_dropped.object.colonne_db[ll_rtn],dw_dropped.object.colonne[ll_rtn],3.000)
	THIS.SetRedraw(TRUE)
	
	IF is_nom_conf <> "" THEN
		ib_conf_enr_modifie = TRUE
		THIS.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
	END IF	
	
END IF 

IF dw_selection.getrow() <> dw_selection.rowcount() THEN 
	dw_selection.inv_rowselect.of_rowselect(dw_selection.getrow() + 1)
END IF 



of_calcul_taille_max()
RETURN 1
end function

public subroutine of_enleverdropped ();long ll_rangee_selection, ll_rtn, ll_cpt

ll_rangee_selection = dw_dropped.getrow()
	
ll_rtn = dw_dropped.deleterow(ll_rangee_selection)

IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	THIS.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF

//Rafraichir l'aperçu
THIS.SetRedraw(FALSE)
dw_apercu.create( is_syntaxe_initiale)

FOR ll_cpt = 1 TO dw_dropped.RowCount()
	il_rendu = ll_cpt
	THIS.of_ajouter_colonne(dw_dropped.object.colonne_db[ll_cpt],dw_dropped.object.colonne[ll_cpt],dw_dropped.object.taille[ll_cpt])
END FOR
il_rendu = 0
dw_apercu.SetPosition(ToTop!)
THIS.SetRedraw(TRUE)

THIS.of_calcul_taille_max()
end subroutine

on w_selectionner_champs_rapport_simple.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.cb_1=create cb_1
this.dw_apercu=create dw_apercu
this.shl_2=create shl_2
this.p_2=create p_2
this.p_1=create p_1
this.shl_1=create shl_1
this.dw_dropped=create dw_dropped
this.rb_814=create rb_814
this.rb_811=create rb_811
this.sle_titre=create sle_titre
this.st_2=create st_2
this.rb_paysage=create rb_paysage
this.rb_portrait=create rb_portrait
this.dw_selection=create dw_selection
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_apercu=create gb_apercu
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_apercu
this.Control[iCurrent+4]=this.shl_2
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.shl_1
this.Control[iCurrent+8]=this.dw_dropped
this.Control[iCurrent+9]=this.rb_814
this.Control[iCurrent+10]=this.rb_811
this.Control[iCurrent+11]=this.sle_titre
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.rb_paysage
this.Control[iCurrent+14]=this.rb_portrait
this.Control[iCurrent+15]=this.dw_selection
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_6
this.Control[iCurrent+20]=this.gb_5
this.Control[iCurrent+21]=this.gb_apercu
this.Control[iCurrent+22]=this.rr_1
end on

on w_selectionner_champs_rapport_simple.destroy
call super::destroy
destroy(this.uo_toolbar)
destroy(this.cb_1)
destroy(this.dw_apercu)
destroy(this.shl_2)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.shl_1)
destroy(this.dw_dropped)
destroy(this.rb_814)
destroy(this.rb_811)
destroy(this.sle_titre)
destroy(this.st_2)
destroy(this.rb_paysage)
destroy(this.rb_portrait)
destroy(this.dw_selection)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_apercu)
destroy(this.rr_1)
end on

event pfc_preopen;call super::pfc_preopen;is_type_from_menu = gnv_app.inv_entrepotglobal.of_retournedonnee("Lien type sauv", FALSE)

string ls_dw_source
string ls_name, ls_libelle, ls_tag
long ll_acc, ll_rtn
n_ds lds_datawindow

n_cst_string lnv_fct

inv_param = Message.powerObjectParm
lds_datawindow = CREATE n_ds
lds_datawindow.dataobject = inv_param.is_dw_source
lds_datawindow.settransobject(SQLCA)

sle_titre.text = inv_param.is_titre

// Formatter la datawindow et insérer autant de champs que découvert
For ll_acc = 1 to long(lds_datawindow.Describe("DataWindow.Column.Count"))
	ls_name = lds_datawindow.Describe("#" + string(ll_acc) + ".name")
	ls_libelle = lds_datawindow.Describe(ls_name + "_t.text")
	// Éviter que des _ ce retrouve dans la liste des colonnes
	
	// Enlever les exclure_mr
	ls_tag = lds_datawindow.Describe(ls_name + "_t.tag")
	
	IF pos(ls_libelle,"_") = 0 AND pos(ls_tag,"exclure_mr") = 0 AND ls_tag <> "!" THEN
		ll_rtn = dw_selection.insertrow(0)
		ls_libelle = lnv_fct.of_GlobalReplace(ls_libelle,':', ' ')
		dw_selection.object.colonne[ll_rtn] = ls_libelle
		dw_selection.object.colonne_db[ll_rtn] = ls_name
	END IF 
next

THIS.of_calcul_taille_max()
end event

event pfc_postopen;call super::pfc_postopen;//Mettre les boutons
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Sélectionner...", "SelectTable5!")
uo_toolbar.of_AddItem("Enregistrer...", "SaveAs!")
uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

IF is_type_from_menu <> "" AND IsNull(is_type_from_menu) = FALSE THEN
	//Charger les paramètres
	SetPointer(Hourglass!)
	OpenWithParm(w_selectionner_conf_rap, THIS)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("Lien type sauv", "")
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("Lien nom sauv", "")
	is_type_from_menu = ""
END IF


end event

type uo_toolbar from u_cst_toolbarstrip within w_selectionner_champs_rapport_simple
event destroy ( )
string tag = "resize=frbsr"
integer x = 14
integer y = 2232
integer width = 4416
integer height = 108
integer taborder = 90
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

		
	CASE "Fermer"
		Close(parent)
		
	
	CASE "Sélectionner..."
		OpenWithParm(w_selectionner_conf_rap, Parent)
		
	CASE "Enregistrer..."
		OpenWithParm(w_enregistrer_conf_rap, Parent)
		
		
	CASE "OK", "Ok"
		
		// Calculer pour la taille maximum si le nombre de champs que l'on a mis sera dépassé
		IF dec(dw_dropped.describe("evaluate('cf_somme_taille',1)")) > dec(dw_dropped.describe("evaluate('cf_taille_max',1)")) THEN
			gnv_app.inv_error.of_message("PRO0001")
			RETURN 
		END IF 
		
		// Construire le n_cst_param_rapport_simple
		long ll_acc 
		long ll_cpt
		dw_dropped.accepttext()
		For ll_acc = 1 to dw_dropped.rowcount()
			ll_cpt += 1
			inv_param.is_colonne[ll_cpt] = dw_dropped.object.colonne_db[ll_acc] 
			inv_param.idec_taille[ll_cpt] = dw_dropped.object.taille[ll_acc] 
		next 
		
		inv_param.is_titre = sle_titre.text
		IF rb_portrait.checked THEN inv_param.il_orientation = 2
		IF rb_paysage.checked THEN inv_param.il_orientation = 1
		
		IF rb_811.checked THEN inv_param.il_formatpapier = 1
		IF rb_814.checked THEN inv_param.il_formatpapier = 5
		
		inv_param.is_syntax = dw_apercu.object.datawindow.syntax
		
		closewithreturn(parent,inv_param)		
	
END CHOOSE
end event

type cb_1 from commandbutton within w_selectionner_champs_rapport_simple
integer x = 274
integer y = 2504
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Annuler"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_apercu from u_dw within w_selectionner_champs_rapport_simple
event ue_dwnbuttonup pbm_dwnlbuttonup
integer x = 2336
integer y = 600
integer width = 2007
integer height = 1520
integer taborder = 60
string dataobject = "d_taille_colonne_rapport_simple"
boolean hscrollbar = true
boolean border = true
end type

event constructor;call super::constructor;Of_setupdateable(FALSE)
end event

event rbuttonup;//override
end event

type shl_2 from statichyperlink within w_selectionner_champs_rapport_simple
integer x = 1175
integer y = 2052
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 15793151
string text = "Enlever"
boolean focusrectangle = false
end type

event clicked;PARENT.of_EnleverDropped()
end event

type p_2 from u_picturebutton within w_selectionner_champs_rapport_simple
integer x = 1079
integer y = 2044
integer width = 87
integer height = 72
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\annuler.gif"
end type

event clicked;call super::clicked;PARENT.of_EnleverDropped()
end event

type p_1 from u_picturebutton within w_selectionner_champs_rapport_simple
integer x = 114
integer y = 2040
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\ajout.jpg"
end type

event clicked;call super::clicked;of_ajouter_dropped()

end event

type shl_1 from statichyperlink within w_selectionner_champs_rapport_simple
integer x = 229
integer y = 2052
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 15793151
string text = "Ajouter"
boolean focusrectangle = false
end type

event clicked;of_ajouter_dropped()

end event

type dw_dropped from u_dw within w_selectionner_champs_rapport_simple
string tag = "exclure_securite"
integer x = 1079
integer y = 148
integer width = 1125
integer height = 1868
integer taborder = 10
string dragicon = "C:\ii4net\CIPQ\images\dragdrop_haut.ico"
string dataobject = "d_dropped_champs_rapport_simple"
boolean border = true
end type

event constructor;call super::constructor;of_setupdateable(FALSE)
end event

event dragdrop;call super::dragdrop;long ll_rtn, ll_rangee_selection, ll_acc
boolean lb_ok = TRUE
IF source.classname() <> "dw_dropped" THEN
	of_ajouter_dropped()
	dw_selection.Drag(end!)
END IF 
end event

event clicked;call super::clicked;IF dwo.name = "colonne" THEN
	this.drag(begin!)
END IF 
end event

event itemchanged;call super::itemchanged;// Afficher ce que l'on écrit sur l'apercu
long ll_acc
If dwo.name = "taille" then
	For ll_acc = 1  to this.rowcount()
		dw_apercu.Modify(this.object.colonne_db[ll_acc] + ".Width='" + string(this.object.taille[ll_acc] * 1000) +"'")
	next
	
	IF is_nom_conf <> "" THEN
		ib_conf_enr_modifie = TRUE
		PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
	END IF	
END IF 

end event

event editchanged;call super::editchanged;this.accepttext()
// Afficher ce que l'on écrit sur l'apercu
long ll_acc
If dwo.name = "taille" then
	For ll_acc = 1  to this.rowcount()
		dw_apercu.Modify(this.object.colonne_db[ll_acc] + ".Width='" + string(this.object.taille[ll_acc] * 1000) +"'")
	next
	
	IF is_nom_conf <> "" THEN
		ib_conf_enr_modifie = TRUE
		PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
	END IF	
END IF 

end event

event rbuttonup;//override
end event

type rb_814 from u_rb within w_selectionner_champs_rapport_simple
integer x = 3360
integer y = 336
integer width = 261
integer height = 68
long backcolor = 15793151
string text = "8½ X 14"
end type

event clicked;call super::clicked;of_calcul_taille_max()
IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF
end event

type rb_811 from u_rb within w_selectionner_champs_rapport_simple
integer x = 3063
integer y = 336
integer width = 261
integer height = 68
long backcolor = 15793151
string text = "8½ X 11"
boolean checked = true
end type

event clicked;call super::clicked;of_calcul_taille_max()
IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF
end event

type sle_titre from u_sle within w_selectionner_champs_rapport_simple
integer x = 2469
integer y = 152
integer width = 1189
integer height = 84
integer taborder = 70
end type

event modified;call super::modified;IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF
end event

type st_2 from u_st within w_selectionner_champs_rapport_simple
integer x = 2345
integer y = 164
integer width = 123
long backcolor = 15793151
string text = "Titre:"
end type

type rb_paysage from u_rb within w_selectionner_champs_rapport_simple
integer x = 2683
integer y = 336
integer width = 288
integer height = 68
long backcolor = 15793151
string text = "Paysage"
end type

event clicked;call super::clicked;of_calcul_taille_max()
IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF
end event

type rb_portrait from u_rb within w_selectionner_champs_rapport_simple
integer x = 2391
integer y = 336
integer width = 261
integer height = 68
long backcolor = 15793151
string text = "Portrait"
boolean checked = true
end type

event clicked;call super::clicked;of_calcul_taille_max()
IF is_nom_conf <> "" THEN
	ib_conf_enr_modifie = TRUE
	PARENT.Title = "Impression d'un rapport simple - " + is_nom_conf + " (" + is_type_conf + ") *"
END IF
end event

type dw_selection from u_dw within w_selectionner_champs_rapport_simple
integer x = 114
integer y = 148
integer width = 818
integer height = 1868
integer taborder = 20
string dragicon = "C:\ii4net\CIPQ\images\dragdrop_bas.ico"
string dataobject = "d_selectionner_champs_rapport_simple"
boolean border = true
end type

event constructor;call super::constructor;of_setupdateable(FALSE)
of_SetRowSelect(TRUE)


end event

event clicked;call super::clicked;this.drag(begin!)
end event

event dragdrop;call super::dragdrop;IF source.classname() <> "dw_selection" THEN
	PARENT.of_EnleverDropped()
	dw_dropped.drag(end!)
END IF
end event

event rbuttonup;//override

end event

event doubleclicked;call super::doubleclicked;//Comme ajouter
of_ajouter_dropped()
end event

type gb_1 from u_gb within w_selectionner_champs_rapport_simple
integer x = 2345
integer y = 260
integer width = 640
integer height = 184
integer taborder = 50
long backcolor = 15793151
string text = "Orientation du papier"
end type

type gb_2 from u_gb within w_selectionner_champs_rapport_simple
integer x = 3008
integer y = 260
integer width = 645
integer height = 184
integer taborder = 80
long backcolor = 15793151
string text = "Format du papier"
end type

type gb_3 from u_gb within w_selectionner_champs_rapport_simple
integer x = 2290
integer y = 64
integer width = 2094
integer height = 424
integer taborder = 30
long backcolor = 15793151
string text = "Informations générales"
end type

type gb_6 from u_gb within w_selectionner_champs_rapport_simple
integer x = 1019
integer y = 64
integer width = 1234
integer height = 2092
integer taborder = 0
long backcolor = 15793151
string text = "Champs du rapport"
end type

type gb_5 from u_gb within w_selectionner_champs_rapport_simple
integer x = 69
integer y = 64
integer width = 914
integer height = 2092
integer taborder = 0
long backcolor = 15793151
string text = "Champs disponibles"
end type

type gb_apercu from u_gb within w_selectionner_champs_rapport_simple
integer x = 2295
integer y = 536
integer width = 2089
integer height = 1620
integer taborder = 40
long backcolor = 15793151
string text = "Aperçu"
end type

type rr_1 from roundrectangle within w_selectionner_champs_rapport_simple
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 14
integer y = 36
integer width = 4411
integer height = 2156
integer cornerheight = 40
integer cornerwidth = 46
end type

