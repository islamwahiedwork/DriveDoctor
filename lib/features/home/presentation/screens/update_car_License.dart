import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateLicenseDateBottomSheet extends StatefulWidget {
  final CarModel carModel;

  const UpdateLicenseDateBottomSheet({super.key, required this.carModel});

  @override
  _UpdateLicenseDateBottomSheetState createState() =>
      _UpdateLicenseDateBottomSheetState();
}

class _UpdateLicenseDateBottomSheetState
    extends State<UpdateLicenseDateBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  GlobalKey<FormState> updateLicenseDateFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: updateLicenseDateFormKey,
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Container(
            color: Colors.black87,
            padding: EdgeInsets.all(16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _firstController,
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        var fromDate =
                        DateFormat('yyyy-MM-dd').format(picked!).toString();
                        _firstController.text = fromDate;
                      });
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration:   InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    labelText:  AppLocalizations.of(context)!.licenseFromDate,
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      :  AppLocalizations.of(context)!.licenseFromDateErrorMessage,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _secondController,
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        var toDate =
                        DateFormat('yyyy-MM-dd').format(picked!).toString();
                        _secondController.text = toDate;
                      });
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration:   InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    labelText:  AppLocalizations.of(context)!.licenseToDate,
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      :  AppLocalizations.of(context)!.licenseToDateErrorMessage,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:   Text(
                          AppLocalizations.of(context)!.close,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        if (updateLicenseDateFormKey.currentState!.validate()) {
                          homeCubit.updateCarLicenseDate(
                            context: context,
                            currentDate: widget.carModel.licenseToDate,
                            fromDate: _firstController.text,
                            toDate: _secondController.text,
                            carId: widget.carModel.carId.toString(),
                          );
                        }
                      },
                      child:   Text( AppLocalizations.of(context)!.submit),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}