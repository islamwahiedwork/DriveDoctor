import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/Model/service.dart';
import 'package:drive_doctor/Model/service_acation.dart';
import 'package:drive_doctor/core/services/helper.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:drive_doctor/features/home/presentation/screens/service/repair_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceScreen extends StatelessWidget {
  final Image icons;
  final String serviceName;

  final CarModel carModel;
  final ServiceModel serviceModel;

  ServiceScreen(
      {super.key,
      required this.icons,
      required this.serviceName,
      required this.carModel,
      required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height.h;
    double width = MediaQuery.of(context).size.width.w;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
            "${carModel.carBrandName} ${AppLocalizations.of(context)!.model} ${carModel.carModel}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14.h)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: const Color(0xFF212121),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return RepairServiceBottomSheet(
                  serviceModel: serviceModel, carModel: carModel);
            },
          );
        },
        child: Image.asset("assets/image/repair.png",
            height: 40, width: 40, color: Colors.white),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          var lisServiceModel = homeCubit.listCarServices.firstWhere(
                  (element) =>
              element.serviceId == serviceModel.serviceId &&
                  element.carId == serviceModel.carId);
          double servicePercentage = getPercentageDifference(
              lastServiceKilometersMade:
              lisServiceModel.lastServiceKilometersMade,
              serviceKilometers: lisServiceModel.serviceKilometers,
              currentCarKilometers: carModel.carKilometers);

          var getDifferenceBetweenKilometers =
          getDifferenceBetweenTwoNumbers(
              firstNumber: carModel.carKilometers,
              secondNumber:
              lisServiceModel.lastServiceKilometersMade);

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(


                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.black],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  serviceName,
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 30.w),
                                ),
                                SizedBox(width: 10.w),
                                Image.asset(
                                  "assets/image/repair.png",
                                  height: 30,
                                  width: 30,
                                  color: servicePercentage == 0
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 73.0.w,
                          lineWidth: 8.0.w,
                          animation: true,
                          percent: servicePercentage / 100.0,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("$servicePercentage %",
                                  style: TextStyle(
                                    fontSize: 23.h,
                                    color: percentageColor(
                                        servicePercentage: servicePercentage),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              if (servicePercentage == 0)
                                Text(
                                  AppLocalizations.of(context)!.expired,
                                  style: TextStyle(
                                      fontSize: 15.h,
                                      fontWeight: FontWeight.w500,
                                      color: servicePercentage == 0
                                          ? Colors.red
                                          : Colors.green),
                                ),
                            ],
                          ),
                          footer: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                servicePercentage == 0
                                    ? "$getDifferenceBetweenKilometers ${AppLocalizations.of(context)!.kmOver}"
                                    : "$getDifferenceBetweenKilometers ${AppLocalizations.of(context)!.kmLeft}",
                                style: TextStyle(
                                    fontWeight: servicePercentage == 0
                                        ? FontWeight.w500
                                        : FontWeight.w500,
                                    color: servicePercentage == 0
                                        ? Colors.red
                                        : Colors.green),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.lastRepair,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12.h,
                                            color: Colors.yellow),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        lisServiceModel
                                            .lastServiceKilometersMade
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: percentageColor(
                                              servicePercentage:
                                              servicePercentage),
                                          fontSize: 14.h,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.km,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.carKilometers,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.h, color: Colors.yellow),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    carModel.carKilometers.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.km,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.yellow, fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.serviceRepairEvery} ${lisServiceModel.serviceKilometers} ${  AppLocalizations.of(context)!.km}",
                                style: TextStyle(
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: percentageColor(
                              servicePercentage: servicePercentage),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (homeCubit.listServiceHistoryModel.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                color: Colors.grey[200],
                                height: 1,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(18, 18, 18, 1),
                                        Color.fromRGBO(40, 40, 40, 5)
                                      ],
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.topCenter),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.history,
                                      style: TextStyle(
                                          color: Colors.grey[200],
                                          fontSize: 14.w),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 80,
                                color: Colors.grey[200],
                                height: 1,
                              ),
                            ],
                          ),
                        if (homeCubit.listServiceHistoryModel.isNotEmpty)
                          SizedBox(height: 10.h),
                        if (homeCubit.listServiceHistoryModel.isNotEmpty)
                          Container(
                            width: 500,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(18, 18, 18, 1),
                                      Color.fromRGBO(40, 40, 40, 5)
                                    ],
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.topCenter)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.totalCost,style: TextStyle(color: Colors.white)),
                                  Row(
                                    children: [
                                      Text(
                                        homeCubit.listServiceHistoryModel
                                            .fold<double>(
                                            0.0,
                                                (previousValue, element) =>
                                            previousValue +
                                                element.cost)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.monetization_on,
                                        color: Colors.yellow,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(height: 10.h,),
                        if (homeCubit.listServiceHistoryModel.isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                homeCubit.listServiceHistoryModel.length,
                                separatorBuilder: (context, state) =>
                                const SizedBox(height: 0),
                                itemBuilder: (context, index) {
                                  return ServiceHistoryCard(
                                    serviceHistoryModel: homeCubit
                                        .listServiceHistoryModel[index],
                                  );
                                }),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

// class ServiceHistoryCard extends StatelessWidget {
//   final ServiceHistoryModel serviceHistoryModel;
//
//   const ServiceHistoryCard({super.key, required this.serviceHistoryModel});
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height.h;
//     double width = MediaQuery.of(context).size.width.w;
//     return Container(
//       padding: const EdgeInsets.all(8),
//       height: 50.h,
//       width: width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(
//             15.0,
//           ),
//           gradient: const LinearGradient(
//               colors: [
//                 Color.fromRGBO(18, 18, 18, 1),
//                 Color.fromRGBO(40, 40, 40, 5)
//               ],
//               begin: FractionalOffset.topCenter,
//               end: FractionalOffset.topCenter)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             serviceHistoryModel.cost.toString(),
//             style: const TextStyle(color: Colors.white),
//           )
//         ],
//       ),
//     );
//   }
// }

class ServiceHistoryCard extends StatefulWidget {
  final ServiceHistoryModel serviceHistoryModel;

  const ServiceHistoryCard({super.key, required this.serviceHistoryModel});

  @override
  _ServiceHistoryCardState createState() => _ServiceHistoryCardState();
}

class _ServiceHistoryCardState extends State<ServiceHistoryCard> {
  bool isExpanded = true;
  bool isExpanded2 = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 5.h,
        ),
        // padding: const EdgeInsets.all(20),

        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1200),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(18, 18, 18, 1),
                  Color.fromRGBO(40, 40, 40, 5)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.topCenter)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text(
                          AppLocalizations.of(context)!.cost,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.serviceHistoryModel.cost.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text(
                          AppLocalizations.of(context)!.kilometers,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.serviceHistoryModel.newServiceKilometersMade
                            .toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Text(
                              AppLocalizations.of(context)!.date,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            convertToDateString(widget
                                .serviceHistoryModel.createdDate
                                .toString()),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                        size: 17,
                      ),
                    ],
                  )
                ],
              ),
              isExpanded ? const SizedBox() : const SizedBox(height: 20),
              AnimatedCrossFade(
                firstChild: const Text(
                  '',
                  style: TextStyle(
                    fontSize: 0,
                  ),
                ),
                secondChild: Text(
                  widget.serviceHistoryModel.detail,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.7,
                  ),
                  textAlign: isArabic(text: widget.serviceHistoryModel.detail)
                      ? TextAlign.right
                      : TextAlign.left,
                  textDirection:
                      isArabic(text: widget.serviceHistoryModel.detail)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 1200),
                reverseDuration: Duration.zero,
                sizeCurve: Curves.fastLinearToSlowEaseIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
