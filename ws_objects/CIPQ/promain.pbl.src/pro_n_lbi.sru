$PBExportHeader$pro_n_lbi.sru
$PBExportComments$(PRO) Extension ListboxItem class
forward
global type pro_n_lbi from nonvisualobject
end type
end forward

global type pro_n_lbi from nonvisualobject autoinstantiate
end type

type variables
Protected:

string is_label
any ia_data

end variables

forward prototypes
public function integer of_setlabel (string as_label)
public function integer of_setdata (any aa_data)
public function string of_getlabel ()
public function any of_getdata ()
end prototypes

public function integer of_setlabel (string as_label);// Assigne l'étiquette de l'élément
is_label = as_label
return 1

end function

public function integer of_setdata (any aa_data);// Assigne les données de l'élément
ia_data = aa_data
return 1

end function

public function string of_getlabel ();// Retourne l'étiquette de l'élément
return is_label

end function

public function any of_getdata ();// Retourne les données de l'élément
return ia_data

end function

on pro_n_lbi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pro_n_lbi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

