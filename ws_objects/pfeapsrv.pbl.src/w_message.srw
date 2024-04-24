$PBExportHeader$w_message.srw
$PBExportComments$Extension Message Service "MessageBox Window".
forward
global type w_message from pro_w_message
end type
end forward

global type w_message from pro_w_message
end type
global w_message w_message

on w_message.create
call super::create
end on

on w_message.destroy
call super::destroy
end on

type gb_userinput from pro_w_message`gb_userinput within w_message
end type

type mle_userinput from pro_w_message`mle_userinput within w_message
end type

type st_userinput from pro_w_message`st_userinput within w_message
end type

type cb_1 from pro_w_message`cb_1 within w_message
end type

type cb_2 from pro_w_message`cb_2 within w_message
end type

type cb_3 from pro_w_message`cb_3 within w_message
end type

type cb_print from pro_w_message`cb_print within w_message
end type

type cb_userinput from pro_w_message`cb_userinput within w_message
end type

type mle_message from pro_w_message`mle_message within w_message
end type

type lv_bmp from pro_w_message`lv_bmp within w_message
string largepicturename[] = {"C:\ii4net\CIPQ\images\info.bmp","C:\ii4net\CIPQ\images\stop.bmp","C:\ii4net\CIPQ\images\excl.bmp","C:\ii4net\CIPQ\images\quest.bmp"}
end type

