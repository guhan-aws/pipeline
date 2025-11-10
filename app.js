const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(morgan('combined'));
app.use(express.json());

// Health check endpoint (used by LoadBalancer and ValidateService hook)
app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// Main endpoint
app.get('/', (req, res) => {
    res.status(200).json({
        message: 'Hello from Node.js on AWS EC2!',
        environment: process.env.NODE_ENV || 'development',
        version: require('./package.json').version
    });
});

// Example API endpoint
app.get('/api/status', (req, res) => {
    res.status(200).json({
        status: 'running',
        timestamp: new Date(),
        node_version: process.version
    });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({ error: 'Route not found' });
});

// Error handler
app.use((err, req, res, next) => {
    console.error('Error:', err);
    res.status(500).json({
        error: 'Internal Server Error',
        message: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`✓ Server running on port ${PORT}`);
    console.log(`✓ Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`✓ Health check: http://localhost:${PORT}/health`);
});

module.exports = app;