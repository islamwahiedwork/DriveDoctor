
import 'package:animations/animations.dart';
import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/core/app_widgets/change_lang.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.black,
centerTitle: true,

title:  Text(AppLocalizations.of(context)!.profile,style:
const TextStyle(color: Colors.white,fontSize: 18),),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<HomeCubit,HomeState>(
          builder: (context,state){
            var homeCubit = HomeCubit.get(context);
            return Container(

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
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: Global.userModel.photoUrl != ""
                            ? NetworkImage( Global.userModel.photoUrl!)
                            : null,
                        child:  Global.userModel.photoUrl == ""
                            ? const Icon(Icons.person, size: 80)
                            : null,
                      ),
                      SizedBox(height: 20.h,),
                      Text( Global.userModel.userFullName??"",
                          style: const TextStyle(color: Colors.white,fontSize: 18)),


                    ],
                  ),
                  const Spacer(),

                  Column(
                    children: [

                      const ChangeLangButton(),
                      SizedBox(height: 10.h,),

                      AppButton(

                        onTap: () async => _showConfirmationDialog(
                          context ,
                          AppLocalizations.of(context)!.signOut,
                              (context) => homeCubit.logOut(context: context),
                        ),
                        secondLinearGradientColor:Colors.blue ,
                        firstLinearGradientColor:Colors.blue ,
                        text: AppLocalizations.of(context)!.signOut,

                      ),
                      SizedBox(height: 10.h,),
                      AppButton(
                        onTap: () async => _showConfirmationDialog(context,
                          AppLocalizations.of(context)!.deleteAccountMessage,
                              (context) => homeCubit.userDeleteAccount(context: context),
                        ),
                        secondLinearGradientColor: Colors.red,
                        firstLinearGradientColor: Colors.red,
                        text: AppLocalizations.of(context)!.deleteAccount,
                      ),
                    ],
                  ),
                ],
              ) ,);
          },
          listener: (context,state){

          },

        ),
      ),

    );
  }
}


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return GestureDetector(
              onTap: openContainer,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: Global.userModel.photoUrl != ""
                    ? NetworkImage(Global.userModel.photoUrl!)
                    : null,
                child: Global.userModel.photoUrl == ""
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
            );
          },
          openColor: Colors.white,
          closedElevation: 50.0,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          closedColor: Colors.transparent,
          openBuilder: (_, closeContainer) {
            return const UserProfileScreen();
          },
        ),
      ),
    );
  }
}
Future<void> _showConfirmationDialog(context,String action, Function(BuildContext) actionCallback) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:   Colors.black87,
        title:   Text(AppLocalizations.of(context)!.confirmation),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${AppLocalizations.of(context)!.confirmationMessage} $action ${StringManager.appLang!="ar"?"?":"؟"}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:   Text(AppLocalizations.of(context)!.close,style: const TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.submit,style: const TextStyle(color: Colors.white),),
            onPressed: () {
              actionCallback(context);

            },
          ),
        ],
      );
    },
  );
}
