import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

void showCustomCalendarView({
  required DateTime initialDate,
  required DateTime firstDate,
  required BuildContext context,
  required Function(DateTime) onDateSelected,
  bool isSecond = false,
  bool yearInFast = false,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CalendarView(initialDate: initialDate, firstDate: firstDate, onDateSelected: onDateSelected, isSecond: isSecond, yearInFast: yearInFast);
    },
  );
}

class CalendarView extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final bool isSecond;
  final Function(DateTime) onDateSelected;
  final bool yearInFast;

  const CalendarView({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.onDateSelected,
    required this.isSecond,
    this.yearInFast = false,
  });

  @override
  State createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime firstDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedCurrentDate = DateTime.now();
  int? selectedYear;
  List<String> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  List<String> weekdays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  @override
  void initState() {
    selectedDate = widget.firstDate;
    selectedDate = widget.initialDate;
    selectedYear = selectedDate.year;
    super.initState();
  }

  // Handle the year change
  void _changeYear(int year) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedYear = year;
        selectedDate = DateTime(year, selectedDate.month, selectedDate.day);
      });
    });
  }

  // Handle the month change
  void _changeMonth(int delta) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedDate = DateTime(selectedDate.year, selectedDate.month + delta, selectedDate.day);
      });
    });
  }

  bool _active({required DateTime dateTime}) {
    try {
      if (widget.isSecond) {
        if (dateTime.isBefore(widget.firstDate.add(Duration(days: 1)))) {
          return true;
        } else {
          return false;
        }
      } else {
        if (dateTime.isBefore(widget.firstDate.subtract(const Duration(days: 1)))) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      errorLog("message", e);
    }
    return true;
  }

  // Build the days for the current month
  List<Widget> _buildDays() {
    int daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    int firstWeekdayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1).weekday;
    int lastWeekdayOfMonth = DateTime(selectedDate.year, selectedDate.month, daysInMonth).weekday;

    // Determine the number of days needed from the previous and next months
    int prevMonthDays = firstWeekdayOfMonth == 7 ? 0 : firstWeekdayOfMonth;
    int nextMonthDays = (6 - lastWeekdayOfMonth);

    List<Widget> dayWidgets = [];

    // Add empty containers for the previous month's days before the start of the current month
    for (int i = prevMonthDays; i > 0; i--) {
      DateTime prevMonthDay = DateTime(selectedDate.year, selectedDate.month, -i);
      dayWidgets.add(
        Center(
          child: AppText(text: prevMonthDay.day.toString(), color: AppColors.instance.black200),
        ),
      );
    }

    // Actual days of the current month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDay = DateTime(selectedDate.year, selectedDate.month, day);
      bool isSelected =
          currentDay.day == selectedCurrentDate.day && currentDay.year == selectedCurrentDate.year && currentDay.month == selectedCurrentDate.month;
      dayWidgets.add(
        GestureDetector(
          // onTap: currentDay.month == selectedDate.month ? () => _onDaySelected(currentDay) : null,
          onTap: () => _onDaySelected(currentDay),
          child: Container(
            decoration: BoxDecoration(color: _active(dateTime: currentDay) ? AppColors.instance.black200 : AppColors.instance.black200),
            child: Container(
              margin: EdgeInsets.all(AppSize.width(value: 5)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: isSelected ? AppColors.instance.primary : AppColors.instance.transparent),
              ),
              child: Center(child: AppText(text: day.toString())),
            ),
          ),
        ),
      );
    }

    // Add empty containers for the next month's days after the end of the current month
    for (int i = 1; i <= nextMonthDays; i++) {
      DateTime nextMonthDay = DateTime(selectedDate.year, selectedDate.month + 1, i);
      dayWidgets.add(
        Center(
          child: AppText(text: nextMonthDay.day.toString(), color: AppColors.instance.black200),
        ),
      );
    }

    // Ensure the total number of items is a multiple of 7 (for 7 columns) by adding empty containers if necessary
    while (dayWidgets.length % 7 != 0) {
      dayWidgets.add(Container()); // Empty container to fill the last row
    }

    return dayWidgets;
  }

  // Handle day selection
  void _onDaySelected(DateTime day) {
    try {
      if (_active(dateTime: day)) {
        return;
      }
      setState(() {
        selectedDate = day;
        widget.onDateSelected(selectedDate);
      });
      Navigator.pop(context);
    } catch (e) {
      errorLog("_onDaySelected", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(AppSize.width(value: 20)),
            padding: EdgeInsets.all(AppSize.width(value: 20)),
            decoration: BoxDecoration(
              color: AppColors.instance.primary,
              borderRadius: BorderRadius.circular(AppSize.width(value: 10)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top bar: Year and Month with change buttons
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PopupMenuButton(
                            color: AppColors.instance.primary,
                            position: PopupMenuPosition.under,
                            child: AppText(text: selectedYear.toString(), fontSize: 24, fontWeight: FontWeight.bold),
                            onSelected: (value) {
                              _changeYear(value);
                            },
                            itemBuilder: (context) {
                              if (widget.yearInFast) {
                                return List.generate(100, (index) {
                                  int year = DateTime.now().year - index;
                                  return PopupMenuItem(
                                    value: year,
                                    child: AppText(text: year.toString(), color: AppColors.instance.black900, fontWeight: FontWeight.w500),
                                  );
                                });
                              }
                              return List.generate(5, (index) {
                                int year = DateTime.now().year + index;
                                return PopupMenuItem(
                                  value: year,
                                  child: AppText(text: year.toString(), color: AppColors.instance.black900, fontWeight: FontWeight.w500),
                                );
                              });
                            },
                          ),
                          AppText(text: "  -  ", fontSize: 24, fontWeight: FontWeight.bold),
                          PopupMenuButton(
                            color: AppColors.instance.primary,
                            position: PopupMenuPosition.under,
                            child: AppText(text: months[selectedDate.month - 1], fontSize: 24, fontWeight: FontWeight.bold),
                            onSelected: (value) {
                              setState(() {
                                selectedDate = DateTime(selectedDate.year, value + 1, 1);
                              });
                            },
                            itemBuilder: (context) {
                              return List.generate(months.length - 1, (index) {
                                return PopupMenuItem(
                                  value: index,
                                  child: AppText(text: months[index], color: AppColors.instance.black900, fontWeight: FontWeight.w500),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Gap(width: 20),
                          IconButton(
                            onPressed: () {
                              _changeMonth(-1);
                            },
                            icon: Icon(Icons.arrow_back_ios, color: AppColors.instance.black900),
                          ),
                          IconButton(
                            onPressed: () {
                              _changeMonth(1);
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: AppColors.instance.black900),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(height: 10),
                // Weekday labels row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: weekdays
                      .map(
                        (day) => Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: AppText(text: day, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 8),

                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 7,
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: _buildDays(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
