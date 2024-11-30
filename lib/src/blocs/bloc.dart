/*import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Event Class
abstract class EmailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateEmail extends EmailEvent {
  final String email;
  UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

// State Class
abstract class EmailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailInitial extends EmailState {}

class EmailStored extends EmailState {
  final String email;
  EmailStored(this.email);

  @override
  List<Object?> get props => [email];
}

// BLoC Class
class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailInitial());

  @override
  Stream<EmailState> mapEventToState(EmailEvent event) async* {
    if (event is UpdateEmail) {
      yield EmailStored(event.email);  // Update email and yield new state
    }
  }
}*/
