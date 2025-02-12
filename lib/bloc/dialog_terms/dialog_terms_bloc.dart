import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dialog_terms_event.dart';
part 'dialog_terms_state.dart';

class DialogTermsBloc extends Bloc<DialogTermsEvent, DialogTermsState> {
  DialogTermsBloc() : super(DialogTermsInitial()) {
    on<DialogTermsAccept>(_onDialogTermsAccept);
    on<DialogTermsClose>(_onDialogTermsClose);
  }

  void _onDialogTermsAccept(DialogTermsAccept event, Emitter<DialogTermsState> emit) {
   emit(DialogTermsAccepted());
  }

  void _onDialogTermsClose(DialogTermsClose event, Emitter<DialogTermsState> emit) {
   emit(DialogTermsClosed());
  }

}
