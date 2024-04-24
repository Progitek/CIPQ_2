$PBExportHeader$pro_u_bb.sru
forward
global type pro_u_bb from pfc_u_pb
end type
end forward

global type pro_u_bb from pfc_u_pb
integer width = 101
integer height = 88
string text = ""
boolean originalsize = false
string picturename = "Custom039!"
end type
global pro_u_bb pro_u_bb

type variables
Protected:

// Options
Boolean ib_multifile = false
Boolean ib_folder = false
Boolean ib_createprompt = false
Boolean ib_explorer = true
Boolean ib_extensiondifferent = false
Boolean ib_filemustexist = false
Boolean ib_hidereadonly = false
Boolean ib_longnames = false
Boolean ib_nochangedir = false
Boolean ib_nodereferencelinks = false
Boolean ib_nolongnames = false
Boolean ib_nonetworkbutton = false
Boolean ib_noreadonlyreturn = false
Boolean ib_notestfilecreate = false
Boolean ib_novalidate = false
Boolean ib_overwriteprompt = false
Boolean ib_pathmustexist = false
Boolean ib_readonly = false

// Variables 
String is_path
String is_files[]
String is_ext = ""
String is_fileDesc[]
String is_fileFilter[]
String is_initDir = ""

// Constantes
Constant uLong OFN_CREATEPROMPT = 1
Constant uLong OFN_EXPLORER = 2
Constant uLong OFN_EXTENSIONDIFFERENT = 4
Constant uLong OFN_FILEMUSTEXIST = 8
Constant uLong OFN_HIDEREADONLY = 16
Constant uLong OFN_LONGNAMES = 32
Constant uLong OFN_NOCHANGEDIR = 64
Constant uLong OFN_NODEREFERENCELINKS = 128
Constant uLong OFN_NOLONGNAMES = 256
Constant uLong OFN_NONETWORKBUTTON = 512
Constant uLong OFN_NOREADONLYRETURN = 1024
Constant uLong OFN_NOTESTFILECREATE = 2048
Constant uLong OFN_NOVALIDATE = 4096
Constant uLong OFN_OVERWRITEPROMPT = 8192
Constant uLong OFN_PATHMUSTEXIST = 16384
Constant uLong OFN_READONLY = 32768

end variables

on pro_u_bb.create
call super::create
end on

on pro_u_bb.destroy
call super::destroy
end on

