$PBExportHeader$w_emplacement_verrat.srw
forward
global type w_emplacement_verrat from w_response
end type
type dw_emplacement_verrat from u_dw within w_emplacement_verrat
end type
type uo_toolbar from u_cst_toolbarstrip within w_emplacement_verrat
end type
type st_1 from statictext within w_emplacement_verrat
end type
type rr_1 from roundrectangle within w_emplacement_verrat
end type
type rr_2 from roundrectangle within w_emplacement_verrat
end type
end forward

global type w_emplacement_verrat from w_response
string tag = "menu=m_verrats"
integer x = 214
integer y = 221
integer width = 1842
integer height = 1384
long backcolor = 12639424
dw_emplacement_verrat dw_emplacement_verrat
uo_toolbar uo_toolbar
st_1 st_1
rr_1 rr_1
rr_2 rr_2
end type
global w_emplacement_verrat w_emplacement_verrat

type variables
string is_tatouage, is_cieno
boolean ib_change = false
end variables

forward prototypes
public subroutine of_ajouter ()
public subroutine of_enregistrer ()
public subroutine of_supprimer ()
end prototypes

public subroutine of_ajouter ();long ll_row

ll_row = dw_emplacement_verrat.event pfc_insertrow()
dw_emplacement_verrat.setItem(ll_row,'tatouage',is_tatouage)
dw_emplacement_verrat.setItem(ll_row,'dateemplacement',today())
dw_emplacement_verrat.setItem(ll_row,'cie_no',is_cieno)
ib_change = true

end subroutine

public subroutine of_enregistrer ();//Mettre le TransDate à null
long		ll_row
datetime	ldt_null

SetNull(ldt_null)
ll_row = dw_emplacement_verrat.GetRow()
IF ll_row > 0 THEN
	//Gestion des données pour le transfert
	dw_emplacement_verrat.object.transdate[ll_row] = ldt_null
END IF

this.event pfc_save()

//if ib_change then
//	if dw_emplacement_verrat.update() = 1 then
//		commit using SQLCA;
//		ib_change = true
//	else
//		rollback using SQLCA;
//	end if	
//end if
end subroutine

public subroutine of_supprimer ();dw_emplacement_verrat.deleteRow(dw_emplacement_verrat.getRow())
ib_change = true 
end subroutine

on w_emplacement_verrat.create
int iCurrent
call super::create
this.dw_emplacement_verrat=create dw_emplacement_verrat
this.uo_toolbar=create uo_toolbar
this.st_1=create st_1
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_emplacement_verrat
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.rr_1
this.Control[iCurrent+5]=this.rr_2
end on

on w_emplacement_verrat.destroy
call super::destroy
destroy(this.dw_emplacement_verrat)
destroy(this.uo_toolbar)
destroy(this.st_1)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

dw_emplacement_verrat.event pfc_retrieve( )



end event

event pfc_preopen;call super::pfc_preopen;is_tatouage = gnv_app.inv_entrepotglobal.of_retournedonnee("tatouage_emplacement")
is_cieno = gnv_app.inv_entrepotglobal.of_retournedonnee("cieno_emplacement")
end event

type dw_emplacement_verrat from u_dw within w_emplacement_verrat
integer x = 32
integer y = 156
integer width = 1765
integer height = 996
integer taborder = 10
string dataobject = "d_emplacement_verrat"
end type

event itemchanged;call super::itemchanged;ib_change = true
end event

event pfc_retrieve;call super::pfc_retrieve;retrieve(is_tatouage)
return 0
end event

type uo_toolbar from u_cst_toolbarstrip within w_emplacement_verrat
integer x = 5
integer y = 1188
integer width = 1819
integer taborder = 10
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string ls_emplacement

CHOOSE CASE as_button
	CASE "Ajouter"
		of_ajouter()
	CASE "Supprimer"
		of_supprimer()
	CASE "Enregistrer"
		of_enregistrer()
	CASE "Fermer"
		select 	first emplacement into :ls_emplacement 
		from 		t_emplacementverrat 
		where 	tatouage = :is_tatouage
		order by	dateemplacement desc;					
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("Nouvelle emplacement verrat", ls_emplacement)
		close(parent)
END CHOOSE

end event

type st_1 from statictext within w_emplacement_verrat
integer x = 55
integer y = 32
integer width = 923
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Emplacement des verrats"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_emplacement_verrat
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 14
integer y = 12
integer width = 1801
integer height = 112
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_emplacement_verrat
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 14
integer y = 140
integer width = 1801
integer height = 1028
integer cornerheight = 40
integer cornerwidth = 46
end type

