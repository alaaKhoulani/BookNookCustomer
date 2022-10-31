import 'package:book_nook_user/consts/constant.dart';
import 'package:book_nook_user/consts/myColors.dart';
import 'package:book_nook_user/services/validate/validation.dart';
import 'package:book_nook_user/ui/widgets/MyButton.dart';
import 'package:book_nook_user/ui/widgets/inputCard.dart';
import 'package:flutter/material.dart';

class AddBook extends StatelessWidget {
  AddBook({Key? key}) : super(key: key);
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController quintityController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    var pickedimage;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        title: Text("Add Book"),
        backgroundColor: MyColors.myPurble,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: pickedimage == null ? null : Image.file(pickedimage!),
              ),
              feild(
                  nameController, "Name", 46, Validation.validateNumericField),
              feild(descriptionController, "Description", 10,
                  Validation.validateNumericField),
              feild(priceController, "Price", 51,
                  Validation.validateNumericField),
              feild(quintityController, "Quantity", 30,
                  Validation.validateNumericField),
              feild(nameController, "Authers", 36,
                  Validation.validateNumericField),
              feild(nameController, "Category", 27,
                  Validation.validateNumericField),
              MyButton(
                  child: Text("Done",
                      style: buttonfont.copyWith(
                        color: MyColors.myWhite,
                      )),
                  fun: () {},
                  context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget feild(TextEditingController controller, String name, double spaceWidth,
      FormFieldValidator<String> validate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("$name:"),
        SizedBox(
          width: spaceWidth,
        ),
        Expanded(
          child: InputCard(
            name: "$name",
            controller: controller,
            vlaidate: validate,
          ),
        ),
      ],
    );
  }
}
