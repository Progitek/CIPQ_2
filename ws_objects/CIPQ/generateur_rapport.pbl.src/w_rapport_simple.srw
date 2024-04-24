$PBExportHeader$w_rapport_simple.srw
forward
global type w_rapport_simple from w_rapport
end type
end forward

global type w_rapport_simple from w_rapport
integer x = 214
integer y = 221
string title = "Liste simple"
long backcolor = 15780518
end type
global w_rapport_simple w_rapport_simple

type variables
n_cst_param_rapport_simple inv_param

string 	is_syntaxe_initiale =""

boolean	ib_affiche = FALSE
end variables

forward prototypes
public subroutine of_batir_rapport ()
public subroutine of_afficher_titre_rapport ()
end prototypes

public subroutine of_batir_rapport ();dw_preview.dataobject = inv_param.is_dw_source
dw_preview.of_settransobject( SQLCA)

u_dw	ldw_temp
String ls_dwsyn, ls_errors,ls_editmask, ls_format, ls_text, ls_chk, ls_obj, ls_x, ls_largeur, ls_texte, ls_texte_orig, ls_type_col, ls_align, ls_command
string ls_table, ls_template, ls_error, ls_temp_select, ls_syntax
string ls_sql, ls_nom_text, ls_nom_col, ls_mod_str = "", ls_mod_str2 = "", ls_mod_str3 = "", ls_mod_str4 = ""
long ll_acc, ll_acc2, ll_debut, ll_fin, ll_fin_ligne, ll_blanc, ll_cpt, ll_x
string ls_colonne[], ls_objects[], ls_describe
dec ldec_taille[], ldec_rendu = 50, ldec_position, ldec_width
string ls_dddw, ls_objets
long  ll_width, li_cpt, li_stop
long ll_rtn , ll_upper

dw_preview.SetRedraw(FALSE)

dw_preview.dataobject = inv_param.is_dw_source
dw_preview.of_settransobject( SQLCA)


ldec_taille = inv_param.idec_taille
ls_colonne = inv_param.is_colonne

