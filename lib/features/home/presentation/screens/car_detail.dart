import 'package:animations/animations.dart';
import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/Model/service.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/helper.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';

import 'package:drive_doctor/features/home/presentation/screens/service/service_screen.dart';
import 'package:drive_doctor/features/home/presentation/screens/update_car_License.dart';
import 'package:drive_doctor/features/home/presentation/screens/update_car_kilometers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'service/add_service.dart';

class CarDetailsScreen extends StatelessWidget {
  final int index;
  final CarModel selectedCarModel;

  const CarDetailsScreen(
      {super.key, required this.index, required this.selectedCarModel});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Run your function only when the screen is first initialized

    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          var carModel = homeCubit.listUserCars
              .firstWhere((element) => element.carId == selectedCarModel.carId);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            floatingActionButton: homeCubit.listUserCars.isNotEmpty
                ? FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) =>
                            AddServiceBottomSheetForm(
                          carModel: carModel,
                        ),
                      );
                    },
                    child: Image.asset("assets/image/service.png",
                        height: 50, width: 50),
                  )
                : const SizedBox(),
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
              child: SingleChildScrollView(
                child: BlocConsumer<HomeCubit,HomeState>(
                  builder: (context,state){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  Text(
                                    "${carModel.carBrandName} ${AppLocalizations.of(context)!.model} ${carModel.carModel}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.h),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.licenseExpiration}  "
                                              "\n${carModel.licenseToDate.toString()}"
                                              " (${getDaysBetween(fromDate: carModel.licenseToDate)} ${AppLocalizations.of(context)!.days})",
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,

                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 13.w,
                                              color:

                                              getDaysBetween(fromDate: carModel.licenseToDate) >= 30 ? Colors.green
                                                  :

                                              getDaysBetween(
                                                  fromDate: carModel
                                                      .licenseToDate) <
                                                  30 &&
                                                  getDaysBetween(
                                                      fromDate: carModel
                                                          .licenseToDate) >
                                                      0
                                                  ? Colors.yellow
                                                  : getDaysBetween(
                                                  fromDate: carModel
                                                      .licenseToDate) <=
                                                  0
                                                  ? Colors.red
                                                  : Colors.red
                                          )

                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return UpdateLicenseDateBottomSheet(
                                                    carModel: carModel);
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${carModel.carKilometers.toString()} ",
                                            style: TextStyle(fontSize: 20.h,color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                            Text(
                                              AppLocalizations.of(context)!.km,
                                            textAlign: TextAlign.center,
                                              style: const TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
  isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return UpdateKilometersBottomSheet(
                                                    carModel: carModel);
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),

                              Hero(
                                tag: index.toString(),
                                child: Global.listBrandModel
                                    .firstWhere((element) =>
                                element.brandId ==
                                    carModel.carBrandId)
                                    .brandImageUrl ==
                                    ""
                                    ? const SizedBox()
                                    : Image.network(
                                  Global.listBrandModel
                                      .firstWhere((element) =>
                                  element.brandId ==
                                      carModel.carBrandId)
                                      .brandImageUrl,
                                  width: 50.w, // Adjust the width as needed
                                  height: 50.h,
                                  // Adjust the height as needed
                                ),
                              ),

                              // Icon(
                              //   Icons.search,
                              //   color: Colors.white,
                              //   size: height / 25,
                              // )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Hero(
                            tag: index.toString(),
                            child: Container(
                              height: height * 0.23.h,
                              width: width,
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.white, // Apply red color filter
                                        BlendMode.modulate,
                                      ),
                                      image: AssetImage("assets/image/tesla.png"),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: SizedBox(
                            height: height * 0.21.h,
                            width: width,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              // Add this line for bounce effect
                              scrollDirection: Axis.horizontal,
                              itemCount: homeCubit.listCarServices.length,
                              itemBuilder: (context, index) {
                                var model = homeCubit.listCarServices[index];
                                var servicePercentage =
                                getPercentageDifference(lastServiceKilometersMade: model.lastServiceKilometersMade, serviceKilometers: model.serviceKilometers, currentCarKilometers: carModel.carKilometers).toString();

                                var getDifferenceBetweenKilometers =
                                getDifferenceBetweenTwoNumbers(
                                    firstNumber: carModel.carKilometers,
                                    secondNumber:
                                    model.lastServiceKilometersMade);

                                return ServiceTab(
                                    serviceModel: model,
                                    carModel: selectedCarModel,
                                    icons: Image.asset(
                                      "assets/image/repair.png",
                                      height: 20,
                                      width: 20,
                                      color:servicePercentage == "0"?Colors.white : Colors.white,
                                    ),
                                    serviceName: model.serviceName,
                                    servicePercentage: servicePercentage,

                                    kilometersSinceChange:
                                    "$getDifferenceBetweenKilometers ${AppLocalizations.of(context)!.kmOver}",

                                   );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 15.w),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                  listener: (context,state){

                  },

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

class ServiceTab extends StatelessWidget {
  final   Image icons;

  final   CarModel carModel;
  final ServiceModel serviceModel;
  final    String serviceName;
  final    String servicePercentage;

  final  String kilometersSinceChange;

   const  ServiceTab({super.key, required this.icons, required this.carModel, required this.serviceModel, required this.serviceName, required this.servicePercentage  ,   required this.kilometersSinceChange});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height.h / 4;
    double width = MediaQuery.of(context).size.width.w / 3;
    return OpenContainer(

      openColor: const Color.fromRGBO(34, 34, 34, 1),
      closedElevation: 50.0,
      closedColor: Colors.transparent,
      closedBuilder: (_, openContainer) {

        return Container(
          padding: EdgeInsets.all(height.h / 25),
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              gradient: LinearGradient(
                  colors: [
                    servicePercentage == "0"?Colors.red[500]!  :  const Color.fromRGBO(20, 20, 20, 1),
                    servicePercentage == "0"?Colors.red[100]!  :    const Color.fromRGBO(34, 34, 34, 1)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              icons,
              Column(
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    serviceName,
                    style: TextStyle(color: Colors.white,fontSize: 20.h),
                  ),
                ],
              ),

              Text(
                "$servicePercentage %",
                style: TextStyle(fontSize: 20.h, color: percentageColor(servicePercentage:double.parse(servicePercentage))),
              ),
              Text(
                kilometersSinceChange ,
                style:   TextStyle(
                    fontWeight:servicePercentage == "0"? FontWeight.w500 : FontWeight.w500,
                    color: servicePercentage == "0"?Colors.black : const Color.fromRGBO(112, 112, 112, 1)),
              ),
              if(servicePercentage == "0")
                  Text(
                  AppLocalizations.of(context)!.expired,
                  style:   const TextStyle(
                      fontSize: 18,
                      fontWeight:  FontWeight.w800,
                      color:   Colors.red),
                ),
              Text(
                AppLocalizations.of(context)!.details  ,
                style:  TextStyle(
                    fontWeight:servicePercentage == "100"? FontWeight.w500 : FontWeight.w500
                    ,color: servicePercentage == "100"?Colors.black : const Color.fromRGBO(112, 112, 112, 1)),
              ),
            ],
          ),
        );
      },
      onClosed: (never){
        Future.delayed(const Duration(milliseconds: 500), () {


        });

      },
      openBuilder: (_, closeContainer) {
        HomeCubit.get(context).getServiceHistory(context: context,serviceId: serviceModel.serviceId,carId:carModel.carId ).catchError((onError){});
        return    ServiceScreen(
          icons: icons,
          carModel:HomeCubit.get(context).listUserCars.firstWhere((element) => element.carId == carModel.carId),

          serviceModel: HomeCubit.get(context).listCarServices.firstWhere((element) => element.serviceId == serviceModel.serviceId),
          serviceName: serviceName,
        );
      },
    );
  }
}
















