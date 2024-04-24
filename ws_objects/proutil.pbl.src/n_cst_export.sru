$PBExportHeader$n_cst_export.sru
forward
global type n_cst_export from n_base
end type
end forward

global type n_cst_export from n_base autoinstantiate
end type

forward prototypes
public subroutine of_exportcsv (readonly u_dw adw_export)
public subroutine of_exportsql (readonly u_dw adw_export)
public subroutine of_exporthtml (u_dw adw_export)
public subroutine of_exportpdf (u_dw adw_export)
public subroutine of_exportexcel (blob ablb_data)
end prototypes

public subroutine of_exportcsv (readonly u_dw adw_export);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ExportCSV
//
//	Accès:  			Public
//
//	Argument:		dw à exporter
//
// Retourne:  		Rien
//
//	Description:	Fonction pour Exporter une datawindow en csv
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string	ls_path_dlg, ls_fichier_dlg, ls_fichier_def, ls_rep
integer	li_retour_dlg, li_retour_boucle = 0, li_question

SetPointer(HourGlass!)

//ls_rep = gnv_app.inv_preference.of_RecupererPreference("path_xls","ATM")
ls_rep = "Par l'application"
IF ls_rep = "Par l'application" THEN
	ls_path_dlg = gnv_app.is_reptemporaire + "\*.csv"
ELSE
	IF RIGHT(ls_rep,1) <> "\" THEN
		ls_path_dlg = ls_rep + "\*.csv"
	ELSE
		ls_path_dlg = ls_rep + "*.csv"
	END IF
END IF

li_retour_dlg = GetFileSaveName ( "Exporter en CSV", ls_path_dlg, ls_fichier_dlg , "csv" , "Fichiers CSV (*.csv),*.csv")
DO WHILE li_retour_boucle = 0
	IF li_retour_dlg = 1 THEN
		ls_fichier_def = ls_path_dlg
		IF FileExists(ls_fichier_def) = TRUE THEN
			li_question = gnv_app.inv_error.of_Message("ATM-0106")
			IF li_question = 2 THEN //Ne veut pas l'écraser
				li_retour_dlg = GetFileSaveName ( "Exporter en CSV", ls_path_dlg, ls_fichier_dlg , "csv" , "Fichiers CSV (*.csv),*.csv")
			ELSE //Veut l'écraser
				li_retour_boucle = 1
			END IF
		ELSE //Nouveau fichier
			li_retour_boucle = 1
		END IF
	ELSE
		RETURN
	END IF
LOOP

SetPointer(Hourglass!)

adw_export.SaveAs(ls_fichier_dlg, CSV!, TRUE)
end subroutine

public subroutine of_exportsql (readonly u_dw adw_export);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ExportSQL
//
//	Accès:  			Public
//
//	Argument:		dw à exporter
//
// Retourne:  		Rien
//
//	Description:	Fonction pour Exporter une datawindow en SQLInsert
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string	ls_path_dlg, ls_fichier_dlg, ls_fichier_def, ls_rep
integer	li_retour_dlg, li_retour_boucle = 0, li_question

SetPointer(HourGlass!)

//ls_rep = gnv_app.inv_preference.of_RecupererPreference("path_xls","ATM")
ls_rep = "Par l'application"
IF ls_rep = "Par l'application" THEN
	ls_path_dlg = gnv_app.is_reptemporaire + "\*.sql"
ELSE
	IF RIGHT(ls_rep,1) <> "\" THEN
		ls_path_dlg = ls_rep + "\*.sql"
	ELSE
		ls_path_dlg = ls_rep + "*.sql"
	END IF
END IF

