$PBExportHeader$pro_semaphore.sru
forward
global type pro_semaphore from nonvisualobject
end type
end forward

global type pro_semaphore from nonvisualobject autoinstantiate
end type

type variables
Private:

integer ii_valeur = 1
end variables

forward prototypes
public subroutine init (integer ai_valeurinitiale)
public subroutine relacher ()
public subroutine essayer ()
end prototypes

public subroutine init (integer ai_valeurinitiale);// Initialise le sémaphore au nombre de ressources disponibles.

ii_valeur = ai_valeurinitiale

end subroutine

public subroutine relacher ();// relâche une ressource

ii_valeur ++

end subroutine

public subroutine essayer ();// Attends qu'une ressource se libère
// et en prend possession

do while ii_valeur <= 0
	yield()
loop

ii_valeur --

end subroutine

on pro_semaphore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pro_semaphore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

