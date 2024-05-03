import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/View/Authentication/login_page.dart';
import 'package:kltn_mobile/View/Authentication/stepper_method_register/steps_method_register.dart';
import 'package:kltn_mobile/View/Authentication/stepper_method_register/steps_register.dart';
import 'package:intl/intl.dart';
import 'package:kltn_mobile/View/HomePage/home_page.dart';
import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/user_register.dart';
import 'package:kltn_mobile/Model/vn_country.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'package:kltn_mobile/bloC/auth/auth_cubit.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/textspan.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// void UserRegister()async{
// }
//Declare Date Input
class _RegisterPageState extends State<RegisterPage> {
  //Declare API School
  List<School> lstschools = [];
  List<City> lstCities = [];
  //Declare
  String email = '';
  String name = '';
  String password = '';
  String confirmpassword = '';
  String phone = '';
  String idCardNumber = '';
  String? selectedSchool;
  String? selectedProgram;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedWard;
  String? address;
  Gender? valueGender;
  DegreeType? valueDegree;
  GradeType? radioGradeTypeValue; // 0: GPA, 1: CGPA
  double? gradeScore;
  CertificateType? selectedCertificateType;
  String certificateImg = '';
  //End of Declare
  //-----------------------------------------------------------------------------------
  //Declare Controller
  final usermailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final idCardNumberController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = DropdownButtonFormField;
  final cityController = DropdownButtonFormField;
  final districtController = DropdownButtonFormField;
  final wardController = DropdownButtonFormField;
  final addressController = TextEditingController();
  final schoolController = DropdownButtonFormField;
  final programController = DropdownButtonFormField;
  final degreeController = DropdownButtonFormField;
  final certificateController = DropdownButtonFormField;
  final gradeTypecontroller = DropdownButtonFormField;
  final gradeController = TextEditingController();
  final certificateTypeController = RadioListTile;
  // final imageController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  int currentStep = 0;

  //--------------------------------------------------------------------------------------------------

  //Declare Intial Method
  //Register User API Method
  // Lấy giá trị email và password từ các TextField

  void userRegister() async {
    String email = usermailController.text.trim();
    String name = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmpasswordController.text.trim();
    String idCardNumber = idCardNumberController.text.trim();
    DateTime dob = DateFormat('dd/MM/yyyy').parse(dateController.text.trim());
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    double gradeScore = double.parse(gradeController.text.trim());
    String gradeScoreString =
        gradeScore.toString(); // Chuyển đổi giá trị gradeScore thành chuỗi

    String certificateImg = imageController.text.toString();

    var items = {
      'School': selectedSchool,
      'Program': selectedProgram,
      'City': selectedCity,
      'District': selectedDistrict,
      'Ward': selectedWard,
      'valueGender': valueGender,
      'valueDegree': valueDegree,
      'radioGradeTypeValue': radioGradeTypeValue,
      'selectedCertificateType': selectedCertificateType,
    };

    items.forEach((key, value) {
      if (value == null) {
        print('$key is null');
      }
    });

    // Kiểm tra xem các giá trị có rỗng không
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        phone.isEmpty ||
        confirmpassword.isEmpty ||
        selectedProgram == null ||
        selectedCity == null ||
        selectedDistrict == null ||
        selectedWard == null ||
        address.isEmpty ||
        radioGradeTypeValue == null ||
        certificateImg.isEmpty) {
      // Hiển thị thông báo lỗi
      print('Email, password, name, phone, confirmpass,.... không được trống!');
      return;
    }
    //Call API from APIService

