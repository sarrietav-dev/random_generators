bool areNumbersBetweenZeroAndOne(List<double> numbers) {
  return numbers.every((element) => element >= 0 && element <= 1);
}
