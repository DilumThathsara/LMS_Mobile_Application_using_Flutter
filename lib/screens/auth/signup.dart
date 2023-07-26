import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/components/custom_textfield.dart';
import 'package:proacademy_moodel/providers/signup_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
  static double h(BuildContext context) => MediaQuery.of(context).size.height;
}

class _SignUpState extends State<SignUp> {
  String gender = "male";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(18, 26, 64, 1.0),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: CustomText(
                  'SignUp',
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Positioned(
                top: 65,
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.all(28),
                  decoration: const BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              "PRO",
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 234, 171),
                            ),
                            CustomText(
                              "ACADEMY",
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 3, 30, 117),
                            ),
                          ],
                        ),
                        const CustomText(
                          "Moodel",
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          hintTxt: "First Name",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .firstNameController,
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintTxt: "Last Name",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .lastNameController,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .birthDayController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            hintText: "Birth Day",
                            hintStyle: const TextStyle(
                                color: AppColors.kBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: AppColors.kAsh),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1988),
                                lastDate: DateTime(2005, 12, 31));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                Provider.of<SignupProvider>(context,
                                        listen: false)
                                    .birthDayController
                                    .text = formattedDate;
                                Provider.of<SignupProvider>(context,
                                        listen: false)
                                    .setAge(formattedDate);
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const CustomText(
                              'Age: ',
                              fontSize: 20,
                              color: AppColors.kAsh,
                            ),
                            const SizedBox(width: 15),
                            CustomText(
                              "${Provider.of<SignupProvider>(context, listen: false).ageController}",
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          hintTxt: "Mobile Number",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .mobileNoController,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const CustomText(
                              'Male',
                              fontSize: 18,
                              color: Colors.black45,
                            ),
                            Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (val) {
                                setState(() {
                                  gender = "male";
                                  Provider.of<SignupProvider>(context,
                                          listen: false)
                                      .setGender('male');
                                });
                              },
                            ),
                            const CustomText(
                              'Female',
                              fontSize: 18,
                              color: Colors.black45,
                            ),
                            Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (val) {
                                setState(() {
                                  gender = "female";
                                  Provider.of<SignupProvider>(context,
                                          listen: false)
                                      .setGender('female');
                                });
                              },
                            ),
                          ],
                        ),
                        CustomTextfield(
                          hintTxt: "Address",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .addressController,
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintTxt: "School or University",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .schoolController,
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintTxt: "Email",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .emailController,
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintTxt: "Password",
                          controller: Provider.of<SignupProvider>(context,
                                  listen: false)
                              .passwordController,
                          isObscure: true,
                        ),
                        const SizedBox(height: 20),
                        Consumer<SignupProvider>(
                          builder: (context, value, child) {
                            return CustomButton(
                              text: 'SignUp',
                              onTap: () {
                                value.startSignup(context);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