    UserAuthRegister? userAuthRegister = await APIRepository().register(
        email,
        password,
        name,
        confirmpassword,
        idCardNumber,
        dob,
        phone,
        selectedSchool,
        selectedProgram,
        selectedCity,
        selectedDistrict,
        selectedWard,
        address,
        valueGender.toString().split('.').last.toUpperCase(),
        valueDegree?.toString().split('.').last.toUpperCase(),
        radioGradeTypeValue?.toString().split('.').last,
        gradeScoreString,
        selectedCertificateType?.toString().split('.').last,
        certificateImg);
    print('Test null user: $userAuthRegister');
    if (userAuthRegister != null) {
      // Đăng ký thành công
      print('Đăng ký thành công: ${userAuthRegister.email}');
      // Hiển thị thông báo đăng ký thành công
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Đăng ký thất bại
      print(userAuthRegister);
      print('Đăng ký thất bại');
      // Hiển thị thông báo đăng ký thất bại
    }
  }

  //Declare intial state value for selectedSchool
  void schoolChange(School? school) {
    setState(() {
      if (school != null) {
        selectedSchool = school.name;
      }
    });
  }

  //Declare intial state value for selectedProgram
  void programChange(Program? program) {
    setState(() {
      if (program != null) {
        selectedProgram = program.name;
      }
    });
  }

  //Declare intial state value for selectedCity
  void cityChange(City? city) {
    setState(() {
      if (city != null) {
        selectedCity = city.name;
      }
    });
  }

  //Declare intial state value for selectedDistrict
  void districtChange(District? district) {
    setState(() {
      if (district != null) {
        selectedDistrict = district.name;
      }
    });
  }

  //Declare intial state value for selectedWard
  void wardChange(Ward? ward) {
    setState(() {
      if (ward != null) {
        selectedWard = ward.name;
      }
    });
  }

  // function to handle changes in radio button value
  void radioValueChanged(GradeType? gradeType) {
    setState(() {
      if (gradeType != null) {
        radioGradeTypeValue = gradeType;
      }
    });
  }

  // function to handle changes in gender value
  void genderValueChanged(Gender? gender) {
    setState(() {
      print("gender: $gender");
      if (gender != null) {
        valueGender = gender;
        print("gender: $gender");
      }
    });
  }

  // function to handle changes in degree value
  void degreeValueChanged(DegreeType? degreeType) {
    setState(() {
      if (degreeType != null) {
        valueDegree = degreeType;
      }
    });
  }

  // function to handle changes in certificate type value
  void certificateTypeValueChanged(CertificateType? certificateType) {
    setState(() {
      if (certificateType != null) {
        selectedCertificateType = certificateType;
      }
    });
  }

  // function to handle changes image value
  Future<void> imageValueChanged(String? certiImg) async {
    print('Certificate ImageValueRegis: $certificateImg');
    setState(() {
      if (certiImg != null) {
        certificateImg = certiImg;
      }
    });
  }
  //End of Intial Method
  //-----------------------------------------------------------------------------------

  //Image Picker Method
  Future<String?> getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print('Picked image path: ${pickedImage.path}');
      String? base64Image = await convertImageToBase64(pickedImage.path);
      if (base64Image != null) {
        setState(() {
          certificateImg = base64Image;
          imageController.text = certificateImg;
          print('Certificate Image: $certificateImg');
        });
        return base64Image;
      } else {
        print("Failed to convert image to base64");
        return null;
      }
    } else {
      print("No image selected");
      return null;
    }
  }

  // Hàm để chuyển đổi hình ảnh thành dạng string
  Future<String?> convertImageToBase64(String? imagePath) async {
    if (imagePath == null) {
      return null; // KiểmF tra nếu đường dẫn hình ảnh là null
    }
    File imageFile = File(imagePath);
    if (!imageFile.existsSync()) {
      print('File does not exist');
      return null;
    }
    List<int> imageBytes = await imageFile.readAsBytes();
    print('Base64 Image: ${base64Encode(imageBytes)}');
    return base64Encode(imageBytes);
  }

  //End of Image Picker Method
