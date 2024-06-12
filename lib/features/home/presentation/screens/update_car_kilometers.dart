import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateKilometersBottomSheet extends StatefulWidget {
  final CarModel carModel;

  const UpdateKilometersBottomSheet({super.key, required this.carModel});

  @override
  _UpdateKilometersBottomSheetState createState() =>
      _UpdateKilometersBottomSheetState();
}

class _UpdateKilometersBottomSheetState
    extends State<UpdateKilometersBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  GlobalKey<FormState> updateKilometersFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstController.text = widget.carModel.carKilometers.toString();
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
      key: updateKilometersFormKey,
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

              child: Container(
                color: Colors.black87,
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstController,
                      readOnly: true,
                      style: TextStyle(color: Colors.grey[500]),
                      decoration: InputDecoration(
                        suffixText: AppLocalizations.of(context)!.km,
                        suffixStyle: TextStyle(color: Colors.grey[500]),
                        labelText: AppLocalizations.of(context)!.oldKilometers,
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _secondController,
                      keyboardType: TextInputType.number,
                      decoration:   InputDecoration(
                        suffixText: AppLocalizations.of(context)!.km,
                        suffixStyle: const TextStyle(color: Colors.white),
                        labelText: AppLocalizations.of(context)!.newKilometers,
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterNumber;
                        }
                        final firstValue = int.tryParse(_firstController.text);
                        final secondValue = int.tryParse(value);
                        if (firstValue != null && secondValue != null) {
                          if (secondValue <= 0) {
                            return AppLocalizations.of(context)!.valueMustGreaterThanZero;
                          }
                          if (secondValue <= firstValue) {
                            return AppLocalizations.of(context)!.valueMustGreaterFirstField;
                          }
                        }
                        return null;
                      },
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
                            if (updateKilometersFormKey.currentState!.validate()) {
                              homeCubit.updateCarKilometers(
                                  context: context,
                                  carId: widget.carModel.carId.toString(),
                                  newKilometers: int.parse(_secondController.text));
                            }
                          },
                          child:   Text( AppLocalizations.of(context)!.submit,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}