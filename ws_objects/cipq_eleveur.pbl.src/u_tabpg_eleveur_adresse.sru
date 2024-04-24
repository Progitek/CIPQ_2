$PBExportHeader$u_tabpg_eleveur_adresse.sru
forward
global type u_tabpg_eleveur_adresse from u_tabpg
end type
type rb_aucun from u_rb within u_tabpg_eleveur_adresse
end type
type dw_facturation_mensuelle_groupe from u_dw within u_tabpg_eleveur_adresse
end type
type rb_groupe_payeur from u_rb within u_tabpg_eleveur_adresse
end type
type rb_sous_groupe from u_rb within u_tabpg_eleveur_adresse
end type
type rb_groupe_client from u_rb within u_tabpg_eleveur_adresse
end type
type rb_sans_groupe from u_rb within u_tabpg_eleveur_adresse
end type
type rb_ppa from u_rb within u_tabpg_eleveur_adresse
end type
type gb_ordre from groupbox within u_tabpg_eleveur_adresse
end type
type dw_eleveur_liv from u_dw within u_tabpg_eleveur_adresse
end type
end forward

global type u_tabpg_eleveur_adresse from u_tabpg
integer width = 4425
integer height = 1828
long backcolor = 15793151
rb_aucun rb_aucun
dw_facturation_mensuelle_groupe dw_facturation_mensuelle_groupe
rb_groupe_payeur rb_groupe_payeur
rb_sous_groupe rb_sous_groupe
rb_groupe_client rb_groupe_client
rb_sans_groupe rb_sans_groupe
rb_ppa rb_ppa
gb_ordre gb_ordre
dw_eleveur_liv dw_eleveur_liv
end type
global u_tabpg_eleveur_adresse u_tabpg_eleveur_adresse

on u_tabpg_eleveur_adresse.create
int iCurrent
call super::create
this.rb_aucun=create rb_aucun
this.dw_facturation_mensuelle_groupe=create dw_facturation_mensuelle_groupe
this.rb_groupe_payeur=create rb_groupe_payeur
this.rb_sous_groupe=create rb_sous_groupe
this.rb_groupe_client=create rb_groupe_client
this.rb_sans_groupe=create rb_sans_groupe
this.rb_ppa=create rb_ppa
this.gb_ordre=create gb_ordre
this.dw_eleveur_liv=create dw_eleveur_liv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_aucun
this.Control[iCurrent+2]=this.dw_facturation_mensuelle_groupe
this.Control[iCurrent+3]=this.rb_groupe_payeur
this.Control[iCurrent+4]=this.rb_sous_groupe
this.Control[iCurrent+5]=this.rb_groupe_client
this.Control[iCurrent+6]=this.rb_sans_groupe
this.Control[iCurrent+7]=this.rb_ppa
this.Control[iCurrent+8]=this.gb_ordre
this.Control[iCurrent+9]=this.dw_eleveur_liv
end on

on u_tabpg_eleveur_adresse.destroy
call super::destroy
destroy(this.rb_aucun)
destroy(this.dw_facturation_mensuelle_groupe)
destroy(this.rb_groupe_payeur)
destroy(this.rb_sous_groupe)
destroy(this.rb_groupe_client)
destroy(this.rb_sans_groupe)
destroy(this.rb_ppa)
destroy(this.gb_ordre)
destroy(this.dw_eleveur_liv)
end on

type rb_aucun from u_rb within u_tabpg_eleveur_adresse
integer x = 1957
integer y = 1368
integer width = 393
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Aucun"
boolean checked = true
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE
end event

type dw_facturation_mensuelle_groupe from u_dw within u_tabpg_eleveur_adresse
boolean visible = false
integer x = 2514
integer y = 1396
integer width = 1239
integer height = 228
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_facturation_mensuelle_groupe"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;datawindowchild 	ldwc_groupe_payeur, ldwc_sous_groupe_payeur
date		ld_null
long		ll_null, ll_rtn

SetNull(ll_null)
SetNull(ld_null)

ll_rtn = THIS.GetChild('idgroup', ldwc_groupe_payeur)
ldwc_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_groupe_payeur.retrieve(ll_null, ld_null)

ll_rtn = THIS.GetChild('idgroupsecondaire', ldwc_sous_groupe_payeur)
ldwc_sous_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_sous_groupe_payeur.retrieve(ll_null, ld_null)
end event