//-----------------------------------------------------------------------------------

  //call function `fetchSchools` in initState to get List School when page initial
  School? school;
  City? city;
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getSchools();
    context.read<AuthCubit>().getCity();
    print('Schools: $lstschools - Check Ini');
    print('Cities: $lstCities - Check Ini');
    // selectDate();
    schoolChange(null);
    programChange(null);
    cityChange(null);
    districtChange(null);
    wardChange(null);
    imageValueChanged(null);
    radioValueChanged(null);
    genderValueChanged(null);
    degreeValueChanged(null);
    certificateTypeValueChanged(null);
    // certificateImg = ''; // Gán giá trị ban đầu cho certificateImg
  }

  //End of LoginUser Method
  //-----------------------------------------------------------------------------------
  //Stepper Method
  continueStep() {
    final isLastStep = currentStep ==
        getSteps(
                    //Declare Input
                    context,
                    currentStep,
                    email,
                    name,
                    password,
                    idCardNumber,
                    phone,
                    confirmpassword,
                    selectedCity,
                    selectedDistrict,
                    selectedWard,
                    address,
                    gradeScore,
                    school,
                    //Declare Controller
                    usermailController,
                    usernameController,
                    passwordController,
                    confirmpasswordController,
                    idCardNumberController,
                    dateController,
                    phoneController,
                    genderController,
                    cityController,
                    districtController,
                    wardController,
                    addressController,
                    degreeController,
                    certificateController,
                    gradeController,
                    //Declare Method
                    setState,
                    selectDate,
                    schoolChange,
                    programChange,
                    cityChange,
                    districtChange,
                    wardChange,
                    radioValueChanged,
                    getImage,
                    imageValueChanged,
                    genderValueChanged,
                    degreeValueChanged,
                    certificateTypeValueChanged,
                    //Declare Stream
                    dateFocusNode,
                    errorDate,
                    valueGender,
                    valueDegree,
                    selectedCertificateType,
                    lstschools,
                    selectedSchool,
                    selectedProgram,
                    lstCities,
                    radioGradeTypeValue)
                .length -
            1;
    if (isLastStep) {
      print('Complete');
    } else {
      setState(() {
        currentStep += 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }
  //Control Builder in step_method_register.dart
  //End of Stepper method
  //-------------------------------------------------------------------------------

//DOB Setup Time not < 18
  String errorDate = "";
  FocusNode dateFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      errorFormatText: 'Ngày không hợp lệ',
      errorInvalidText: 'Ngày không hợp lệ',
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != selectedDate) {
      if (picked.isBefore(DateTime(DateTime.now().year - 17))) {
        // Ngày hợp lệ
        setState(() {
          selectedDate = picked;
          dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
          errorDate = "";
        });
      } else {
        setState(() {
          errorDate = "*Bạn phải đủ 18 tuổi";
        });
      }
    }
  }
//End of DOB method
//------------------------------------------------------------------------------------

//End of Gender method
//-------------------------------
//BuildContext
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              backgroundColor: const Color(0xffFAFAFA),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const TextMonserats(
                        'Create an account',
                        color: Color(0xff7D1F1F),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      const SizedBox(height: 5),
                      const TextMonserats(
                        'Create an account to manage yout account today',
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                      ),
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Color(0xff7D1F1F))),
                          child: Stepper(
                            physics: const ClampingScrollPhysics(),
                            type: StepperType.horizontal,
                            elevation: 0,
                            currentStep: currentStep,
                            onStepContinue: continueStep,
                            onStepCancel: cancelStep,
                            onStepTapped: onStepTapped,
                            controlsBuilder: controlsBuilder,
                            steps: getSteps(
                                //Declare Input
                                context,
                                currentStep,
                                email,
                                name,
                                password,
                                idCardNumber,
                                phone,
                                confirmpassword,
                                selectedCity,
                                selectedDistrict,
                                selectedWard,
                                address,
                                gradeScore,
                                school,
                                //Declare Controller
                                usermailController,
                                usernameController,
                                passwordController,
                                confirmpasswordController,
                                idCardNumberController,
                                dateController,
                                phoneController,
                                genderController,
                                cityController,
                                districtController,
                                wardController,
                                addressController,
                                degreeController,
                                certificateController,
                                gradeController,
                                //Declare Method
                                setState,
                                selectDate,
                                schoolChange,
                                programChange,
                                cityChange,
                                districtChange,
                                wardChange,
                                radioValueChanged,
                                getImage,
                                imageValueChanged,
                                genderValueChanged,
                                degreeValueChanged,
                                certificateTypeValueChanged,
                                //Declare Stream
                                dateFocusNode,
                                errorDate,
                                valueGender,
                                valueDegree,
                                selectedCertificateType,
                                lstschools,
                                selectedSchool,
                                selectedProgram,
                                lstCities,
                                radioGradeTypeValue
                                //Test
                                ), //steps_register
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Color(0xFFCBD5E1),
                        thickness: 1.0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                styledTextSpan(
                                  'Already have an account? ',
                                  color: Colors.black,
                                ),
                                styledTextSpan(
                                  'Sign in',
                                  color: const Color(0xff7D1F1F),
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color(
                                      0xff7D1F1F), // Change the color of the underline
                                  decorationStyle: TextDecorationStyle
                                      .solid, // Change the number of lines
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
