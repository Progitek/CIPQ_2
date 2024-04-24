$PBExportHeader$n_cst_param_rapport_simple.sru
forward
global type n_cst_param_rapport_simple from n_base
end type
end forward

global type n_cst_param_rapport_simple from n_base autoinstantiate
end type

type variables
string is_colonne[]
dec idec_taille[]
string is_dw_source
string is_titre
long il_orientation
long il_formatpapier
string	is_syntax
end variables

on n_cst_param_rapport_simple.create
call super::create
end on

on n_cst_param_rapport_simple.destroy
call super::destroy
end on

