export const ErrorRegistry = {
  AUTH001: { code: 'AUTH001', message: 'Email already registered', status: 400 },
  AUTH002: { code: 'AUTH002', message: 'Invalid credentials', status: 401 },
  AUTH003: { code: 'AUTH003', message: 'Session invalid or expired', status: 401 },
  AUTH004: { code: 'AUTH004', message: 'Missing or invalid authorization', status: 401 },
  AUTH005: { code: 'AUTH005', message: 'Account locked due to multiple failed login attempts', status: 429 },
  AUTH006: { code: 'AUTH006', message: 'Forbidden: Insufficient role', status: 403 },
  
  VAL001: { code: 'VAL001', message: 'Validation failed', status: 400 },
  
  SYNC001: { code: 'SYNC001', message: 'Conflict detected', status: 409 },
  SYNC002: { code: 'SYNC002', message: 'Retry required', status: 422 },
  
  AI001: { code: 'AI001', message: 'Invalid Prompt', status: 400 },
  AI002: { code: 'AI002', message: 'Provider Timeout', status: 504 },
  AI003: { code: 'AI003', message: 'Schema Validation Failed', status: 422 },
  AI004: { code: 'AI004', message: 'Quota Exceeded', status: 429 },
  AI005: { code: 'AI005', message: 'Provider Unavailable', status: 503 },
  AI006: { code: 'AI006', message: 'Safety Blocked', status: 403 },
  AI007: { code: 'AI007', message: 'Invalid JSON Response', status: 502 },
  AI008: { code: 'AI008', message: 'Unknown AI Error', status: 500 },
  AI009: { code: 'AI009', message: 'Cache Failure', status: 500 },
  AI010: { code: 'AI010', message: 'Provider Rate Limited', status: 429 },
  
  SYS001: { code: 'SYS001', message: 'Internal server error', status: 500 },
};

export type ErrorCode = keyof typeof ErrorRegistry;

export class AppError extends Error {
  public readonly code: string;
  public readonly status: number;
  
  constructor(errorCode: ErrorCode, customMessage?: string) {
    const errorDef = ErrorRegistry[errorCode] || ErrorRegistry.SYS001;
    super(customMessage || errorDef.message);
    this.code = errorDef.code;
    this.status = errorDef.status;
    
    // Set prototype explicitly for built-in Error extending in TS
    Object.setPrototypeOf(this, AppError.prototype);
  }
}

export class ErrorFactory {
  static create(errorCode: ErrorCode, customMessage?: string): AppError {
    return new AppError(errorCode, customMessage);
  }
}
