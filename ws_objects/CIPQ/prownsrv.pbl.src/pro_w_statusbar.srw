$PBExportHeader$pro_w_statusbar.srw
$PBExportComments$(PRO) Extension Statusbar window
forward
global type pro_w_statusbar from pfc_w_statusbar
end type
end forward

global type pro_w_statusbar from pfc_w_statusbar
int Width=1761
int Height=97
end type
global pro_w_statusbar pro_w_statusbar

on pro_w_statusbar.create
call pfc_w_statusbar::create
end on

on pro_w_statusbar.destroy
call pfc_w_statusbar::destroy
end on

