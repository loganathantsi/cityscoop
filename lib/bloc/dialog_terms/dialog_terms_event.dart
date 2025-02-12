part of 'dialog_terms_bloc.dart';

@immutable
sealed class DialogTermsEvent {}

class DialogTermsAccept extends DialogTermsEvent {}

class DialogTermsClose extends DialogTermsEvent {}

