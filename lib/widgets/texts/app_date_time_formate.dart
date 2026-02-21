import 'package:flutter_riverpod_template/utils/app_log.dart';


class AppDateTimeFormate {
  AppDateTimeFormate._privateConstructor();
  static final AppDateTimeFormate _instance = AppDateTimeFormate._privateConstructor();
  static AppDateTimeFormate get instance => _instance;



  String timeFormateTextMonthYear(String? inputDateTime) {
    try {
      if (inputDateTime == null) return "";
      DateTime? dateTime = DateTime.tryParse(inputDateTime);
      if (dateTime == null) return "";

      DateTime utcTime = dateTime.toLocal();
    
      const List<String> monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

      String month = monthNames[utcTime.month - 1];
      int year = utcTime.year;
      return "$month $year";
    } catch (e) {
      errorLog("timeFormateTextMonthYear", e);
      return "";
    }
  }

  String timeFormateTextDayMonthYear(String? inputDateTime) {
    try {
      if (inputDateTime == null) return "";
      DateTime? dateTime = DateTime.tryParse(inputDateTime);
      if (dateTime == null) return "";
      DateTime localTime = dateTime.toLocal();
 
      const List<String> monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

      String month = monthNames[localTime.month - 1];
      int year = localTime.year;
      int day = localTime.day;
      return "$day $month, $year";
    } catch (e) {
      errorLog("timeFormateTextMonthYear", e);
      return "";
    }
  }

  String timeFormateTextMonthDayYear(String? inputDateTime) {
    try {
      if (inputDateTime == null) return "";
      DateTime? dateTime = DateTime.tryParse(inputDateTime);
      if (dateTime == null) return "";

      DateTime localTime = dateTime.toLocal();

      const List<String> monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

      String month = monthNames[localTime.month - 1];
      int year = localTime.year;
      int day = localTime.day;
      return "$month $day, $year";
    } catch (e) {
      errorLog("timeFormateTextMonthYear", e);
      return "";
    }
  }

  String fullDateAndTimeConsultationFormateFunction(String? inputDateTime) {
    try {
      if (inputDateTime == null) return "";
      if (inputDateTime.isEmpty) return "";
      // Parse the input string to DateTime
      DateTime? localTime = DateTime.tryParse(inputDateTime);

      if (localTime == null) return "";

      const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      // Extract month, day, year, hour, and minute
      String month = months[localTime.month - 1];

      int day = localTime.day;
      int year = localTime.year;
      int hour = localTime.hour;
      int minute = localTime.minute;

      // Determine AM or PM
      String period = hour >= 12 ? "PM" : "AM";

      // Convert hour to 12-hour format
      hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      // Format minute to always show 2 digits
      String minuteStr = minute.toString().padLeft(2, '0');

      // Build the formatted string
      return "$month $day, $year  $hour:$minuteStr $period";
    } catch (e) {
      errorLog("fullDateAndTimeFormateFunction", e);
      return "";
    }
  }

  String timePeriod(String? inputDateTime) {
    try {
      if (inputDateTime == null) return "";
      DateTime? localTime = DateTime.tryParse(inputDateTime)?.toLocal();

      if (localTime == null) return "";
    

      final DateTime now = DateTime.now().toLocal();
      final Duration difference = now.difference(localTime);

      if (difference.inDays == 0) {
        // If the date is today, return the time in hh:mm a format
        int hour = localTime.hour;
        int minute = localTime.minute;
        String period = hour >= 12 ? 'pm' : 'am';

        if (hour > 12) {
          hour -= 12;
        } else if (hour == 0) {
          hour = 12;
        }

        final String minuteStr = minute < 10 ? '0$minute' : '$minute';
        return '$hour:$minuteStr $period';
      } else if (difference.inDays == 1) {
        return '1 day';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days';
      } else if (difference.inDays < 30) {
        return '${difference.inDays ~/ 7} week${difference.inDays ~/ 7 > 1 ? 's' : ''}';
      } else if (difference.inDays < 365) {
        return '${difference.inDays ~/ 30} month${difference.inDays ~/ 30 > 1 ? 's' : ''}';
      } else {
        return '${difference.inDays ~/ 365} year${difference.inDays ~/ 365 > 1 ? 's' : ''} ';
      }
    } catch (e) {
      errorLog("timePeriod", e);
      return "";
    }
  }
}
