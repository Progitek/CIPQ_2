$PBExportHeader$w_recoltesave.srw
forward
global type w_recoltesave from w_sheet_frame
end type
type gb_2 from groupbox within w_recoltesave
end type
type dw_recolte from u_dw within w_recoltesave
end type
type dw_dernieres_recoltes from u_dw within w_recoltesave
end type
type rr_1 from roundrectangle within w_recoltesave
end type
type uo_toolbar from u_cst_toolbarstrip within w_recoltesave
end type
type pb_voir from picturebutton within w_recoltesave
end type
type ole_com from olecustomcontrol within w_recoltesave
end type
end forward

global type w_recoltesave from w_sheet_frame
string tag = "menu=m_recoltes"
gb_2 gb_2
dw_recolte dw_recolte
dw_dernieres_recoltes dw_dernieres_recoltes
rr_1 rr_1
uo_toolbar uo_toolbar
pb_voir pb_voir
ole_com ole_com
end type
global w_recoltesave w_recoltesave

type variables
boolean	ib_TAG_111 = FALSE, ib_TAG_112 = FALSE, ib_TAG_113 = FALSE, ib_TAG_114 = FALSE, ib_TAG_115 = FALSE
boolean	ib_doublon = FALSE, ib_insertion_temp = FALSE, ib_save = FALSE, ib_first = TRUE
string	is_oldverrat = "",is_focus= ""
end variables

forward prototypes
public subroutine of_calcul_concentration ()
public function long of_calcul_dose_produite (long al_fertilite, long al_sperme)
public function boolean of_verifier_si_message (string as_verrat)
public function long of_recupererprochainnumero (string as_centre)
public subroutine of_readcom1 ()
end prototypes

public subroutine of_calcul_concentration ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_calcul_concentration
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour trouver la valeur de la concentration
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-09-14	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_row, ll_nbsperme, ll_cote
decimal	ldec_concentration, ldec_poids

ll_row = dw_recolte.GetRow()

IF ll_row > 0 THEN
	ldec_concentration = dw_recolte.object.concentration[ll_row]
	ldec_poids = dw_recolte.object.volume[ll_row]
	ll_cote = dw_recolte.object.motilite_p[ll_row]
	
	If IsNull(ldec_concentration) OR ldec_concentration = 0 OR IsNull(ldec_poids) OR ldec_poids = 0 THEN
		dw_recolte.object.nbr_sperm[ll_row] = 0
		dw_recolte.object.ampo_total[ll_row] = 0
		RETURN
	ELSE
		ll_nbsperme = long( round(((ldec_poids * ldec_concentration) / 1000) , 0))
		
		dw_recolte.object.nbr_sperm[ll_row] = ll_nbsperme
		dw_recolte.object.ampo_total[ll_row] = of_calcul_dose_produite(ll_cote, ll_nbsperme)
		
	END IF
END IF
end subroutine

public function long of_calcul_dose_produite (long al_fertilite, long al_sperme);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_calcul_dose_produite
//
//	Accès:  			Public
//
//	Argument:		al_fertilite	-	La cote de fertilité
//						al_sperme		-	Le volume
//
//	Retourne:  		Rien
//
// Description:	Fonction pour trouver le nombre de doses produites
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-09-17	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long		ll_dose = 0, ll_row
long     ll_nbdosemax
string	ls_type
decimal	ldec_concentration

ll_row = dw_recolte.GetRow()
IF al_fertilite = 0 OR al_sperme = 0 OR ll_row < 1 THEN RETURN 0

ls_type = upper(dw_recolte.object.type_sem[ll_row])

IF ls_type = "T" OR ls_type = "S" OR ls_type = "M" OR ls_type = "C" THEN
	RETURN 0
END IF

//Chercher la concentration et faire le calcul
SELECT 	concentration INTO :ldec_concentration 
FROM		t_recoltecote
WHERE		cote = :al_fertilite
USING SQLCA;

If IsNull(ldec_concentration) Or ldec_concentration = 0 Then
    ll_dose = 0
Else
    ll_dose = long(round(al_sperme / ldec_concentration, 0))
End If

SELECT isnull(nbdosemax,0) INTO :ll_nbdosemax 
FROM t_parametre 
USING SQLCA;

//If ll_dose >= 60 Then ll_dose = 60
if ll_nbdosemax > 0 then
	If ll_dose >= ll_nbdosemax Then ll_dose = ll_nbdosemax
end if

RETURN ll_dose
end function

