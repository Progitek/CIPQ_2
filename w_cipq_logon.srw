HA$PBExportHeader$w_cipq_logon.srw
forward
global type w_cipq_logon from w_logon
end type
type p_1 from u_p within w_cipq_logon
end type
type uo_toolbar from u_cst_toolbarstrip within w_cipq_logon
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_cipq_logon
end type
type st_1 from statictext within w_cipq_logon
end type
type rr_3 from roundrectangle within w_cipq_logon
end type
end forward

global type w_cipq_logon from w_logon
integer width = 1376
integer height = 632
boolean titlebar = false
string title = ""
boolean controlmenu = false
long backcolor = 15793151
p_1 p_1
uo_toolbar uo_toolbar
uo_toolbar2 uo_toolbar2
st_1 st_1
rr_3 rr_3
end type
global w_cipq_logon w_cipq_logon

type variables
INTEGER   	ii_nbr_essais
BOOLEAN   	ib_est_connecter = false
n_cst_errorattrib inv_errorattrib
end variables

forward prototypes
public function long of_initialvalue (classdefinition a_class, string as_property, ref any aa_value)
public subroutine of_ajoutdroit (classdefinition a_class)
end prototypes

public function long of_initialvalue (classdefinition a_class, string as_property, ref any aa_value);//////////////////////////////////////////////////////////////////////////////
//	Function:			of_InitialValue
//	Description:		Scan a class definitions variablelist looking for a property,
//						If found Then return the property's value
//////////////////////////////////////////////////////////////////////////////
long		ll_idx, ll_cnt

SetPointer ( HourGlass! )

as_property = Trim ( Lower ( as_property ) )

// get the variables from the class definition
ll_cnt = UpperBound ( a_class.VariableList ) 
For ll_idx = 1 To ll_cnt
	If as_property = a_class.VariableList[ll_idx].Name Then
		// found - so return success
		aa_value = a_class.VariableList[ll_idx].InitialValue
		Return 1 
	End If
Next

// variable not found so return error
Return -1
end function

public subroutine of_ajoutdroit (classdefinition a_class);//////////////////////////////////////////////////////////////////////////////
//	Function:		of_AjoutDroit
//	Description:  	Parcours le menu principal et donne tous les acc$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$l'utilisateur Progitek.
//////////////////////////////////////////////////////////////////////////////
long ll_cnt, ll_idx, ll_hndl
string ls_name
n_cst_string lnv_str
any la_tag, la_text

SetPointer(HourGlass!)

if not isValid(a_class) then return
// Si l'objet est $$HEX2$$e0002000$$ENDHEX$$exclure de la s$$HEX1$$e900$$ENDHEX$$curit$$HEX1$$e900$$ENDHEX$$
if of_initialValue(a_class, "tag", la_tag) = 1 then
	if pos(string(la_tag), 'exclure_securite') > 0 then return
end if
// Si l'objet n'est qu'un s$$HEX1$$e900$$ENDHEX$$parateur
if of_initialValue(a_class, "text", la_text) = 1 then
	if lnv_str.of_isFormat(string(la_text)) then return
end if


// get the class it self
ls_name = a_class.name
ls_name = Mid(ls_name, Pos(ls_name, "`" ) + 1)

select count(*) into :ll_cnt from t_droitsusagers where id_user = 0 and objet = :ls_name;

if ll_cnt = 0 then
	insert into t_droitsusagers (id_user, objet, droits) values (0, :ls_name, 'IMDA');
end if

// see how many objects to be scaned
ll_cnt = UpperBound(a_class.NestedClassList)
// get the controls on the object
For ll_idx = 1 To ll_cnt
	of_ajoutDroit(a_class.NestedClassList[ll_idx])
Next
end subroutine

on w_cipq_logon.create
int iCurrent
call super::create
this.p_1=create p_1
this.uo_toolbar=create uo_toolbar
this.uo_toolbar2=create uo_toolbar2
this.st_1=create st_1
this.rr_3=create rr_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.uo_toolbar2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rr_3
end on

on w_cipq_logon.destroy
call super::destroy
destroy(this.p_1)
destroy(this.uo_toolbar)
destroy(this.uo_toolbar2)
destroy(this.st_1)
destroy(this.rr_3)
end on

event pfc_postopen;call super::pfc_postopen;//Voir cb_ok :: Clicked



uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar2.POST of_displaytext(true)

