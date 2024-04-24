$PBExportHeader$w_eleveur_rech.srw
forward
global type w_eleveur_rech from w_response
end type
type uo_toolbar_gauche from u_cst_toolbarstrip within w_eleveur_rech
end type
type dw_eleveur_rech from u_dw within w_eleveur_rech
end type
type rr_1 from roundrectangle within w_eleveur_rech
end type
type uo_toolbar from u_cst_toolbarstrip within w_eleveur_rech
end type
end forward

global type w_eleveur_rech from w_response
string tag = "menu=m_enregistrerlescommandes"
integer width = 2094
integer height = 1296
string title = "Code d~'hébergeur pour cet éleveur"
long backcolor = 12639424
uo_toolbar_gauche uo_toolbar_gauche
dw_eleveur_rech dw_eleveur_rech
rr_1 rr_1
uo_toolbar uo_toolbar
end type
global w_eleveur_rech w_eleveur_rech

type variables
private integer ii_selinact
end variables

forward prototypes
public subroutine of_inserer (long al_row)
end prototypes

public subroutine of_inserer (long al_row);//Retourner la valeur du numéro

long	ll_no_eleveur, ll_actif, ll_rouge

IF al_row > 0 THEN
	ll_no_eleveur = dw_eleveur_rech.object.no_eleveur[al_row]
	ll_actif = dw_eleveur_rech.object.chkactivite[al_row]
	ll_rouge = dw_eleveur_rech.object.rouge[al_row]
	
	IF ll_actif = 0 THEN
		if ii_selinact = 1 then
			if gnv_app.inv_error.of_message("CIPQ0163") = 2 then return
		else
			gnv_app.inv_error.of_message("CIPQ0053")
			return
		end if
	END IF
	
	IF ll_rouge = 1 THEN
		if ii_selinact = 1 and ll_actif = 1 then
			if gnv_app.inv_error.of_message("CIPQ0164") = 2 then return
		else
			gnv_app.inv_error.of_message("CIPQ0162")
			return
		end if
	END IF
	
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("retour eleveur rech", string(ll_no_eleveur))
	close(THIS)
	
END IF
end subroutine

on w_eleveur_rech.create
int iCurrent
call super::create
this.uo_toolbar_gauche=create uo_toolbar_gauche
this.dw_eleveur_rech=create dw_eleveur_rech
this.rr_1=create rr_1
this.uo_toolbar=create uo_toolbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar_gauche
this.Control[iCurrent+2]=this.dw_eleveur_rech
this.Control[iCurrent+3]=this.rr_1
this.Control[iCurrent+4]=this.uo_toolbar
end on

on w_eleveur_rech.destroy
call super::destroy
destroy(this.uo_toolbar_gauche)
destroy(this.dw_eleveur_rech)
destroy(this.rr_1)
destroy(this.uo_toolbar)
end on

event open;call super::open;long		ll_retour
string	ls_insertion

ll_retour = dw_eleveur_rech.retrieve()

uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.POST of_displaytext(true)

uo_toolbar_gauche.of_settheme("classic")
uo_toolbar_gauche.of_DisplayBorder(true)
uo_toolbar_gauche.of_AddItem("Rechercher...", "Search!")
uo_toolbar_gauche.POST of_displaytext(true)

ls_insertion = gnv_app.inv_entrepotglobal.of_retournedonnee("insertion eleveur rech", FALSE)
IF ls_insertion = "oui" THEN
	dw_eleveur_rech.object.b_inserer.enabled = TRUE
ELSE
	dw_eleveur_rech.object.b_inserer.enabled = FALSE
END IF

ii_selinact = integer(gnv_app.inv_entrepotglobal.of_retournedonnee("eleveur rech rouges et inactifs"))
if isNull(ii_selinact) then ii_selinact = 0

end event

type uo_toolbar_gauche from u_cst_toolbarstrip within w_eleveur_rech
event destroy ( )
integer x = 18
integer y = 1076
integer width = 507
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar_gauche.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;IF dw_eleveur_rech.RowCount() > 0 THEN
	dw_eleveur_rech.SetRow(1)
	dw_eleveur_rech.ScrolltoRow(1)
	dw_eleveur_rech.event pfc_finddlg()
END IF
end event

type dw_eleveur_rech from u_dw within w_eleveur_rech
integer x = 64
integer y = 40
integer width = 1952
integer height = 976
integer taborder = 10
string dataobject = "d_eleveur_rech"
end type

event constructor;call super::constructor;THIS.of_setfind( true)
THIS.of_SetRowSelect(TRUE)
end event

event buttonclicked;call super::buttonclicked;//Retourner la valeur du numéro

parent.of_inserer(row)
end event

event doubleclicked;call super::doubleclicked;parent.of_inserer(row)
end event

type rr_1 from roundrectangle within w_eleveur_rech
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 18
integer y = 16
integer width = 2039
integer height = 1024
integer cornerheight = 40
integer cornerwidth = 46
end type

type uo_toolbar from u_cst_toolbarstrip within w_eleveur_rech
event destroy ( )
integer x = 1554
integer y = 1076
integer width = 507
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

