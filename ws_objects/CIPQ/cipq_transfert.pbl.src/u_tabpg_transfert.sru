﻿$PBExportHeader$u_tabpg_transfert.sru
forward
global type u_tabpg_transfert from u_tabpg
end type
type dw_transfert_centre from u_dw within u_tabpg_transfert
end type
end forward

global type u_tabpg_transfert from u_tabpg
integer width = 4503
integer height = 1828
long backcolor = 15793151
string text = "Transfert"
long tabbackcolor = 15793151
dw_transfert_centre dw_transfert_centre
end type
global u_tabpg_transfert u_tabpg_transfert

forward prototypes
public subroutine of_voir ()
public subroutine of_retourner ()
end prototypes

public subroutine of_voir ();//of_voir
string	ls_repexportold, ls_fichier
long		ll_row

ll_row = dw_transfert_centre.GetRow()

IF ll_row > 0 THEN
	//Vérifier le répertoire d'exportation
	ls_repexportold = gnv_app.of_getvaleurini( "FTP", "EXPORTPATHOLD")
	IF LEN(ls_repexportold) > 0 THEN
		IF NOT FileExists(ls_repexportold) THEN
			gnv_app.inv_error.of_message("CIPQ0145")
			RETURN
		END IF
	ELSE
		gnv_app.inv_error.of_message("CIPQ0146")
		RETURN
	END IF
	IF RIGHT(ls_repexportold, 1) <> "\" THEN 	ls_repexportold += "\"
	
	ls_fichier = dw_transfert_centre.object.nomfichier[ll_row]
	
	RUN('notepad "' + ls_repexportold + ls_fichier + '"')
END IF
end subroutine

public subroutine of_retourner ();//of_retourner
long	ll_row

ll_row = dw_transfert_centre.GetRow()
IF ll_row > 0 THEN
	
END IF

RETURN
end subroutine

on u_tabpg_transfert.create
int iCurrent
call super::create
this.dw_transfert_centre=create dw_transfert_centre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_transfert_centre
end on

on u_tabpg_transfert.destroy
call super::destroy
destroy(this.dw_transfert_centre)
end on

type dw_transfert_centre from u_dw within u_tabpg_transfert
integer x = 32
integer y = 36
integer width = 4475
integer height = 1780
integer taborder = 10
string dataobject = "d_transfert_centre"
end type

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
		
	CASE "b_voir"
		//ouvrir le fichier
		parent.of_voir()
		
	CASE "b_retourner"
		//Relancer la commande
		parent.of_retourner()
		
END CHOOSE
end event
