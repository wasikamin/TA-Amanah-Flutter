import 'package:flutter/material.dart';

class KycProvider with ChangeNotifier {
  // make variable for all data that will be used in kyc
  bool _loading = false;

  String _ktpImage = "";
  get ktpImage => _ktpImage;

  String _faceImage = "";
  get faceImage => _faceImage;

  String _fullName = "",
      _gender = "",
      _birthDate = "",
      _work = "",
      _salary = "",
      _relativeContactName1 = "",
      _relativeContactRelation1 = "",
      _relativeContactPhone1 = "",
      _relativeContactName2 = "",
      _relativeContactRelation2 = "",
      _relativeContactPhone2 = "",
      _idCardNumber = "";

  get fullName => _fullName;
  get gender => _gender;
  get birthDate => _birthDate;
  get work => _work;
  get salary => _salary;
  get idCardNumber => _idCardNumber;
  get relativeContactName1 => _relativeContactName1;
  get relativeContactRelation1 => _relativeContactRelation1;
  get relativeContactPhone1 => _relativeContactPhone1;
  get relativeContactName2 => _relativeContactName2;
  get relativeContactRelation2 => _relativeContactRelation2;
  get relativeContactPhone2 => _relativeContactPhone2;
  bool get loading => _loading;

  // make set function for all variable above
  Future<void> setIdCardImage(String image) async {
    _ktpImage = image;
    notifyListeners();
  }

  Future<void> setLoading(bool value) async {
    _loading = value;
    notifyListeners();
  }

  Future<void> setFaceImage(String image) async {
    _faceImage = image;
    notifyListeners();
  }

  // make set funtion for all variable above
  Future<void> personal(
      String name, gender, birthDate, work, salary, idCardNumber) async {
    _fullName = name;
    _birthDate = birthDate;
    _work = work;
    _salary = salary;
    _gender = gender;
    _idCardNumber = idCardNumber;
    notifyListeners();
  }

  Future<void> setRelative1(String relativeContactName1,
      relativeContactRelation1, relativeContactPhone1) async {
    _relativeContactName1 = relativeContactName1;
    _relativeContactRelation1 = relativeContactRelation1;
    _relativeContactPhone1 = relativeContactPhone1;
    notifyListeners();
  }

  Future<void> setRelative2(String relativeContactName2,
      relativeContactRelation2, relativeContactPhone2) async {
    _relativeContactName2 = relativeContactName2;
    _relativeContactRelation2 = relativeContactRelation2;
    _relativeContactPhone2 = relativeContactPhone2;
    notifyListeners();
  }
}