event itemchanged;call super::itemchanged;
IF dwo.name = "idgroup" THEN

	datawindowchild 	ldwc_sous_groupe_payeur
	date		ld_null
	long		ll_rtn, ll_group
	
	SetNull(ld_null)
	ll_group = long(data)
	ll_rtn = THIS.GetChild('idgroupsecondaire', ldwc_sous_groupe_payeur)
	ldwc_sous_groupe_payeur.setTransObject(SQLCA)
	SetPointer(HourGlass!)
	ll_rtn = ldwc_sous_groupe_payeur.retrieve(ll_group, ld_null)
END IF
end event

type rb_groupe_payeur from u_rb within u_tabpg_eleveur_adresse
integer x = 3205
integer y = 1344
integer width = 517
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Groupe payeur"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = TRUE

//Lancer le retrieve de la section du bas
datawindowchild 	ldwc_groupe_payeur
long		ll_rtn, ll_null
date		ld_null

SetNull(ll_null)
SetNull(ld_null)

ll_rtn = dw_facturation_mensuelle_groupe.GetChild('idgroup', ldwc_groupe_payeur)
ldwc_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_groupe_payeur.retrieve(1, ld_null)
dw_facturation_mensuelle_groupe.object.idgroup[1] = ll_null
dw_facturation_mensuelle_groupe.object.idgroupsecondaire[1] = ll_null
end event

type rb_sous_groupe from u_rb within u_tabpg_eleveur_adresse
integer x = 2601
integer y = 1344
integer width = 517
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Sous groupe payeur"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = TRUE

//Lancer le retrieve de la section du bas
datawindowchild 	ldwc_groupe_payeur
long		ll_rtn, ll_null
date		ld_null

SetNull(ll_null)
SetNull(ld_null)

ll_rtn = dw_facturation_mensuelle_groupe.GetChild('idgroup', ldwc_groupe_payeur)
ldwc_groupe_payeur.setTransObject(SQLCA)
ll_rtn = ldwc_groupe_payeur.retrieve(2, ld_null)

dw_facturation_mensuelle_groupe.object.idgroup[1] = ll_null
dw_facturation_mensuelle_groupe.object.idgroupsecondaire[1] = ll_null
end event

type rb_groupe_client from u_rb within u_tabpg_eleveur_adresse
integer x = 1957
integer y = 1572
integer width = 553
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Groupe client payeur"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE
end event

type rb_sans_groupe from u_rb within u_tabpg_eleveur_adresse
integer x = 1957
integer y = 1504
integer width = 393
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 15793151
string text = "Sans groupe"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE
end event

type rb_ppa from u_rb within u_tabpg_eleveur_adresse
integer x = 1957
integer y = 1436
integer width = 393
integer height = 68
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 15793151
string text = "PPA"
end type

event clicked;call super::clicked;dw_facturation_mensuelle_groupe.visible = FALSE
end event

type gb_ordre from groupbox within u_tabpg_eleveur_adresse
integer x = 1911
integer y = 1296
integer width = 1883
integer height = 364
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Ordre d~'envoi postal"
end type

type dw_eleveur_liv from u_dw within u_tabpg_eleveur_adresse
integer x = 50
integer y = 24
integer width = 4325
integer height = 1784
integer taborder = 10
string dataobject = "d_eleveur_liv"
end type

event buttonclicked;call super::buttonclicked;//Lancer l'impression
long 	ll_choix, ll_groupe, ll_sous_groupe, ll_noeleveur, ll_courrier
string ls_filtre, ls_sql
w_r_etiquette_eleveur	lw_window_d
w_eleveur	lw_parent

