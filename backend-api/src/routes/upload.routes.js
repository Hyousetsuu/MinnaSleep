const express = require('express');
const router = express.Router();

router.post('/avatar', (req, res) => {
  res.json({ success: true, message: 'Upload avatar endpoint' });
});

module.exports = router;
