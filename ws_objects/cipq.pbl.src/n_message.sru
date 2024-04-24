$PBExportHeader$n_message.sru
forward
global type n_message from n_base
end type
end forward

global type n_message from n_base autoinstantiate
end type

forward prototypes
public function integer of_sendmessage (date adt_envoye, string as_messagede, string as_messagea, string as_sujet, string as_body, string as_erreur, long al_noeleveur)
end prototypes

public function integer of_sendmessage (date adt_envoye, string as_messagede, string as_messagea, string as_sujet, string as_body, string as_erreur, long al_noeleveur);insert into t_message(dateenvoye, priorite, message_de, message_a, sujet, message_texte, fichier_attache, source, statut,statut_lu, statut_affiche, typemessagerie, couleur, email, envoyer, sms, nomemail, id_user, nomordinateur, nomreel,failmsg,no_eleveur)
values(string(date(:adt_envoye)) + ' 07:30:00.000', 0, :as_messagede, :as_messagea, :as_sujet, :as_body,null, 'e', 'a', 'o','o', 'U', 15780518, 1, 0, 1,'',0,'','',:as_erreur,:al_noeleveur);
			
if SQLCA.SQLCode = 0 then
	commit using SQLCA;
	return 0
else
	rollback using SQLCA;
	return -1
end if
end function

on n_message.create
call super::create
end on

on n_message.destroy
call super::destroy
end on

