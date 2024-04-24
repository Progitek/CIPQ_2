$PBExportHeader$w_r_liste_males_a_recolter_complete.srw
forward
global type w_r_liste_males_a_recolter_complete from w_rapport
end type
end forward

global type w_r_liste_males_a_recolter_complete from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Liste des mâles à récolter complète"
end type
global w_r_liste_males_a_recolter_complete w_r_liste_males_a_recolter_complete

on w_r_liste_males_a_recolter_complete.create
call super::create
end on

on w_r_liste_males_a_recolter_complete.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;//Préparer les données

long	ll_cpt, ll_rowcount, ll_jour
string	ls_codeverrat 
date		ld_cur

gnv_app.of_dolistemale( date(today()) )

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

dw_preview.retrieve( )
end event

type dw_preview from w_rapport`dw_preview within w_r_liste_males_a_recolter_complete
string dataobject = "d_r_liste_males_a_recolter_complete"
end type

