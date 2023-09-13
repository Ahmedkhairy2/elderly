part of 'auth_cubit.dart';

@immutable
abstract class ControllerState {}

class ControllerInitial extends ControllerState {}
class DatabaseCreated extends ControllerState {}
// login state start
class LoginLoadingState extends ControllerState{
  LoginLoadingState();
}
class LoginSuccessfulState extends ControllerState{
  String message;
  String role;
  bool ban;
  bool approved;
  LoginSuccessfulState({required this.message,required this.role , required this.ban,required this.approved});
}
class LoginErrorState extends ControllerState{
  String message;
  LoginErrorState(this.message);
}
// login state end

// start Register state
class RegisterLoadingState extends ControllerState{
  RegisterLoadingState();
}
class RegisterSuccessfulState extends ControllerState{
  String message;
  RegisterSuccessfulState(this.message);
}
class RegisterErrorState extends ControllerState{
  String message;
  RegisterErrorState(this.message);
}
// start Register state
// start Register state
class GetUserDataLoadingState extends ControllerState{
  GetUserDataLoadingState();
}
class GetUserDataSuccessfulState extends ControllerState{
  String message;
  GetUserDataSuccessfulState(this.message);
}
class GetUserDataErrorState extends ControllerState{
  String message;
  GetUserDataErrorState(this.message);
}
// start Register state
// start Register state
class UpdateDataLoadingState extends ControllerState{
  UpdateDataLoadingState();
}
class UpdateDataSuccessfulState extends ControllerState{
  String message;
  UpdateDataSuccessfulState(this.message);
}
class UpdateDataErrorState extends ControllerState{
  String message;
  UpdateDataErrorState(this.message);
}
// start Register state
//
class UploadImageStateSuccessful extends ControllerState{
  String message;
  UploadImageStateSuccessful(this.message);
}
class UploadImageStateError extends ControllerState{
  String message;
  UploadImageStateError(this.message);
}
class UploadImageStateLoading extends ControllerState{
  String message;
  UploadImageStateLoading(this.message);
}
//end image state
// start get Admin
class GetAdminsStateSuccessful extends ControllerState{
  String message;
  GetAdminsStateSuccessful(this.message);
}
class GetAdminsStateError extends ControllerState{
  String message;
  GetAdminsStateError(this.message);
}
class GetAdminsStateLoading extends ControllerState{
  String message;
  GetAdminsStateLoading(this.message);
}
// end admin
class SendMessageStateLoading extends ControllerState{
  String message;
  SendMessageStateLoading(this.message);
}
class SendMessageStateError extends ControllerState{
  String message;
  SendMessageStateError(this.message);
}
class SendMessageStateSuccessful extends ControllerState{
  String message;
  SendMessageStateSuccessful(this.message);
}
// get pharmacy details
class GetPharmacyDetailsStateLoading extends ControllerState{
  String message;
  GetPharmacyDetailsStateLoading(this.message);
}
class GetPharmacyDetailsStateError extends ControllerState{
  String message;
  GetPharmacyDetailsStateError(this.message);
}
class GetPharmacyDetailsStateSuccessful extends ControllerState{
  String message;
  GetPharmacyDetailsStateSuccessful(this.message);
}
class AddPharmacyDetailsStateLoading extends ControllerState{
  String message;
  AddPharmacyDetailsStateLoading(this.message);
}
class AddPharmacyDetailsStateError extends ControllerState{
  String message;
  AddPharmacyDetailsStateError(this.message);
}
class AddPharmacyDetailsStateSuccessful extends ControllerState{
  String message;
  AddPharmacyDetailsStateSuccessful(this.message);
}
// create services start
class GetUrlSuccessfulState extends ControllerState{
  String message;
  GetUrlSuccessfulState(this.message);
}
class GetAllUsersLoadnig extends ControllerState{
  GetAllUsersLoadnig();
}
class GetAllCinemaOwnerSuccessfulState extends ControllerState{
  String message;
  GetAllCinemaOwnerSuccessfulState(this.message);
}
class GetAllUserErrorState extends ControllerState{
  String message;
  GetAllUserErrorState(this.message);
}
// delete service end

class GetAllCustomerScreenLoading extends ControllerState{}
class GetAllCustomerScreenSuccessful extends ControllerState{}
class GetAllCustomerScreenError extends ControllerState{}
class GetHallsLoading extends ControllerState {}
class GetHallsSuccessful  extends ControllerState {}
class GetHallsError  extends ControllerState {}
class CreateHallsLoading  extends ControllerState {}
class CreateHallsSuccessful  extends ControllerState {}
class CreateHallsError  extends ControllerState {
  final String error;
  CreateHallsError(this.error);
}
class EditHallsLoading  extends ControllerState {}
class EditHallsSuccessful  extends ControllerState {}
class EditHallsError  extends ControllerState {}
class PickImageSuccessful extends ControllerState {}
class AddNewFilmLoading extends ControllerState {}
class AddNewFilmSuccessful extends ControllerState {}
class AddNewFilmError extends ControllerState {}
class GetFilmsLoading extends ControllerState {}
class GetFilmsSuccessful extends ControllerState {}
class GetFilmsError extends ControllerState {}
class DeleteFilmLoading extends ControllerState {}
class DeleteFilmSuccessful extends ControllerState {}
class DeleteFilmError extends ControllerState {}
class EditFilmLoading extends ControllerState {}
class EditFilmSuccessful extends ControllerState {}
class EditFilmError extends ControllerState {}
class GetHallInfoLoading extends ControllerState {}
class GetHallInfoSuccessful extends ControllerState {}
class GetHallInfoError extends ControllerState {}

class CreateTreatmentStateLoading extends ControllerState{}
class CreateTreatmentStateSuccessful extends ControllerState{
  String id;
  CreateTreatmentStateSuccessful(this.id);
}
class CreateTreatmentStateError extends ControllerState{}

class GetTreatmentDataStateLoading extends ControllerState{}
class updateTreatmentSuccessful extends ControllerState{}

class GetTreatmentDataStateSuccessful extends ControllerState{}
class GetTreatmentDataStateError extends ControllerState{}
class GetDataTreatmentStateLoading extends ControllerState{}
class GetDataTreatmentStateSuccessful extends ControllerState{}
class GetDataTreatmentStateError extends ControllerState{}
class DeleteTreatmentStateLoading extends ControllerState{}
class DeleteTreatmentStateSuccessful extends ControllerState{}
class DeleteTreatmentStateError extends ControllerState{}
class PickSoundState extends ControllerState{}