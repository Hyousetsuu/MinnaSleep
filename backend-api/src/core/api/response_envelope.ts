export interface ApiSuccessResponse<T> {
  success: true;
  data: T;
  meta?: Record<string, any>;
  requestId: string;
  timestamp: string;
  apiVersion: string;
}

export interface ApiErrorResponse {
  success: false;
  error: {
    code: string;
    message: string;
  };
  requestId: string;
  timestamp: string;
  apiVersion: string;
}

export class ResponseEnvelope {
  static success<T>(data: T, requestId: string, meta?: Record<string, any>): ApiSuccessResponse<T> {
    return {
      success: true,
      data,
      meta,
      requestId,
      timestamp: new Date().toISOString(),
      apiVersion: '1.0',
    };
  }

  static error(code: string, message: string, requestId: string): ApiErrorResponse {
    return {
      success: false,
      error: {
        code,
        message,
      },
      requestId,
      timestamp: new Date().toISOString(),
      apiVersion: '1.0',
    };
  }
}
