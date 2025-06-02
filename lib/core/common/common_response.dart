class CommonResponse<T> {
  final int code;
  final String head;
  final String desc;
  final T data;

  CommonResponse(
      {required this.code,
      required this.head,
      required this.desc,
      required this.data});
}
