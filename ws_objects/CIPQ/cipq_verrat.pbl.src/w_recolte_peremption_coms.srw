$PBExportHeader$w_recolte_peremption_coms.srw
forward
global type w_recolte_peremption_coms from w_response
end type
type uo_toolbar from u_cst_toolbarstrip within w_recolte_peremption_coms
end type
type dw_recolte_peremption_coms from u_dw within w_recolte_peremption_coms
end type
type rr_1 from roundrectangle within w_recolte_peremption_coms
end type
end forward

global type w_recolte_peremption_coms from w_response
integer x = 214
integer y = 221
integer width = 2459
integer height = 2768
string title = "Commentaires de récolte peremption"
boolean controlmenu = false
long backcolor = 12639424
uo_toolbar uo_toolbar
dw_recolte_peremption_coms dw_recolte_peremption_coms
rr_1 rr_1
end type
global w_recolte_peremption_coms w_recolte_peremption_coms

type variables
string	is_codeverrat = "", is_famille
date is_dater
end variables

forward prototypes
public subroutine of_save ()
end prototypes

public subroutine of_save ();
if dw_recolte_peremption_coms.update() = 1 then
	commit using SQLCA;
	dw_recolte_peremption_coms.retrieve(is_codeverrat,is_dater, is_famille)
else
	rollback using SQLCA;
end if
end subroutine

on w_recolte_peremption_coms.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_recolte_peremption_coms=create dw_recolte_peremption_coms
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_recolte_peremption_coms
this.Control[iCurrent+3]=this.rr_1
end on

on w_recolte_peremption_coms.destroy
call super::destroy
destroy(this.uo_toolbar)
destroy(this.dw_recolte_peremption_coms)
destroy(this.rr_1)
end on

event pfc_preopen;call super::pfc_preopen;long 	ll_nbrow
long i, ll_noverrat
string ls_noverrat

is_codeverrat = gnv_app.inv_entrepotglobal.of_retournedonnee("cote_peremption_coms")
is_dater = gnv_app.inv_entrepotglobal.of_retournedonnee("daterecolte")
is_famille = gnv_app.inv_entrepotglobal.of_retournedonnee("famille")

ll_nbrow = dw_recolte_peremption_coms.retrieve(is_codeverrat, is_dater, is_famille)

FOR i = 1 TO ll_nbrow
	ls_noverrat = dw_recolte_peremption_coms.getitemstring( i, 't_recolte_gestionlot_detail_codeverrat')
	SELECT count(noverrat) INTO :ll_noverrat FROM t_recolte_msg WHERE noverrat = :ls_noverrat;
	IF ll_noverrat = 0 THEN
		INSERT INTO t_recolte_msg(noverrat) VALUES (:ls_noverrat);
	END IF 
NEXT
end event

event pfc_postopen;call super::pfc_postopen;long 	ll_nbrow, ll_row
long i, ll_noverrat
string ls_noverrat

dw_recolte_peremption_coms.object.datawindow.readonly = "No"

ll_nbrow = dw_recolte_peremption_coms.retrieve(is_codeverrat, is_dater, is_famille)

uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("OK", "C:\ii4net\CIPQ\images\ok.gif")
uo_toolbar.of_displaytext(true)

end event

type uo_toolbar from u_cst_toolbarstrip within w_recolte_peremption_coms
integer x = 1906
integer y = 2572
integer taborder = 20
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;of_save()
close(parent)
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

type dw_recolte_peremption_coms from u_dw within w_recolte_peremption_coms
integer x = 69
integer y = 44
integer width = 2290
integer height = 2476
integer taborder = 10
string dataobject = "d_cote_peremption_coms"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationnever!
boolean ib_maj_ligne_par_ligne = false
boolean ib_champrequisrangeecourante = false
boolean ib_getfocus_en_cours = true
boolean ib_insertautomatique = false
boolean ib_confirmationdestruction = false
boolean ib_nouvelle_rangee = true
end type

event itemchanged;call super::itemchanged;//of_save()
end event

event clicked;call super::clicked;string ls_test
choose case dwo.name
	case 'b_copy'
		dw_recolte_peremption_coms.object.t_recolte_msg_msg[row]
		
		
		//dw_recolte_peremption_coms.object.t_recolte_msg_msg[row].copy()
		//copyrtf(this.object.t_recolte_msg_msg[this.getrow()].text)
	case 'b_paste'
end choose

//if dwo.name = 'b_paste' then 
	
//end if
end event

type rr_1 from roundrectangle within w_recolte_peremption_coms
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 28
integer width = 2377
integer height = 2532
integer cornerheight = 40
integer cornerwidth = 46
end type

