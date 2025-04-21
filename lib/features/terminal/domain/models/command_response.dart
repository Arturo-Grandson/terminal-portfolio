class CommandResponse {
  final String content;
  final bool isError;

  const CommandResponse({required this.content, this.isError = false});
}
