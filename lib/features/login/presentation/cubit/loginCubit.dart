import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_doctor/Model/user.dart';
import 'package:drive_doctor/core/network/auth/google_signIn_service.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:drive_doctor/features/login/presentation/screens/sign_in/sign_in.dart';
import 'package:drive_doctor/features/login/presentation/screens/sign_up/sign_up.dart';
import 'package:drive_doctor/features/home/presentation/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);


   // login
  GlobalKey<FormState>  loginFormKey = GlobalKey<FormState>();
  TextEditingController  txtLoginEmailControl =     TextEditingController();
  TextEditingController  txtLoginPasswordControl =     TextEditingController();
  bool isLoginPasswordObscureText = true;

  goToLogin({required BuildContext context}){
    CashHelper.setData(key: StringManager.isShowWelcomeScreen, value: true);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SignInScreen()),
    );
  }
  goToSignUp({required BuildContext context}){
    CashHelper.setData(key: StringManager.isShowWelcomeScreen, value: true);
    restSignUpControls();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>   const SignUp(isLoginWithEmail: false,)),
    );
  }

  restLoginControls(){
    txtLoginEmailControl.clear();
    txtLoginPasswordControl.clear();
    isLoginPasswordObscureText = true;
    emit(RestLoginControlsStateSuccessfully());
  }

  restLoginAndSignUpControls(){
    restSignUpControls();
    restLoginControls();
  }


  Future<void> login({required BuildContext context}) async {


    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: txtLoginEmailControl.text)
        .where('userPassword', isEqualTo: txtLoginPasswordControl.text)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {

      final userData = result.docs.first.data();

      var userModel =  UserModel(
        uid: userData['uid'],
        photoUrl: userData['photoUrl'],
        userEmail: userData['userEmail'],
        userPassword: userData['userPassword'],
        userFullName: userData['userFullName'],
        fireBaseToken: userData['fireBaseToken'],
      );

      await   UserModel.saveUserModel(userModel:userModel);
      Global.userModel =   UserModel.getUserModel()??UserModel();
      await    CashHelper.setData(key: StringManager.isUserLogin, value: true);
      HomeCubit.get(context).getUserCarModels();
      isFirstBuild = false;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
              (Route<dynamic> route) => false);

    }
    else {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Username or password incorrect. Please try again.'),
        ),
      );
      return; // User not found
    }



  }


  Future<bool> checkIsUserHaveAccount({GoogleSignInAccount? googleSignInAccount}) async {
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: googleSignInAccount?.email)
        .limit(1)
        .get();
    if (result.docs.isNotEmpty) {

        final userData = result.docs.first.data();
        var userModel =  UserModel(
          uid: userData['uid'],
          photoUrl: userData['photoUrl'],
          userEmail: userData['userEmail'],
          userPassword: userData['userPassword'],
          userFullName: userData['userFullName'],
          fireBaseToken: userData['fireBaseToken'],
        );
        await   UserModel.saveUserModel(userModel:userModel);
        Global.userModel =   UserModel.getUserModel()??UserModel();
        await    CashHelper.setData(key: StringManager.isUserLogin, value: true);




      return true;
    }else{
      return false;
    }

  }


  // SignUp
  GlobalKey<FormState>  signUpFormKey = GlobalKey<FormState>();
  TextEditingController  txtEmailControl =     TextEditingController();
  TextEditingController  txtSecondEmailControl =     TextEditingController();
  TextEditingController  txtFullNameControl =     TextEditingController();
  TextEditingController  txtPasswordControl =     TextEditingController();
  TextEditingController  txtConfirmPasswordControl = TextEditingController();

  String  userImageUrl = "";
  bool isSignUpPasswordObscureText = true;
  bool isSignUpConfirmPasswordObscureText = true;

  bool isLoginWithEmail = true;

  Future<void> signUpByEmail({required BuildContext context, required bool isLoginScreen})
  async {

    GoogleSignInService googleSignInService = GoogleSignInService();
    bool isGoogleSignedIn = googleSignInService.isGoogleSignedIn();

    await googleSignInService.signOutGoogle();

    if (!isGoogleSignedIn) {
      var result = await googleSignInService.signInWithGoogle();

      if (result != null) {

        checkIsUserHaveAccount(googleSignInAccount:result).then((value) async {
          if(value){


          await  HomeCubit.get(context).getUserCarModels();
            isFirstBuild = false;

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
                  (Route<dynamic> route) => false);


          }
          else{
            restSignUpControls();
            txtEmailControl.text = result.email;
            txtFullNameControl.text = result.displayName!;
            userImageUrl = result.photoUrl ?? '';

            if (isLoginScreen) {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUp(
                    isLoginWithEmail: true,
                  ),
                ),
              );
            }
            else {
              // After obtaining email data, create a user with email and password
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: result.email,
                  password: txtPasswordControl.text, // Generating a random password for initial sign-up
                );

                // Optionally, update additional user profile information
                await userCredential.user!.updateDisplayName(result.displayName);
                await userCredential.user!.updatePhotoURL( result.photoUrl);

                // You can now navigate the user to the home screen or perform any other actions

              } catch (e) {
                if (kDebugMode) {
                  print("Error signing up with email: $e");
                }
                // Handle error here
              }
            }
          }

        });


      }
    } else {
      await googleSignInService.signOutGoogle();
    }

    // emit(SignUpByEmailStateSuccessfully());
  }
  User? user ;
  Future<void> createUserForFireStore({required BuildContext context}) async {

    // check if user email
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo:txtEmailControl.text)
        .limit(1)
        .get();
    if (result.docs.isNotEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('The chosen username or email is already taken.'
              'q Please choose a different one.'),
        ),
      );
    }else{
      // Sign out current user if any
      await FirebaseAuth.instance.signOut();
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      user =   userCredential.user;

      // You can access the user's ID using userCredential.user.uid
      print("Signed in anonymously with UID: ${userCredential.user!.uid}");


      if (user != null) {

        try{
          // create user model to save
          UserModel userModel = UserModel(
            fireBaseToken: Global.fireBaseToken,
            userEmail:txtEmailControl.text ,
            secondEmail: txtSecondEmailControl.text,
            uid: user!.uid,
            photoUrl: userImageUrl,
            userFullName:txtFullNameControl.text ,
            userPassword:txtPasswordControl.text ,
          );

          await FirebaseFirestore.instance.collection('users')
              .doc(user!.uid).set(userModel.toMap()).then((value) async {
            Global.userModel = userModel;
            await   UserModel.saveUserModel(userModel:userModel );
            await    CashHelper.setData(key: StringManager.isUserLogin, value: true);
            HomeCubit.get(context).getUserCarModels();
            isFirstBuild = false;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                    (Route<dynamic> route) => false);
          });


        }catch(e){
          if (kDebugMode) {

            print(e);
          }
        }

      }
    }




  }

  changeLoginShowPasswordFlag(){
    isLoginPasswordObscureText = !isLoginPasswordObscureText;
    emit(ChangShowPasswordFlagState());
  }

  changShowPasswordFlag(){
    isSignUpPasswordObscureText = !isSignUpPasswordObscureText;
    emit(ChangShowPasswordFlagState());
  }

  changShowConfirmPasswordFlag(){
    isSignUpConfirmPasswordObscureText = !isSignUpConfirmPasswordObscureText;
    emit(ChangShowConfirmPasswordFlagState());
  }

  restSignUpControls(){
    txtEmailControl.clear();
    txtSecondEmailControl.clear();
    txtFullNameControl.clear();
    txtPasswordControl.clear();
    txtConfirmPasswordControl.clear();
    userImageUrl = "";

    emit(RestSignUpControlsStateSuccessfully());

  }

}