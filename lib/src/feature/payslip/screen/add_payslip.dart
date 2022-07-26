import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../appLocalizations.dart';

class AddPayslip extends StatefulWidget {
  final String monthly;
  const AddPayslip({required this.monthly}) ;

  @override
  State<AddPayslip> createState() => _AddPayslipState();
}

class _AddPayslipState extends State<AddPayslip> {
  final TextEditingController _usrCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _contractId = TextEditingController();
  final TextEditingController _allowancCtrl = TextEditingController();
  final TextEditingController _bonusCtrl = TextEditingController();
  final TextEditingController? _seniorityCtrl = TextEditingController();
  final TextEditingController _advanceCtrl = TextEditingController();
  final TextEditingController _currencyCtrl = TextEditingController();
  final TextEditingController _exchangeRate = TextEditingController();
  final TextEditingController _deductionCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  String id = "";
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(DateTime.now().year - 5),
            maxTime: DateTime(DateTime.now().year + 60),
            // minTime: DateTime(2018, 01, 01),
            // maxTime: DateTime(2030, 01, 01),
            theme: DatePickerTheme(
                // headerColor: Colors.blueGrey,
                headerColor: Colors.blue,
                backgroundColor: Colors.white,
                itemStyle: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
            onChanged: (date) {},
            onConfirm: (date) {},
            currentTime: DateTime.now(),
            locale: LocaleType.en)
        .then((value) {
      if (value == null) {
        print("null");
      } else {
        setState(() {
          date = value;
          String formateDate = DateFormat('yyyy/MM/dd').format(date!);
          controller.text = formateDate.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("add_payslip")!}"),
    );
  }
}