public function boolean of_verifier_si_message (string as_verrat);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_verifier_si_message
//
//	Accès:  			Public
//
//	Argument:		String - verrat
//
//	Retourne:  		Prix
//
// Description:	Fonction pour vérifier s'il y a des messages (commentaires)
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-09-18	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

string	ls_message

SELECT	msg
INTO		:ls_message
FROM		t_recolte_msg
WHERE 	noverrat = :as_verrat
USING 	SQLCA;

IF IsNull(ls_message) OR trim(ls_message) = "" THEN
	RETURN FALSE
ELSE
	RETURN TRUE
END IF
end function

public function long of_recupererprochainnumero (string as_centre);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumero
//
//	Accès:  			Public
//
//	Argument:		String - Nom du centre
//
//	Retourne:  		Prix
//
// Description:	Fonction pour trouver la valeur du prochain numéro de 
//						récolte
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2007-09-19	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(norecolte) + 1
INTO		:ll_no
FROM		t_recolte
WHERE		cie_no = :as_centre
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

public subroutine of_readcom1 ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_readcomm1
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Rien
//
// Description:	Fonction pour trouver la valeur de la balance
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur				Description
//	2007-09-14	Mathieu Gendron		Création
//
//	2010-04-13	Sébastien Tremblay	Arrangé pour que ça marche !
//
//////////////////////////////////////////////////////////////////////////////

string	ls_InString, ls_commande
long		ll_aLen, ll_row, ll_port
time		lt_aTimeFinish

//Marche si on utilise une balance APX-602

setPointer(HourGlass!)

ll_row = dw_recolte.GetRow()

IF ll_row <= 0 THEN return

ll_port = long(gnv_app.of_getvaleurini("BALANCE", "PORT"))

if ll_port < 1 or ll_port > 16 then return

//Ouverture du port
ole_com.object.Settings = "9600,S,7,1"
ole_com.object.InputLen = 0
ole_com.object.CommPort = ll_port
ole_com.object.PortOpen = True
  
//Demande d'info
ls_commande = Char(27) + 'P~r~n'
ole_com.object.Output = ls_commande

//Délai de travail maximum: 5 secondes

lt_aTimeFinish = RelativeTime(now(), 5)
Do
  	//Check for data.
  	If ole_com.object.InBufferCount Then
		ls_InString = ole_com.object.Input
		messagebox("input",ls_InString)
  	End If
	  
	If now() > lt_aTimeFinish Then
		//Exit Do
		ole_com.object.PortOpen = False
		Return
	End If
	
Loop Until Pos(ls_InString, " ") > 0 //Attendre la réponse de la balance APX-602

ole_com.object.PortOpen = False

ll_aLen = POS(ls_InString, "g")
if ll_aLen > 0 then
	ls_InString = Trim(Mid(ls_InString, 1, ll_aLen - 1))
else
	ls_InString = Trim(ls_InString)
end if

dw_recolte.object.volume[ll_row] = double(ls_InString)

of_calcul_concentration()
end subroutine

on w_recoltesave.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.dw_recolte=create dw_recolte
this.dw_dernieres_recoltes=create dw_dernieres_recoltes
this.rr_1=create rr_1
this.uo_toolbar=create uo_toolbar
this.pb_voir=create pb_voir
this.ole_com=create ole_com
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_recolte
this.Control[iCurrent+3]=this.dw_dernieres_recoltes
this.Control[iCurrent+4]=this.rr_1
this.Control[iCurrent+5]=this.uo_toolbar
this.Control[iCurrent+6]=this.pb_voir
this.Control[iCurrent+7]=this.ole_com
end on

on w_recoltesave.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.dw_recolte)
destroy(this.dw_dernieres_recoltes)
destroy(this.rr_1)
destroy(this.uo_toolbar)
destroy(this.pb_voir)
destroy(this.ole_com)
end on

event pfc_postopen;call super::pfc_postopen;string	ls_commande

dw_recolte.post event pfc_retrieve()

setredraw(true)
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter une récolte", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer cette récolte", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Rechercher une récolte...", "Search!")

uo_toolbar.of_AddItem("Imprimer l'écran", "Preview!")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

ls_commande = upper(gnv_app.of_getvaleurini("DATABASE", "CommandeRecolte"))

IF ls_commande = "TRUE" THEN dw_recolte.object.p_commande.visible = 1

SetPointer(Hourglass!)

//Rentrer en mode insertion 
IF gnv_app.of_getcompagniedefaut( ) <> "110" THEN
	dw_recolte.post event pfc_insertrow()
