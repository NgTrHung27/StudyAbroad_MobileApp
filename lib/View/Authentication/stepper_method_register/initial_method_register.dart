// File: register_methods.dart

import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/vn_country.dart';

class RegisterMethods {
  late String selectedSchool;
  late String selectedProgram;
  late String selectedCity;
  late String selectedDistrict;
  late String selectedWard;
  late GradeType radioGradeTypeValue;
  late Gender valueGender;
  late DegreeType valueDegree;
  late CertificateType selectedCertificateType;
  late String certificateImg;

  void schoolChange(School? school) {
    if (school != null) {
      selectedSchool = school.name;
    }
  }

  //Declare intial state value for selectedProgram
  void programChange(Program? program) {
    if (program != null) {
      selectedProgram = program.name;
    }
  }

  //Declare intial state value for selectedCity
  void cityChange(City? city) {
    if (city != null) {
      selectedCity = city.name;
    }
  }

  //Declare intial state value for selectedDistrict
  void districtChange(District? district) {
    if (district != null) {
      selectedDistrict = district.name;
    }
  }

  //Declare intial state value for selectedWard
  void wardChange(Ward? ward) {
    if (ward != null) {
      selectedWard = ward.name;
    }
  }

  // function to handle changes in radio button value
  void radioValueChanged(GradeType? gradeType) {
    if (gradeType != null) {
      radioGradeTypeValue = gradeType;
    }
  }

  // function to handle changes in gender value
  void genderValueChanged(Gender? gender) {
    if (gender != null) {
      valueGender = gender;
      print("gender: $gender");
    }
  }

  // function to handle changes in degree value
  void degreeValueChanged(DegreeType? degreeType) {
    if (degreeType != null) {
      valueDegree = degreeType;
    }
  }

  // function to handle changes in certificate type value
  void certificateTypeValueChanged(CertificateType? certificateType) {
    if (certificateType != null) {
      selectedCertificateType = certificateType;
    }
  }
  // ... other methods
}
