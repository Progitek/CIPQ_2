$PBExportHeader$w_fiche_sante.srw
forward
global type w_fiche_sante from w_sheet_frame
end type
type st_1 from statictext within w_fiche_sante
end type
type dw_fiche_sante from u_dw within w_fiche_sante
end type
type uo_toolbar from u_cst_toolbarstrip within w_fiche_sante
end type
type gb_1 from u_gb within w_fiche_sante
end type
type gb_2 from u_gb within w_fiche_sante
end type
type rr_1 from roundrectangle within w_fiche_sante
end type
type ddlb_tatouage from u_ddlb within w_fiche_sante
end type
end forward

global type w_fiche_sante from w_sheet_frame
string tag = "menu=m_fichesante"
st_1 st_1
dw_fiche_sante dw_fiche_sante
uo_toolbar uo_toolbar
gb_1 gb_1
gb_2 gb_2
rr_1 rr_1
ddlb_tatouage ddlb_tatouage
end type
global w_fiche_sante w_fiche_sante

type variables
string	is_cie = "", is_tatou = "", is_code = ""

string	is_tatou_arg = ""
end variables

forward prototypes
public subroutine of_retrievefiche ()
public function long of_recupererprochainnumero ()
end prototypes

public subroutine of_retrievefiche ();long		ll_rtn
string	ls_cie

//Trouver la cie active pour ce tatouage

//Pousser les valeurs de la clé primaire
is_tatou = ddlb_tatouage.text

SetNull(is_cie)

SELECT T_Verrat.CIE_NO, T_Verrat.CodeVerrat 
INTO :is_cie, :is_code
FROM T_Verrat 
WHERE T_Verrat.TATOUAGE=:is_tatou AND T_Verrat.ELIMIN Is Null USING SQLCA;

//SI non trouvé essayer avec les verrats éliminés
IF IsNull(is_cie) THEN
	SELECT T_Verrat.CIE_NO, T_Verrat.CodeVerrat 
	INTO :is_cie, :is_code
	FROM T_Verrat 
	WHERE T_Verrat.TATOUAGE=:is_tatou USING SQLCA;
END IF

	
//Lancer le retrieve de la fiche
ll_rtn = dw_fiche_sante.Retrieve(is_tatou)

IF ll_rtn > 0 AND (is_cie = "" OR isnull(is_cie)) THEN
	is_cie = dw_fiche_sante.object.cie_no[1]
	
END IF

setnull(ls_cie)

//Retrieve de la dddw
dataWindowChild ldwc_prep

dw_fiche_sante.GetChild('prepid', ldwc_prep)

ldwc_prep.setTransObject(SQLCA)
ll_rtn =ldwc_prep.retrieve(ls_cie)
end subroutine

public function long of_recupererprochainnumero ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumero
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Numéro 
//
// Description:	Fonction pour trouver la valeur du prochain numéro 
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-11-12	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(compteur) + 1
INTO		:ll_no
FROM		t_verrat_fichesante
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_fiche_sante.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_fiche_sante=create dw_fiche_sante
this.uo_toolbar=create uo_toolbar
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rr_1=create rr_1
this.ddlb_tatouage=create ddlb_tatouage
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_fiche_sante
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.rr_1
this.Control[iCurrent+7]=this.ddlb_tatouage
end on

on w_fiche_sante.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_fiche_sante)
destroy(this.uo_toolbar)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rr_1)
destroy(this.ddlb_tatouage)
end on

event pfc_postopen;call super::pfc_postopen;//Remplir la ddlb de tous les verrats
long	ll_nbrow, ll_cpt
n_ds 	lds_tatouage

lds_tatouage = CREATE n_ds
lds_tatouage.dataobject = "ds_tatouage_tous"
lds_tatouage.SetTransobject(SQLCA)
ll_nbrow = lds_tatouage.retrieve()

FOR ll_cpt = 1 TO ll_nbrow
	ddlb_tatouage.additem(lds_tatouage.object.tatouage[ll_cpt])
END FOR

IF IsValid(lds_tatouage) THEN DesTroy(lds_tatouage)


//Mettre les boutons
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Imprimer", "Print!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
	
uo_toolbar.of_displaytext(true)

IF is_tatou_arg <> "" THEN 
	ddlb_tatouage.text = upper(is_tatou_arg)
	of_retrievefiche()
END IF

ddlb_tatouage.post SetFocus()
end event

event pfc_preopen;call super::pfc_preopen;//Vérifier si un argument a été passé
string ls_retour

