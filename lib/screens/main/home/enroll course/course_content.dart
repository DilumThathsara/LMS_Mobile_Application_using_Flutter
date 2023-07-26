import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({super.key});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {},
              child: Card(
                color: const Color.fromRGBO(229, 248, 252, 1),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: Size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            // image: DecorationImage(
                            //     image: NetworkImage(
                            //         value.hotelsModel[index].hotelImg),
                            //     fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          height: 53,
                          width: Size.width,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'Week ',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  'Title',
                                  fontSize: 20,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
