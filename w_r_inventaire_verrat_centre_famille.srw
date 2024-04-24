HA$PBExportHeader$w_r_inventaire_verrat_centre_famille.srw
forward
global type w_r_inventaire_verrat_centre_famille from w_rapport
end type
end forward

global type w_r_inventaire_verrat_centre_famille from w_rapport
string title = "Rapport - Inventaire des verrats par centre et famille de produits"
end type
global w_r_inventaire_verrat_centre_famille w_r_inventaire_verrat_centre_famille

on w_r_inventaire_verrat_centre_famille.create
call super::create
end on

on w_r_inventaire_verrat_centre_famille.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb
date	ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de)
end event

type dw_preview from w_rapport`dw_preview within w_r_inventaire_verrat_centre_famille
string dataobject = "d_r_inventaire_verrat_centre_famille"
end type

