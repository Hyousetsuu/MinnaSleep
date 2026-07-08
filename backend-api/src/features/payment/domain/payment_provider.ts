export interface PaymentProvider {
  /**
   * Verifies the authenticity of a webhook payload using the provider's signature.
   */
  verifyWebhookSignature(payload: string, signature: string): boolean;

  /**
   * Gets the canonical name of the provider (e.g., 'stripe', 'midtrans').
   */
  getProviderName(): string;
}

export interface PaymentWebhookEvent {
  eventId: string;
  type: string; // e.g., 'payment_intent.succeeded'
  timestamp: Date;
  referenceId: string; // e.g., subscriptionId or orderId
  customerId: string; // Internal userId or external customerId
  metadata: Record<string, any>;
}
