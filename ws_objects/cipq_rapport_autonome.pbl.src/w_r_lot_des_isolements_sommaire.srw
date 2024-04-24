$PBExportHeader$w_r_lot_des_isolements_sommaire.srw
forward
global type w_r_lot_des_isolements_sommaire from w_rapport
end type
end forward

global type w_r_lot_des_isolements_sommaire from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Lots des isolements (sommaire)"
end type
global w_r_lot_des_isolements_sommaire w_r_lot_des_isolements_sommaire

on w_r_lot_des_isolements_sommaire.create
call super::create
end on

on w_r_lot_des_isolements_sommaire.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long		ll_nbligne
string	ls_date

/*ls_date = gnv_app.inv_entrepotglobal.of_retournedonnee("lien rapport recolte commande date")
IF ls_date = "" OR isnull(ls_date) OR ls_date = "00-00-0000" THEN
	ls_date = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")
ELSE
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien rapport recolte commande date", "")
END IF
*/

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nbligne = dw_preview.retrieve(date(ls_date))

end event

type dw_preview from w_rapport`dw_preview within w_r_lot_des_isolements_sommaire
string dataobject = "d_r_lot_des_isolements_sommaire"
boolean ib_insertautomatique = false
end type

