const express = require('express');
const router = express.Router();

router.get('/me', (req, res) => {
  res.json({ success: true, message: 'Get profile endpoint' });
});

router.post('/setup', (req, res) => {
  res.json({ success: true, message: 'Setup profile endpoint' });
});

router.put('/me', (req, res) => {
  res.json({ success: true, message: 'Update profile endpoint' });
});

router.get('/:username', (req, res) => {
  res.json({ success: true, message: 'Get public profile endpoint' });
});

module.exports = router;
