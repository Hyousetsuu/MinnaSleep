import { z } from 'zod';
import { ErrorFactory } from '../../../core/api/error_factory.js';
import { AIInsightSchema, AIRecommendationSchema, AIInsightDTO, AIRecommendationDTO } from '../domain/ai_dto.js';
import { logger } from '../../../logger.js';

export class OutputValidator {
  /**
   * Validates raw JSON string from AI Provider against the Insight Schema.
   * Throws specific AI Error codes on failure.
   */
  static validateInsight(rawOutput: string): AIInsightDTO {
    try {
      const parsedJSON = JSON.parse(rawOutput);
      const result = AIInsightSchema.safeParse(parsedJSON);
      
      if (!result.success) {
        logger.warn('[OutputValidator] Insight Schema Validation Failed', result.error);
        throw ErrorFactory.create('AI003', `Schema validation failed: ${result.error.message}`);
      }
      
      return result.data;
    } catch (e: any) {
      if (e.code === 'AI003') throw e;
      logger.error('[OutputValidator] Invalid JSON returned by AI', e);
      throw ErrorFactory.create('AI007', 'Invalid JSON returned by provider');
    }
  }

  /**
   * Validates raw JSON string from AI Provider against the Recommendation Schema.
   */
  static validateRecommendation(rawOutput: string): AIRecommendationDTO {
    try {
      const parsedJSON = JSON.parse(rawOutput);
      const result = AIRecommendationSchema.safeParse(parsedJSON);
      
      if (!result.success) {
        logger.warn('[OutputValidator] Recommendation Schema Validation Failed', result.error);
        throw ErrorFactory.create('AI003', `Schema validation failed: ${result.error.message}`);
      }
      
      return result.data;
    } catch (e: any) {
      if (e.code === 'AI003') throw e;
      logger.error('[OutputValidator] Invalid JSON returned by AI', e);
      throw ErrorFactory.create('AI007', 'Invalid JSON returned by provider');
    }
  }
}
