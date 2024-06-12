import 'package:intl/intl.dart';

class DateTimeManager  {

  // Date Format
  static  const  String format_yyyyMMdd_Dash = "yyyy-MM-dd";
  static  const  String format_ddMMyyyy_Dash = "dd-MM-yyyy";
  static  const  String format_ddMMyyyy_BackSlash = "dd/MM/yyyy";
  static  const  String format_yyyyMMdd_hh_mm_a_Dash = "yyyy-MM-dd hh:mm a";
  static  const  String format_hh_mm_a = "hh:mm a";
  static  const  String format_EEE = "EEE";
  static  const  String format_MMM = "MMM";







  static String formatTime(Duration duration){

    String twoDigits(int n)=>n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours>0)hours,
      minutes,
      seconds
    ].join(':');
  }




  static DateTime? convert_DateString_To_BaseDateTime({required String dateString}) {
    try{

        // Your input date string
      final DateFormat customFormat = DateFormat('yyyy-MM-dd');
      DateTime dateTime = customFormat.parse(dateString);


      return dateTime;
    }catch(e){
      print(e);
      return null;
    }
  }


  static String convert_DateString_To_Time({required String dateString}) {
     try{
       DateTime dateTime = DateTime.parse(dateString);
       String timeString = DateFormat.jm().format(dateTime);
       return timeString;
     }catch(e){
       print(e);
       return '';
     }
  }

  // Example // isToDay = 10:30 Am // isYesterday = Yesterday // else = 31-7-2023
  static String convert_DateString_To_ChatDateTime({required String dateString}) {

      try {
        String dateAfterFormat =  DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime.parse(dateString));
        String today =  DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day));
        String yesterday =  DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime(
            DateTime
                .now()
                .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day - 1));

        if (dateAfterFormat == yesterday) {
          return 'Yesterday';
        }
        else if (dateAfterFormat == today) {
          var todayDate =  DateFormat( DateTimeManager.format_hh_mm_a).format(DateTime.parse(dateString));
          return todayDate;
        }
        else {
          return dateAfterFormat;
        }
      } catch (e) {
        return '';
      }

  }

  // Example // isToDay = Today // isYesterday = Yesterday // else = Tue 11 Jul 2023
  static String convert_DateString_To_CustomDate({required String dateString}) {

    try {
      String dateAfterFormat =  DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime.parse(dateString));
      String today =  DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime(DateTime
          .now()
          .year, DateTime
          .now()
          .month, DateTime
          .now()
          .day));
      String yesterday =  DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime(
          DateTime
              .now()
              .year, DateTime
          .now()
          .month, DateTime
          .now()
          .day - 1));

      if (dateAfterFormat == yesterday) {
        return 'Yesterday';
      }
      else if (dateAfterFormat == today) {

        return "Today";
      }
      else {
        DateTime dateTime = DateTime.parse(dateString);
        var v1 =  DateFormat(DateTimeManager.format_EEE).format(dateTime);
        var v2 =  DateFormat(DateTimeManager.format_MMM).format(dateTime);
        return v1 + " " + dateTime.day.toString() + " " + v2.toString() + " " + dateTime.year.toString();
      }
    } catch (e) {
      return '';
    }

  }

  // Example // isToDay = Today // isYesterday = Yesterday // else = Tue 11 Jul 2023
  static String convert_DateString_To_TodOrYestOrDate({required String dateString,showTodayHour = false}) {

      try {
        String dateAfterFormat = DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime.parse(dateString));
        String today = DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
        String yesterday = DateFormat(DateTimeManager.format_ddMMyyyy_Dash).format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));

        if (dateAfterFormat == yesterday) {
          return 'Yesterday';
        } else if (dateAfterFormat == today) {
          return showTodayHour ? DateTimeManager.convert_DateString_To_Time(dateString: dateString) : 'Today';
        } else {
          return dateAfterFormat;
        }
      } catch (e) {
        print(e);
        return '';
      }

  }




  static String convert_DateString_To_YearMonthDay_Dash({required String dateString}) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return  DateFormat(DateTimeManager.format_yyyyMMdd_Dash).format(dateTime);
    } catch (e) {
      return "";
    }
  }
  static String convert_int_To_HourAndMinute({required int integerDateValue}) {
    int h, m;
    h = integerDateValue ~/ 3600;
    m = ((integerDateValue - h * 3600)) ~/ 60;
    String result = "$h:$m" + " Hrs";
    return result;
  }
  static String convert_DateString_format({required String dateString,required String dateFormat}) {
    try {
      DateTime valueToDateTime = DateTime.parse(dateString);
      String todayDate =  DateFormat(dateFormat).format(valueToDateTime);
      return todayDate;
    } catch (e) {
      return '';
    }
  }

  static String convert_Seconds_To_Minutes_And_Seconds(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }


  // Example Tue 11 Jul 2023
  static String convert_DateString_Custom_format({required String dateString}) {
    if(dateString.trim() != ""){
      try {
        DateTime dateTime = DateTime.parse(dateString);
        var v1 =  DateFormat(DateTimeManager.format_EEE).format(dateTime);
        var v2 =  DateFormat(DateTimeManager.format_MMM).format(dateTime);
        return v1 + " " + dateTime.day.toString() + " " + v2.toString() + " " + dateTime.year.toString();
      } catch (e) {
        return '';
      }
    }
    else{
      return '';
    }

  }
  static String get_hours_Two_Date_asString({String dateString = '', String fromTime = "", String toTime = ""}) {
    try{
      if(fromTime.trim() != "" && toTime.trim() != "" ){
        dateString = "2022-10-18T";
        fromTime = dateString + fromTime;
        toTime = dateString + toTime;
        DateTime from = DateTime.parse(fromTime);
        DateTime to = DateTime.parse(toTime);
        var difference = to.difference(from).inSeconds;
        return DateTimeManager.convert_int_To_HourAndMinute(integerDateValue: difference);
      }else{
        return "";
      }
    }catch(e){
      return "";
    }


  }
  // Example  10 days
  static String get_Days_Between_Two_Date_asString ({required String fromDateString,required String toDateString}) {

    if(fromDateString != null && toDateString != null && fromDateString.trim() != "" && toDateString.trim() != "" )
    {
      DateTime from = DateTime.parse(fromDateString);
      DateTime to = DateTime.parse(toDateString);

      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      int daysNumber = (to.difference(from).inHours / 24).round() + 1;

      return daysNumber.toString() + " Day";
    }
    else{
      return "";
    }

  }
  // Example //  isToday => Created Today // is Yesterday => Created a day ago // Another => 10 days ago
  static String get_Custom_Days_Between_asString({required String fromDateString,required String toDateString}) {
    DateTime from = DateTime.parse(fromDateString);
    DateTime to = DateTime.parse(toDateString);

    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    int daysBetween = (to
        .difference(from)
        .inHours / 24).round();
    if (daysBetween == 0) {
      return "Created Today";
    }
    else if (daysBetween == 1) {
      return "Created a day ago";
    } else {
      return " $daysBetween days ago";
    }
  }

  static int get_hours_Between_Two_Time({required String fromTimeString,required String toTimeString}){
    var   createdDate  =  "2022-10-18T";
    fromTimeString = createdDate + fromTimeString;
    toTimeString = createdDate + toTimeString;
    DateTime from = DateTime.parse(fromTimeString);
    DateTime to = DateTime.parse(toTimeString);
    int difference = to.difference(from).inSeconds;
    return  difference;
  }
  static int get_minutes_Between_Two_Date({required String fromTimeString,required String toTimeString}) {
    DateTime from = DateTime.parse(fromTimeString);
    DateTime to = DateTime.parse(toTimeString);
    int difference = to.difference(from).inMinutes;
    return difference;
  }
  static int get_Days_Between_Two_Date_asInteger({required String fromDateString,required String toDateString }) {
    try{
      DateTime from = DateTime.parse(fromDateString);
      DateTime to = DateTime.parse(toDateString);

      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      int daysNumber = (to.difference(from).inHours / 24).round() + 1;
      return daysNumber;
    }catch(e){
      return 0;
    }



  }

  static bool check_DateString_IsToday({required String dateString}){
    try{
      DateTime dateTime = DateTime.parse(dateString);
      var dateByFormate =  DateFormat(DateTimeManager.format_yyyyMMdd_Dash).format(dateTime);
      String today =  DateFormat(DateTimeManager.format_yyyyMMdd_Dash).format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
      if(dateByFormate == today){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }

  }
  static bool check_DateString_Is_days_Between({required String fromDateString,required String toDateString}) {
    try{
      DateTime from = DateTime.parse(fromDateString);
      DateTime to = DateTime.parse(toDateString);
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      int daysNumber = (to.difference(from).inHours / 24).round() + 1;
      if(daysNumber > 0){
        return true;
      }
      else{
        return false;
      }
    }catch(e){

      return false;
    }
  }
  static bool check_Time_Valid({required int integerDateValue}) {
    var valid = true;
    int h, m;
    h = integerDateValue ~/ 3600;
    m = ((integerDateValue - h * 3600)) ~/ 60;
    if (h <= 0 && m <= 0) {
      valid = false;
    }
    return valid;
  }

}