import 'package:flutter/cupertino.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<userProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Image.network(
                value.userModel!.img,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 10),
              CustomText(
                value.userModel!.firstName,
                fontSize: 18,
              ),
              const SizedBox(width: 5),
              CustomText(
                value.userModel!.lastName,
                fontSize: 18,
              ),
            ],
          ),
        );
      },
    );
  }
}