long 		ll_upper
string	ls_commandline, ls_parm[]

ls_commandline = CommandParm()

//Pour test
//ls_commandline = "cipq.exe cipq transfert transfert"
//ls_commandline = "cipq ts ts"

//Autologin
ll_upper = gnv_app.inv_string.of_parsetoarray( ls_commandline, " ", ls_parm)
IF ll_upper > 1 THEN
	//Rentrer en autologin
	cb_ok.event clicked()


END IF


end event

type p_logo from w_logon`p_logo within w_cipq_logon
boolean visible = false
integer x = 521
integer y = 748
end type

type st_help from w_logon`st_help within w_cipq_logon
boolean visible = false
integer x = 393
integer y = 708
integer width = 896
integer height = 116
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 32768
long backcolor = 12639424
string text = "Veuillez sp$$HEX1$$e900$$ENDHEX$$cifier un usager et un mot de passe:"
end type

type cb_ok from w_logon`cb_ok within w_cipq_logon
integer x = 123
integer y = 716
end type

event cb_ok::clicked;//Override pour plus de controle
/////////////////////////////////////////////////////////////////////////
//
// But:		Cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement retourne un bool$$HEX1$$e900$$ENDHEX$$en "TRUE" et ferme
//				cette fen$$HEX1$$ea00$$ENDHEX$$tre de type Response dans le cas o$$HEX2$$f9002000$$ENDHEX$$l'identification
//				est valide.
//
// Registre de MAJ:
// 
// DATE			NOM					R$$HEX1$$c900$$ENDHEX$$VISION
//------			-------------------------------------------------------------
//
/////////////////////////////////////////////////////////////////////////

string 	ls_app, ls_pass_ecrit, ls_login_ecrit, ls_typepass, ls_commandline, ls_commodbc, ls_parm[], &
			ls_userpre, ls_passwordpre, ls_sql
boolean	lb_identification_ok = FALSE, lb_admin = FALSE
long		ll_count, ll_id_user, ll_pos, ll_upper
any 		la_menu

w_message 			lw_message
classDefinition 	lobj_class

SetPointer(HourGlass!)
ls_commandline = CommandParm()
//cipq.exe nom_odbc login password

//Pour test
//ls_commandline = "cipq transfert transfert"
//ls_commandline = "cipq ts ts"
if ls_commandline = "" then 
	ls_commodbc = 'cipq'
else
	ll_upper = gnv_app.inv_string.of_parsetoarray( ls_commandline, " ", ls_parm)
	IF ll_upper > 0 THEN
		ls_commodbc = ls_parm[1]
	END IF
	IF ll_upper > 1 THEN
		ls_userpre = ls_parm[2]
		sle_userid.text = ls_userpre
	END IF
	IF ll_upper > 2 THEN
		ls_passwordpre = ls_parm[3]
		sle_password.text = ls_passwordpre
	END IF
end if

ls_app = GetApplication().AppName

inv_errorattrib.is_title = "Erreur d'identification"
inv_errorattrib.ie_icon = StopSign!
inv_errorattrib.ie_buttonstyle = ok!

// S'assurer qu'un nom d'usager et un mot de passe ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisis.
// Sinon, envoyer un message et retourner $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre avec le focus 
// sur l'information manquante.

sle_userid.text = lower(sle_userid.text)
ls_pass_ecrit = trim(sle_password.text)
ls_login_ecrit = trim(sle_userid.text)

IF ls_login_ecrit = "" THEN
	inv_errorattrib.is_text  = "Valeur requise pour le champ ~"Usager~".  ~r~n~r~nS.V.P. saisir une valeur."
	OpenWithParm(lw_message, inv_errorattrib)
	SetFocus(sle_userid)
	return
ELSEIF ls_pass_ecrit = "" then
	inv_errorattrib.is_text  = "Valeur requise pour le champ ~"Mot de passe~".  ~r~n~r~nS.V.P. saisir une valeur."
	OpenWithParm(lw_message, inv_errorattrib)
	SetFocus(sle_password)
	return
END IF

		
setpointer ( hourglass! )
application	l_app
l_app = getapplication()
//Dynamique pour valider le mot de passe
// String de connection
SQLCA.DBMS       = 'ODBC'
SQLCA.AutoCommit = True
SQLCA.LOCK		  = "0"
//SQLCA.DbParm  = "ConnectString='DSN=cipq;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
SQLCA.DbParm  = "ConnectString='DSN=" + ls_commodbc + ";UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"

l_app.displayname = "CIPQ - Syst$$HEX1$$e800$$ENDHEX$$me de gestion"

gnv_app.inv_entrepotglobal.of_ajoutedonnee('ODBC_INI', ls_commodbc)
	
//SQLCA.DbParm  = "ConnectString='DSN=cipqtest;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
//l_app.displayname = "CIPQ - test"

if SQLCA.sqlcode = 0 then 
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour login", -1)
	CloseWithReturn(Parent,-1)
END IF

SQLCA.of_connect()

//----------------------------------------------------------------------
// Si l'identification n'a pas r$$HEX1$$e900$$ENDHEX$$ussi, afficher le message d'erreur
// sp$$HEX1$$e900$$ENDHEX$$cifique du DBMS et retourner $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre W_identification
//----------------------------------------------------------------------

setpointer ( arrow! )

IF SQLCA.SQLCode <> 0 then
	//Le serveur est non-disponible
	inv_errorattrib.is_text  = "Il est impossible de rejoindre le serveur. " + ls_commodbc + " . Veuillez r$$HEX1$$e900$$ENDHEX$$essayer plus tard."
	OpenWithParm(lw_message, inv_errorattrib)
	SetFocus(sle_password)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour login", -1)
	closewithreturn(parent,-1)
	RETURN
END IF

// Authentifier la connection pour la version 11

ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
execute immediate :ls_sql using SQLCA;
if sqlca.sqlcode <> 0 then
	MessageBox ("Validation d'authentification", sqlca.sqlerrtext)
	return
end if

// 2009-03-19 - S$$HEX1$$e900$$ENDHEX$$bastien Tremblay - Si l'utilisateur n'a pas de mot de passe d$$HEX1$$e900$$ENDHEX$$fini, lui donner la valeur par d$$HEX1$$e900$$ENDHEX$$faut.
SetNull(ll_id_user)
select id_user, t_users.password
  into :ll_id_user, :ls_passwordpre
  from t_users
 where login_user = :ls_login_ecrit;

if not isNull(ll_id_user) then
	if isNull(ls_passwordpre) then
		update t_users set password = :ls_login_ecrit where id_user = :ll_id_user;
		commit;
	end if
	
	select count(1)
	  into :ll_count
	  from t_password
	 where id_user = :ll_id_user;
	
	if ll_count = 0 then
		insert into t_password (id_user, password)
		values (:ll_id_user, :ls_login_ecrit);
		commit;
	end if
	
	SetNull(ll_id_user)
end if
// ****

// V$$HEX1$$e900$$ENDHEX$$rifier si l'utilisateur a entr$$HEX2$$e9002000$$ENDHEX$$le bon mot de passe
select t_password.id_user, t_users.typepass
INTO :ll_id_user, :ls_typepass
from t_users 
INNER JOIN t_password ON t_users.id_user = t_password.id_user
where login_user = :ls_login_ecrit AND lower(t_password.password) = lower(:ls_pass_ecrit);

//2008-10-19 enlev$$HEX1$$e900$$ENDHEX$$
//IF IsNull(ll_id_user) THEN
//	select id_user, typepass into :ll_id_user, :ls_typepass from t_users where login_user = :ls_login_ecrit AND lower(password) = lower(:ls_pass_ecrit);
//END IF

IF ls_typepass = "a" THEN lb_admin = TRUE
IF isnull(ll_id_user) = FALSE THEN lb_identification_ok = TRUE

IF lb_identification_ok = false then 
	
	n_cst_string	lnv_string
	IF lnv_string.of_IsUpper(sle_password.text) THEN		
		inv_errorattrib.is_text  = "Vous avez commis une erreur d'identification, vous devez recommencer. Peut-$$HEX1$$ea00$$ENDHEX$$tre que votre touche Verr. Maj est enfonc$$HEX1$$e900$$ENDHEX$$e."
	ELSE
		inv_errorattrib.is_text  = "Vous avez commis une erreur d'identification, vous devez recommencer."
	END IF
	OpenWithParm(lw_message, inv_errorattrib)
	//if ii_nbr_essais < 3 then
		setpointer ( arrow! )
		ii_nbr_essais = ii_nbr_essais + 1
		setfocus(sle_password)
		SQLCA.of_disconnect( )
		RETURN
	//end if
else
	
	gnv_app.il_id_user = ll_id_user
	//gnv_app.is_login = ls_login_ecrit
	
	// V$$HEX1$$e900$$ENDHEX$$rifier si l'utilisateur en cours est l'admin
	select count(1) into :ll_count from t_users where id_user = 0;
	if ll_count > 0 then
		if lb_admin then
			lobj_class = findClassDefinition("w_application")
			if isValid(lobj_class) then
				if of_initialValue(lobj_class, "menuname", la_menu) = 1 then
					// Formulaires
					lobj_class = findClassDefinition(string(la_menu) + '`m_formulaires')
					if isValid(lobj_class) then of_ajoutdroit(lobj_class)
					
					// Pilotage
					lobj_class = findClassDefinition(string(la_menu) + '`m_pilotage')
					if isValid(lobj_class) then of_ajoutdroit(lobj_class)
					
					// Rapports
					lobj_class = findClassDefinition(string(la_menu) + '`m_rapports')
					if isValid(lobj_class) then of_ajoutdroit(lobj_class)
				end if
			end if
		end if
	else
		insert into t_users(id_user,password, login_user, typepass, actif) 
		values(0,'progitekde','progitek', 'a', 1) using sqlca;
		
		commit using sqlca;
	end if	
	
	RegistrySet( "HKEY_CURRENT_USER\Software\Progitek\cipq", "LogId", RegString!, ls_login_ecrit)
	gnv_app.of_SetPassword(trim( ls_pass_ecrit ))
	gnv_app.of_SetUserID(trim( ls_login_ecrit ))
	ib_est_connecter = true
	
