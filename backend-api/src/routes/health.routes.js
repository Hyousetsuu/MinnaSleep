const express = require('express');
const router = express.Router();
const { supabase } = require('../config/supabase');

router.get('/', async (req, res) => {
  try {
    // Check Supabase connection (optional simple query)
    const { data, error } = await supabase.from('profiles').select('id').limit(1);
    
    res.json({
      success: true,
      data: {
        status: 'UP',
        timestamp: new Date().toISOString(),
        database: error ? 'DISCONNECTED' : 'CONNECTED',
      }
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: { message: 'Health check failed', details: err.message }
    });
  }
});

module.exports = router;
