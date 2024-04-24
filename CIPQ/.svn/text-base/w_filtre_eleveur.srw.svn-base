HA$PBExportHeader$w_filtre_eleveur.srw
forward
global type w_filtre_eleveur from w_response
end type
type dw_filtre_eleveur from u_dw within w_filtre_eleveur
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_filtre_eleveur
end type
type uo_toolbar from u_cst_toolbarstrip within w_filtre_eleveur
end type
type rr_1 from roundrectangle within w_filtre_eleveur
end type
end forward

global type w_filtre_eleveur from w_response
string tag = "menu=m_eleveurs"
integer width = 2866
integer height = 1424
string title = "Filtre d~'$$HEX1$$e900$$ENDHEX$$leveurs"
long backcolor = 12639424
dw_filtre_eleveur dw_filtre_eleveur
uo_toolbar2 uo_toolbar2
uo_toolbar uo_toolbar
rr_1 rr_1
end type
global w_filtre_eleveur w_filtre_eleveur

on w_filtre_eleveur.create
int iCurrent
call super::create
this.dw_filtre_eleveur=create dw_filtre_eleveur
this.uo_toolbar2=create uo_toolbar2
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filtre_eleveur
this.Control[iCurrent+2]=this.uo_toolbar2
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.rr_1
end on

on w_filtre_eleveur.destroy
call super::destroy
destroy(this.dw_filtre_eleveur)
destroy(this.uo_toolbar2)
destroy(this.uo_toolbar)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;uo_toolbar.of_settheme("classic")

uo_toolbar.of_DisplayBorder(true)

uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Filtrer", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar2.of_AddItem("Annuler", "C:\ii4net\CIPQ\images\annuler.gif")
uo_toolbar.POST of_displaytext(true)
uo_toolbar2.POST of_displaytext(true)

dw_filtre_eleveur.event pfc_insertrow()
end event

event closequery;//Override
Return 0
end event

type dw_filtre_eleveur from u_dw within w_filtre_eleveur
integer x = 46
integer y = 24
integer width = 2729
integer height = 1112
integer taborder = 10
string dataobject = "d_filtre_eleveur"
boolean vscrollbar = false
end type

type uo_toolbar2 from u_cst_toolbarstrip within w_filtre_eleveur
event destroy ( )
integer x = 2322
integer y = 1212
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien filtre eleveur", "annuler")
Close(parent)
end event

type uo_toolbar from u_cst_toolbarstrip within w_filtre_eleveur
event destroy ( )
integer x = 1760
integer y = 1212
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string	ls_filtre = "", ls_genre_elevage, ls_region, ls_sql
long		ll_no_client, ll_no_groupe, ll_privilege, ll_privilege_total, ll_nb_truie_de, ll_nb_truie_a, ll_selection, &
			ll_secteur
datetime ldt_du, ldt_au

dw_filtre_eleveur.AcceptText()

//B$$HEX1$$e200$$ENDHEX$$tir la string de filtre

ls_genre_elevage = dw_filtre_eleveur.object.genre_elevage[1]
IF ls_genre_elevage <> "" AND Not IsNull(ls_genre_elevage) THEN
	ls_filtre += "AND genr_elev = '" + ls_genre_elevage + "' "
END IF

ls_region = dw_filtre_eleveur.object.region[1]
IF ls_region <> "" AND Not IsNull(ls_region) THEN
	ls_filtre += "AND reg_agr = '" + ls_region + "' "
END IF

ll_no_client = dw_filtre_eleveur.object.no_client[1]
IF ll_no_client <> 0 AND Not IsNull(ll_no_client) THEN
	ls_filtre += "AND no_eleveur = " + string(ll_no_client) + " "
END IF

ll_no_groupe = dw_filtre_eleveur.object.no_groupe[1]
IF ll_no_groupe <> 0 AND Not IsNull(ll_no_groupe) THEN
	ls_filtre += "AND groupe = " + string(ll_no_groupe) + " "
END IF

ll_privilege = dw_filtre_eleveur.object.prog_privilege[1]
IF ll_privilege <> 1 AND Not IsNull(ll_privilege) THEN
	IF ll_privilege = 2 THEN
		ls_filtre += "AND plivrgratuit = 1 "
	ELSE
		ls_filtre += "AND plivrgratuit = 0 "
	END IF
END IF

ll_privilege_total = dw_filtre_eleveur.object.prog_total[1]
IF ll_privilege_total <> 1 AND Not IsNull(ll_privilege_total) THEN
	IF ll_privilege_total = 2 THEN
		ls_filtre += "AND plivrgratuittot = 1 "
	ELSE
		ls_filtre += "AND plivrgratuittot = 0 "
	END IF
END IF

ll_nb_truie_de = dw_filtre_eleveur.object.nb_truie_de[1]
ll_nb_truie_a = dw_filtre_eleveur.object.nb_truie_a[1]
IF ll_nb_truie_de <> 0 AND Not IsNull(ll_nb_truie_de) AND ll_nb_truie_a <> 0 AND Not IsNull(ll_nb_truie_a) THEN
	ls_filtre += "AND nb_truie >= " + string(ll_nb_truie_de) + " AND nb_truie <= " + string(ll_nb_truie_a) 
END IF

ll_selection = dw_filtre_eleveur.object.actif[1]
IF ll_selection <> 0 AND Not IsNull(ll_selection) THEN
	ls_filtre += "AND chkActivite = 1 "
END IF

ll_secteur = dw_filtre_eleveur.object.secteur_transporteur[1]
IF ll_secteur <> 0 AND Not IsNull(ll_secteur) THEN
	ls_filtre += "AND secteur_transporteur = " + string(ll_secteur) + " "
END IF


//Enlever le 1er AND
IF ls_filtre <> "" THEN
	ls_filtre = RIGHT(ls_filtre, LEN(ls_filtre) - 3)
END IF

ldt_du = dw_filtre_eleveur.object.fact_de[1]
ldt_au = dw_filtre_eleveur.object.fact_a[1]
			
IF Not IsNull(ldt_du) AND Not IsNull(ldt_au) THEN
	ls_sql = " WHERE t_eleveur.no_eleveur IN ( SELECT t_eleveur.no_eleveur FROM t_eleveur, T_STATFACTURE " + & 
				"where t_eleveur.no_eleveur = T_STATFACTURE.no_eleveur and " + &
				"T_STATFACTURE.FACT_DATE >= '" + string(date(ldt_du),"yyyy-mm-dd") + "' AND " + &
				"T_STATFACTURE.FACT_DATE <= '" + string(date(ldt_au),"yyyy-mm-dd") + "' )"
END IF

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien filtre eleveur", ls_filtre)
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien filtre eleveur SQL", ls_sql)
Close(parent)
end event

type rr_1 from roundrectangle within w_filtre_eleveur
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 2807
integer height = 1168
integer cornerheight = 40
integer cornerwidth = 46
end type