end if

gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour login", "1")
CloseWithReturn(Parent,1)
end event

type cb_cancel from w_logon`cb_cancel within w_cipq_logon
integer x = 123
integer y = 828
string text = "Annuler"
end type

event cb_cancel::clicked;//Override pour plus de controle
gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour login", -1)
closewithreturn(parent,-1)
end event

type sle_userid from w_logon`sle_userid within w_cipq_logon
integer x = 832
integer y = 208
integer width = 411
integer height = 88
borderstyle borderstyle = stylebox!
end type

type sle_password from w_logon`sle_password within w_cipq_logon
event ue_keypress pbm_keydown
integer x = 832
integer width = 411
integer height = 88
borderstyle borderstyle = stylebox!
end type

event sle_password::ue_keypress;IF KeyDown(KeyF2!) THEN
	integer 	li_FileNum
	string 	ls_nom, ls_pass

	IF FileExists("C:\ii4net\CIPQ\images\pass.txt") THEN
		li_FileNum = FileOpen("C:\ii4net\CIPQ\images\pass.txt", LineMode!)
		FileRead(li_FileNum, ls_pass)
		FileClose(li_FileNum)
	
		sle_userid.text = "Progitek"
		sle_password.text = ls_pass
		cb_ok.TriggerEvent(Clicked!)
	END IF
END IF
end event

type st_2 from w_logon`st_2 within w_cipq_logon
integer x = 375
integer y = 212
integer width = 329
long backcolor = 12639424
string text = "Usager:"
alignment alignment = left!
end type

type st_3 from w_logon`st_3 within w_cipq_logon
integer x = 375
integer y = 304
integer width = 329
long backcolor = 12639424
string text = "Mot de passe:"
alignment alignment = left!
end type

type p_1 from u_p within w_cipq_logon
integer x = 69
integer y = 76
integer width = 229
integer height = 200
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\ii4net\CIPQ\images\lock.jpg"
boolean border = true
end type

type uo_toolbar from u_cst_toolbarstrip within w_cipq_logon
integer x = 69
integer y = 440
integer width = 507
integer taborder = 30
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_ok.event clicked( )
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_toolbar2 from u_cst_toolbarstrip within w_cipq_logon
integer x = 754
integer y = 440
integer width = 507
integer taborder = 40
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;cb_cancel.event clicked( )
end event

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

type st_1 from statictext within w_cipq_logon
integer x = 370
integer y = 80
integer width = 910
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 12639424
string text = "Veuillez sp$$HEX1$$e900$$ENDHEX$$cifier un usager et un mot de passe:"
boolean focusrectangle = false
end type

type rr_3 from roundrectangle within w_cipq_logon
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 12639424
integer x = 18
integer y = 16
integer width = 1307
integer height = 576
integer cornerheight = 75
integer cornerwidth = 75
end type

