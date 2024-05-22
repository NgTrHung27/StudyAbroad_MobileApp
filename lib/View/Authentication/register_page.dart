import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/Model/country.dart';
import 'package:kltn_mobile/Model/schools.dart';
import 'package:kltn_mobile/View/Authentication/login_page.dart';
import 'package:intl/intl.dart';
import 'package:kltn_mobile/Model/enum.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kltn_mobile/bloC/auth/auth_cubit.dart';
import 'package:kltn_mobile/bloC/auth/auth_state.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/Style/textspan.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/convert_imagetostring.dart';
import 'package:kltn_mobile/components/dropdown.dart';
import 'package:kltn_mobile/components/radio.dart';
import 'package:kltn_mobile/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//Declare Date Input
class _RegisterPageState extends State<RegisterPage> {
  //Declare API School
  List<Schools> lstschools = [];
  List<Country> lstCountry = [];
  String? errorEmailMessage;
  String? errorNameMessage;
  String? errorPasswordMessage;
  String? errorConfrimPasswordMessage;
  String? errorIDCardNumberMessage;
  String? errorDateMessage;
  String? errorPhoneMessage;
  String? errorCityMessage;
  String? errorDistrictMessage;
  String? errorWardMessage;
  String? errorAddressMessage;
  String? errorGenderMessage;
  String? errorDegreeMessage;
  String? errorGradeTypeMessage;
  String? errorGradeMessage;
  String? errorCertificateTypeMessage;
  String? errorMessage;
  //Declare
  String email = '';
  String name = '';
  String password = '';
  String confirmpassword = '';
  String phone = '';
  String idCardNumber = '';
  String dob = '';
  Schools? selectedSchoolObject;
  String? selectedSchool;
  String? selectedProgram;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedWard;
  String address = '';
  Gender? valueGender;
  DegreeType? valueDegree;
  GradeType? radioGradeTypeValue; // 0: GPA, 1: CGPA
  double gradeScore = 0.0;
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
    //Call API from APIService

