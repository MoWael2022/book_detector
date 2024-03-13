class CategoryServerException implements Exception {
  final String errorMessage;

  CategoryServerException({required this.errorMessage});
}