li_retour_dlg = GetFileSaveName ( "Exporter en SQL", ls_path_dlg, ls_fichier_dlg , "sql" , "Fichiers SQL (*.sql),*.sql")
DO WHILE li_retour_boucle = 0
	IF li_retour_dlg = 1 THEN
		ls_fichier_def = ls_path_dlg
		IF FileExists(ls_fichier_def) = TRUE THEN
			li_question = gnv_app.inv_error.of_Message("ATM-0106")
			IF li_question = 2 THEN //Ne veut pas l'écraser
				li_retour_dlg = GetFileSaveName ( "Exporter en SQL", ls_path_dlg, ls_fichier_dlg , "sql" , "Fichiers SQL (*.sql),*.sql")
			ELSE //Veut l'écraser
				li_retour_boucle = 1
			END IF
		ELSE //Nouveau fichier
			li_retour_boucle = 1
		END IF
	ELSE
		RETURN
	END IF
LOOP

SetPointer(Hourglass!)

adw_export.SaveAs(ls_fichier_dlg, SQLInsert!, TRUE)
end subroutine

public subroutine of_exporthtml (u_dw adw_export);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ExportHTML
//
//	Accès:  			Public
//
//	Argument:		dw à exporter
//
// Retourne:  		Rien
//
//	Description:	Fonction pour Exporter une datawindow en HTML Table
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string	ls_path_dlg, ls_fichier_dlg, ls_fichier_def, ls_rep
integer	li_retour_dlg, li_retour_boucle = 0, li_question

SetPointer(HourGlass!)

//ls_rep = gnv_app.inv_preference.of_RecupererPreference("path_xls","ATM")
ls_rep = "Par l'application"
IF ls_rep = "Par l'application" THEN
	ls_path_dlg = gnv_app.is_reptemporaire + "\*.htm"
ELSE
	IF RIGHT(ls_rep,1) <> "\" THEN
		ls_path_dlg = ls_rep + "\*.htm"
	ELSE
		ls_path_dlg = ls_rep + "*.htm"
	END IF
END IF

li_retour_dlg = GetFileSaveName ( "Exporter en HTML", ls_path_dlg, ls_fichier_dlg , "htm" , "Fichiers HTML (*.htm),*.htm")
DO WHILE li_retour_boucle = 0
	IF li_retour_dlg = 1 THEN
		ls_fichier_def = ls_path_dlg
		IF FileExists(ls_fichier_def) = TRUE THEN
			li_question = gnv_app.inv_error.of_Message("ATM-0106")
			IF li_question = 2 THEN //Ne veut pas l'écraser
				li_retour_dlg = GetFileSaveName ( "Exporter en HTML", ls_path_dlg, ls_fichier_dlg , "htm" , "Fichiers HTML (*.htm),*.htm")
			ELSE //Veut l'écraser
				li_retour_boucle = 1
			END IF
		ELSE //Nouveau fichier
			li_retour_boucle = 1
		END IF
	ELSE
		RETURN
	END IF
LOOP

SetPointer(Hourglass!)

adw_export.SaveAs(ls_fichier_dlg, HTMLTable!, TRUE)
end subroutine

public subroutine of_exportpdf (u_dw adw_export);string	ls_path_dlg, ls_fichier_dlg, ls_fichier_def, ls_rep
integer	li_retour_dlg, li_retour_boucle = 0, li_question

SetPointer(HourGlass!)

ls_rep = "Par l'application"
IF ls_rep = "Par l'application" THEN
	ls_path_dlg = gnv_app.is_reptemporaire + "\*.pdf"
ELSE
	IF RIGHT(ls_rep,1) <> "\" THEN
		ls_path_dlg = ls_rep + "\*.pdf"
	ELSE
		ls_path_dlg = ls_rep + "*.pdf"
	END IF
END IF

li_retour_dlg = GetFileSaveName ( "Exporter en PDF", ls_path_dlg, ls_fichier_dlg , "pdf" , "Fichiers PDF (*.pdf),*.pdf")
DO WHILE li_retour_boucle = 0
	IF li_retour_dlg = 1 THEN
		ls_fichier_def = ls_path_dlg
		IF FileExists(ls_fichier_def) = TRUE THEN
			li_question = gnv_app.inv_error.of_Message("ATM-0106")
			IF li_question = 2 THEN //Ne veut pas l'écraser
				li_retour_dlg = GetFileSaveName ( "Exporter en PDF", ls_path_dlg, ls_fichier_dlg , "pdf" , "Fichiers PDF (*.pdf),*.pdf")
			ELSE //Veut l'écraser
				li_retour_boucle = 1
			END IF
		ELSE //Nouveau fichier
			li_retour_boucle = 1
		END IF
	ELSE
		RETURN
	END IF
