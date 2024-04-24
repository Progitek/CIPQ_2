$PBExportHeader$w_destination_verrat.srw
forward
global type w_destination_verrat from w_sheet_pilotage
end type
end forward

global type w_destination_verrat from w_sheet_pilotage
string tag = "menu=m_destinationsdesverrats"
end type
global w_destination_verrat w_destination_verrat

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

SELECT 	max(id_dest) + 1
INTO		:ll_no
FROM		t_verrat_dest
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_destination_verrat.create
int iCurrent
call super::create
end on

on w_destination_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_destination_verrat
string picturename = "C:\ii4net\CIPQ\images\go_forward.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_destination_verrat
end type

type st_title from w_sheet_pilotage`st_title within w_destination_verrat
string text = "Destinations des verrats"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_destination_verrat
string dataobject = "d_destination_verrat"
end type

event dw_pilotage::pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.id_DEST[AncestorReturnValue] = ll_no
	
END IF


RETURN AncestorReturnValue
end event

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Dest", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_destination_verrat
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_destination_verrat
end type

