$PBExportHeader$w_transfert.srw
forward
global type w_transfert from w_sheet_frame
end type
type tab_transfert from u_tab_transfert_centre within w_transfert
end type
type tab_transfert from u_tab_transfert_centre within w_transfert
end type
type st_message from statictext within w_transfert
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_transfert
end type
type st_impression from statictext within w_transfert
end type
type st_odbc from statictext within w_transfert
end type
type st_pathexe from statictext within w_transfert
end type
end forward

global type w_transfert from w_sheet_frame
string title = "Transfert de commande"
tab_transfert tab_transfert
st_message st_message
uo_toolbar2 uo_toolbar2
st_impression st_impression
st_odbc st_odbc
st_pathexe st_pathexe
end type
global w_transfert w_transfert

type variables
private:

	long il_interval = 0
	long il_cntTimer = 0
	boolean ib_ImpJournal = false
	long il_intervalold = 720
	long il_cntTimerold = 720 //24 heures à coup de 2 minutes
end variables

forward prototypes
public subroutine of_demarrertimer ()
public subroutine of_arretertimer ()
end prototypes

public subroutine of_demarrertimer ();// Fonction of_DemarrerTimer
// fonction qui active le timer toutes les 60 secondes

timer(60, this)
end subroutine

public subroutine of_arretertimer ();// Fonction of_ArreterTimer
// fonction qui arrête l'exécution du timer

timer(0, this)
end subroutine

on w_transfert.create
int iCurrent
call super::create
this.tab_transfert=create tab_transfert
this.st_message=create st_message
this.uo_toolbar2=create uo_toolbar2
this.st_impression=create st_impression
this.st_odbc=create st_odbc
this.st_pathexe=create st_pathexe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_transfert
this.Control[iCurrent+2]=this.st_message
this.Control[iCurrent+3]=this.uo_toolbar2
this.Control[iCurrent+4]=this.st_impression
this.Control[iCurrent+5]=this.st_odbc
this.Control[iCurrent+6]=this.st_pathexe
end on

on w_transfert.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_transfert)
destroy(this.st_message)
destroy(this.uo_toolbar2)
destroy(this.st_impression)
destroy(this.st_odbc)
destroy(this.st_pathexe)
end on

event pfc_postopen;call super::pfc_postopen;il_interval = long(gnv_app.of_getValeurIni("FTP", "TIMER_INTERVAL")) 
IF ISNull(il_interval) OR il_interval = 0 THEN il_interval = 5
// il_interval = 5
ib_ImpJournal = (lower(trim(gnv_app.of_getValeurIni("DATABASE", "SaveToPrinter"))) = 'true')

SetPointer(HourGlass!)
tab_transfert.tabpage_transfert.dw_transfert_centre.Retrieve()

//THIS.event timer()
//
//of_demarrertimer()


end event

event timer;call super::timer;n_zlib luo_zlib
n_runandwait luo_run
n_cst_process luo_process
n_cst_dirattrib luo_attrib[]
n_cst_filesrvwin32 luo_files
ULONG lul_ProcessIDList[], lul_unzFile
string ls_importstring, ls_exportdir, ls_name, ls_fullname, ls_importdir, ls_zipfile, ls_exportolddir, ls_cheminvpn, ls_valeur
string li_filelog
datastore ds_zip
long i, j, k, ll_sec
boolean lb_delete = false
boolean lb_execute = false
string  ls_time

luo_files = create n_cst_filesrvwin32
ds_zip = create datastore
ds_zip.dataobject = "d_zipdirectory" 
ds_zip.setTransObject(SQLCA)

luo_process = create n_cst_process

ls_time = string(now(),"hh:mm")
ll_sec = long(right(ls_time,1))

CHOOSE CASE gnv_app.of_getodbc( )
	
	CASE "cipq_admin"
		if ll_sec = 0 or ll_sec = 5 then  lb_execute = true
	CASE "cipq_stlambert"
		if ll_sec = 1 or ll_sec = 6 then  lb_execute = true
	CASE "cipq_stpatrice"
		if ll_sec = 2 or ll_sec = 7 then  lb_execute = true
	CASE "cipq_stcuthbert"
		if ll_sec = 3 or ll_sec = 8 then  lb_execute = true
	CASE "cipq_roxton"	
		if ll_sec = 4 or ll_sec = 9 then  lb_execute = true
END CHOOSE 

if lb_execute = false then return

//// Transferts
//if il_interval > 0 then
//	if il_cntTimer = 0 then
//		il_cntTimer = il_interval
//		st_message.text = "Lecture en cours"
//	else
//		il_cntTimer -= 1
//		st_message.text = "Prochaine lecture dans " + string(il_cntTimer + 1) + " minute(s)"
//		RETURN
//	end if
//end if

of_arreterTimer()

//Enlever les vieux fichiers
IF il_cntTimerold = 0 THEN
	il_cntTimerold = il_intervalold
	gnv_app.inv_transfert_inter_centre.of_enlevervieuxfichiers( )
