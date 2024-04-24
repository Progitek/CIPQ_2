$PBExportHeader$w_recolte_externe.srw
forward
global type w_recolte_externe from w_sheet_frame
end type
type dw_recolte_externe from u_dw within w_recolte_externe
end type
type uo_toolbar from u_cst_toolbarstrip within w_recolte_externe
end type
type rr_1 from roundrectangle within w_recolte_externe
end type
end forward

global type w_recolte_externe from w_sheet_frame
string tag = "menu=m_recoltesexternes"
dw_recolte_externe dw_recolte_externe
uo_toolbar uo_toolbar
rr_1 rr_1
end type
global w_recolte_externe w_recolte_externe

on w_recolte_externe.create
int iCurrent
call super::create
this.dw_recolte_externe=create dw_recolte_externe
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_recolte_externe
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.rr_1
end on

on w_recolte_externe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_recolte_externe)
destroy(this.uo_toolbar)
destroy(this.rr_1)
end on

event open;call super::open;long 	ll_nbrow
date 	ld_date

ld_date = Today()

//Supprimer les enregistrement des jours antérieures
DELETE FROM t_recolte_externe where date_recolte < : ld_date ;
COMMIT USING SQLCA;

ll_nbrow = dw_recolte_externe.event pfc_retrieve()
IF ll_nbrow = 0 THEN
	dw_recolte_externe.event pfc_insertrow()
END IF
end event

event pfc_postopen;call super::pfc_postopen;setredraw(true)
uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter une récolte", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer cette récolte", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Rechercher une récolte...", "Search!")

uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_recolte_externe
integer x = 251
string text = "Ajout de récoltes externes"
end type

type p_8 from w_sheet_frame`p_8 within w_recolte_externe
integer x = 55
integer y = 44
integer width = 165
integer height = 92
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\recolte_externe.bmp"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_recolte_externe
end type

type dw_recolte_externe from u_dw within w_recolte_externe
integer x = 82
integer y = 248
integer width = 4439
integer height = 1692
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_recolte_externe"
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN THIS.Retrieve()
end event

event constructor;call super::constructor;THIS.of_setfind( true)
end event

event pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	long 		ll_retour, ll_no
	
	//Pousser les valeurs de la clé primaire
	THIS.object.date_recolte[AncestorReturnValue] = today()
	
	SELECT 	MAX(isnull(norecolte,0)) + 1 as cc_max
	INTO		:ll_no
	FROM		t_recolte_externe
	USING 	SQLCA;

	IF IsNull(ll_no) THEN ll_no = 1
	THIS.object.norecolte[AncestorReturnValue] = ll_no

END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from u_cst_toolbarstrip within w_recolte_externe
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2052
integer width = 4558
integer height = 108
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button

	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		event pfc_save()
		
	CASE "Fermer", "Close"		
		Close(parent)
		
	CASE "Ajouter une récolte"
		dw_recolte_externe.event pfc_insertrow()
		
	CASE "Supprimer cette récolte"
		dw_recolte_externe.event pfc_deleterow()
		
	CASE "Rechercher une récolte..."
		dw_recolte_externe.event pfc_finddlg()		
		
END CHOOSE

end event

type rr_1 from roundrectangle within w_recolte_externe
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 180
integer width = 4549
integer height = 1816
integer cornerheight = 40
integer cornerwidth = 46
end type