ls_retour = gnv_app.inv_entrepotglobal.of_retournedonnee( "lien fiche")
IF ls_retour <> "" AND isnull(ls_retour) = FALSE THEN
	//Il y a un tatouage de passé en argument
	is_tatou_arg = ls_retour
	gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien fiche", "")
END IF
end event

type st_title from w_sheet_frame`st_title within w_fiche_sante
integer x = 215
string text = "Fiche santé"
end type

type p_8 from w_sheet_frame`p_8 within w_fiche_sante
integer x = 50
integer y = 36
integer width = 128
integer height = 112
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\medalert.jpg"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_fiche_sante
end type

type st_1 from statictext within w_fiche_sante
integer x = 155
integer y = 304
integer width = 402
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Tatouage:"
boolean focusrectangle = false
end type

type dw_fiche_sante from u_dw within w_fiche_sante
integer x = 101
integer y = 540
integer width = 4347
integer height = 1480
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fiche_sante"
end type

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 	ll_retour
	
	//Pousser les valeurs de la clé primaire
	
	dw_fiche_sante.object.cie_no[AncestorReturnValue] = is_cie
	dw_fiche_sante.object.codeverrat[AncestorReturnValue] = is_code
	dw_fiche_sante.object.tatouage[AncestorReturnValue] = is_tatou
	dw_fiche_sante.object.dateinspection[AncestorReturnValue] = today()
	
	//Retrieve de la dddw
	dataWindowChild ldwc_prep
	
	ldwc_prep.setTransObject(SQLCA)
	dw_fiche_sante.GetChild('prepid', ldwc_prep)
	ll_retour = ldwc_prep.retrieve(is_cie)

	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.compteur[AncestorReturnValue] = ll_no
	
	
END IF


RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;IF dwo.name = "codemedicament" THEN
	//Aller chercher le format
	string ls_format
	
  	SELECT 	formatposologie
  	INTO 		:ls_format
   FROM 		t_pharmacie 
	WHERE		codemedicament = :data USING SQLCA;

	IF IsNull(ls_format) = FALSE THEN 
		THIS.object.t_pharmacie_formatposologie[row] = ls_format
	END IF
	
END IF

// Gestion des données pour le transfert
// Mettre le TransDate à null
datetime	ldt_null

SetNull(ldt_null)
this.object.TransDate[row] = ldt_null

end event

event constructor;call super::constructor;SetRowFocusIndicator(Hand!)
end event

type uo_toolbar from u_cst_toolbarstrip within w_fiche_sante
integer x = 142
integer y = 2072
integer width = 4306
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string	ls_tatouage

ls_tatouage = ddlb_tatouage.text

CHOOSE CASE as_button
	CASE "Add","Ajouter"
		IF ls_tatouage <> "" AND IsNull(ls_tatouage) = FALSE THEN
			dw_fiche_sante.event pfc_insertrow()
		END IF
		
	CASE "Supprimer", "Delete"
		dw_fiche_sante.event pfc_deleterow()
			
	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Imprimer", "Print"
		if is_tatou <> "" then
			if parent.event pfc_save() >= 0 then
				w_critere_date_du_au	lw_window
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("rapport date", "w_r_fiche_sante")
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("rapport fiche sante tatou", is_tatou)
				OpenSheet(lw_window, gnv_app.of_GetFrame(), 6, layered!)
			end if
		end if		
	CASE "Fermer", "Close"		
		Close(parent)

END CHOOSE

end event

type gb_1 from u_gb within w_fiche_sante
integer x = 87
integer y = 492
integer width = 4411
integer height = 1724
integer taborder = 0
long backcolor = 15793151
string text = "Fiche santé"
end type

type gb_2 from u_gb within w_fiche_sante
integer x = 87
integer y = 228
integer width = 4411
integer height = 232
integer taborder = 0
long backcolor = 15793151
string text = "Sélection du verrat"
end type

type rr_1 from roundrectangle within w_fiche_sante
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 1073741824
integer x = 23
integer y = 184
integer width = 4549
integer height = 2092
integer cornerheight = 40
integer cornerwidth = 46
end type

type ddlb_tatouage from u_ddlb within w_fiche_sante
integer x = 590
integer y = 316
integer width = 850
integer height = 608
integer taborder = 10
boolean bringtotop = true
boolean allowedit = true
end type

event selectionchanged;call super::selectionchanged;of_retrievefiche()
end event

event modified;call super::modified;IF KeyDown(KeYEnter!) THEN
	THIS.text = UPPER(THIS.TEXT)
	of_retrievefiche()
END IF
end event

