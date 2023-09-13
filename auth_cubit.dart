import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/treatment_model.dart';


part 'auth_state.dart';

class ControllerCubit extends Cubit<ControllerState> {
  ControllerCubit() : super(ControllerInitial());

  static ControllerCubit get(context) =>
      BlocProvider.of<ControllerCubit>(context);
  Database? database;
  List<Map> treatments = [];

  createDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'treatment.db');
    openDatabase(path, version: 1, onCreate: _onCreate, onOpen: (database) {
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(DatabaseCreated());
    });
  }

  void _onCreate(Database db, int version) async {
    return await db
        .execute(
            'CREATE TABLE treat (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL,duration INTEGER,image TEXT,sound TEXT,lastTimeTake TEXT,finished INTEGER,times_of_took INTEGER,startTime TEXT)')
        .then((value) {
      print('database created');
    }).catchError((onError) {
      print('there is error in database');
    });
  }

  // hb3t el data fy el insert w a7otha mkan el value
 void insertContact(// ContactData contact,
  {required String name,required num amount , required int duration, required String image, required String sound,required String lastTime}
      ) async {
   emit(CreateTreatmentStateLoading());

   await database!.transaction((txn) async {
    await  txn
          .rawInsert(
              'INSERT INTO treat(name,amount,duration,image,sound,lastTimeTake,finished,times_of_took,startTime) VALUES ("$name","$amount","$duration","$image","$sound","${DateTime.now().toString()}","0","0","${DateTime.now().toString()}")')
          .then((value) {
        print("$value int value");
        emit(CreateTreatmentStateSuccessful(value.toString()));

        getDataFromDatabase(database!);

      }).catchError((onError) {
      emit(CreateTreatmentStateError());

    });
    });

  }
  List<TreatMentModel> treatmentModel = [];

  getDataFromDatabase(Database database) {
    treatmentModel = [];
    emit(GetTreatmentDataStateLoading());

    database.rawQuery('SELECT * FROM treat WHERE amount > 0.0').then((value) {
      for (var element in value)
      {
        treatmentModel.add(TreatMentModel.fromMap(element));


      }
      // treatments = value;
      emit(GetTreatmentDataStateSuccessful());

    });
  }
  TreatMentModel? treatMentModelOne;

  Future<void> getRowById(int id) async {
    // Get a reference to the database
    treatMentModelOne=null;
    emit(GetTreatmentDataStateLoading());

    // Execute the query
     await database!.query(
      'treat',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    ).then((value) async {
      print('${value}valuevaluevalue');
       treatMentModelOne= TreatMentModel.fromMap(value.first);

       emit(GetTreatmentDataStateSuccessful());
       // await database!.close();

     });

    // Close the database connection


    // Return the first row found (or null if no row was found)
  }

  updateDatabase({num? amount,String? lastTimeTake, int? id}) async {
    await database!.rawUpdate(
        'UPDATE treat SET amount = ?, lastTimeTake = ? WHERE id = ?', ['$amount','$lastTimeTake' ,id]).then((value) {
      print(value);
      emit(updateTreatmentSuccessful());
      getDataFromDatabase(database!);
    });
  }
  updateImageDatabase({String? image, int? id}) async {
    await database!.rawUpdate(
        'UPDATE treat SET image = ? WHERE id = ?', ['$image' ,id]).then((value) {
      print(value);
      emit(updateTreatmentSuccessful());
      getDataFromDatabase(database!);
    });
  }

  deleteDatabase({ int? id}) async {
    await database!
        .rawDelete('DELETE FROM treat  WHERE id = ?', [id]).then((value) {
      emit(DeleteTreatmentStateSuccessful());
      getDataFromDatabase(database!);
    });
  }

  // UserModel? userModel;
  io.File? file;
  FilePickerResult? filePicker;
  String? baseName;

  void pickSound() async {
    filePicker = await FilePicker.platform
        .pickFiles(allowedExtensions: ['mp3'], type: FileType.custom);
    if (filePicker != null) {
      file = io.File(io.File(filePicker!.files.single.path!).path);
      print(filePicker!.files.single.path);
      baseName = basename(file!.path);
    } else {
      // User canceled the pick
      // User canceled the picker
    }
    emit(PickSoundState());
  }



  final ImagePicker _picker = ImagePicker();



  String? imageUrl;

  XFile? image;

  Future<void> pickImageGallary(BuildContext context) async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      print(image!.path);
      // await uploadFile(image, context).then((value) {});
    }
  }

  Future<void> pickImageCamera(BuildContext context) async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
    } else {
      print(image!.path);
      // await uploadFile(image, context).then((value) {});

      emit(PickImageSuccessful());
    }
  }

  // List<UserModel> adminData = [];

  String? docOne;
  String? docTwo;



  FilePickerResult? result;

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      io.File file = io.File(result!.files.single.path.toString());

    }
  }

  XFile? image2;
  XFile? imageSnack;


  XFile? imageTreatment;

  Future<void> pickImageGallaryTreatment(BuildContext context) async {
    imageTreatment = await _picker.pickImage(source: ImageSource.gallery);
    if (imageTreatment == null) {
    } else {
      print(imageTreatment!.path);
    }
    emit(PickImageSuccessful());
  }

  Future<void> pickImageGallaryTreatmentUpdate(
      BuildContext context, String id) async {
    imageTreatment = await _picker.pickImage(source: ImageSource.gallery);
    if (imageTreatment == null) {
    } else {
      updateImageDatabase(image:imageTreatment!.path,id: int.parse(id) );


      print(imageTreatment!.path);
      emit(PickImageSuccessful());
    }
  }

  String? url;

  Future<void>  pickImageCameraTreatmentUpdate(
      BuildContext context, String id) async {
    imageTreatment = await _picker.pickImage(source: ImageSource.camera);
    if (imageTreatment == null) {
    } else {
      print(imageTreatment!.path);
      updateImageDatabase(image:imageTreatment!.path,id: int.parse(id) );

      emit(PickImageSuccessful());
    }
  }

  Future<void> pickImageCameraTreatment(
    BuildContext context,
  ) async {
    imageTreatment = await _picker.pickImage(source: ImageSource.camera);
    if (imageTreatment == null) {
    } else {
      print(imageTreatment!.path);

      emit(PickImageSuccessful());
    }
  }


}
