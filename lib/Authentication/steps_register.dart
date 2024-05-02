import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/vn_country.dart';
import 'package:kltn_mobile/bloC/auth/auth_cubit.dart';
import 'package:kltn_mobile/bloC/auth/auth_state.dart';
import 'package:kltn_mobile/components/dropdown.dart';
import 'package:kltn_mobile/components/numeric_textfield.dart';
import 'package:kltn_mobile/components/text_field.dart';
import 'package:google_fonts/google_fonts.dart';

List<Step> getSteps(
        //Declare Input
        BuildContext context,
        int currentStep,
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
        //Declare Future Method
        Function setState,
        selectDate,
        Function fetchSchools,
        schoolChange,
        programChange,
        fetchCity,
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
        authBloc,
        List<School> lstschools,
        selectedSchool,
        selectedProgram,
        List<City> lstCities,
        radioGradeTypeValue) =>
    //---------------------------------------------------------------------------------------------------------
    //Declare Step
    [
      //Step 1 - Account
      Step(
        title: const SizedBox.shrink(),
        isActive: currentStep != 1 && currentStep != 2,
        label: Padding(
          padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0), // Điều chỉnh khoảng cách giữa các số 1, 2, 3 ở đây
          child: Text('Account',
              style: GoogleFonts.getFont(
                'Montserrat',
                color: const Color(0xff7D1F1F),
                fontWeight: FontWeight.w400,
                fontSize: 11,
              )),
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
        label: Text('Profile',
            style: GoogleFonts.getFont(
              'Montserrat',
              color: const Color(0xff7D1F1F),
              fontWeight: FontWeight.w400,
              fontSize: 11,
            )),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    )),
              ],
            ),
            //City
            const SizedBox(height: 12),
            SizedBox(
                height: 37,
                child: DropdownCustom<City>(
                  items: lstCities,
                  selectedItem: selectedCity == null
                      ? null
                      : lstCities.firstWhere(
                          (element) => element.name == selectedCity),
                  onChanged: (City? newValueCountry) {
                    if (newValueCountry != null) {
                      cityChange(newValueCountry);
                      selectedDistrict = null;
                      selectedWard = null;
                    }
                  },
                  itemLabel: (City city) => city.name,
                  hintText: 'City',
                  isExpanded: false,
                )),
            //District - Ward
            const SizedBox(height: 13),
            Row(children: [
              Expanded(
                child: SizedBox(
                    height: 37,
                    child: DropdownCustom<District>(
                      items: selectedCity == null
                          ? []
                          : lstCities
                              .firstWhere(
                                  (element) => element.name == selectedCity)
                              .districts,
                      selectedItem: selectedDistrict == null
                          ? null
                          : lstCities
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
                    )),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                    height: 37,
                    child: DropdownCustom<Ward>(
                      items: selectedDistrict == null
                          ? []
                          : lstCities
                              .firstWhere(
                                  (element) => element.name == selectedCity)
                              .districts
                              .firstWhere(
                                  (element) => element.name == selectedDistrict)
                              .wards,
                      selectedItem: selectedWard == null
                          ? null
                          : lstCities
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
        label: Padding(
          padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0), // Điều chỉnh khoảng cách giữa các số 1, 2, 3 ở đây
          child: Text('Education',
              style: GoogleFonts.getFont(
                'Montserrat',
                color: const Color(0xff7D1F1F),
                fontWeight: FontWeight.w400,
                fontSize: 11,
              )),
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
                          if (state is AuthLoadedState) {
                            lstschools = state.school!;
                          }
                          return DropdownCustom<School>(
                            items: lstschools,
                            selectedItem: selectedSchool == null
                                ? null
                                : lstschools.firstWhere((element) =>
                                    element.name == selectedSchool),
                            onChanged: (School? newValueSchool) {
                              setState(() {
                                schoolChange(newValueSchool);
                                selectedProgram = null;
                              });
                            },
                            itemLabel: (School school) => school.name,
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
                      isExpanded: false,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 37,
                    child: DropdownButtonFormField<DegreeType>(
                      hint: Text(
                        'Degree',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      icon: null,
                      value: valueDegree,
                      onChanged: (DegreeType? newValueDegree) {
                        setState(() {
                          degreeValueChanged(newValueDegree);
                          print(valueDegree);
                        });
                      },
                      items: <DegreeType>[
                        DegreeType.Highschool,
                        DegreeType.University,
                      ].map<DropdownMenuItem<DegreeType>>((DegreeType value) {
                        return DropdownMenuItem<DegreeType>(
                            value: DegreeType.values[value.index],
                            child: Text(
                              DegreeType.values[value.index]
                                  .toString()
                                  .split('.')
                                  .last,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ));
                      }).toList(),
                      isExpanded: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.workspace_premium,
                            color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        // errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        errorStyle: const TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFCBD5E1), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 2,
                        ),
                      ),
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
                    String certiImg = await getImage();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.upload_file,
                      size: 21,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Upload file here',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            //Overall Score
            const SizedBox(height: 13),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Score',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            //GPA - CGPA
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 37,
                    child: ListTile(
                      title: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('GPA (?/4.0)',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            )),
                      ),
                      // leading: Radio<GradeType>(
                      //   value: GradeType.GPA,
                      //   groupValue: radioGradeTypeValue ,
                      //   onChanged: radioValueChanged,
                      // ),
                      leading: Radio<GradeType>(
                        value: GradeType.GPA,
                        groupValue: radioGradeTypeValue,
                        onChanged: (GradeType? newGradeTypeValue) {
                          radioValueChanged(newGradeTypeValue);
                        },
                      ),
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 37,
                    child: ListTile(
                      title: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('GGPA (?/10.0)',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            )),
                      ),
                      // leading: Radio<GradeType>(
                      //   value: GradeType.CGPA,
                      //   groupValue: radioGradeTypeValue,
                      //   onChanged: radioValueChanged,
                      // ),
                      leading: Radio<GradeType>(
                        value: GradeType.CGPA,
                        groupValue: radioGradeTypeValue,
                        onChanged: (GradeType? value) {
                          radioValueChanged(value);
                        },
                      ),
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
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
                // // Lưu giá trị email mới được nhập
                // gradeScore = value;
                // print({value});
                // Kiểm tra xem giá trị nhập liệu có phải là một số không
                if (value is double || value is int) {
                  // Nếu là số, gán giá trị cho biến gradeScoreValue
                  gradeScore = value.toDouble();
                  print("Grade Score: $gradeScore");
                } else {
                  // Nếu không phải số, in ra thông báo lỗi
                  print("Vui lòng nhập một số thực.");
                }
              },
            ),
          ],
        ),
      ),
    ];
