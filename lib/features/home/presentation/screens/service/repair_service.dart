import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/Model/service.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RepairServiceBottomSheet extends StatefulWidget {
  final CarModel carModel;
  final ServiceModel serviceModel;

  const RepairServiceBottomSheet({super.key, required this.carModel, required this.serviceModel});

  @override
  _RepairServiceBottomSheetState createState() =>
      _RepairServiceBottomSheetState();
}

class _RepairServiceBottomSheetState
    extends State<RepairServiceBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _constController = TextEditingController();
  final _detailController = TextEditingController();
  GlobalKey<FormState> updateKilometersFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstController.text = widget.serviceModel.lastServiceKilometersMade.toString();

    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _constController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            return Form(
              key: updateKilometersFormKey,
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
                        labelText: AppLocalizations.of(context)!.lastRepairKilometers,
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
                        labelText: AppLocalizations.of(context)!.newRepairKilometers,
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
                          if (secondValue > widget.carModel.carKilometers) {
                            return AppLocalizations.of(context)!.valueSmallerEqualCarKm0;
                          }
                          if (secondValue <= firstValue) {
                            return AppLocalizations.of(context)!.valueMustGreaterFirstField;
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _constController,
                      keyboardType: TextInputType.number,
                      decoration:   InputDecoration(

                        suffixStyle: const TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.monetization_on,color: Colors.grey[350]),
                        labelText: AppLocalizations.of(context)!.cost,
                        hintText: "0",
                        hintStyle:  const TextStyle(color: Colors.grey),
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.costErrorMessage;
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _detailController,

                      maxLines: 4,
                      minLines: 4,
                      decoration:   InputDecoration(
                       suffixIcon: Icon(Icons.description,color: Colors.grey[350]),
                        suffixStyle: const TextStyle(color: Colors.white),
                        labelText: AppLocalizations.of(context)!.details,
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enterDetailErrorMessage;
                        }

                        return null;
                      },
                    ),
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
                              homeCubit.updateServiceKilometers(
                                context: context,
                                detail: _detailController .text,
                                cost: double.parse(_constController.text),
                                carKilometers: widget.carModel.carKilometers,
                                oldServiceKilometersMade:  widget.serviceModel.lastServiceKilometersMade   ,
                                newServiceKilometersMade: int.parse(_secondController.text) ,
                                serviceId:widget.serviceModel.serviceId ,
                                carId: widget.carModel.carId.toString(),
                              );
                            }
                          },
                          child:   Text(AppLocalizations.of(context)!.submit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}