LOOP

SetPointer(Hourglass!)

adw_export.SaveAs(ls_fichier_dlg, PDF!, TRUE)
end subroutine

public subroutine of_exportexcel (blob ablb_data);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_ExportExcel
//
//	Accès:  			Public
//
//	Argument:		Blob contenant la dw
//
// Retourne:  		Rien
//
//	Description:	Fonction pour Exporter une datawindow en Excel
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

n_ds		lds_export
long		ll_cpt, ll_cpt_col, ll_nbcolonne
string	ls_contenu, ls_type, ls_path_dlg, ls_fichier_dlg, ls_fichier_def, &
			ls_rep
integer	li_retour_dlg, li_retour_boucle = 0, li_question

SetPointer(HourGlass!)

//ls_rep = gnv_app.inv_preference.of_RecupererPreference("path_xls","ATM")
ls_rep = "Par l'application"
IF ls_rep = "Par l'application" THEN
	ls_path_dlg = gnv_app.is_reptemporaire + "\*.xls"
ELSE
	IF RIGHT(ls_rep,1) <> "\" THEN
		ls_path_dlg = ls_rep + "\*.xls"
	ELSE
		ls_path_dlg = ls_rep + "*.xls"
	END IF
END IF

li_retour_dlg = GetFileSaveName ( "Exporter en Excel", ls_path_dlg, ls_fichier_dlg , "xls" , "Fichiers Excel (*.xls),*.xls")
DO WHILE li_retour_boucle = 0
	IF li_retour_dlg = 1 THEN
		ls_fichier_def = ls_path_dlg
		IF FileExists(ls_fichier_def) = TRUE THEN
			li_question = gnv_app.inv_error.of_Message("ATM-0106")
			IF li_question = 2 THEN //Ne veut pas l'écraser
				li_retour_dlg = GetFileSaveName ( "Exporter en Excel", ls_path_dlg, ls_fichier_dlg , "xls" , "Fichiers Excel (*.xls),*.xls")
			ELSE //Veut l'écraser
				li_retour_boucle = 1
			END IF
		ELSE //Nouveau fichier
			li_retour_boucle = 1
		END IF
	ELSE
		RETURN
	END IF
LOOP

SetPointer(Hourglass!)

lds_export = CREATE n_ds
lds_export.SetFullState(ablb_data)
ll_nbcolonne = long(lds_export.Object.DataWindow.Column.Count)

FOR ll_cpt = 1 TO lds_export.RowCount()
	//Enlever les tabs et autre caractère non-imprimable
	FOR ll_cpt_col = 1 TO ll_nbcolonne
		
		ls_type = LEFT(lds_export.Describe( "#" + string(ll_cpt_col) + ".coltype" ), 5)
		
		//Traiter seulement les colonnes textes pour les tabs
		IF ls_type = "char(" OR ls_type = "varch" THEN
			ls_contenu = lds_export.GetItemString( ll_cpt, ll_cpt_col)
			gnv_app.inv_string.of_RemoveNonPrint(ls_contenu)
			lds_export.SetItem( ll_cpt, ll_cpt_col, ls_contenu)
		END IF
	NEXT
NEXT

lds_export.SaveAs(ls_fichier_def, Excel8!, TRUE)

//IF lds_export.SaveAsAscii ( ls_fichier_def) = -1 THEN
//	//Problème lors de la sauvegarde, probablement le fichier déjà ouvert
//	gnv_app.inv_error.of_Message("ATM-0210")
//END IF

If IsValid(lds_export) THEN Destroy(lds_export)
end subroutine

on n_cst_export.create
call super::create
end on

on n_cst_export.destroy
call super::destroy
end on

