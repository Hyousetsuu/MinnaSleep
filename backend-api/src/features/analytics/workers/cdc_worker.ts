/**
 * Sprint 14: Change Data Capture (CDC) Worker Interface
 * Decouples the system from specific streaming tech (Kafka, Debezium).
 */

export interface CDCEvent {
  topic: string;
  operation: 'INSERT' | 'UPDATE' | 'DELETE';
  payload: any;
  timestamp: string;
}

export interface CDCWorker {
  connect(): Promise<void>;
  subscribe(topic: string, handler: (event: CDCEvent) => Promise<void>): void;
}

export class MockCDCWorker implements CDCWorker {
  async connect(): Promise<void> {
    console.log('[MockCDC] Connected to CDC Stream.');
  }

  subscribe(topic: string, handler: (event: CDCEvent) => Promise<void>): void {
    console.log(`[MockCDC] Subscribed to topic: ${topic}`);
    // Simulate incoming data
    // setInterval(() => handler({ topic, operation: 'INSERT', payload: {}, timestamp: new Date().toISOString() }), 10000);
  }
}

export class KafkaCDCWorker implements CDCWorker {
  async connect(): Promise<void> {
    // TODO: Initialize Kafka Consumer
  }

  subscribe(topic: string, handler: (event: CDCEvent) => Promise<void>): void {
    // TODO: consumer.subscribe({ topic })
  }
}
