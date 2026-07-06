class AppConfig {
  final String apiUrl;
  final String environment;
  final String version;
  final int buildNumber;
  final bool debugMode;

  const AppConfig({
    required this.apiUrl,
    required this.environment,
    required this.version,
    required this.buildNumber,
    required this.debugMode,
  });
}

// Development Config
const devConfig = AppConfig(
  apiUrl: 'http://localhost:3000/api/v1',
  environment: 'development',
  version: '0.1.0',
  buildNumber: 1,
  debugMode: true,
);

// Production Config
const prodConfig = AppConfig(
  apiUrl: 'https://api.minnasleep.com/v1',
  environment: 'production',
  version: '1.0.0',
  buildNumber: 1,
  debugMode: false,
);

// Current Config globally accessible if needed, but better via DI
late AppConfig currentConfig;
