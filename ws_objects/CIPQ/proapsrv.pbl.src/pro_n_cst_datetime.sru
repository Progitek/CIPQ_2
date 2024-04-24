﻿$PBExportHeader$pro_n_cst_datetime.sru
$PBExportComments$(PRO) Extension Date and/or Datetime service
forward
global type pro_n_cst_datetime from pfc_n_cst_datetime
end type
end forward

global type pro_n_cst_datetime from pfc_n_cst_datetime
end type

type variables
String 	is_month_short[12] = { &
	"Ja", "Fe", "Mr", "Av", &
	 "Ma",  "Jn", "Jl", "Ao",  "Se", &
	"Oc",  "No", "De" }
end variables

forward prototypes
public function string of_shortmonthname (integer ai_monthnumber)
end prototypes

public function string of_shortmonthname (integer ai_monthnumber);return is_month_short[ai_monthnumber]
end function

on pro_n_cst_datetime.create
call super::create
end on

on pro_n_cst_datetime.destroy
call super::destroy
end on
