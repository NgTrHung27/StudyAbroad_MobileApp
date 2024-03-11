import 'package:flutter/material.dart';
import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/vn_country.dart';
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
                    child: StreamBuilder(
                      stream: authBloc.genderStream,
                      builder: (context, snapshot) =>
                          DropdownButtonFormField<Gender>(
                        hint: Text(
                          'Gender',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        icon: null,
                        value: valueGender,
                        onChanged: (Gender? newValue) {
                          setState(() {
                            valueGender = newValue;
                            //fix tiep 12/3/2024
                            print(valueDegree);
                          });
                        },
                        items: <Gender>[
                          Gender.Female,
                          Gender.Male,
                        ].map<DropdownMenuItem<Gender>>((Gender value) {
                          return DropdownMenuItem<Gender>(
                              value: Gender.values[value.index],
                              child: Text(
                                Gender.values[value.index]
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
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.wc, color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          errorStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFCBD5E1), width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFCBD5E1), width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 2,
                          ),
                        ),
                      ),
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
              child: DropdownButtonFormField<City>(
                hint: Text(
                  'City',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: selectedCity == null
                    ? null
                    : lstCities
                        .firstWhere((element) => element.name == selectedCity),
                onChanged: (City? newValueCountry) {
                  if (newValueCountry != null) {
                    cityChange(newValueCountry);
                    selectedDistrict = null;
                    selectedWard = null;
                  }
                },
                items: lstCities.map<DropdownMenuItem<City>>(
                  (City city) {
                    return DropdownMenuItem<City>(
                      value: city,
                      child: Text(
                        city.name,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ).toList(),
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.map, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  // errorText: snapshot.hasError ? snapshot.error.toString() : null,
                  errorStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
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
            //District - Ward
            const SizedBox(height: 13),
            Row(children: [
              Expanded(
                child: SizedBox(
                  height: 37,
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return DropdownButtonFormField<District>(
                          hint: Text(
                            selectedCity == null ? 'District' : 'District',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: selectedDistrict == null
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
                          items: selectedCity == null
                              ? []
                              : lstCities
                                  .firstWhere(
                                      (element) => element.name == selectedCity)
                                  .districts
                                  .map<DropdownMenuItem<District>>(
                                      (District district) {
                                  return DropdownMenuItem<District>(
                                    value: district,
                                    child: Text(
                                      district.name,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city,
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
                        );
                      }),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 37,
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return DropdownButtonFormField<Ward>(
                          hint: Text(
                            selectedDistrict == null ? 'Ward' : 'Ward',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: selectedDistrict == null ||
                                  selectedWard == null
                              ? null
                              : lstCities
                                  .firstWhere(
                                      (element) => element.name == selectedCity)
                                  .districts
                                  .firstWhere((element) =>
                                      element.name == selectedDistrict)
                                  .wards
                                  .firstWhere(
                                    (element) => element.name == selectedWard,
                                  ),
                          onChanged: (Ward? newValueWard) {
                            setState(() {
                              wardChange(newValueWard);
                            });
                          },
                          items: selectedDistrict == null
                              ? []
                              : lstCities
                                  .firstWhere(
                                      (element) => element.name == selectedCity)
                                  .districts
                                  .firstWhere((element) =>
                                      element.name == selectedDistrict)
                                  .wards
                                  .map<DropdownMenuItem<Ward>>((Ward ward) {
                                  return DropdownMenuItem<Ward>(
                                    value: ward,
                                    child: Text(
                                      ward.name,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.pin_drop, color: Colors.black),
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
                        );
                      }),
                ),
              ),
              // Khoảng cách giữa hai trường
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
                    child: StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          //Đang Fix
                          return DropdownButtonFormField<School>(
                            hint: Text(
                              '- Choose your school -',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: selectedSchool == null
                                ? null
                                : lstschools.firstWhere((element) =>
                                    element.name == selectedSchool),
                            onChanged: (School? newValueSchool) {
                              setState(() {
                                schoolChange(newValueSchool);
                                selectedProgram = null;
                              });
                            },
                            items: lstschools
                                .map<DropdownMenuItem<School>>((School school) {
                              return DropdownMenuItem<School>(
                                value: school,
                                child: Text(
                                  school.name,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.school, color: Colors.black),
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
                                vertical: 11,
                                horizontal: 2,
                              ),
                            ),
                          );
                        }),
                  ),
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
                    child: DropdownButtonFormField<Program>(
                      hint: Text(
                        selectedSchool == null
                            ? '- Choose Your Major -'
                            : '- Choose your major -',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: selectedProgram == null
                          ? null
                          : lstschools
                              .firstWhere(
                                  (element) => element.name == selectedSchool)
                              .programs
                              .firstWhere(
                                  (element) => element.name == selectedProgram),
                      onChanged: (Program? newProgramValue) {
                        print({"selected ": newProgramValue});
                        if (newProgramValue != null) {
                          programChange(newProgramValue);
                        }
                      },
                      items: selectedSchool == null
                          ? []
                          : lstschools
                              .firstWhere(
                                  (element) => element.name == selectedSchool)
                              .programs
                              .map<DropdownMenuItem<Program>>(
                              (Program program) {
                                return DropdownMenuItem<Program>(
                                  value: program,
                                  child: Text(
                                    program.name,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                      isExpanded: true,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.history_edu, color: Colors.black),
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
                      onChanged: (DegreeType? newValue) {
                        setState(() {
                          valueDegree = newValue;
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
              child: DropdownButtonFormField<CertificateType>(
                hint: Text(
                  'Certificate',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: null,
                value: null,
                onChanged: (CertificateType? newValue) {
                  setState(() {
                    valueDegree = newValue;
                  });
                },
                items: <CertificateType>[
                  CertificateType.IELTS,
                  CertificateType.TOEFL,
                ].map<DropdownMenuItem<CertificateType>>(
                  (CertificateType value) {
                    return DropdownMenuItem<CertificateType>(
                        value: CertificateType.values[value.index],
                        child: Text(
                          CertificateType.values[value.index]
                              .toString()
                              .split('.')
                              .last,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ));
                  },
                ).toList(),
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.collections_bookmark,
                      color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  // errorText: snapshot.hasError ? snapshot.error.toString() : null,
                  errorStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
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
                  // setState(
                  //   () {
                  //     getImage().then((value) => print("Value: $value"));
                  //     Future<String?> imageValueChanged() async {
                  //       String certiImg = await getImage();
                  //       if (certiImg != null) {
                  //         print("Certificate ImageValue: $certiImg");
                  //       } else {
                  //         print("Certificate ImageValue: null");
                  //       }
                  //       return null;
                  //     }

                  //     imageValueChanged();
                  //   },
                  // );

                  // setState(imageValueChanged(getImage()));

                  // imageValueChanged(getImage());

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
                        groupValue: radioGradeTypeValue ?? GradeType.GPA,
                        onChanged: (GradeType? value) {
                          radioValueChanged(value);
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
                        groupValue: radioGradeTypeValue ?? GradeType.CGPA,
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