ELSE
	il_cntTimerold -- 
END IF


// On zip les fichiers dans le repertoire exporter

ls_exportdir = gnv_app.of_getvaleurini("FTP","EXPORTPATH")
ls_exportolddir = gnv_app.of_getvaleurini("FTP","EXPORTPATHOLD")
luo_files.of_dirlist(ls_exportdir + "*.txt", 33, luo_attrib)

for i = 1 to upperbound(luo_attrib)
	
	ls_zipfile = luo_attrib[i].is_filename
	
	CHOOSE CASE left(luo_attrib[i].is_filename,3)
		CASE '110'
			ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN110")
		CASE '111'
			ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN111")
		CASE '112' // ROXTON
			ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN112")
		CASE '113'
			ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN113")
		CASE '116'
			ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN116")
	END CHOOSE
	
	if FileCopy(ls_exportdir + ls_zipfile ,ls_cheminvpn + ls_zipfile,true) = 1 then
		if FileMove(ls_exportdir + luo_attrib[i].is_filename,ls_exportolddir + luo_attrib[i].is_filename) <> 1 then // Déplacer le fichier dans le old
			if not directoryExists(gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\"+left(luo_attrib[i].is_filename,3)) then
				CreateDirectory(gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\"+left(luo_attrib[i].is_filename,3))
			end if
			gnv_app.inv_filesrv.of_filewrite(gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\"+left(luo_attrib[i].is_filename,3)+"\logfiletxt.txt", "#1 Impossible de le déplacer " + ls_exportdir + luo_attrib[i].is_filename)
			FileCopy(ls_exportdir + luo_attrib[i].is_filename,ls_exportolddir + luo_attrib[i].is_filename,true)
			if FileDelete(ls_exportdir + luo_attrib[i].is_filename) = false then
				gnv_app.inv_filesrv.of_filewrite(gnv_app.of_getPathDefault() +gnv_app.of_getODBC()+"\"+left(luo_attrib[i].is_filename,3)+"\logfiletxt.txt", "#2 - Impossible de le copier " + ls_exportdir + luo_attrib[i].is_filename)
			end if
			
		end if
		FileDelete(ls_exportdir + ls_zipfile)		
	end if

next

/*
for j = 1 to upperbound(luo_attrib)
	
	ls_zipfile = left(luo_attrib[j].is_filename, len(luo_attrib[j].is_filename) - 4)
	lul_unzFile = luo_zlib.of_zipOpen(ls_exportdir + ls_zipfile + ".zip")
	if lul_unzFile >= 0  then
		if luo_zlib.of_importfile( lul_unzFile, ls_exportdir + luo_attrib[j].is_filename, luo_attrib[j].is_filename) = 0 then
			luo_zlib.of_zipclose(lul_unzFile,"")
			sleep(1)
			CHOOSE CASE left(luo_attrib[j].is_filename,3)
				CASE '110'
					ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN110")
				CASE '111'
					ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN111")
				CASE '112' // ROXTON
					ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN112")
				CASE '113'
					ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN113")
				CASE '116'
					ls_cheminvpn = gnv_app.of_getvaleurini("FTP","VPN116")
			END CHOOSE
			if FileCopy(ls_exportdir + ls_zipfile + ".zip",ls_cheminvpn + ls_zipfile + ".zip",true) = 1 then
				if FileMove(ls_exportdir + luo_attrib[j].is_filename,ls_exportolddir + luo_attrib[j].is_filename) <> 1 then // Déplacer le fichier dans le old
					if not directoryExists(gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\"+left(luo_attrib[j].is_filename,3)) then
						CreateDirectory(gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\"+left(luo_attrib[j].is_filename,3))
					end if
					gnv_app.inv_filesrv.of_filewrite(gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\"+left(luo_attrib[j].is_filename,3)+"\logfiletxt.txt", "#1 Impossible de le déplacer " + ls_exportdir + luo_attrib[j].is_filename)
					FileCopy(ls_exportdir + luo_attrib[j].is_filename,ls_exportolddir + luo_attrib[j].is_filename,true)
					if FileDelete(ls_exportdir + luo_attrib[j].is_filename) = false then
						gnv_app.inv_filesrv.of_filewrite(gnv_app.of_getPathDefault() +gnv_app.of_getODBC()+"\"+left(luo_attrib[j].is_filename,3)+"\logfiletxt.txt", "#2 - Impossible de le copier " + ls_exportdir + luo_attrib[j].is_filename)
					end if
					
				end if
				FileDelete(ls_exportdir + ls_zipfile + ".zip")		
			end if
		else
			luo_zlib.of_zipclose(lul_unzFile,"")
			sleep(1)
			FileDelete(ls_exportdir + ls_zipfile + ".zip")
		end if
	end if
		
next

*/

// Partir l'executable du FTP

// luo_run.of_run("z:\cipq\ftp\ftpcipq.bat",Maximized!)

// iMPORTATION des fichiers du centre 110

ls_valeur = "VPN" + gnv_app.of_getcompagniedefaut( )
ls_cheminvpn = gnv_app.of_getvaleurini("FTP",ls_valeur)
ls_importdir = gnv_app.of_getvaleurini("FTP","IMPORTPATH")
luo_files.of_dirlist(ls_cheminvpn + gnv_app.of_getcompagniedefaut( ) + "*.txt", 33, luo_attrib)



for j = 1 to upperbound(luo_attrib)
	
	if FileCopy(ls_cheminvpn + luo_attrib[j].is_filename, ls_importdir + luo_attrib[j].is_filename,true) = 1 then
		FileDelete(ls_cheminvpn + luo_attrib[j].is_filename)
	end if

next

/*for j = 1 to upperbound(luo_attrib)
	
	ls_importstring = luo_zlib.of_directory(ls_cheminvpn + luo_attrib[j].is_filename, false)
	ds_zip.reset()
	ds_zip.importstring(ls_importstring)
	
	for i = 1 to ds_zip.rowcount()
		ls_name = ds_zip.GetItemString(i, "name")
		ls_fullname = ds_zip.GetItemString(i, "fullname")		
		lul_unzFile = luo_zlib.of_unzOpen(ls_cheminvpn + luo_attrib[j].is_filename)
		if lul_unzFile >= 0 then
			if luo_zlib.of_ExtractFile(lul_unzFile, ls_importdir+ls_name, ls_fullname) then
				lb_delete = true
			end if
		end if
		sleep(1)
		
		luo_zlib.of_unzClose(lul_unzFile)
		if lb_delete then 
			FileDelete(ls_cheminvpn + luo_attrib[j].is_filename)
			lb_delete = false
		end if
		
	next
	
next

*/

sleep(1)

// Procéder à l'importation
gnv_app.inv_transfert_inter_centre.of_importfichier()

//Rafraichir
SetPointer(HourGlass!)
tab_transfert.tabpage_transfert.dw_transfert_centre.Retrieve()

// Impression du journal
if ib_ImpJournal then
	st_impression.visible = TRUE
	gnv_app.inv_journal.of_ImprimerJournal()
	st_impression.visible = FALSE
end if


//ajouter les commandes du jour (répétitives, transférées) 
INSERT INTO t_Commande_Validation ( DateCommande, No_Eleveur ) 
SELECT t_Commande.DateCommande, t_Commande.No_Eleveur 
FROM t_Commande WHERE date(t_Commande.DateCommande) = Date(today()) 
AND t_commande.no_eleveur NOT IN (
SELECT no_eleveur from t_commande_validation WHERE date(datecommande) = date(today())
);

st_message.text = "Lecture terminée"

of_demarrerTimer()




end event

event open;call super::open;uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)
uo_toolbar2.of_AddItem("Fermer", "Exit!")
uo_toolbar2.POST of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_transfert
string text = "Transfert de commande"
end type

type p_8 from w_sheet_frame`p_8 within w_transfert
integer x = 73
integer y = 48
integer width = 91
integer height = 84
boolean originalsize = false
string picturename = "InsertReturn!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_transfert
integer width = 4571
end type

type tab_transfert from u_tab_transfert_centre within w_transfert
integer x = 18
integer y = 264
integer width = 4585
integer height = 1960
integer taborder = 11
boolean bringtotop = true
end type

type st_message from statictext within w_transfert
integer x = 23
integer y = 160
integer width = 4571
integer height = 108
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "En attente"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_toolbar2 from u_cst_toolbarstrip within w_transfert
integer x = 4096
integer y = 2240
integer width = 507
integer taborder = 50
boolean bringtotop = true
end type

event ue_clicked_anywhere;call super::ue_clicked_anywhere;Close(parent)
end event

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

type st_impression from statictext within w_transfert
integer x = 1851
integer y = 52
integer width = 2181
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 15793151
string text = "Impression du backup papier en cours"
boolean focusrectangle = false
end type

type st_odbc from statictext within w_transfert
integer x = 3186
integer y = 48
integer width = 1339
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

event constructor;CHOOSE CASE gnv_app.of_getODBC()
	CASE 'cipq_admin'
		st_odbc.text = "ADMINISTRATION"
	CASE 'cipq_roxton'
		st_odbc.text = "ROXTON"
	CASE 'cipq_stlambert'
		st_odbc.text = "ST_LAMBERT"
	CASE 'cipq_stcuthbert'
		st_odbc.text = "ST_CUTHBERT"
	CASE 'cipq_stpatrice'
		st_odbc.text = "ST_PATRICE"
END CHOOSE
end event

type st_pathexe from statictext within w_transfert
integer x = 27
integer y = 2240
integer width = 3794
integer height = 116
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "none"
boolean focusrectangle = false
end type

event constructor;st_pathexe.text = gnv_app.of_getPathDefault() + gnv_app.of_getODBC()+"\" + "@" + gnv_app.of_getvaleurini("FTP","EXPORTPATH")
end event

