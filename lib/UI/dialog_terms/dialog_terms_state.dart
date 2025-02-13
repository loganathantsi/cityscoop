part of 'dialog_terms_bloc.dart';

@immutable
sealed class DialogTermsState {}

final class DialogTermsInitialState extends DialogTermsState {}

final class DialogTermsAcceptedState extends DialogTermsState {}

final class DialogTermsClosedState extends DialogTermsState {}