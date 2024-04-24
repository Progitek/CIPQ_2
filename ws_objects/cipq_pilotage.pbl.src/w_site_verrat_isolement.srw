$PBExportHeader$w_site_verrat_isolement.srw
forward
global type w_site_verrat_isolement from w_sheet_pilotage
end type
end forward

global type w_site_verrat_isolement from w_sheet_pilotage
string tag = "menu=m_sitesdesverratsenisolement"
end type
global w_site_verrat_isolement w_site_verrat_isolement

forward prototypes
public function integer of_recupererprochainnumero ()
end prototypes

public function integer of_recupererprochainnumero ();//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_recupererprochainnumero
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		Numéro 
//
// Description:	Fonction pour trouver la valeur du prochain numéro 
//						
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//	2008-11-12	Mathieu Gendron	Création
//
//////////////////////////////////////////////////////////////////////////////

long	ll_no

SELECT 	max(nosite) + 1
INTO		:ll_no
FROM		t_isolementsite
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_site_verrat_isolement.create
int iCurrent
call super::create
end on

on w_site_verrat_isolement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;
//Override

long		ll_retour, ll_site

ll_site = long(gnv_app.inv_entrepotglobal.of_retournedonnee( "lien site"))
IF dw_pilotage.event pfc_retrieve() > 0 THEN
	IF IsNull(ll_site) = FALSE AND ll_site <> 0 THEN
		gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien site", "")
		ll_retour = dw_pilotage.Find("nosite = " + string(ll_site) , 1, dw_pilotage.RowCount())
		IF ll_retour > 0 THEN
			dw_pilotage.SetRow(ll_retour)
			dw_pilotage.ScrollToRow(ll_retour)
		END IF
	END IF
END IF
end event

type p_8 from w_sheet_pilotage`p_8 within w_site_verrat_isolement
integer x = 73
integer y = 48
string picturename = "C:\ii4net\CIPQ\images\listview_datawindow.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_site_verrat_isolement
end type

type st_title from w_sheet_pilotage`st_title within w_site_verrat_isolement
string text = "Sites des verrats en isolement"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_site_verrat_isolement
string dataobject = "d_site_verrat_isolement"
end type

event dw_pilotage::constructor;call super::constructor;SetRowFocusIndicator(OFF!)
end event

event dw_pilotage::pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.nosite[AncestorReturnValue] = ll_no
	
END IF


RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_site_verrat_isolement
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_site_verrat_isolement
end type

