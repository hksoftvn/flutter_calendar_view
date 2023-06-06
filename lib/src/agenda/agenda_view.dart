import 'package:flutter/material.dart';

import '../../calendar_view.dart';
import '../components/behavior.dart';

class AgendaView extends StatefulWidget {
  final Widget Function(DateTime date) bodyAgenda;
  const AgendaView({Key? key, required this.bodyAgenda}) : super(key: key);

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  late DateTime _maxDate;
  late DateTime _minDate;
  final WeekDays startDay = WeekDays.monday;
  late int _totalWeeks;
  late PageController _pageController;
  late int _currentIndex;
  late DateTime _currentWeek;
  late DateTime _currentEndDate;

  @override
  void initState() {
    _setDateRange();

    _currentWeek = DateTime.now().withoutTime;

    _regulateCurrentDate();
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AgendaView oldWidget) {
    _setDateRange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemCount: _totalWeeks,
        itemBuilder: (context, index) {
          final dates = DateTime(_minDate.year, _minDate.month,
                  _minDate.day + (index * DateTime.daysPerWeek))
              .datesOfWeek(start: startDay);
          return _InternalAgendaViewPage(
            dates: dates,
            bodyAgenda: widget.bodyAgenda,
          );
        });
  }

  void _setDateRange() {
    _minDate =
        CalendarConstants.epochDate.firstDayOfWeek(start: startDay).withoutTime;

    _maxDate =
        CalendarConstants.maxDate.lastDayOfWeek(start: startDay).withoutTime;

    assert(
      _minDate.isBefore(_maxDate),
      "Minimum date must be less than maximum date.\n"
      "Provided minimum date: $_minDate, maximum date: $_maxDate",
    );

    _totalWeeks = _minDate.getWeekDifference(_maxDate, start: startDay) + 1;
  }

  void _regulateCurrentDate() {
    if (_currentWeek.isBefore(_minDate)) {
      _currentWeek = _minDate;
    } else if (_currentWeek.isAfter(_maxDate)) {
      _currentWeek = _maxDate;
    }

    _currentEndDate = _currentWeek.lastDayOfWeek(start: startDay);
    _currentIndex =
        _minDate.getWeekDifference(_currentEndDate, start: startDay);
  }
}

class _InternalAgendaViewPage extends StatefulWidget {
  final List<DateTime> dates;
  final Widget Function(DateTime date) bodyAgenda;
  const _InternalAgendaViewPage(
      {Key? key, required this.dates, required this.bodyAgenda})
      : super(key: key);

  @override
  State<_InternalAgendaViewPage> createState() =>
      _InternalAgendaViewPageState();
}

class _InternalAgendaViewPageState extends State<_InternalAgendaViewPage> {
  @override
  Widget build(BuildContext context) {
    final filteredDates = _filteredDate();

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: filteredDates.length,
          itemBuilder: (context, index) {
            final date = filteredDates[index];
            return widget.bodyAgenda(date);
          }),
    );
  }

  List<DateTime> _filteredDate() {
    final output = <DateTime>[];
    final weekDays = WeekDays.values.toList();

    for (final date in widget.dates) {
      if (weekDays.any((weekDay) => weekDay.index + 1 == date.weekday)) {
        output.add(date);
      }
    }

    return output;
  }
}
