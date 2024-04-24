$PBExportHeader$w_sous_code_hebergeur.srw
forward
global type w_sous_code_hebergeur from w_sheet_pilotage
end type
end forward

global type w_sous_code_hebergeur from w_sheet_pilotage
string tag = "menu=m_codesdeshebergeurs"
end type
global w_sous_code_hebergeur w_sous_code_hebergeur

on w_sous_code_hebergeur.create
int iCurrent
call super::create
end on

on w_sous_code_hebergeur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_sous_code_hebergeur
string tag = ""
boolean originalsize = false
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_sous_code_hebergeur
string tag = ""
integer linethickness = 0
end type

type st_title from w_sheet_pilotage`st_title within w_sous_code_hebergeur
string tag = ""
string text = "Sous codes des hébergeurs"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_sous_code_hebergeur
integer width = 3392
integer taborder = 0
string dataobject = "d_code_soushebergeur"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_CodeHebergeur", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_sous_code_hebergeur
string tag = ""
integer width = 3529
integer taborder = 0
boolean bringtotop = false
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_sous_code_hebergeur
integer linethickness = 0
integer cornerheight = 75
integer cornerwidth = 75
end type