END IF
end event

event pfc_preopen;call super::pfc_preopen;dw_dernieres_recoltes.inv_linkage.of_SetMaster(dw_recolte)
dw_dernieres_recoltes.inv_Linkage.of_SetStyle(dw_dernieres_recoltes.inv_Linkage.RETRIEVE)
dw_dernieres_recoltes.inv_linkage.of_Register("codeverrat","codeverrat")
dw_recolte.inv_linkage.of_SetTransObject(SQLCA)
dw_recolte.inv_linkage.of_setsynconkeychange(true)
end event

type st_title from w_sheet_frame`st_title within w_recoltesave
integer x = 256
integer width = 389
string text = "Récoltes"
end type

type p_8 from w_sheet_frame`p_8 within w_recoltesave
integer x = 55
integer y = 44
integer width = 174
integer height = 88
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\recolte.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_recoltesave
integer y = 24
end type

type gb_2 from groupbox within w_recoltesave
integer x = 2597
integer y = 864
integer width = 1778
integer height = 1264
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Historique de récoltes"
end type

type dw_recolte from u_dw within w_recoltesave
integer x = 78
integer y = 216
integer width = 4439
integer height = 1916
integer taborder = 10
string dataobject = "d_recolte"
end type

event constructor;call super::constructor;THIS.of_setfind( true)

this.Of_SetLinkage(TRUE)

THIS.of_setpremierecolonneinsertion("preplaboid")
end event

event pfc_retrieve;call super::pfc_retrieve;string	ls_cie
long		ll_rtn, ll_heb

setnull(ls_cie)
setnull(ll_heb)

//Retrieve de la dddw
dataWindowChild ldwc_prep, ldwc_tech, ldwc_cote

THIS.GetChild('prepose', ldwc_prep)
ldwc_prep.setTransObject(SQLCA)
ll_rtn =ldwc_prep.retrieve(ls_cie)

THIS.GetChild('preplaboid', ldwc_tech)
ldwc_tech.setTransObject(SQLCA)
ll_rtn = ldwc_tech.retrieve(ls_cie)

THIS.GetChild('motilite_p', ldwc_cote)
ldwc_cote.setTransObject(SQLCA)
ll_rtn = ldwc_cote.retrieve(ll_heb)

RETURN THIS.Retrieve()
end event

event buttonclicked;call super::buttonclicked;//buttonclicked
n_cst_menu	lnv_menu
string		ls_tatouage, ls_verrat
menu			lm_item, lm_menu
long			ll_row

lm_menu = gnv_app.of_getframe().MenuID

IF Row > 0 THEN
	CHOOSE CASE dwo.name
			
		CASE "b_plustype"
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,"m_typesdesemence", lm_item) > 0 THEN
					IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
						lm_item.event clicked()
					END IF
				END IF 
			END IF
			
		CASE "b_message"
			ll_row = dw_recolte.getrow()
			IF ll_row > 0 THEN
				ls_verrat = THIS.object.codeverrat[ll_row]
				IF IsNull(ls_verrat) = FALSE AND ls_verrat <> "" THEN
					w_recolte_message	lw_window
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien commentaires recolte", ls_verrat)
					Open(lw_window)
					IF IsValid(lw_window) THEN Destroy(lw_window)
					gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien commentaires recolte", "")
					
				END IF
			END IF
			
	END CHOOSE
END IF

end event

event clicked;call super::clicked;if row > 0 THEN
	CHOOSE CASE dwo.name
			
		CASE "p_balance"
			parent.of_readcom1()
			
		CASE "p_commande"
			
			//Vérifier si la punaise est déjà ouverte à quelque part
			IF gnv_app.of_checkifpunaiseopen() = TRUE THEN
				Messagebox("Attention", "Cette interface est déjà ouverte par un autre utilisateur.")
				Return
			END IF
			
			//Ouvrir l'interface des commandes
			w_recolte_commande	lw_window
			
			OpenSheet(lw_window, gnv_app.of_GetFrame(), 6, layered!)
	END CHOOSE
END IF
end event

event itemchanged;call super::itemchanged;long		ll_rtn, ll_row_dwc, ll_type, ll_no_employe, ll_compteur_punch, ll_count, ll_no_recolte, ll_heb, ll_rowdddw, &
			ll_null, ll_countverrat