    context.read<AuthCubit>().register(
        email,
        name,
        password,
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
        gradeScoreString,
        selectedCertificateType,
        certificateImg);
  }

  //Declare intial state value for selectedSchool ,program, city, district, ward
  void schoolChange(Schools? school) {
    setState(() {
      if (school != null) {
        selectedSchoolObject = school;
        selectedSchool = school.name;
      }
    });
  }

  void programChange(Program? program) {
    setState(() {
      if (program != null) {
        selectedProgram = program.name;
      }
    });
  }

  void cityChange(Country? city) {
    setState(() {
      if (city != null) {
        selectedCity = city.name;
      }
    });
  }

  void districtChange(District? district) {
    setState(() {
      if (district != null) {
        selectedDistrict = district.name;
      }
    });
  }

  void wardChange(Ward? ward) {
    setState(() {
      if (ward != null) {
        selectedWard = ward.name;
      }
    });
  }

  void radioValueChanged(GradeType? gradeType) {
    setState(() {
      if (gradeType != null) {
        radioGradeTypeValue = gradeType;
      }
    });
  }

  void genderValueChanged(Gender? gender) {
    setState(() {
      print("gender: $gender");
      if (gender != null) {
        valueGender = gender;
        print("gender: $gender");
      }
    });
  }

  void degreeValueChanged(DegreeType? degreeType) {
    setState(() {
      if (degreeType != null) {
        valueDegree = degreeType;
      }
    });
  }

  void certificateTypeValueChanged(CertificateType? certificateType) {
    setState(() {
      if (certificateType != null) {
        selectedCertificateType = certificateType;
      }
    });
  }

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

  //Date
  Future<void> openDatePicker(BuildContext context) async {
    BottomPicker.date(
      pickerTitle: Text(
        'Date of Birth',
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      pickerTextStyle: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      dateOrder: DatePickerDateOrder.dmy,
      bottomPickerTheme: BottomPickerTheme.blue,
      initialDateTime: DateTime(2000, 01, 01),
      maxDateTime: DateTime(2010),
      minDateTime: DateTime(1960),
      onChange: (value) {
        setState(() {
          print(value);
          dateController.text = DateFormat('dd/MM/yyyy').format(value);
        });
      },
      onSubmit: (value) {
        print(value);
        dateController.text = DateFormat('dd/MM/yyyy').format(value);
        if (value.isAfter(DateTime(DateTime.now().year - 17))) {
          context.read<AuthCubit>().checkDob(value);
        } else {
          setState(() {
            errorDateMessage = null;
          });
        }
      },
    ).show(context);
  }

  //End of Image Picker Method
//-----------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getSchools();
    context.read<AuthCubit>().getCity();
  }

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
                  child: SimpleButton(
                    backgroundColor: Colors.transparent,
                    borderColor: AppColor.redButton,
                    onPressed: details.onStepCancel,
                    child: TextMonserats(
                      'Back',
                      color: AppColor.redButton,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
                  child: SizedBox(
                    child: SimpleButton(
                      backgroundColor: Colors.transparent,
                      borderColor: AppColor.redButton,
                      onPressed: details.onStepCancel,
                      child: TextMonserats(
                        'Back',
                        color: AppColor.redButton,
                      ),
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
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                prefixIcon: Icons.email,
                errorText: errorEmailMessage,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  email = value;
                  context.read<AuthCubit>().checkEmail(email);
                  if (email.isEmpty) {
                    setState(() {
                      errorEmailMessage;
                    });
                  } else {
                    setState(() {
                      errorEmailMessage = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 3),
              MyTextField(
                controller: usernameController,
                hintText: 'FullName',
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                prefixIcon: Icons.person,
                errorText: errorNameMessage,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  name = value;
                  context.read<AuthCubit>().checkName(name);
                  if (name.isEmpty) {
                    setState(() {
                      errorNameMessage;
                    });
                  } else {
                    setState(() {
                      errorMessage = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 3),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                prefixIcon: Icons.lock,
                errorText: errorPasswordMessage,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  password = value;
                  context.read<AuthCubit>().checkPassword(password);
                  if (password.isEmpty) {
                    setState(() {
                      errorPasswordMessage;
                    });
                  } else {
                    setState(() {
                      errorPasswordMessage = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 3),
              MyTextField(
                controller: confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
                prefixIcon: Icons.lock_reset,
                errorText: errorConfrimPasswordMessage,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  confirmpassword = value;
                  context
                      .read<AuthCubit>()
                      .checkConfrimPassword(password, confirmpassword);
                  if (confirmpassword.isEmpty) {
                    setState(() {
                      errorConfrimPasswordMessage;
                    });
                  } else {
                    setState(() {
                      errorConfrimPasswordMessage = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 3),
              MyTextField(
                controller: idCardNumberController,
                hintText: 'ID Card Number',
                obscureText: false,
                prefixIcon: Icons.how_to_reg,
                errorText: errorIDCardNumberMessage,
                onChanged: (value) {
                  // Lưu giá trị email mới được nhập
                  idCardNumber = value;
                  context.read<AuthCubit>().checkIDCardNumber(idCardNumber);
                  if (idCardNumber.isEmpty) {
                    setState(() {
                      errorIDCardNumberMessage;
                    });
                  } else {
                    setState(() {
                      errorIDCardNumberMessage = null;
                    });
                  }
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
                  height: 73,
                  child: GestureDetector(
                    onTap: () {
                      openDatePicker(context);
                    },
                    child: AbsorbPointer(
                      child: MyTextField(
                        controller: dateController,
                        hintText: 'Date of Birth',
                        obscureText: false,
                        prefixIcon: Icons.date_range,
                        errorText: errorDateMessage,
                        onChanged: (context) {},
                      ),
                    ),
                  )),
              //Gender - Phone number
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 73,
                      child: DropdownCustom<Gender>(
                        icon: Icons.wc,
                        hintText: 'Gender',
                        items: Gender.values,
                        selectedItem: valueGender,
                        errorText: errorGenderMessage,
                        onChanged: (Gender? newValueGender) {
                          if (newValueGender != null) {
                            setState(() {
                              errorGenderMessage;
                            });
                          } else {
                            setState(() {
                              errorGenderMessage = null;
                            });
                          }
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
                    child: MyTextField(
                      keyboardType: TextInputType.number,
                      controller:
                          phoneController, // Thêm controller cho trường số điện thoại
                      hintText: 'Phone',
                      obscureText: false,
                      prefixIcon: Icons.phone,
                      errorText: errorPhoneMessage,
                      onChanged: (value) {
                        // Save phone value
                        phone = value;
                        if (phone.isEmpty) {
                          setState(() {
                            errorPhoneMessage;
                          });
                        } else {
                          setState(() {
                            errorPhoneMessage = null;
                          });
                        }
                        context.read<AuthCubit>().checkPhoneNumber(phone);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              //Address
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMonserats('Address'),
                ],
              ),
              //City
              const SizedBox(height: 12),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadedCityState) {
                    lstCountry = state.country;
                  }
                  return DropdownCustom<Country>(
                    icon: Icons.location_city,
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
              ),
              //District - Ward
              const SizedBox(height: 15),
              Row(children: [
                Expanded(child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadedCityState) {
                      lstCountry = state.country;
                    }
                    return DropdownCustom<District>(
                      icon: Icons.map,
                      items: selectedCity == null
                          ? []
                          : lstCountry
                              .firstWhere(
                                  (element) => element.name == selectedCity)
                              .districts,
                      selectedItem: selectedDistrict == null
                          ? null
                          : lstCountry
                              .firstWhere(
                                  (element) => element.name == selectedCity)
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
                const SizedBox(width: 15),
                Expanded(child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadedCityState) {
                      lstCountry = state.country;
                    }
                    return DropdownCustom<Ward>(
                      icon: Icons.location_on,
                      items: selectedDistrict == null
                          ? []
                          : lstCountry
                              .firstWhere(
                                  (element) => element.name == selectedCity)
                              .districts
                              .firstWhere(
                                  (element) => element.name == selectedDistrict)
                              .wards,
                      selectedItem: selectedWard == null
                          ? null
                          : lstCountry
                              .firstWhere(
                                  (element) => element.name == selectedCity)
                              .districts
                              .firstWhere(
                                  (element) => element.name == selectedDistrict)
                              .wards
                              .firstWhere(
                                  (element) => element.name == selectedWard),
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
              ]),
              const SizedBox(height: 15),
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
                  Expanded(child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadedNamedSchoolState) {
                        lstschools = state.school;
                      }
                      return DropdownCustom<Schools>(
                        icon: Icons.school,
                        items: lstschools,
                        selectedItem: selectedSchool == null
                            ? null
                            : lstschools.firstWhere(
                                (element) => element.name == selectedSchool),
                        onChanged: (Schools? newValueSchool) {
                          setState(() {
                            schoolChange(newValueSchool);
                            selectedProgram = null;
                          });
                        },
                        itemLabel: (Schools school) => school.name,
                        hintText: '-Choose your school-',
                        isExpanded: true,
                      );
                    },
                  )),
                ],
              ),
              const SizedBox(height: 15),
              // Major - Degree
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadedNamedSchoolState) {
                          lstschools = state.school;
                        }
                        return DropdownCustom<Program>(
                          icon: Icons.history_edu,
                          items: selectedSchool == null
                              ? []
                              : selectedSchoolObject!.programs,
                          selectedItem: selectedProgram == null
                              ? null
                              : selectedSchoolObject!.programs.firstWhere(
                                  (element) => element.name == selectedProgram),
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
                  const SizedBox(width: 15),
                  Expanded(
                    child: DropdownCustom<DegreeType>(
                      icon: Icons.hotel_class,
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
                ],
              ),
              const SizedBox(height: 15),
              //Certificate
              DropdownCustom<CertificateType>(
                icon: Icons.bookmark_add,
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

              // Upload Certificate
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 37,
                child: SimpleButton(
                  backgroundColor: Colors.transparent,
                  borderColor: AppColor.redButton,
                  onPressed: () {
                    Future<String?> imageValueChanged() async {
                      String? certiImg = await getImage();
                      if (certiImg != null) {
                        print("Certificate ImageValue: $certiImg");
                      } else {
                        print("Certificate ImageValue: null");
                      }
                      return null;
                    }

                    imageValueChanged();
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
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
              MyTextField(
                keyboardType: TextInputType.number,
                controller: gradeController,
                hintText: 'Grade Score',
                obscureText: false,
                prefixIcon: Icons.functions,
                errorText: errorGradeMessage,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorGradeMessage;
                    });
                  } else if (value is double || value is int) {
                    gradeScore = value.toDouble();
                    print("Grade Score: $gradeScore");
                    setState(() {
                      errorGradeMessage = null;
                    });
                  } else {
                    print("Vui lòng nhập một số thực.");
                  }
                  context.read<AuthCubit>().checkGradeScore(gradeScore);
                },
              ),
            ],
          ),
        ),
      ];
  //End of Stepper method
  //-------------------------------------------------------------------------------
//BuildContext
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthErrorEmailState) {
          setState(() {
            errorEmailMessage = state.error;
          });
        } else if (state is AuthErrorNameState) {
          setState(() {
            errorNameMessage = state.error;
          });
        } else if (state is AuthErrorPasswordState) {
          setState(() {
            errorPasswordMessage = state.error;
          });
        } else if (state is AuthErrorConfrimPasswordState) {
          setState(() {
            errorConfrimPasswordMessage = state.error;
          });
        } else if (state is AuthErrorIDCardNumberState) {
          setState(() {
            errorIDCardNumberMessage = state.error;
          });
        } else if (state is AuthErrorDOBState) {
          setState(() {
            errorDateMessage = state.error;
          });
        } else if (state is AuthErrorPhoneState) {
          setState(() {
            errorPhoneMessage = state.error;
          });
        } else if (state is AuthErrorCityState) {
          setState(() {
            errorCityMessage = state.error;
          });
        } else if (state is AuthErrorDistrictState) {
          setState(() {
            errorDistrictMessage = state.error;
          });
        } else if (state is AuthErrorWardState) {
          setState(() {
            errorWardMessage = state.error;
          });
        } else if (state is AuthErrorAddressState) {
          setState(() {
            errorAddressMessage = state.error;
          });
        } else if (state is AuthErrorGenderErrorState) {
          setState(() {
            errorGenderMessage = state.error;
          });
        } else if (state is AuthErrorDegreeTypeState) {
          setState(() {
            errorDegreeMessage = state.error;
          });
        } else if (state is AuthErrorGradeTypeState) {
          setState(() {
            errorGradeTypeMessage = state.error;
          });
        } else if (state is AuthErrorGradeScore) {
          setState(() {
            errorGradeMessage = state.error;
          });
        } else if (state is AuthErrorCertificateTypeState) {
          setState(() {
            errorCertificateTypeMessage = state.error;
          });
        } else if (state is AuthErrorState) {
          setState(() {
            errorMessage = state.error;
          });
        } else if (state is AuthSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      }, builder: (context, state) {
        if (state is AuthErrorState) {
          Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is AuthLoadingState) {
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AuthInitialState) {}
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextMonserats(
                    'Create an account',
                    color: AppColor.redButton,
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
                      data: ThemeData(
                        canvasColor: Theme.of(context).scaffoldBackgroundColor,
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: AppColor.redButton,
                              background: Colors.red,
                              secondary: Colors.green,
                            ),
                      ),
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
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          styledTextSpan(
                            'Already have an account? ',
                            color: Colors.black,
                          ),
                          styledTextSpan(
                            'Sign up',
                            color: AppColor.redButton,
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
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}
