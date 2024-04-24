$PBExportHeader$w_r_rejet_centre.srw
forward
global type w_r_rejet_centre from w_rapport
end type
end forward

global type w_r_rejet_centre from w_rapport
end type
global w_r_rejet_centre w_r_rejet_centre

on w_r_rejet_centre.create
call super::create
end on

on w_r_rejet_centre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_rejet_centre
string dataobject = "d_r_rejet_centre"
end type