boolean	lb_tag = FALSE
string	ls_couleur, ls_cie, ls_classe, ls_null, ls_message_recolte, ls_coderace, ls_emplacement, ls_codeverrat
date		ld_today, ld_punch
time		lt_punch
w_recolte_message 	lw_recolte_message
datawindowchild		ldwc_cote
datawindowchild 		ldwc_classe
datawindowchild 	ldwc_verrat
n_cst_datetime		lnv_dt

SetNull(ll_null)
SetNull(ls_null)
ld_today = Today()

/*
if ib_save = False and ib_first = False then
	   select count(codeverrat) into :ll_countverrat from t_verrat where codeverrat = :data;
		if ll_countverrat > 0 then
			Messagebox("Avertissement","Enregistrer les modifications pour faire une nouvelle récolte !") 
			Return 1
		end if
end if

ib_save = False
ib_first = false
*/

ls_cie = gnv_app.of_getcompagniedefaut( )

IF row > 0 THEN
	
	IF dwo.name = "motilite_p" THEN
		THIS.GetChild('motilite_p', ldwc_cote)
		ldwc_cote.setTransObject(SQLCA)
		ll_rowdddw = ldwc_cote.Find("cote = " + data , 1, ldwc_cote.RowCount())		
		IF ll_rowdddw = 0 THEN
			gnv_app.inv_error.of_message("PRO0011")
			THIS.ib_suppression_message_itemerror = TRUE
			THIS.object.motilite_p[row] = ll_null
			THIS.SetColumn("motilite_p")
			RETURN 1				
		END IF
		
	END IF
	
	CHOOSE CASE dwo.name
		CASE "motilite_p", "concentration", "volume", "type_sem"
			
			THIS.AcceptText()
			parent.of_calcul_concentration()
		
		CASE "preplaboid"
			datawindowchild 	ldwc_prep
			THIS.GetChild('preplaboid', ldwc_prep)
			ldwc_prep.setTransObject(SQLCA)
			ll_row_dwc = ldwc_prep.Find("prepid = " + data , 1, ldwc_prep.RowCount())		
			
			IF ll_row_dwc = 0 THEN
				gnv_app.inv_error.of_message("PRO0011")
				THIS.ib_suppression_message_itemerror = TRUE
				THIS.object.preplaboid[row] = ll_null
				THIS.SetColumn("preplaboid")
				RETURN 1				
			END IF
		
		CASE "codeverrat"
			
			//Vérifier si c'est exclusif
			THIS.AcceptText()
			ls_codeverrat = trim(data)
			setItem(row,'codeverrat',ls_codeverrat)
	
			THIS.GetChild('codeverrat', ldwc_verrat)
			ldwc_verrat.setTransObject(SQLCA)
			ll_row_dwc = ldwc_verrat.Find("upper(codeverrat) = '" + upper(data) + "'", 1, ldwc_verrat.RowCount())		

			//Vérifier si le centre d'insémination travaille avec les puces électroniques
			CHOOSE CASE ls_cie
				CASE "111"
					if upper(gnv_app.of_getvaleurini("TAG", "111")) = "TRUE" THEN lb_tag = TRUE
				CASE "112"
					if upper(gnv_app.of_getvaleurini("TAG", "112")) = "TRUE" THEN lb_tag = TRUE
				CASE "113"
					if upper(gnv_app.of_getvaleurini("TAG", "113")) = "TRUE" THEN lb_tag = TRUE
				CASE "114"
					if upper(gnv_app.of_getvaleurini("TAG", "114")) = "TRUE" THEN lb_tag = TRUE
				CASE "115"
					if upper(gnv_app.of_getvaleurini("TAG", "115")) = "TRUE" THEN lb_tag = TRUE
				CASE "116"
					if upper(gnv_app.of_getvaleurini("TAG", "116")) = "TRUE" THEN lb_tag = TRUE
				CASE "117"
					if upper(gnv_app.of_getvaleurini("TAG", "117")) = "TRUE" THEN lb_tag = TRUE
					
			END CHOOSE
			
			//lb_tag = TRUE
			
			IF ll_row_dwc = 0 THEN
				//REMIS //Pas de message - ça se peut que ça vienne du scan et qu'il y ait une erreur
				gnv_app.inv_error.of_message("PRO0011")
				THIS.ib_suppression_message_itemerror = TRUE
				THIS.object.codeverrat[row] = ls_null
				THIS.object.exclusif[row] = 0
				THIS.object.type_exclu[row] = ll_null
				//THIS.SetColumn("codeverrat")
				RETURN 1				
			ELSE
				ll_type = ldwc_verrat.GetItemNumber(ll_row_dwc,"TypeVerrat")
				ls_cie = ldwc_verrat.GetItemString(ll_row_dwc,"cie_no")
				ls_classe = ldwc_verrat.GetItemString(ll_row_dwc,"classe")
				ls_message_recolte = ldwc_verrat.GetItemString(ll_row_dwc,"messagerecolte")
				ls_coderace = ldwc_verrat.GetItemString(ll_row_dwc,"coderace")
				ls_emplacement = ldwc_verrat.GetItemString(ll_row_dwc,"emplacement")
				
				IF ll_type = 2 or ll_type = 3 THEN
					THIS.object.exclusif_t.visible = TRUE
					THIS.object.exclusif.visible = TRUE
					
					if THIS.object.exclusif[row] = 1 then
						THIS.object.type_exclu[row] = ll_type
					else
						THIS.object.type_exclu[row] = ll_null
					end if
				ELSE
					THIS.object.exclusif_t.visible = FALSE
					THIS.object.exclusif.visible = FALSE
					THIS.object.exclusif[row] = 0
					THIS.object.type_exclu[row] = ll_null
				END IF
				
				THIS.object.cie_no[row] = ls_cie
				THIS.object.emplacement[row] = ls_emplacement
				
				IF ls_classe = "0" OR ls_classe = "" THEN
					THIS.object.classe[row] = ls_null
				ELSE
					THIS.object.classe[row] = ls_classe
					
					THIS.GetChild('classe', ldwc_classe)
					ldwc_classe.setTransObject(SQLCA)
					
					ll_row_dwc = ldwc_classe.Find("classeverrat = '" + (ls_classe) + "'", 1, ldwc_classe.RowCount())
					IF ll_row_dwc > 0 THEN
						ls_couleur = ldwc_classe.GetItemString(ll_row_dwc,"couleur")
						IF IsNull(ls_couleur) THEN
							THIS.object.t_couleur.text = ""
						ELSE
							THIS.object.t_couleur.text = ls_couleur
						END IF
					ELSE
						THIS.object.t_couleur.text = ""
					END IF
				END IF
				
				THIS.GetChild('motilite_p', ldwc_cote)
				ldwc_cote.setTransObject(SQLCA)
				THIS.object.messagerecolte[row] = ls_message_recolte
				IF Upper(ls_coderace) = "LO" THEN
					THIS.object.motilite_p[row] = 50
					ll_rtn = ldwc_cote.retrieve(1)
				ELSE
					THIS.object.motilite_p[row] = 0
					ll_rtn = ldwc_cote.retrieve(0)
				END IF
				
			END IF
			
			// Imprimer étiquette automatiquement (pas d'intéraction avec l'utilisateur)
			
			if gnv_app.of_getcompagniedefaut( ) <> '110' then
				// Impression de l'étiquette sur Zebra
				n_ds ds_etiq
				ds_etiq = create n_ds
				ds_etiq.dataobject = "d_codeverratetiq"
				ds_etiq.setTransobject(SQLCA)
				ds_etiq.retrieve(THIS.object.codeverrat[row])
				ds_etiq.print()
				destroy ds_etiq 
			end if
			
			//Si oui, punch
			IF lb_tag = TRUE THEN
				//Ajout des valeurs obtenues par les lectures électroniques
				SELECT	FIRST no_employe, "date", Jour_heure, Compteur
				INTO		:ll_no_employe, :ld_punch, :lt_punch, :ll_compteur_punch
				FROM 		punch
				WHERE 	trim(no_job) = :data AND no_item is null AND date("date") = date(:ld_today )
				ORDER BY compteur
				USING 	SQLCA;

				IF SQLCA.SQLCode < 0 then
					Messagebox("Une erreur est survenue", "Le verrat " + data + "~r~n~r~n" + SQLCA.SQLeRRText)
				END IF
			
				IF IsNull(ll_compteur_punch) OR ll_compteur_punch = 0 THEN
					gnv_app.inv_error.of_message("CIPQ0037")
				ELSE
					//Initialiser les données
					IF IsNull(ll_no_employe) THEN ll_no_employe = 0
					
					THIS.object.prepose[row] = ll_no_employe
					THIS.object.date_recolte[row] = ld_punch
					THIS.object.heure_recolte[row] = datetime(today(),lt_punch)
					THIS.object.compteurpunch[row] = ll_compteur_punch
					
				   //Indiquer à Punch que ce verrat a été lu
					UPDATE	punch SET no_item = 'T' 
					WHERE 	no_job = :data AND no_item is null AND date("date") = date(:ld_today )
					ORDER BY compteur
					USING 	SQLCA;

   				THIS.SetColumn("heure_recolte")
				END IF

			END IF
			
			ll_no_recolte = THIS.object.norecolte[row]
			
			//Si ce verrat a déjà été récolté aujourd'hui, envoyer un message...
			select 	count(NoRecolte)
			INTO		:ll_count
			FROM		t_RECOLTE
			WHERE		NoRecolte <> :ll_no_recolte AND codeverrat = :data AND date_recolte = :ld_today
			USING 	SQLCA ;
			
			IF ll_count > 0 THEN
				gnv_app.inv_error.of_message("CIPQ0038")
				ib_doublon = TRUE
			END IF 
			
			IF parent.of_verifier_si_message(data) THEN
				//Ouvrir la fenêtre des messages
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien commentaires recolte", string(data))
				Open(lw_recolte_message)
				
				gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien commentaires recolte", "")
				IF lb_tag = TRUE THEN THIS.SetColumn("gedis")
			END IF
			
			dw_dernieres_recoltes.visible = FALSE
			if ib_en_insertion then 
				dw_dernieres_recoltes.retrieve(data)
				
			end if
	
		CASE "classe"
		
			return 2
			
