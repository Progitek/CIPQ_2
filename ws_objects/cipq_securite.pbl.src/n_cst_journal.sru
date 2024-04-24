$PBExportHeader$n_cst_journal.sru
forward
global type n_cst_journal from nonvisualobject
end type
end forward

global type n_cst_journal from nonvisualobject
end type
global n_cst_journal n_cst_journal

type variables

end variables

forward prototypes
public function integer of_imprimerjournal ()
end prototypes

public function integer of_imprimerjournal ();//////////////////////////////////////////////////////////////////////////////
//
// Méthode:		of_ImprimerJournal
//
// Accès:		Public
//
// Argument:	Aucun
//
// Retourne:	Integer, 1 si succes, 0 si rien à imprimer, -1 si erreur
//
//////////////////////////////////////////////////////////////////////////////
//
// Historique
//
// Date			Programmeur				Description
//	2008-05-14	Sébastien Tremblay	Imprimer le journal (log)  
// 2008-09-25	Mathieu Gendron		Paper feed
//	2008-11-02	Mathieu Gendron		Ajout de la table de log de préimpression
//
//////////////////////////////////////////////////////////////////////////////

long 		ll_nb_rows, ll_nbligne, li_bytes, ll_newrow, ll_pos //, ll_cpt
n_ds 		lds_journal
integer 	li_fich, li_fich2
string 	ls_port, ls_descriptioncommande, ls_source, ls_left, ls_fin, ls_cieno, ls_nomfile, ls_fichier, ls_linefich
string 	ls_fullstring, ls_imp, ls_printdefault
datetime	ld_now
datastore ds_log

ds_log = create datastore
ds_log.dataobject = 'd_impbackup'

ld_now = datetime(today(), now())

lds_journal = create n_ds

lds_journal.dataobject = "d_r_journalcommandes"
lds_journal.setTransObject(SQLCA)

ll_nb_rows = lds_journal.retrieve()

// Si aucune rangée, on retourne 0,
// si erreur, on le signale dans la valeur de retour
choose case ll_nb_rows
	// Aucune commande à imprimer
	case 0
		return 0
	// Erreur
	case is < 0
		return -1
end choose

// Impression
// Ancienne ligne, on change la façon de faire parce que ça paper feed quand l'impression est terminée
// if lds_journal.print(false, false) < 1 then return -1


/*******************************************************

ls_port = gnv_app.of_getValeurIni("IMPRIMANTE", "Journalcommande")
if ls_port = "" then
	IF gnv_app.of_getcompagniedefaut( ) = "112" THEN
		ls_port = "LPT2"
	ELSE 
		ls_port = "LPT1"
	END IF
end if

li_fich = fileOpen(ls_port, linemode!, write!)

************************************************/

ls_cieno = gnv_app.of_getcompagniedefaut( )
ls_port = gnv_app.of_getValeurIni("IMPRIMANTE", "Journalcommande")
ls_imp = gnv_app.of_getValeurIni("IMPRIMANTE", "Journalimp")

do while ll_nb_rows > 0
	
	select isnull(idfichier,''), isnull(nbligne,0) into :ls_nomfile, :ll_nbligne from t_centrecipq where cie = :ls_cieno;

	if ll_nbligne = 0 or ll_nbligne = 20 or ls_nomfile = '' then
		ls_nomfile = string(today(),'yyyy-mm-dd') + string(now(),"hh-mm-ss") + ".txt"
		update t_centrecipq set idfichier = :ls_nomfile  where cie = :ls_cieno;
	end if
	
	ls_fichier = ls_port + ' ' + ls_nomfile
	li_fich = fileOpen(ls_fichier, linemode!, write!)
	
//	FOR ll_cpt = ll_nb_rows TO 1 STEP -1
	ls_descriptioncommande = lds_journal.object.descriptioncommande[1]
	
	INSERT INTO t_log_commande VALUES (:ld_now , :ls_descriptioncommande) USING SQLCA;
	COMMIT USING SQLCA;
	
	ls_left = LEFT(ls_descriptioncommande, 62)
	ls_fin = MID(ls_descriptioncommande, 63)
	ls_source = lds_journal.object.source[1]
	IF IsNull(ls_source) THEN ls_source = ""
	fileWrite(li_fich, ls_left + ls_source)
	IF Not IsNull(ls_fin) AND ls_fin <> "" THEN
		fileWrite(li_fich, ls_fin)
	END IF
	//Détruire la ligne
	lds_journal.DeleteRow(1)
	if lds_journal.event pfc_update(true, true) < 1 then return -1
//	END FOR
	
	// Suppression 
	//if lds_journal.rowsMove(1, ll_nb_rows, Primary!, lds_journal, 1, Delete!) < 1 then return -1
	//do while yield()
	//loop
	//
	//if lds_journal.event pfc_update(true, true) < 1 then return -1
	
	// On récupère la ligne suivante
	
	ll_nb_rows = lds_journal.retrieve()
	
	fileClose(li_fich)
	ll_nbligne++
	
	if ll_nbligne = 20 then
		
		ds_log.reset()
		
		li_fich2 = fileOpen(ls_fichier, linemode!, read!)
		li_bytes = FileRead(li_fich2,ls_linefich)
		
		DO WHILE li_bytes <> -100
		
			ll_newrow = ds_log.insertRow(0)
			ds_log.setItem(ll_newrow,'ligne',ls_linefich)
			
			li_bytes = FileRead(li_fich2,ls_linefich)
	
		LOOP
		
		fileclose(li_fich2)
		
  	
	 	ls_fullstring=PrintGetPrinter()
		ll_pos=pos (ls_fullstring, "~t")
		ls_printdefault=left(ls_fullstring, ll_pos -1)
		PrintSetPrinter (ls_imp)
		ds_log.print()
		PrintSetPrinter (ls_printdefault)
		
		update t_centrecipq set nbligne = 0  where cie = :ls_cieno;
		COMMIT USING SQLCA;
		
	else
		
		update t_centrecipq set nbligne = :ll_nbligne  where cie = :ls_cieno;
		COMMIT USING SQLCA;
		
	end if
	
	
	
	
loop

destroy ds_log

do while yield()
loop

if isValid(lds_journal) then destroy(lds_journal)

return 1

end function

on n_cst_journal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_journal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

