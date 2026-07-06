const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const { environment } = require('./config/environment');

const app = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/health', require('./routes/health.routes'));
app.use('/api/auth', require('./routes/auth.routes'));
app.use('/api/profiles', require('./routes/profile.routes'));
app.use('/api/sleep', require('./routes/sleep.routes'));
app.use('/api/upload', require('./routes/upload.routes'));

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    success: false,
    error: {
      message: err.message || 'Internal Server Error',
    },
  });
});

app.listen(environment.port, () => {
  console.log(`🚀 Server running in ${environment.nodeEnv} mode on port ${environment.port}`);
});