//			THIS.GetChild('classe', ldwc_classe)
//			ldwc_classe.setTransObject(SQLCA)
//			
//			ll_row_dwc = ldwc_classe.Find("classeverrat = '" + data + "'", 1, ldwc_classe.RowCount())
//			IF ll_row_dwc > 0 THEN
//				ls_couleur = ldwc_classe.GetItemString(ll_row_dwc,"couleur")
//				IF IsNull(ls_couleur) THEN
//					THIS.object.t_couleur.text = ""
//				ELSE
//					THIS.object.t_couleur.text = ls_couleur
//				END IF
//			ELSE
//				THIS.object.t_couleur.text = ""
//			END IF
			
		CASE "exclusif"
			if long(data) = 1 then
				THIS.GetChild('codeverrat', ldwc_verrat)
				ldwc_verrat.setTransObject(SQLCA)
				ll_row_dwc = ldwc_verrat.Find("upper(codeverrat) = '" + upper(THIS.object.codeverrat[row]) + "'", 1, ldwc_verrat.RowCount())		
	
				if ll_row_dwc > 0 then
					ll_type = ldwc_verrat.GetItemNumber(ll_row_dwc,"TypeVerrat")
			
					if ll_type = 2 or ll_type = 3 then
						THIS.object.type_exclu[row] = ll_type
					else
						THIS.object.type_exclu[row] = ll_null
					end if
				else
					THIS.object.type_exclu[row] = ll_null
				end if
			else
				THIS.object.type_exclu[row] = ll_null
			end if
			
		CASE "date_recolte"
			ld_punch = date(data)
			
			if ld_punch < lnv_dt.of_relativemonth(today(), -1) or ld_punch > today() then
				return 2
			end if
			
	END CHOOSE
	
