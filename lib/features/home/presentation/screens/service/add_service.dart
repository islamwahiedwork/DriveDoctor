import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddServiceBottomSheetForm extends StatefulWidget {
  final CarModel carModel;

  const AddServiceBottomSheetForm({super.key, required this.carModel});

  @override
  _AddServiceBottomSheetFormState createState() =>
      _AddServiceBottomSheetFormState();
}

class _AddServiceBottomSheetFormState extends State<AddServiceBottomSheetForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceKilometersController = TextEditingController();
  TextEditingController lastServiceKilometersController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 34, 34, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Adjust the value as needed
            topRight: Radius.circular(20.0), // Adjust the value as needed
          ),
        ),
        child: Form(
          key: _formKey,
          child: BlocConsumer<HomeCubit, HomeState>(
            builder: (context, state) {
              var homeCubit = HomeCubit.get(context);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppLocalizations.of(context)!.addMaintenance,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: serviceNameController,
                    decoration:   InputDecoration(
                      labelText: AppLocalizations.of(context)!.maintenanceName,
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.maintenanceErrorMessage;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: serviceKilometersController,
                    style: const TextStyle(color: Colors.white),
                    decoration:   InputDecoration(
                      labelText: AppLocalizations.of(context)!.maintenanceKilometers,
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.maintenanceKilometersErrorMessage;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: lastServiceKilometersController,
                    style: const TextStyle(color: Colors.white),
                    decoration:   InputDecoration(
                      labelText: AppLocalizations.of(context)!.lastMaintenanceKilometers,
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.maintenanceKilometersErrorMessage;
                      }
                      // // Check if last service kilometers is smaller than or equal to service kilometers
                      // if (double.tryParse(value)! < double.tryParse(serviceKilometersController.text)!) {
                      //
                      //   return AppLocalizations.of(context)!.shouldSmallerEqualMaintenanceKilometers;
                      // }
                      if (double.tryParse(value)! > widget.carModel.carKilometers) {
                        return AppLocalizations.of(context)!.valueSmallerEqualCarKm;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
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
                          if (_formKey.currentState!.validate()) {
                            // Submit your form here
                            // Example: print form values

                            // Close the bottom sheet
                            homeCubit.addCarService(
                                serviceName: serviceNameController.text,
                                carModel: widget.carModel,
                                context: context,
                                serviceKilometers:
                                    int.parse(serviceKilometersController.text),
                                lastServiceKilometersMade: int.parse(
                                    lastServiceKilometersController.text));
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.submit),
                      ),
                    ],
                  ),
                ],
              );
            },
            listener: (BuildContext context, HomeState state) {},
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    serviceKilometersController.dispose();
    lastServiceKilometersController.dispose();
    super.dispose();
  }
}
