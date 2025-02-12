part of 'dialog_terms_bloc.dart';

@immutable
sealed class DialogTermsState {}

final class DialogTermsInitial extends DialogTermsState {}

final class DialogTermsAccepted extends DialogTermsState {}

final class DialogTermsClosed extends DialogTermsState {}