END IF
IF IsValid(lw_recolte_message) THEN Destroy(lw_recolte_message)
end event

event rowfocuschanged;call super::rowfocuschanged;long		ll_row_dwc, ll_type, ll_heb
string	ls_couleur, ls_classe, ls_codeverrat

IF currentrow > 0 THEN
	
	ib_doublon = FALSE
	SetNull(ll_heb)
	
	ls_classe = THIS.object.classe[currentrow]
	ls_codeverrat = THIS.object.codeverrat[currentrow]
	
	datawindowchild 	ldwc_verrat, ldwc_classe, ldwc_cote

	THIS.GetChild('motilite_p', ldwc_cote)
	ldwc_cote.setTransObject(SQLCA)
	ldwc_cote.retrieve(ll_heb)
	
	THIS.GetChild('codeverrat', ldwc_verrat)
	ldwc_verrat.setTransObject(SQLCA)
	ll_row_dwc = ldwc_verrat.Find("codeverrat = '" + ls_codeverrat + "'", 1, ldwc_verrat.RowCount())
	IF ll_row_dwc > 0 THEN
		ll_type = ldwc_verrat.GetItemNumber(ll_row_dwc,"TypeVerrat")
	
		IF ll_type = 2 or ll_type = 3 THEN
			THIS.object.exclusif_t.visible = TRUE
			THIS.object.exclusif.visible = TRUE
		ELSE
			THIS.object.exclusif_t.visible = FALSE
			THIS.object.exclusif.visible = FALSE
		END IF
	ELSE
		THIS.object.exclusif_t.visible = FALSE
		THIS.object.exclusif.visible = FALSE
	END IF

	THIS.GetChild('classe', ldwc_classe)
	ldwc_classe.setTransObject(SQLCA)
	ll_row_dwc = ldwc_classe.Find("classeverrat = '" + ls_classe + "'", 1, ldwc_classe.RowCount())
	IF ll_row_dwc > 0 THEN
		ls_couleur = ldwc_classe.GetItemString(ll_row_dwc,"couleur")
		IF IsNull(ls_couleur) THEN
			THIS.object.t_couleur.text = ""
		ELSE
			THIS.object.t_couleur.text = ls_couleur
		END IF
	ELSE
		THIS.object.t_couleur.text = ""
	END IF
	dw_dernieres_recoltes.visible = FALSE

