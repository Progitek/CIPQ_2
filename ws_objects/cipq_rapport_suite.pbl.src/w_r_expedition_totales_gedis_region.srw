$PBExportHeader$w_r_expedition_totales_gedis_region.srw
forward
global type w_r_expedition_totales_gedis_region from w_rapport
end type
end forward

global type w_r_expedition_totales_gedis_region from w_rapport
end type
global w_r_expedition_totales_gedis_region w_r_expedition_totales_gedis_region

on w_r_expedition_totales_gedis_region.create
call super::create
end on

on w_r_expedition_totales_gedis_region.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;date	ld_de, ld_au
string ls_facture

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")
ls_facture = gnv_app.inv_entrepotglobal.of_retournedonnee("lien facture")
if ls_facture = "" then setnull(ls_facture)

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

dw_preview.retrieve(datetime(ld_de, 00:00:00), datetime(ld_au, 23:59:59.999999), ls_Facture )
end event

type dw_preview from w_rapport`dw_preview within w_r_expedition_totales_gedis_region
string dataobject = "d_r_expedition_totales_gedis_region"
end type

