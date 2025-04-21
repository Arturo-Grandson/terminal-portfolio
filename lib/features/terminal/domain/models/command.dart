class Command {
  final String name;
  final String description;
  final String example;

  const Command({
    required this.name,
    required this.description,
    required this.example,
  });
}

class CommandResponse {
  final String content;
  final bool isError;

  const CommandResponse({required this.content, this.isError = false});
}