choose case dwo.name
	CASE "b_impr" 
		lw_parent = THIS.of_getfenetreparent()
		
		ls_filtre = lw_parent.is_filtre
		ls_sql = lw_parent.is_where_plus
		
		choose case true
			case rb_ppa.checked //Client 'PPA'
				if ls_filtre <> '' then ls_filtre += ' and '
				ls_filtre += "billing_cycle_code = 'PPA'"
				
			case rb_sans_groupe.checked //Client indépendant
				if ls_filtre <> '' then ls_filtre += ' and '
				ls_filtre += "billing_cycle_code <> 'PPA' And isNull(groupe)"
				
			case rb_groupe_client.checked //Client indépendant avec groupe
				if ls_sql <> '' then ls_sql += ' and ' else ls_sql = ' where '
				ls_sql += "t_eleveur.no_eleveur in (select t_eleveur.no_eleveur " +&
																 "from t_eleveur inner join t_eleveur_Group on t_eleveur_Group.idGroup = t_eleveur.groupe " + &
																 "left outer join t_eleveur_GroupSecondaire on t_eleveur_GroupSecondaire.idGroup = t_eleveur.groupe " + &
																 "and t_eleveur_GroupSecondaire.idGroupSecondaire = t_eleveur.groupeSecondaire " + &
																 "where t_eleveur.Billing_cycle_code <> 'PPA' and (t_eleveur_Group.TypePayeur = 0 " + &
																 "or (t_eleveur_Group.TypePayeur = 2 and t_eleveur_GroupSecondaire.NonPayeur = 1)))"
					
			case rb_sous_groupe.checked //Sous groupe payeur
				if ls_sql <> '' then ls_sql += ' and ' else ls_sql = ' where '
				ls_sql += "t_eleveur.no_eleveur in (select t_eleveur.no_eleveur " +&
																 "from t_eleveur inner join t_eleveur_Group on t_eleveur_Group.idGroup = t_eleveur.groupe " + &
																 "inner join t_eleveur_GroupSecondaire on t_eleveur_GroupSecondaire.idGroup = t_eleveur.groupe " + &
																 "and t_eleveur_GroupSecondaire.idGroupSecondaire = t_eleveur.groupeSecondaire " + &
																 "where t_eleveur.Billing_cycle_code <> 'PPA' " + &
																 "and t_eleveur_Group.TypePayeur = 2 and t_eleveur_GroupSecondaire.NonPayeur = 0"
				
				ll_groupe = dw_facturation_mensuelle_groupe.object.idgroup[1]
				ll_sous_groupe = dw_facturation_mensuelle_groupe.object.idgroupsecondaire[1]
				
				IF Not IsNull(ll_groupe) THEN
					ls_sql += " AND t_ELEVEUR.Groupe = " + string(ll_groupe)
				END IF
				
				IF Not IsNull(ll_sous_groupe) THEN
					ls_sql += " AND t_ELEVEUR.GroupeSecondaire = " + string(ll_sous_groupe)
				END IF
				
				ls_sql += ")"
				
			case rb_groupe_payeur.checked //Groupe payeur
				if ls_sql <> '' then ls_sql += ' and ' else ls_sql = ' where '
				ls_sql += "t_eleveur.no_eleveur in (select t_eleveur.no_eleveur " +&
																 "from t_eleveur inner join t_eleveur_Group on t_eleveur_Group.idGroup = t_eleveur.groupe " + &
																 "where t_eleveur.Billing_cycle_code <> 'PPA' " + &
																 "and t_eleveur_Group.TypePayeur = 1"
				
				ll_groupe = dw_facturation_mensuelle_groupe.object.idgroup[1]
				
				IF Not IsNull(ll_groupe) THEN
					ls_sql += " AND t_ELEVEUR.Groupe = " + string(ll_groupe)
				END IF
				
				ls_sql += ")"
				
		end choose
		
		ll_choix = THIS.object.cc_impr[row]
		
		if ls_sql <> '' then ls_sql += ' and ' else ls_sql = ' where '
		if Messagebox("Question !","Voulez-vous imprimer les facturations par internet ?", Question!, YesNo!, 2) = 1 then
			ls_sql += "isnull(t_ELEVEUR.AF_COURRIEL,'') <> '' "
		else
			ls_sql += "isnull(t_ELEVEUR.AF_COURRIEL,'') = '' "
		end if

		gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes filtre", ls_filtre)
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes sql", ls_sql)
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes choix", string(ll_choix))

		OpenSheet(lw_window_d, gnv_app.of_GetFrame(), 6, layered!)
	CASE 'b_courrier'
		lw_parent = THIS.of_getfenetreparent()
		
		ls_filtre = lw_parent.is_filtre
		ls_sql = lw_parent.is_where_plus
	   ll_courrier = dw_eleveur_liv.getitemnumber(row,'courrier')
		if not isnull(ll_courrier) or ll_courrier > 0 or string(ll_courrier) <> '' then
		
			ll_noeleveur = dw_eleveur_liv.getitemnumber(row,'no_eleveur')
			ls_sql = " where no_eleveur >= " + string(ll_noeleveur)
		
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes filtre", ls_filtre)
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes sql", ls_sql)
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes choix", "4")
	      gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien eleveur etiquettes eleveur", string(ll_noeleveur))
			
			OpenSheet(lw_window_d, gnv_app.of_GetFrame(), 6, layered!)
			
		end if
		
END CHOOSE
end event

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Eleveur", TRUE)
END IF

RETURN AncestorReturnValue
end event

