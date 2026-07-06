const { createClient } = require('@supabase/supabase-js');
const { environment } = require('./environment');

if (!environment.supabaseUrl || !environment.supabaseServiceKey) {
  console.warn('⚠️ Supabase credentials missing. Supabase client will not be initialized properly.');
}

const supabase = createClient(
  environment.supabaseUrl || 'https://placeholder.supabase.co',
  environment.supabaseServiceKey || 'placeholder'
);

module.exports = { supabase };
