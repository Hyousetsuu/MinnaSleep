import { SubscriptionEventLog } from './subscription_event_log.js';
import { EntitlementService } from './entitlement_service.js';

/**
 * Sprint 18: RevenueCat Webhook Handler
 * Central processor for all App Store / Play Store billing events.
 */

export class RevenuecatWebhookHandler {
  constructor(
    private eventLog: SubscriptionEventLog,
    private entitlementService: EntitlementService
  ) {}

  async handleWebhook(payload: any): Promise<void> {
    const eventType = payload.event.type; // INITIAL_PURCHASE, RENEWAL, CANCELLATION, EXPIRATION
    const userId = payload.event.app_user_id;
    const productId = payload.event.product_id || 'free_tier';

    // 1. Audit Trail
    await this.eventLog.logEvent(userId, eventType, payload);

    // 2. Map to logical subscription state
    let status = 'EXPIRED';
    if (['INITIAL_PURCHASE', 'RENEWAL'].includes(eventType)) {
      status = 'ACTIVE';
    }

    // 3. Grant Entitlements
    let entitlements = ['MANUAL_SLEEP', 'SOCIAL_FEED'];
    if (status === 'ACTIVE') {
      entitlements = await this.entitlementService.getEntitlementsForProduct(productId);
    }
    
    console.log(`[RevenueCat] User ${userId} status updated to ${status}. Entitlements: ${entitlements.join(', ')}`);
  }
}