END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;IF AncestorReturnValue = CONTINUE_ACTION THEN
	long	ll_cpt_punch, ll_row
	
	ll_row = THIS.GetRow()
	ll_cpt_punch = THIS.object.compteurpunch[ll_row]
	
	IF ll_cpt_punch <> 0 AND isnull(ll_cpt_punch ) = FALSE THEN
		UPDATE punch SET no_item = NULL WHERE compteur = :ll_cpt_punch;
		COMMIT USING SQLCA;
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event pfc_postupdate;call super::pfc_postupdate;IF AncestorReturnValue <> 1 THEN
	RETURN AncestorReturnValue
END IF

IF ib_doublon = TRUE THEN
	
	//Ce verrat a été récolté deux fois dans la même journée
  	//On remet disponible ce verrat dans la gestion des lots	
	
	date		ld_date
	long		ll_row
	string	ls_codeverrat
	
	ll_row = THIS.GetRow()
	ld_date = date(THIS.object.date_recolte[ll_row])
	ls_codeverrat = THIS.object.codeverrat[ll_row]
	
	UPDATE 	T_Recolte_GestionLot_Detail SET DistributionTermine = 0
	WHERE		DateRecolte = :ld_date AND CodeVerrat = :ls_codeverrat ;
	
	commit using SQLCA;
	
	ib_doublon = FALSE
END IF


RETURN AncestorReturnValue
end event

event dberror;//Override pour trapper le doublon sur le no de récolte
IF sqldbcode = -193 THEN
	long		ll_no, ll_row
	string	ls_cie

	ll_row = THIS.GetRow()
	ls_cie = THIS.object.cie_no[ll_row]
	ll_no = PARENT.of_recupererprochainnumero( ls_cie)
	THIS.object.norecolte[ll_row] = ll_no
	
	POST Event pfc_save()
	RETURN 1
ELSE
	CALL super::dberror
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;is_focus = dwo.name

IF ib_en_insertion OR row = 0 THEN RETURN

IF lower(dwo.name) = "codeverrat" THEN
	is_oldverrat = THIS.object.codeverrat[row]
	
	//Vérifier pour le scan ?? TO DO
	
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long		ll_row, ll_no
string	ls_cie
date		ld_recolte

ll_row = GetRow()
IF ll_row > 0 THEN
	THIS.SetColumn("preplaboid")
	
	//2008-12-01 Il est maintenant impossible de modifier les récoltes < que la date du jour
	ld_recolte = date(THIS.object.date_recolte[ll_row])
	//2009-06-02 S.T. Sauf si l'utilisateur a le droit "Autre" pour cette fenêtre
	IF ld_recolte < date(today()) AND ib_en_insertion = FALSE THEN
		if not of_droitautres("CIPQ0018", {"Il est impossible de modifier une rangée pour une journée antérieure."}) then
			RETURN FAILURE
		end if
	END IF
	
	ll_no = THIS.object.norecolte[ll_row]
	IF IsNull(ll_no) THEN
		ls_cie = THIS.object.cie_no[ll_row]
		
		ll_no = PARENT.of_recupererprochainnumero(ls_cie)
		THIS.object.norecolte[ll_row] = ll_no
	END IF
	
	IF ib_en_insertion = FALSE THEN
		IF is_oldverrat <> "" AND IsNull(is_oldverrat) = FALSE THEN
			THIS.object.heure_edition[ll_row] = datetime(today(),now())
			THIS.object.Ancien_CodeVerrat[ll_row] = is_oldverrat
		END IF
	ELSE
		THIS.object.heure_analyse[ll_row] = datetime(today(),now())
	END IF