// S'assurer que la fonction a retournée des colonnes.
IF Upperbound(ls_colonne) > 0 THEN
	
	// Ouverture de la datawindow pour aller chercher les informations

	dw_preview.Object.DataWindow.Header.Height = '4627'
	dw_preview.Object.DataWindow.Detail.Height = '410'
	dw_preview.Object.DataWindow.Footer.Height = '476'
	dw_preview.Object.DataWindow.Summary.Height = '10'
	dw_preview.Object.DataWindow.Detail.Height.AutoSize = TRUE
	
	dw_preview.BorderStyle = StyleLowered!
	
	dw_preview.Object.DataWindow.Color = 16777215
	dw_preview.Object.DataWindow.Header.Color = 16777215
	dw_preview.Object.DataWindow.Detail.Color = 16777215
	dw_preview.Object.DataWindow.Footer.Color = 16777215
	
	
	ll_upper = dw_preview.inv_dwsrv.of_GetObjects (ls_objects[ ])
	FOR ll_cpt = 1 TO ll_upper
		ls_mod_str = ls_mod_str + ls_objects[ll_cpt] + ".visible = 0 "
		ls_mod_str = ls_mod_str + ls_objects[ll_cpt] + ".x = 1 "
		ls_mod_str = ls_mod_str + ls_objects[ll_cpt] + ".y = 1 "
		ls_mod_str = ls_mod_str + ls_objects[ll_cpt] + ".width = 100 "
		ls_mod_str = ls_mod_str + ls_objects[ll_cpt] + ".height = 100 "
	END FOR
	
	//Créer la ligne d'entête
	IF inv_param.il_orientation = 1 and inv_param.il_formatpapier = 1 THEN 	ll_x = 26000
	IF inv_param.il_orientation = 1 and inv_param.il_formatpapier > 1 THEN ll_x = 34000
	IF inv_param.il_orientation = 2 THEN ll_x = 19605

	dw_preview.object.datawindow.print.orientation = inv_param.il_orientation
	dw_preview.object.datawindow.print.documentname = inv_param.is_titre
	dw_preview.object.datawindow.print.margin.left = 110
	dw_preview.object.datawindow.print.margin.right = 110
	dw_preview.object.datawindow.print.margin.top = 96
	dw_preview.object.datawindow.print.margin.bottom = 96
	dw_preview.object.datawindow.print.paper.source = 0
	dw_preview.object.datawindow.print.paper.size = inv_param.il_formatpapier
	
	ls_command = 'create line(band=header x1="79" y1="4542" x2="' + string(ll_x) + '" y2="4542"  name=l_1 visible="1" pen.style="0" pen.width="52" pen.color="8388608"  background.mode="2" background.color="1073741824" )'
	dw_preview.modify(ls_command)
	ls_command = 'create line(band=header x1="79" y1="4595" x2="' + string(ll_x) + '" y2="4595"  name=l_2 visible="1" pen.style="0" pen.width="52" pen.color="134217728"  background.mode="2" background.color="1073741824" )'
	dw_preview.modify(ls_command)
	
	IF inv_param.il_orientation = 1 and inv_param.il_formatpapier = 1 THEN  
		ls_command = 'create report(band=header dataobject="d_r_entete_entreprise_land_8_11" x="0" y="0" height="4127" width="26000" border="0"  height.autosize=yes criteria="" trail_footer = yes  name=dw_entete visible="1"  slideup=directlyabove )'
	ELSE
		IF inv_param.il_orientation = 1 and inv_param.il_formatpapier > 1 THEN 
			ls_command = 'create report(band=header dataobject="d_r_entete_entreprise_land_8_14" x="0" y="0" height="4127" width="34000" border="0"  height.autosize=yes criteria="" trail_footer = yes  name=dw_entete visible="1"  slideup=directlyabove )'				
		ELSE
			ls_command = 'create report(band=header dataobject="d_r_entete_entreprise" x="0" y="0" height="4127" width="19605" border="0"  height.autosize=yes criteria="" trail_footer = yes  name=dw_entete visible="1"  slideup=directlyabove )'
		END IF 
	END IF 

	dw_preview.modify(ls_command)
	
	//Création du footer	
	IF inv_param.il_orientation = 1 and inv_param.il_formatpapier = 1 THEN 
		ll_x = 18629
		ll_width = 19100
	END IF 
	IF inv_param.il_orientation = 1 and inv_param.il_formatpapier > 1 THEN 
		ll_x = 26200
		ll_width = 25993
	END IF 
	
	IF inv_param.il_orientation = 2 THEN 
		ll_x = 12447
		ll_width = 12770
	END IF 
	
	ls_command = 'create compute(band=footer alignment="0" tag="exclure_mr" expression="' + char(39) + '    ' + char(39) +' " border="0" color="0" x="26" y="26" height="370" width="' + string(ll_width) + '" format="[GENERAL]" html.valueishtml="0"  name=cf_footer visible="1"  font.face="Arial" font.height="-8" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'
	dw_preview.modify(ls_command)
	ls_command = 'create compute(band=footer alignment="1" tag="exclure_mr" expression="' + char(39) + 'Page ' + char(39) + ' + page() + '+char(39) + ' de ' +char(39) + ' + pageCount() " border="0" color="0" x="' + string(ll_x)+ '" y="26" height="370" width="7860" format="[general]" html.valueishtml="0"  name=page_count visible="1"  font.face="Arial" font.height="-8" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'	
	dw_preview.modify(ls_command)
	
	// Création du libellé st_tri dans l'entete du rapport.
//	ls_command = 'create text(band=header alignment="0" text="text" border="0" color="33554432" x="1710" y="504" height="76" width="110" html.valueishtml="0"  name=st_tri visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
//	dw_preview.modify(ls_command)
	
	//Faire le tour des colonnes, si elles sont disponible dans les sélections de l'utilisateurs, les mettre visibles
	FOR ll_cpt = 1 TO UpperBound(ls_colonne)
		//Mettre la colonne visible
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".visible = 1 "
		//Positionner la colonne
		IF ll_cpt <> 1 THEN
			ldec_position = ldec_rendu + 200
		ELSE
			ldec_position = ldec_rendu 
		END IF
		
		ldec_width = (ldec_taille[ll_cpt] * 1000)
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".x =" + string(ldec_position) + " "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".y =100 "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".width =" + string(ldec_width) + " "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".height=396 "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".border =0 "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".background.color='16777215' "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".background.mode='1'  "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".tabsequence=0 "
		ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".Alignment ='0' " 
		
		//Vérifier si c'est un radiobutton
		ls_describe = Lower(dw_preview.Describe(ls_colonne[ll_cpt] +".Edit.Style")) 
		IF ls_describe = "dddw" THEN
			ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".dddw.UseAsBorder	='No' "
		ELSEIF ls_describe = "ddlb" THEN
			ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".ddlb.UseAsBorder='No' "
		ELSEIF ls_describe = "checkbox" THEN
			ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".checkbox.text='' "
			ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".alignment='2' "
		ELSEIF ls_describe = "radiobuttons" THEN
			ls_mod_str2 = ls_mod_str2 + ls_colonne[ll_cpt] + ".ddlb.Required='No' "
		END IF
		
				
		//Mettre le libellé visible
		
		//Trouver le bon texte
		ls_texte_orig = trim(dw_preview.describe(ls_colonne[ll_cpt] + "_t.text"))
		IF ls_texte_orig = "!" THEN ls_texte_orig = ""
		IF RIGHT(ls_texte_orig, 1) = ":" THEN ls_texte_orig = LEFT(ls_texte_orig, LEN(ls_texte_orig) - 1)
		ls_nom_text = ls_colonne[ll_cpt] + "_t"
		
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.visible=1 "
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + '_t.text="' + ls_texte_orig + '" '
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.x=" + string(ldec_position) + " "
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.y=4090 "
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.width=" + string(ldec_width) + " "
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.height=465 "
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.background.color='16777215' "		
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.color=0 "	
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.font.weight=700 "		
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.border='0'  "				
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.font.face='Arial'  "	
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.font.height=-10  "							
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.background.mode='0'  "
		ls_mod_str3 = ls_mod_str3 + ls_colonne[ll_cpt] + "_t.alignment='0'  "
		
		ldec_rendu = ldec_rendu + ldec_width
	END FOR
	
	ls_error = dw_preview.Modify( ls_mod_str )
	ls_error = dw_preview.Modify( ls_mod_str2 )
	ls_error = dw_preview.Modify( ls_mod_str3 )

	dw_preview.object.datawindow.print.preview = 'yes'

