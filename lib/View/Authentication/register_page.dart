import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/Model/country.dart';
import 'package:kltn_mobile/Model/schools.dart';
import 'package:kltn_mobile/View/Authentication/login_page.dart';
import 'package:intl/intl.dart';
import 'package:kltn_mobile/View/HomePage/home_page.dart';
import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/user_register.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kltn_mobile/bloC/auth/auth_cubit.dart';
import 'package:kltn_mobile/bloC/auth/auth_state.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/Style/textspan.dart';
import 'package:kltn_mobile/components/convert_imagetostring.dart';
import 'package:kltn_mobile/components/dropdown.dart';
import 'package:kltn_mobile/components/numeric_textfield.dart';
import 'package:kltn_mobile/components/radio.dart';
import 'package:kltn_mobile/components/text_field.dart';

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
  List<Schools> lstschools = [];
  List<Country> lstCountry = [];
  //Declare
  String email = '';
  String name = '';
  String password = '';
  String confirmpassword = '';
  String phone = '';
  String idCardNumber = '';
  Schools? selectedSchoolObject;
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
  TextEditingController imageController = TextEditingController();
  int currentStep = 0;

  //--------------------------------------------------------------------------------------------------

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
    String gradeScoreString = gradeScore.toString();

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
  void schoolChange(Schools? school) {
    setState(() {
      if (school != null) {
        selectedSchoolObject = school;
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
  void cityChange(Country? city) {
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

  //End of Image Picker Method
//-----------------------------------------------------------------------------------

  //call function `fetchSchools` in initState to get List School when page initial
  Schools? school;
  Country? country;
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getSchools();
    context.read<AuthCubit>().getCity();
  }

  //End of LoginUser Method
  //-----------------------------------------------------------------------------------
  //Stepper Method
  continueStep() {
    final isLastStep = currentStep == getSteps().length - 1;
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
                  child: SimpleButton(
                    backgroundColor: Colors.transparent,
                    borderColor: const Color(0xff7D1F1F),
                    onPressed: details.onStepCancel,
                    child: const TextMonserats(
                      'Back',
                      color: Color(0xff7D1F1F),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: SimpleButton(
                      onPressed: () {
                        userRegister();
                      },
                      child: const TextMonserats(
                        'Sign Up',
                        color: Colors.white,
                      ),
                    )),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: SimpleButton(
                    backgroundColor: Colors.transparent,
                    borderColor: const Color(0xff7D1F1F),
                    onPressed: details.onStepCancel,
                    child: const TextMonserats(
                      'Back',
                      color: Color(0xff7D1F1F),
                    ),
                  ),
                ),
                const SizedBox(width: 120),
                Expanded(
                  child: SimpleButton(
                    onPressed: details.onStepContinue,
                    child: const TextMonserats(
                      'Next',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

// List Steps
  List<Step> getSteps() => [
        //Step 1 - Account
        Step(
          title: const SizedBox.shrink(),
          isActive: currentStep != 1 && currentStep != 2,
          label: const Padding(
            padding: EdgeInsets.only(
                left: 15.0,
                right:
                    15.0), // Điều chỉnh khoảng cách giữa các số 1, 2, 3 ở đây
            child: TextMonserats('Account'),
          ),
          content: Column(
            children: [
              MyTextField(
                controller: usermailController,
                hintText: 'Email',
                obscureText: false,
                prefixIcon: Icons.email,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                },
              ),
              const SizedBox(height: 13),
              MyTextField(
                controller: usernameController,
                hintText: 'FullName',
                obscureText: false,
                prefixIcon: Icons.person,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                },
              ),
              const SizedBox(height: 13),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: false,
                prefixIcon: Icons.lock,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                },
              ),
              const SizedBox(height: 13),
              MyTextField(
                controller: confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: false,
                prefixIcon: Icons.lock_reset,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                },
              ),
              const SizedBox(height: 13),
              MyTextField(
                controller: idCardNumberController,
                hintText: 'ID Card Number',
                obscureText: false,
                prefixIcon: Icons.how_to_reg,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                },
              ),
            ],
          ),
        ),

        //---------------------------------------------------------------------------------------------------------
        //Step 2 - Profile
        Step(
          title: const SizedBox.shrink(),
          isActive: currentStep != 0 && currentStep != 2,
          label: const TextMonserats('Profile'),
          content: Column(
            children: [
              //DOB
              SizedBox(
                width: double.infinity,
                height: 37,
                child: GestureDetector(
                  onTap: () => selectDate(context), // Call Calendar when click
                  child: AbsorbPointer(
                    child: TextFormField(
                      focusNode: dateFocusNode,
                      controller: dateController,
                      decoration: InputDecoration(
                        hintText: 'Date of birth',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: errorDate != "" ? errorDate : null,
                        errorStyle: const TextStyle(color: Color(0xff7D1F1F)),
                        prefixIcon: const Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFCBD5E1), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 2,
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              //Gender - Phone number
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 37,
                      child: DropdownCustom<Gender>(
                        hintText: 'Gender',
                        items: Gender.values,
                        selectedItem: valueGender,
                        onChanged: (Gender? newValueGender) {
                          setState(() {
                            genderValueChanged(newValueGender);
                            print(valueGender);
                          });
                        },
                        itemLabel: (Gender gender) =>
                            gender.toString().split('.').last,
                        isExpanded: false,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15), // Khoảng cách giữa hai trường
                  Expanded(
                    child: NumericTextField(
                      controller:
                          phoneController, // Thêm controller cho trường số điện thoại
                      hintText: 'Phone Number',
                      prefixIcon: Icons.phone,
                      onChanged: (value) {
                        // Save phone value
                        phone = value;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 13),
              //Address
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMonserats('Address'),
                ],
              ),
              //City
              const SizedBox(height: 12),
              SizedBox(
                  height: 37,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadedCityState) {
                        lstCountry = state.country;
                      }
                      return DropdownCustom<Country>(
                        items: lstCountry,
                        selectedItem: selectedCity == null
                            ? null
                            : lstCountry.firstWhere(
                                (element) => element.name == selectedCity),
                        onChanged: (Country? newValueCountry) {
                          if (newValueCountry != null) {
                            cityChange(newValueCountry);
                            selectedDistrict = null;
                            selectedWard = null;
                          }
                        },
                        itemLabel: (Country country) => country.name,
                        hintText: 'City',
                        isExpanded: false,
                      );
                    },
                  )),
              //District - Ward
              const SizedBox(height: 13),
              Row(children: [
                Expanded(
                  child: SizedBox(
                      height: 37,
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoadedCityState) {
                            lstCountry = state.country;
                          }
                          return DropdownCustom<District>(
                            items: selectedCity == null
                                ? []
                                : lstCountry
                                    .firstWhere((element) =>
                                        element.name == selectedCity)
                                    .districts,
                            selectedItem: selectedDistrict == null
                                ? null
                                : lstCountry
                                    .firstWhere((element) =>
                                        element.name == selectedCity)
                                    .districts
                                    .firstWhere((element) =>
                                        element.name == selectedDistrict),
                            onChanged: (District? newValueDistrict) {
                              setState(() {
                                districtChange(newValueDistrict);
                                selectedWard = null;
                              });
                            },
                            itemLabel: (District district) => district.name,
                            hintText: 'District',
                            isExpanded: true,
                          );
                        },
                      )),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                      height: 37,
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoadedCityState) {
                            lstCountry = state.country;
                          }
                          return DropdownCustom<Ward>(
                            items: selectedDistrict == null
                                ? []
                                : lstCountry
                                    .firstWhere((element) =>
                                        element.name == selectedCity)
                                    .districts
                                    .firstWhere((element) =>
                                        element.name == selectedDistrict)
                                    .wards,
                            selectedItem: selectedWard == null
                                ? null
                                : lstCountry
                                    .firstWhere((element) =>
                                        element.name == selectedCity)
                                    .districts
                                    .firstWhere((element) =>
                                        element.name == selectedDistrict)
                                    .wards
                                    .firstWhere((element) =>
                                        element.name == selectedWard),
                            onChanged: (Ward? newValueWard) {
                              setState(() {
                                wardChange(newValueWard);
                              });
                            },
                            itemLabel: (Ward ward) => ward.name,
                            hintText: 'Ward',
                            isExpanded: true,
                          );
                        },
                      )),
                  // Khoảng cách giữa hai trường
                )
              ]),
              const SizedBox(height: 13),
              MyTextField(
                controller: addressController,
                hintText: 'Address',
                obscureText: false,
                prefixIcon: Icons.home,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                },
              ),
            ],
          ),
        ),

        //---------------------------------------------------------------------------------------------------------
        //Step 3 - Education
        Step(
          title: const SizedBox.shrink(),
          isActive: currentStep != 0 && currentStep != 1,
          label: const Padding(
            padding: EdgeInsets.only(
                left: 15.0,
                right:
                    15.0), // Điều chỉnh khoảng cách giữa các số 1, 2, 3 ở đây
            child: TextMonserats('Education'),
          ),
          content: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 37,
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoadedNamedSchoolState) {
                              lstschools = state.school;
                            }
                            return DropdownCustom<Schools>(
                              items: lstschools,
                              selectedItem: selectedSchool == null
                                  ? null
                                  : lstschools.firstWhere((element) =>
                                      element.name == selectedSchool),
                              onChanged: (Schools? newValueSchool) {
                                setState(() {
                                  schoolChange(newValueSchool);
                                  selectedProgram = null;
                                });
                              },
                              itemLabel: (Schools school) => school.name,
                              hintText: 'School',
                              isExpanded: false,
                            );
                          },
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              // Major - Degree
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 37,
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoadedNamedSchoolState) {
                            lstschools = state.school;
                          }
                          return DropdownCustom<Program>(
                            items: selectedSchool == null
                                ? []
                                : selectedSchoolObject!.programs,
                            selectedItem: selectedProgram == null
                                ? null
                                : selectedSchoolObject!.programs.firstWhere(
                                    (element) =>
                                        element.name == selectedProgram),
                            onChanged: (Program? newValueProgram) {
                              setState(() {
                                programChange(newValueProgram);
                              });
                            },
                            itemLabel: (Program program) => program.name,
                            hintText: 'Major',
                            isExpanded: true,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      height: 37,
                      child: DropdownCustom<DegreeType>(
                        items: DegreeType.values,
                        selectedItem: valueDegree,
                        onChanged: (DegreeType? newValueDegree) {
                          setState(() {
                            degreeValueChanged(newValueDegree);
                            print(valueDegree);
                          });
                        },
                        itemLabel: (DegreeType degreeType) =>
                            degreeType.toString().split('.').last,
                        hintText: 'Degree',
                        isExpanded: true,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 13),
              //Certificate
              SizedBox(
                height: 37,
                child: DropdownCustom<CertificateType>(
                  items: CertificateType.values,
                  onChanged: (CertificateType? newValueCertificateType) {
                    setState(() {
                      certificateTypeValueChanged(newValueCertificateType);
                      print(selectedCertificateType);
                    });
                  },
                  selectedItem: selectedCertificateType,
                  itemLabel: (CertificateType certificateType) =>
                      certificateType.toString().split('.').last,
                  hintText: 'Certificate',
                  isExpanded: false,
                ),
              ),
              // Upload Certificate
              const SizedBox(height: 13),
              SizedBox(
                width: double.infinity,
                height: 37,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
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
                        (states) =>
                            states.contains(MaterialState.pressed) ? 5.0 : 0.0),
                  ),
                  onPressed: () {
                    Future<String?> imageValueChanged() async {
                      String? certiImg = await getImage();
                      // ignore: unnecessary_null_comparison
                      if (certiImg != null) {
                        print("Certificate ImageValue: $certiImg");
                      } else {
                        print("Certificate ImageValue: null");
                      }
                      return null;
                    }

                    imageValueChanged();
                    // imageValueChanged(getImage());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.upload_file,
                        size: 21,
                      ),
                      SizedBox(width: 10),
                      TextMonserats('Upload file here')
                    ],
                  ),
                ),
              ),
              //Overall Score
              const SizedBox(height: 13),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMonserats('Overall Score'),
                ],
              ),
              //GPA - CGPA
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomRadio<GradeType>(
                    value: GradeType.GPA,
                    groupValue: radioGradeTypeValue,
                    onChanged: (GradeType? newGradeTypeValue) {
                      radioValueChanged(newGradeTypeValue);
                    },
                    title: 'GPA (?/4.0)',
                  ),
                  CustomRadio<GradeType>(
                    value: GradeType.CGPA,
                    groupValue: radioGradeTypeValue,
                    onChanged: (GradeType? newGradeTypeValue) {
                      radioValueChanged(newGradeTypeValue);
                    },
                    title: 'GGPA (?/10.0)',
                  ),
                ],
              ),
              //Grade Score
              const SizedBox(height: 13),
              NumericTextField(
                controller: gradeController,
                hintText: 'Grade Score',
                prefixIcon: Icons.functions,
                onChanged: (value) {
                  if (value is double || value is int) {
                    gradeScore = value.toDouble();
                    print("Grade Score: $gradeScore");
                  } else {
                    print("Vui lòng nhập một số thực.");
                  }
                },
              ),
            ],
          ),
        ),
      ];
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
                            steps: getSteps(), //steps_register
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
