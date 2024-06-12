import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCarBottomSheet extends StatefulWidget {
  const AddCarBottomSheet({super.key});

  @override
  _AddCarBottomSheetState createState() => _AddCarBottomSheetState();
}

class _AddCarBottomSheetState extends State<AddCarBottomSheet> {
  @override
  void initState() {
    HomeCubit.get(context).restBottomSheetControls();
    super.initState();
  }

  GlobalKey<FormState> addCarFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocConsumer<HomeCubit, HomeState>(
            builder: (context, state) {
              var homeCubit = HomeCubit.get(context);
              return Form(
                key: addCarFormKey,
                child: Container(
                  color: Colors.black87,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              AppLocalizations.of(context)!.addCar,
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
                      DropdownSearch<String>(

                        dropdownButtonProps: const DropdownButtonProps(
                          color: Colors.white,
                          focusColor: Colors.white,

                        ),

                        clearButtonProps: const ClearButtonProps(
                            color: Colors.white
                        ),

                        popupProps:   PopupProps.dialog(
                          itemBuilder: (BuildContext context, String text, bool isSelect){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text( text ,style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w400)),
                            );
                          },


                          searchFieldProps: const TextFieldProps(

                              style: TextStyle(color: Colors.white)
                          ),

                          showSearchBox: true,
                          showSelectedItems: true,

                          dialogProps: const DialogProps(

                            backgroundColor: Colors.black,

                          ),
                        ),
                        items:Global.listBrandModel.map((brand) => brand.brandName).toList(),
                        dropdownDecoratorProps:   DropDownDecoratorProps(

                          dropdownSearchDecoration: InputDecoration(
                              border: const OutlineInputBorder(),
                            labelText:AppLocalizations.of(context)!.brandNameHint,
                            labelStyle: const TextStyle(color: Colors.grey),
                            hintText: AppLocalizations.of(context)!.brandNameHint,
                          ),
                          baseStyle: const TextStyle(color: Colors.white),


                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.brandNameErrorMessage;
                          }
                          // You can add more validation logic here if needed
                          return null;
                        },
                        onChanged: (String? value){
                          if(value!.isNotEmpty){
                            homeCubit.selectedCarBrandModel
                            =
                                Global.listBrandModel.firstWhere((element) => element.brandName == value );
                            homeCubit.emit(SelectBrandState());

                          }

                        },
                        selectedItem:  homeCubit.selectedCarBrandModel?.brandName??"",
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: homeCubit.carModelController,
                        style: const TextStyle(color: Colors.white),
                        decoration:   InputDecoration(
                          labelText: AppLocalizations.of(context)!.carModelHint,
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.carModelErrorMessage;
                          }
                          // You can add more validation logic here if needed
                          return null;
                        },
                      ),



                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          Image.asset("assets/icons/license.png",
                              width: 35, height: 35, color: Colors.white),
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: const ColorScheme.dark(
                                          primary: Colors.blue, // Change this to your desired color
                                          onPrimary: Colors.black, // Change this to your desired text color
                                        ),
                                        textTheme: const TextTheme(
                                          bodyText1: TextStyle(color: Colors.white), // Change this to your desired text color
                                          bodyText2: TextStyle(color: Colors.white), // Change this to your desired text color
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  setState(() {
                                    homeCubit.licenseFromDate = picked;


                                  });
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    homeCubit.licenseFromDate == null
                                        ? AppLocalizations.of(context)!.selectLicenseFrom
                                        : '${AppLocalizations.of(context)!.from}: ${DateFormat('yyyy-MM-dd').format(homeCubit.licenseFromDate!)}',
                                    style: const TextStyle(fontSize: 14,color: Colors.white),
                                  ),
                                  if(!homeCubit.isLicenseDateValid)
                                    Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Text(AppLocalizations.of(context)!.selectLicenseFromDate,style: const TextStyle(color: Colors.red,fontSize: 10),)
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: const ColorScheme.dark(
                                          primary: Colors.blue, // Change this to your desired color
                                          onPrimary: Colors.black, // Change this to your desired text color
                                        ),
                                        textTheme: const TextTheme(
                                          bodyText1: TextStyle(color: Colors.white), // Change this to your desired text color
                                          bodyText2: TextStyle(color: Colors.white), // Change this to your desired text color
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },

                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  setState(() {
                                    homeCubit.licenseToDate = picked;


                                  });
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    homeCubit.licenseToDate == null
                                        ? AppLocalizations.of(context)!.selectLicenseTo
                                        : '${AppLocalizations.of(context)!.to}:\n ${DateFormat('yyyy-MM-dd').format(homeCubit.licenseToDate!)}',
                                    style: const TextStyle(fontSize: 14,color: Colors.white),
                                  ),
                                  if(!homeCubit.isLicenseDateValid)
                                    Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Text(AppLocalizations.of(context)!.selectLicenseToDate,style: const TextStyle(color: Colors.red,fontSize: 10),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),



                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: homeCubit.carKilometersController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration:   InputDecoration(
                          labelText: AppLocalizations.of(context)!.kilometers,
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.kilometersErrorMessage;
                          }
                          // You can add more validation logic here if needed
                          return null;
                        },
                      ),

                      // Add widget to select car image
                      // Add button to submit data
                      SizedBox(height: 10.h),
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

                              if(homeCubit.licenseFromDate == null || homeCubit.licenseToDate == null){
                                setState(() {
                                  homeCubit.isLicenseDateValid = false;
                                });
                              }
                             else if(!homeCubit.isDateInRange(startDate:homeCubit.licenseFromDate,
                                  endDate:homeCubit.licenseToDate!)){
                                setState(() {
                                  homeCubit.isLicenseDateValid = false;
                                });
                              }

                               if (addCarFormKey.currentState!.validate()) {
                                homeCubit.addNewCar(context: context);
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
      ),
    );
  }
}