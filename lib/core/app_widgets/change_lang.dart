import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';
import 'package:drive_doctor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLangButton extends StatelessWidget {
  const ChangeLangButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:   EdgeInsets.all(8.0.h),
      child: ElevatedButton(
        style:ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.black26),),
        onPressed: (){

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(


                title: Text(AppLocalizations.of(context)!.lang,style: const TextStyle(color: Colors.black),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('English'),
                      onTap: () {
                        LanguageCubit.get(context)
                            .changeLanguage(const Locale('en'));
                        CashHelper.setData(key: "lang", value: "en");
                        StringManager.appLang = "en";
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('عربي'),
                      onTap: () {
                        LanguageCubit.get(context).
                        changeLanguage(const Locale('ar'));
                        CashHelper.setData(key: "lang", value: "ar");
                        StringManager.appLang = "ar";
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );


        },
        child: Text(
          AppLocalizations.of(context)!.lang,
          style: TextStyle(color: Colors.grey[300],fontWeight: FontWeight.w600,fontSize: 14),
        ),
      ),
    );
  }
}
