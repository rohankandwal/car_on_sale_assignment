enum Environment {
  dev("https://dev.example.org/v1"),
  prod("https://example.org/v1");

  final String baseUrl;

  const Environment(this.baseUrl);
}
