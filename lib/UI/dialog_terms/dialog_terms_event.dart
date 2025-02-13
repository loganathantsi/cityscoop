part of 'dialog_terms_bloc.dart';

@immutable
sealed class DialogTermsEvent {}

class DialogTermsAcceptEvent extends DialogTermsEvent {}

class DialogTermsCloseEvent extends DialogTermsEvent {}

