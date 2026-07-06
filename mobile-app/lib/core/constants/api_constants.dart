class ApiConstants {
  // Base URLs
  static const String baseUrlDev = 'http://localhost:3000/api/v1';
  static const String baseUrlProd = 'https://api.minnasleep.com/v1';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;

  // Endpoints
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authLogout = '/auth/logout';
  
  static const String userProfile = '/user/profile';
  
  static const String syncUpload = '/sync/upload';
  static const String syncDownload = '/sync/download';

  // AI & Analytics
  static const String aiInsights = '/ai/insights';
}
