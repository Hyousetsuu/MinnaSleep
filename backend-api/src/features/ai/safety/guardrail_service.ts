import { AIResponse } from '../providers/ai_provider.interface';

export enum RiskLevel {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  BLOCKED = 'BLOCKED'
}

export class GuardrailException extends Error {
  constructor(public code: string, message: string, public risk: RiskLevel) {
    super(message);
    this.name = 'GuardrailException';
  }
}

export class GuardrailService {
  
  validate(response: AIResponse): void {
    this._validateJSON(response.content);
    this._detectMedicalDiagnosis(response.content);
    this._detectUnsafeAdvice(response.content);
  }

  private _validateJSON(content: string) {
    try {
      JSON.parse(content);
    } catch (e) {
      throw new GuardrailException('AI006', 'Malformed JSON Response', RiskLevel.HIGH);
    }
  }

  private _detectMedicalDiagnosis(content: string) {
    const diagnosticKeywords = [
      'diagnose', 'suffer from', 'you have sleep apnea', 'insomnia treatment',
      'prescription', 'medical condition', 'disease'
    ];
    
    const lowerContent = content.toLowerCase();
    for (const keyword of diagnosticKeywords) {
      if (lowerContent.includes(keyword)) {
        // AI007 Fallback Injection
        throw new GuardrailException(
          'AI007', 
          'Unsafe Medical Advice: Model attempted to diagnose or prescribe.', 
          RiskLevel.BLOCKED
        );
      }
    }
  }

  private _detectUnsafeAdvice(content: string) {
    // Check for harmful lifestyle advice
    if (content.toLowerCase().includes('stop taking your medication')) {
      throw new GuardrailException('AI008', 'Unsafe Behavioral Advice', RiskLevel.BLOCKED);
    }
  }
}
