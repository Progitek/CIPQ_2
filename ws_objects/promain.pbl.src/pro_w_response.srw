﻿$PBExportHeader$pro_w_response.srw
$PBExportComments$(PRO) Extension Response Window class
forward
global type pro_w_response from pfc_w_response
end type
end forward

global type pro_w_response from pfc_w_response
integer width = 3662
integer height = 1996
boolean center = true
end type
global pro_w_response pro_w_response

on pro_w_response.create
call super::create
end on

on pro_w_response.destroy
call super::destroy
end on

