import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dialog_terms_event.dart';
part 'dialog_terms_state.dart';

class DialogTermsBloc extends Bloc<DialogTermsEvent, DialogTermsState> {
  DialogTermsBloc() : super(DialogTermsInitialState()) {
    on<DialogTermsAcceptEvent>(_onDialogTermsAcceptEvent);
    on<DialogTermsCloseEvent>(_onDialogTermsCloseEvent);
  }

  void _onDialogTermsAcceptEvent(DialogTermsAcceptEvent event, Emitter<DialogTermsState> emit) {
   emit(DialogTermsAcceptedState());
  }

  void _onDialogTermsCloseEvent(DialogTermsCloseEvent event, Emitter<DialogTermsState> emit) {
   emit(DialogTermsClosedState());
  }

}
