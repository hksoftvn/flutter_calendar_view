import 'package:flutter/material.dart';

import '../calendar_view.dart';

class CalendarAction {
  void setJumpDate(DateTime date, {required PageController pageController}) {
    final minDate = (CalendarConstants.epochDate).withoutTime;
    final maxDate = (CalendarConstants.maxDate).withoutTime;
    if (date.isBefore(minDate) || date.isAfter(maxDate)) {
      return;
    }
    pageController.jumpToPage(minDate.getDayDifference(date));
  }

  void setJumpWeek(DateTime week, {required PageController pageController}) {
    final startDay = WeekDays.monday;
    final minDay = (CalendarConstants.epochDate)
        .firstDayOfWeek(start: startDay)
        .withoutTime;
    final maxDay =
        (CalendarConstants.maxDate).firstDayOfWeek(start: startDay).withoutTime;
    if (week.isBefore(minDay) || week.isAfter(maxDay)) {
      return;
    }
    pageController.jumpToPage(minDay.getWeekDifference(week, start: startDay));
  }

  void setJumpMonth(DateTime month, {required PageController pageController}) {
    final minDate = (CalendarConstants.epochDate).withoutTime;
    final maxDate = (CalendarConstants.maxDate).withoutTime;
    if (month.isBefore(minDate) || month.isAfter(maxDate)) {
      return;
    }
    pageController.jumpToPage(minDate.getMonthDifference(month) - 1);
  }


}
