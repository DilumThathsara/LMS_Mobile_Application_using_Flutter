import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/components/custom_textfield.dart';
import 'package:proacademy_moodel/providers/admin_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Expanded(
              child: Column(
                children: [
                  const CustomText(
                    "admin - add couses",
                    color: AppColors.kBlack,
                    fontSize: 25,
                  ),
                  const SizedBox(height: 10),
                  Consumer<AdminProvider>(
                    builder: (context, value, child) {
                      return value.courseimage.path == ""
                          ? IconButton(
                              onPressed: () => value.selectCourseImage(),
                              icon: const Icon(
                                Icons.image,
                                size: 60,
                              ))
                          : InkWell(
                              onTap: () => value.selectCourseImage(),
                              child: Image.file(
                                value.courseimage,
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    hintTxt: "Course Name",
                    controller: Provider.of<AdminProvider>(context)
                        .courseNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintTxt: "Course Language",
                    controller: Provider.of<AdminProvider>(context)
                        .courseLanguageController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: Provider.of<AdminProvider>(context)
                        .courseContentController,
                    decoration: InputDecoration(
                      labelText: 'Course Content',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 15,
                  ),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    hintTxt: "Course Price",
                    controller: Provider.of<AdminProvider>(context)
                        .coursePriceController,
                  ),
                  const SizedBox(height: 20),
                  Consumer<AdminProvider>(
                    builder: (context, value, child) {
                      return CustomButton(
                        isLoading: value.isLoading,
                        onTap: () {
                          value.startSaveCourseDetails();
                        },
                        text: 'save product',
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
