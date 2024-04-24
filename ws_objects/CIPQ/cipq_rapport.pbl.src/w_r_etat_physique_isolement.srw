$PBExportHeader$w_r_etat_physique_isolement.srw
forward
global type w_r_etat_physique_isolement from w_rapport
end type
end forward

global type w_r_etat_physique_isolement from w_rapport
string title = "Rapport - État physique des verrats en isolement"
end type
global w_r_etat_physique_isolement w_r_etat_physique_isolement

on w_r_etat_physique_isolement.create
call super::create
end on

on w_r_etat_physique_isolement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nolot, ll_cpt, ll_nbligne

ll_nolot = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien lot"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", "")

ll_nbligne = dw_preview.retrieve(ll_nolot)
end event

type dw_preview from w_rapport`dw_preview within w_r_etat_physique_isolement
string dataobject = "d_r_etat_physique_isolement"
end type

