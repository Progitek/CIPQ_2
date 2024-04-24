$PBExportHeader$w_r_suivi_courriel_facturation.srw
forward
global type w_r_suivi_courriel_facturation from w_rapport
end type
end forward

global type w_r_suivi_courriel_facturation from w_rapport
string title = "Rapport - Suivi des courriels (Facturation)"
string menuname = "m_rapport_transfert"
event ue_transfertinternet ( )
end type
global w_r_suivi_courriel_facturation w_r_suivi_courriel_facturation

on w_r_suivi_courriel_facturation.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_rapport_transfert" then this.MenuID = create m_rapport_transfert
end on

on w_r_suivi_courriel_facturation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

SetPointer(Hourglass!)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.Retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_suivi_courriel_facturation
string dataobject = "d_r_suivi_courriel_facturation"
end type

event dw_preview::constructor;call super::constructor;//Mettre le menu disponible
n_cst_menu 	lnv_menu
menu			lm_item, lm_menu

lm_menu = parent.MenuID
lnv_menu.of_GetMenuReference (lm_menu,"m_tiri", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_trier", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE

lnv_menu.of_GetMenuReference (lm_menu,"m_filtrer", lm_item)
lm_item.visible = TRUE
lm_item.toolbaritemvisible = TRUE
end event

event dw_preview::pfc_filterdlg;call super::pfc_filterdlg;dw_preview.Post GroupCalc()

//Vérifier le filtre
string	ls_filtre
ls_filtre = gnv_app.inv_entrepotglobal.of_retournedonnee("Filtre affichage", FALSE)

IF ls_filtre <> "" AND Not(IsNull(ls_filtre)) THEN
	IF POS(ls_filtre, "Sous-") > 0 THEN
		dw_preview.object.cf_som.visible = 0
		dw_preview.object.cf_totalgroupe.visible = 0
		dw_preview.object.cf_montant.visible = 0
		dw_preview.object.cf_tps.visible = 0
		dw_preview.object.cf_tvq.visible = 0
		dw_preview.object.cf_totalg.visible = 0
	END IF
END IF

RETURN AncestorReturnValue
end event

event dw_preview::clicked;call super::clicked;string ls_nomdoc		 
n_cst_syncproc luo_sync

if row > 0 then
	if dwo.name = "pathfile" then	
		ls_nomdoc = gnv_app.of_getPathDefault() +gnv_app.of_getODBC()+"\pdf\" + dw_preview.getItemString(row,'pathfile')			
		luo_sync = CREATE n_cst_syncproc
		luo_sync.of_setwindow('normal')
		luo_sync.of_RunAndWait('"' + ls_nomdoc + '"')
		IF IsValid(luo_sync) THEN destroy luo_sync
	end if
end if
end event

