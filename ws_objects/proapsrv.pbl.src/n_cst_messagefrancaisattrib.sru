$PBExportHeader$n_cst_messagefrancaisattrib.sru
$PBExportComments$Attributs des messages
forward
global type n_cst_messagefrancaisattrib from n_cst_baseattrib
end type
end forward

global type n_cst_messagefrancaisattrib from n_cst_baseattrib autoinstantiate
end type

type variables
string	is_msgid
string	is_msgparm[]
long		il_nb_rangee_detruite
end variables

on n_cst_messagefrancaisattrib.create
call super::create
end on

on n_cst_messagefrancaisattrib.destroy
call super::destroy
end on

