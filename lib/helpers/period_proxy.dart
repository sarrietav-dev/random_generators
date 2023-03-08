List<double> periodProxy(List<double> numbers) {
  var firstNumber = numbers.first;

  var periodIndex =
      numbers.sublist(1).indexWhere((element) => element == firstNumber);

  if (periodIndex == -1) {
    return numbers;
  } else {
    return numbers.sublist(0, periodIndex);
  }
}
