﻿$PBExportHeader$w_transfert_adm.srw
forward
global type w_transfert_adm from w_sheet_frame
end type
type st_message from statictext within w_transfert_adm
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_transfert_adm
end type
end forward

global type w_transfert_adm from w_sheet_frame
string title = "Transfert"
st_message st_message
uo_toolbar2 uo_toolbar2
end type
global w_transfert_adm w_transfert_adm

type variables
private:

	long il_interval = 0
	long il_cntTimer = 0
	
	long il_intervalold = 720 //12 heures à coup de 1 minute
	long il_cntTimerold = 720
end variables

on w_transfert_adm.create
int iCurrent
call super::create
this.st_message=create st_message
this.uo_toolbar2=create uo_toolbar2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
this.Control[iCurrent+2]=this.uo_toolbar2
end on

on w_transfert_adm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_message)
destroy(this.uo_toolbar2)
end on

event pfc_postopen;call super::pfc_postopen;il_interval = long(gnv_app.of_getValeurIni("FTP", "TIMER_INTERVAL"))
if il_interval = 0 or isnull(il_interval) then il_interval = 2
//il_interval = 2

THIS.event timer()
timer(60, this)
end event

event timer;call super::timer;string ls_importdir, ls_importstring, ls_name, ls_fullname, ls_exportdir, ls_zipfile
n_cst_filesrvwin32 luo_files
n_cst_dirattrib luo_attrib[]
n_zlib luo_zlib
long j, i
ulong lul_unzFile
datastore ds_zip

luo_files = create n_cst_filesrvwin32
ds_zip = create datastore
ds_zip.dataobject = "d_zipdirectory" 
ds_zip.setTransObject(SQLCA)

// Transferts
if il_interval > 0 then
	if il_cntTimer = 0 then
		il_cntTimer = il_interval
		st_message.text = "Lecture en cours"
	else
		il_cntTimer -= 1
		st_message.text = "Prochaine lecture dans " + string(il_cntTimer + 1) + " minute(s)"
		RETURN
	end if
end if

//Enlever les vieux fichiers
IF il_cntTimerold = 0 THEN
	il_cntTimerold = il_intervalold
	gnv_app.inv_transfert_inter_centre.of_enlevervieuxfichiers( )
ELSE
	il_cntTimerold -- 
END IF

// Procéder à l'importation
if gnv_app.inv_transfert_centre_adm.of_DownloadFTPFile() then

	// On dezippe les fichiers
	
	ls_importdir = gnv_app.of_getvaleurini("FTP","IMPORTPATH")
	luo_files.of_dirlist(ls_importdir + "*.zip", 33, luo_attrib)
	for j = 1 to upperbound(luo_attrib)
		
		ls_importstring = luo_zlib.of_directory(ls_importdir + luo_attrib[j].is_filename, false)
		ds_zip.reset()
		ds_zip.importstring(ls_importstring)
		
		for i = 1 to ds_zip.rowcount()
			ls_name = ds_zip.GetItemString(i, "name")
			ls_fullname = ds_zip.GetItemString(i, "fullname")		
			lul_unzFile = luo_zlib.of_unzOpen(ls_importdir + luo_attrib[j].is_filename)
			luo_zlib.of_ExtractFile(lul_unzFile, ls_importdir+ls_name, ls_fullname)
			luo_zlib.of_unzClose(lul_unzFile)
			FileDelete(ls_importdir + luo_attrib[j].is_filename)
		next
		
	next
	
end if


// Procéder à l'exportation

ls_exportdir = gnv_app.of_getvaleurini("FTP","EXPORTPATH")
luo_files.of_dirlist(ls_exportdir + "*.txt", 33, luo_attrib)
for j = 1 to upperbound(luo_attrib)
	
	ls_zipfile = left(luo_attrib[j].is_filename, len(luo_attrib[j].is_filename) - 4)
	lul_unzFile = luo_zlib.of_zipOpen(ls_exportdir + ls_zipfile + ".zip")
	luo_zlib.of_importfile( lul_unzFile, ls_exportdir + luo_attrib[j].is_filename, luo_attrib[j].is_filename)
	luo_zlib.of_zipclose(lul_unzFile,"")
	FileDelete(ls_exportdir + luo_attrib[j].is_filename)
	
next

gnv_app.inv_transfert_centre_adm.of_UploadFTPFile()

//if gnv_app.inv_transfert_centre_adm.of_UploadFTPFile() then

	// On zip les fichiers dans le repertoire exporter
	
//	ls_exportdir = gnv_app.of_getvaleurini("FTP","FTP_PATH")
//	luo_files.of_dirlist(ls_exportdir + "*.txt", 33, luo_attrib)
//	for j = 1 to upperbound(luo_attrib)
//		
//		ls_zipfile = left(luo_attrib[j].is_filename, len(luo_attrib[j].is_filename) - 4)
//		lul_unzFile = luo_zlib.of_zipOpen(ls_exportdir + ls_zipfile + ".zip")
//		luo_zlib.of_importfile( lul_unzFile, ls_exportdir + luo_attrib[j].is_filename, luo_attrib[j].is_filename)
//		luo_zlib.of_zipclose(lul_unzFile,"")
//		FileDelete(ls_exportdir + luo_attrib[j].is_filename)
//		
//	next
	
//end if

// Procéder à la copie vers le répertoire de traitement
gnv_app.inv_transfert_centre_adm.of_ImportFichiers()

st_message.text = "Lecture terminée"

end event

event open;call super::open;uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)
uo_toolbar2.of_AddItem("Fermer", "Exit!")
uo_toolbar2.POST of_displaytext(true)
end event

type st_title from w_sheet_frame`st_title within w_transfert_adm
string text = "Transfert centre administratif"
end type

type p_8 from w_sheet_frame`p_8 within w_transfert_adm
integer x = 73
integer y = 48
integer width = 91
integer height = 84
boolean originalsize = false
string picturename = "InsertReturn!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_transfert_adm
end type

type st_message from statictext within w_transfert_adm
integer x = 23
integer y = 324
integer width = 4549
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

type uo_toolbar2 from u_cst_toolbarstrip within w_transfert_adm
integer x = 4059
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

