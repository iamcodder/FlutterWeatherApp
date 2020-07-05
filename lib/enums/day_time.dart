enum DayTime {
  zero,
  three,
  six,
  nine,
  twelve,
  fifteen,
  eighteen,
  twentyone,
  twentyfour
}

extension getDayTime on DayTime {
  String get extGetDayTime {
    switch (this) {
      case DayTime.zero:
        return '00:00';
        break;
      case DayTime.three:
        return '03:00';
        break;
      case DayTime.six:
        return '06:00';
        break;
      case DayTime.nine:
        return '09:00';
        break;
      case DayTime.twelve:
        return '12:00';
        break;
      case DayTime.fifteen:
        return '15:00';
        break;
      case DayTime.eighteen:
        return '18:00';
        break;
      case DayTime.twentyone:
        return '21:00';
        break;
      case DayTime.twentyfour:
        return '00:00';
        break;
    }
  }
}