END IF

RETURN ancestorreturnvalue
end event

event pfc_finddlg;SetPointer(Hourglass!)

THIS.object.datawindow.retrieve.asneeded = FALSE

CALL SUPER::pfc_finddlg
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_retour, ll_no
	string	ls_cie
	
	//Pousser les valeurs de la clé primaire
	THIS.object.date_recolte[AncestorReturnValue] = date(today())
//	THIS.object.heure_analyse[AncestorReturnValue] = datetime(today(),now())
	
	ls_cie = gnv_app.of_getcompagniedefaut()
	
	ll_no = PARENT.of_recupererprochainnumero( ls_cie)
	THIS.object.norecolte[AncestorReturnValue] = ll_no
	THIS.object.cie_no[AncestorReturnValue] = ls_cie
	
	IF ls_cie = "114" THEN
		THIS.object.collectis[AncestorReturnValue] = 0
	ELSE
		THIS.object.collectis[AncestorReturnValue] = 1
	END IF
	
	dw_dernieres_recoltes.of_reset()
	
END IF


RETURN AncestorReturnValue
end event

event pro_keypress;call super::pro_keypress;IF KeyDown(KeyControl!) THEN
	IF KeyDown(KeyE!) THEN
		do while yield()
		loop
		uo_toolbar.event ue_buttonclicked("Enregistrer")
	END IF
END IF
end event

event pfc_deleterow;call super::pfc_deleterow;dw_dernieres_recoltes.visible = FALSE
return ancestorReturnValue
end event

type dw_dernieres_recoltes from u_dw within w_recoltesave
integer x = 2651
integer y = 956
integer width = 1650
integer height = 992
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dernieres_recoltes"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.Of_SetLinkage(TRUE)
end event

type rr_1 from roundrectangle within w_recoltesave
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 184
integer width = 4549
integer height = 2004
integer cornerheight = 40
integer cornerwidth = 46
end type

type uo_toolbar from u_cst_toolbarstrip within w_recoltesave
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2216
integer width = 4558
integer height = 108
integer taborder = 30
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		IF PARENT.event pfc_save() >= 0 THEN
			ib_save = TRUE
			ib_insertion_temp = TRUE
			dw_recolte.SetFocus()
			dw_recolte.event pfc_insertrow()
			ib_insertion_temp = FALSE
		END IF
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Ajouter une récolte"
		Setpointer(Hourglass!)
		IF PARENT.event pfc_save() >= 0 THEN
			Setpointer(Hourglass!)
			dw_recolte.event pfc_insertrow()
		END IF
		
	CASE "Supprimer cette récolte"
		dw_recolte.event pfc_deleterow()
		
	CASE "Rechercher une récolte..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_recolte.RowCount() > 0 THEN
				dw_recolte.SetRow(1)
				dw_recolte.ScrolltoRow(1)
				dw_recolte.event pfc_finddlg()		
			END IF
		END IF
		
	CASE "Imprimer l'écran"
		long ll_Job

		ll_Job = PrintOpen("Écran", TRUE)
		PrintScreen(ll_Job,1,1,8125,6250)

		PrintClose(ll_Job)	
END CHOOSE

end event

type pb_voir from picturebutton within w_recoltesave
integer x = 4005
integer y = 1964
integer width = 293
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\ii4net\CIPQ\images\lunettes.bmp"
alignment htextalign = left!
end type

event clicked;//IF dw_recolte.ib_en_insertion = FALSE THEN
	dw_dernieres_recoltes.Visible = TRUE
//END IF
end event

type ole_com from olecustomcontrol within w_recoltesave
event oncomm ( )
boolean visible = false
integer x = 3895
integer y = 660
integer width = 174
integer height = 152
integer taborder = 30
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_recoltesave.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Aw_recoltesave.bin 
2700000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000015cb580001cf6f6d00000003000000c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000260000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000003c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004648a5600101b2c6e0000b682140000000000000015cb580001cf6f6d15cb580001cf6f6d000000000000000000000000fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00430079007000690072006800670020007400630028002000290039003100340039000000200000000000000000000000000000000000000000000000001234432100000008000003ed000003ed648a560100060000000100000000040000000200000025800008000000000000000000000000003f00000001000000001234432100000008000003ed000003ed648a560100060000000100000000040000000200000025800008000000000000000000000000003f00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000020000003c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Aw_recoltesave.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