END IF

IF IsValid(ldw_temp) THEN DesTROY(ldw_temp)
dw_preview.SetRedraw(TRUE)
end subroutine

public subroutine of_afficher_titre_rapport ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_afficher_titre_rapport
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Prix
//
// Description:	Fonction pour afficher le titre du rapport dans le rapport
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-11-02	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////


long 		ll_rowcount, ll_pos, ll_cpt
string 	ls_critere, ls_titre

// Appliquer le titre de aux colonnes de rapport.
ll_rowcount = dw_preview.rowcount()
IF ll_rowcount > 0 THEN 
	dw_preview.Object.dw_entete.Object.nombre_t.text = "Nombre: " + string(ll_rowcount)
	ls_titre = THIS.Title
	ll_pos = POS(ls_titre, "Page ")
	IF ll_pos > 0 THEN
		ls_titre = LEFT(ls_titre,ll_pos - 2)
	END IF
	
	dw_preview.Object.dw_entete.Object.cc_nom_rapport[1] = ls_titre
	
	string	ls_filter
	ls_filter = dw_preview.inv_filter.of_GetFilter ( ) 
	IF ls_filter <> "" AND Not (IsNull(ls_filter)) THEN
		//dw_preview.Object.dw_entete.Object.cc_criteres[1] = "Filtré"
		dw_preview.Object.dw_entete.Object.cc_criteres[1] = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)
	END IF
	
END IF 

IF dw_preview.RowCount() = 0 THEN
	ib_affiche = TRUE
	gnv_app.inv_error.of_message("PRO0010")
END IF


end subroutine

on w_rapport_simple.create
call super::create
end on

on w_rapport_simple.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;THIS.of_batir_rapport( )
end event

event pfc_postopen;call super::pfc_postopen;//Refaire le tour des colonnes puisque celles-ci ont changées

integer	li_numcols, li_i

// Faire le tour des colonnes pour les charger
li_numcols = integer(dw_preview.Object.DataWindow.Column.Count)
FOR li_i = 1 to li_numcols
	dw_preview.is_colonnes_tour[li_i] = dw_preview.Describe("#" + string(li_i) + ".Name")
END FOR


dw_preview.of_SetTri(TRUE)

dw_preview.event pfc_filterdlg()
dw_preview.event pfc_retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_rapport_simple
integer taborder = 1
string dataobject = "d_r_entete_entreprise"
end type

event dw_preview::pfc_retrieve;call super::pfc_retrieve;long	ll_retour

ll_retour = this.retrieve()

IF ll_retour = 0 AND ib_affiche = FALSE THEN
	gnv_app.inv_error.of_message("PRO0010")
END IF

ib_affiche = FALSE

RETURN ll_retour

end event

event dw_preview::retrieveend;//Override

parent.of_afficher_titre_rapport()
end event

event dw_preview::pfc_sortdlg;call super::pfc_sortdlg;
//Après le sort, il flush le titre
parent.of_afficher_titre_rapport()


RETURN AncestorReturnValue
end event

event dw_preview::constructor;call super::constructor;inv_param = Message.PowerObjectParm
parent.title = inv_param.is_titre



//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_tiri", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_trier", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event

event dw_preview::pfc_filterdlg;call super::pfc_filterdlg;
//Après le filter, il flush le titre
parent.POST of_afficher_titre_rapport( )




RETURN AncestorReturnValue
end event

