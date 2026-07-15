import { AnalyticsService } from '../services/analytics_service';

export class AnalyticsController {
  constructor(private service: AnalyticsService) {}

  /**
   * GET /api/v1/analytics/dashboard
   */
  async getDashboard(req: any, res: any) {
    try {
      const { userId, date } = req.query;
      const data = await this.service.getDashboard(userId, date);
      
      return res.status(200).json({
        success: true,
        data,
        meta: { cached: true }
      });
    } catch (e: any) {
      return res.status(404).json({ success: false, error: e.message });
    }
  }

  /**
   * GET /api/v1/analytics/recovery
   */
  async getRecovery(req: any, res: any) {
    try {
      const { userId, start, end } = req.query;
      const data = await this.service.getRecoveryTrends(userId, start, end);
      
      return res.status(200).json({ success: true, data });
    } catch (e: any) {
      return res.status(500).json({ success: false, error: e.message });
    }
  }
}
