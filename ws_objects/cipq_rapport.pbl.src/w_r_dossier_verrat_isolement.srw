$PBExportHeader$w_r_dossier_verrat_isolement.srw
forward
global type w_r_dossier_verrat_isolement from w_rapport
end type
end forward

global type w_r_dossier_verrat_isolement from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Dossier des verrats en isolement"
end type
global w_r_dossier_verrat_isolement w_r_dossier_verrat_isolement

on w_r_dossier_verrat_isolement.create
call super::create
end on

on w_r_dossier_verrat_isolement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//Appliquer un filtre selon les arguments
long ll_lot
string	ls_tatouage

ll_lot = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien lot"))

dw_preview.Retrieve(ll_lot)

//Deux cas  - seulement un dossier, tous les dossiers d'un même verrat
IF gnv_app.inv_entrepotglobal.of_retournedonnee("type lien dossier") = "lot" THEN
	//Do nothing
ELSE
	//Filtre sur le verrat
	ls_tatouage = gnv_app.inv_entrepotglobal.of_retournedonnee("lien isolement tatouage")
	
	dw_preview.SetFilter ( "tatouage = '" + ls_tatouage + "'")
	dw_preview.Filter()
END IF

gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("type lien dossier", "")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien isolement tatouage", "")

end event

type dw_preview from w_rapport`dw_preview within w_r_dossier_verrat_isolement
string dataobject = "d_r_dossier_verrat_isolement"
end type

