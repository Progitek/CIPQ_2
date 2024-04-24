$PBExportHeader$w_depot_spa.srw
forward
global type w_depot_spa from w_sheet_pilotage
end type
end forward

global type w_depot_spa from w_sheet_pilotage
string tag = "menu=m_depotduspa"
end type
global w_depot_spa w_depot_spa

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

SELECT 	max(id_depot) + 1
INTO		:ll_no
FROM		t_depot_spa
USING 	SQLCA;

IF IsNull(ll_no) THEN ll_no = 1

RETURN ll_no
end function

on w_depot_spa.create
int iCurrent
call super::create
end on

on w_depot_spa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_depot_spa
integer width = 87
integer height = 72
string picturename = "C:\ii4net\CIPQ\images\foldopen.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_depot_spa
end type

type st_title from w_sheet_pilotage`st_title within w_depot_spa
string text = "Dépôt SPA"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_depot_spa
string dataobject = "d_depot_spa"
end type

event dw_pilotage::pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	
	long 		ll_no
	ll_no = PARENT.of_recupererprochainnumero()
	THIS.object.id_depot[AncestorReturnValue] = ll_no
	
END IF


RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_depot_spa
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_depot_spa
end type

