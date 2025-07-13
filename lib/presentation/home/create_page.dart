import 'package:expense_tracker/common/common_textfield.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_image.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/domain/expense/common_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController expenseModeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String amount = "";
  int selectedIndex = 0;
  CommonExpenseModel? selectedExpense = commonExpenseList.first;
  @override
  Widget build(BuildContext context) {
    final expenseController = Get.find<ExpenseController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            10.hGap,
            InkWell(
              onTap: () {
                // drawerController.changePage('create');
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            10.hGap,
            const Text(
              "Add Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "\$",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            20.hGap,
                            Text(
                              amount == '' ? '0' : amount,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        const Text(
                          "Ks",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    10.vGap,
                    const Divider(
                      color: Colors.black,
                      height: 4,
                      thickness: 2,
                    ),
                    20.vGap,
                    const Text(
                      "Expense Title",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.vGap,
                    CommonTextField(
                      width: double.infinity,
                      controller: descriptionController,
                      hintText: "Type here ....",
                    ),
                    10.vGap,
                    const Divider(color: Colors.black26),
                    10.vGap,
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        for (var x in commonExpenseList) ...[
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedExpense = x;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedExpense?.slug == x.slug
                                      ? MyTheme.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      width: 1,
                                      color: selectedExpense?.slug == x.slug
                                          ? Colors.white
                                          : MyTheme.primaryColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      x.image,
                                      height: 20,
                                      width: 20,
                                      color: selectedExpense?.slug == x.slug
                                          ? Colors.white
                                          : MyTheme.primaryColor,
                                    ),
                                    5.hGap,
                                    Text(
                                      x.title,
                                      style: TextStyle(
                                          color: selectedExpense?.slug == x.slug
                                              ? Colors.white
                                              : MyTheme.primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //! Keypad
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// for 123
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}1';
                              setState(() {});
                            },
                            child: const Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}2';
                              setState(() {});
                            },
                            child: const Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}3';
                              setState(() {});
                            },
                            child: const Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    20.vGap,

                    /// for 456
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}4';
                              setState(() {});
                            },
                            child: const Text(
                              "4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}5';
                              setState(() {});
                            },
                            child: const Text(
                              "5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}6';
                              setState(() {});
                            },
                            child: const Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    20.vGap,

                    /// for 789
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}7';
                              setState(() {});
                            },
                            child: const Text(
                              "7",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}8';
                              setState(() {});
                            },
                            child: const Text(
                              "8",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}9';
                              setState(() {});
                            },
                            child: const Text(
                              "9",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    20.vGap,

                    /// for action row
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              if (amount != '') {
                                amount = amount.substring(0, amount.length - 1);
                                setState(() {});
                              }
                            },
                            child: Image.asset(
                              MyImage.deleteIcon,
                              height: 30,
                              width: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              amount = '${amount}0';
                              setState(() {});
                            },
                            child: const Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              expenseController.addExpense(
                                expenseType: selectedExpense?.slug ?? 'other',
                                description: descriptionController.text,
                                amount: double.tryParse(amount) ?? 0,
                              );
                              Vibration.vibrate(duration: 100);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyTheme.primaryColor),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    10.vGap,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
