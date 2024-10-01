class ResponseEntity<T> {
  final String message;
  final int status;
  final Map<String, dynamic> data;

  ResponseEntity(
      {required this.message, required this.status, required this.data});
}
