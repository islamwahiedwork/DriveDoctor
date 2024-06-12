import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:drive_doctor/features/home/presentation/screens/add_car.dart';
import 'package:drive_doctor/features/home/presentation/screens/car_card.dart';
import 'package:drive_doctor/features/home/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool isFirstBuild = true;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Run your function only when the screen is first initialized
    if (isFirstBuild) {
      HomeCubit.get(context).getUserCarModels();
      isFirstBuild = false;
    }
    return BlocConsumer<HomeCubit,HomeState>(
      builder: (context,state){
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false, // This line ensures that the keyboard doesn't resize the scaffold
          floatingActionButton:
       FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) =>
                const AddCarBottomSheet(),
              );
            },
            child: Image.asset("assets/image/1.png"),
          )
              ,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              height: height,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderHomeScreen(),
                  BodyHomeScreen(),
                ],
              ),
            ),
          ),
        );
      },
      listener:(context,state){} ,

    );
  }
}


class HeaderHomeScreen extends StatelessWidget {
  const HeaderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
                width: 50, height: 50, child: UserProfile()),
            SizedBox(width: 10.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Text(
                      AppLocalizations.of(context)!.homeWelcomeText,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      Global.userModel.userFullName ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   width: 20.w,
            // ),
            // const Icon(
            //   Icons.notifications,
            //   color: Colors.white,
            // )
          ],
        ),
        SizedBox(height: 35.h),
      ],
    );
  }
}


class BodyHomeScreen extends StatelessWidget {

const BodyHomeScreen({super.key });

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<HomeCubit,HomeState>(
      builder: (context,state){
        var homeCubit = HomeCubit.get(context);
        return  Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            if (homeCubit.listUserCars.isNotEmpty)
                Text(
                  AppLocalizations.of(context)!.currentCars,
                style: const TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    fontSize: 20),
              ),
            if (homeCubit.listUserCars.isNotEmpty)
              SizedBox(height: 30.h),
            Expanded(
              child: homeCubit.listUserCars.isNotEmpty
                  ?
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 0.0, vertical: 0),
                children: List.generate(
                    homeCubit.listUserCars.length, (index) {
                  return CarCard(index: index,carModel:homeCubit.listUserCars[index] ,);
                }),
              )
                  :
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                    const AddCarBottomSheet(),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.addCarTitle,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/image/1.png",
                      height: 60,
                      width: 60,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],),
        );
      },
       listener:    (context,state){},
    );
  }
}





