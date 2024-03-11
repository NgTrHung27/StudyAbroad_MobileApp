import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/API/api_service.dart';
import 'package:kltn_mobile/Authentication/login_page.dart';
import 'package:kltn_mobile/Authentication/steps_register.dart';
import 'package:intl/intl.dart';
import 'package:kltn_mobile/HomePage/home_page.dart';
import 'package:kltn_mobile/Model/auth_bloc.dart';
import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/user_register.dart';
import 'package:kltn_mobile/Model/vn_country.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

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
  String? valueGender;
  String? valueDegree;
  String? radioGradeTypeValue; // 0: GPA, 1: CGPA
  double? gradeScore;
  String? selectedCertificateType;
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

  //AuthBloc
  AuthBloc authBloc = AuthBloc(); //kiểm tra và hiển thị lỗi trong các TextField
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController dateController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController genderController = TextEditingController();
  // final TextEditingController cICController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passController = TextEditingController();
  //End of AuthBloc
  //-------------------------------------------------------------------------

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
    if (selectedSchool == null) {
      print('School is null');
    }
    if (selectedProgram == null) {
      print('Program is null');
    }
    if (selectedCity == null) {
      print('City is null');
    }
    if (selectedDistrict == null) {
      print('District is null');
    }
    if (selectedWard == null) {
      print('Ward is null');
    }

    String address = addressController.text.trim();
    if (valueGender == null) {
      print('valueGender is null');
    }
    if (valueDegree == null) {
      print('valueDegree is null');
    }
    if (radioGradeTypeValue == null) {
      print('radioGradeTypeValue is null');
    }

    if (selectedCertificateType == null) {
      print('selectedCertificateType is null');
    }
    double gradeScore = double.parse(gradeController.text.trim());
    String certificateImg = imageController.text.toString();

    // Type selectedCity = cityController;
    // Type selectedDistrict = districtController;
    // Type selectedWard = wardController;
    // Type valueGender = genderController;
    // Type valueDegree = degreeController;
    // Type radioGradeTypeValue = gradeTypecontroller; // 0: GPA, 1: CGPA
    // Type selectedCertificateType = certificateTypeController;

    // Kiểm tra xem các giá trị có rỗng không
    // if (email.isEmpty ||
    //     password.isEmpty ||
    //     name.isEmpty ||
    //     phone.isEmpty ||
    //     confirmpassword.isEmpty ||
    //     gradeScore == null ||
    //     selectedProgram == null ||
    //     selectedCity == null ||
    //     selectedDistrict == null ||
    //     selectedWard == null ||
    //     address.isEmpty ||
    //     radioGradeTypeValue == null ||
    //     certificateImg.isEmpty) {
    //   // Hiển thị thông báo lỗi
    //   print('Email, password, name, phone, confirmpass,.... không được trống!');
    //   return;
    // }
    //Call API from APIService

    UserAuthRegister? userAuthRegister = await APIService().register(
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
        valueGender,
        valueDegree,
        radioGradeTypeValue,
        gradeScore,
        selectedCertificateType,
        certificateImg);
    if (userAuthRegister != null) {
      // Đăng ký thành công
      print('Đăng ký thành công: ${userAuthRegister.email}');
      // Hiển thị thông báo đăng ký thành công
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Đăng ký thất bại
      print('Đăng ký thất bại');
      // Hiển thị thông báo đăng ký thất bại
    }
  }

  //Method API
  void fetchSchools() async {
    try {
      List<School> fetchedSchools = await APIService().getSchools();
      setState(() {
        lstschools = fetchedSchools;
        print('Fetched Schools: $fetchedSchools');
      });
    } catch (e) {
      print("Failed to fetch schools: $e");
    }
  }

  void fetchCity() async {
    try {
      List<City> fetchedCity = await APIService().getCity();
      setState(() {
        lstCities = fetchedCity.cast<City>();
      });
    } catch (e) {
      print("Failed to fetch country: $e");
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
        radioGradeTypeValue = gradeType.toString().split('.').last;
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
  @override
  void initState() {
    super.initState();
    // selectDate();
    fetchSchools();
    schoolChange(null);
    programChange(null);
    fetchCity();
    cityChange(null);
    districtChange(null);
    wardChange(null);
    imageValueChanged(null);
    // radioValueChanged(null);
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
                    fetchSchools,
                    schoolChange,
                    programChange,
                    fetchCity,
                    cityChange,
                    districtChange,
                    wardChange,
                    radioValueChanged,
                    getImage,
                    imageValueChanged,
                    //Declare Stream
                    dateFocusNode,
                    errorDate,
                    valueGender,
                    valueDegree,
                    authBloc,
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

  Widget controlsBuilder(context, details) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: currentStep == 2 // Kiểm tra nếu đang ở bước thứ 3
          ? Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Color(0xff7D1F1F),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => states.contains(MaterialState.pressed)
                              ? const Color(0xff7D1F1F).withOpacity(0.2)
                              : const Color(0xff7D1F1F).withOpacity(0.1)),
                      shadowColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => states.contains(MaterialState.pressed)
                              ? Colors.black.withOpacity(0.3)
                              : Colors.transparent),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (states) => states.contains(MaterialState.pressed)
                              ? 5.0
                              : 0.0),
                    ),
                    onPressed: details.onStepCancel,
                    child: Text('Back',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: const Color(0xff7D1F1F),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff7D1F1F)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (states) => states.contains(MaterialState.pressed)
                                ? const Color(0xff7D1F1F).withOpacity(0.2)
                                : const Color(0xff7D1F1F).withOpacity(0.1)),
                        shadowColor: MaterialStateProperty.resolveWith<Color>(
                            (states) => states.contains(MaterialState.pressed)
                                ? Colors.black.withOpacity(0.3)
                                : Colors.transparent),
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (states) => states.contains(MaterialState.pressed)
                                ? 5.0
                                : 0.0),
                      ),
                      onPressed: () {
                        // Thực hiện chức năng đăng ký khi nhấn nút Sign Up
                        // Đoạn code xử lý đăng ký người dùng
                        userRegister();
                      },
                      child: Text('Sign Up',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                    )),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Color(0xff7D1F1F),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    onPressed: details.onStepCancel,
                    child: Text('Back',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: const Color(0xff7D1F1F),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(width: 120),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff7D1F1F)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: details.onStepContinue,
                    child: Text('Next',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                ),
              ],
            ),
    );
  }

  //End of Stepper method
  //-------------------------------------------------------------------------------

  //DOB Setup Time not < 18
  String errorDate = "";
  FocusNode dateFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  // TextEditingController dateController = TextEditingController();

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
                      Text('Create an account',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: const Color(0xff7D1F1F),
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          )),
                      const SizedBox(height: 5),
                      Text('Create an account to manage yout account today',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          )),
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
                                fetchSchools,
                                schoolChange,
                                programChange,
                                fetchCity,
                                cityChange,
                                districtChange,
                                wardChange,
                                radioValueChanged,
                                getImage,
                                imageValueChanged,
                                //Declare Stream
                                dateFocusNode,
                                errorDate,
                                valueGender,
                                valueDegree,
                                authBloc,
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
                              text: 'Already have an account? ',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign in',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    color: const Color(0xff7D1F1F),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                  ),
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
