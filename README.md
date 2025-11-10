# My Node.js Application

A Node.js application deployed on AWS EC2 using CodePipeline and CodeDeploy.

## Prerequisites

- Node.js 18+
- AWS Account
- GitHub Account
- AWS CLI configured

## Local Development

```bash
npm install
npm run dev
```

## Deployment

This application is automatically deployed to AWS EC2 using:
- **Source**: GitHub repository
- **Build**: AWS CodeBuild
- **Deploy**: AWS CodeDeploy

Push changes to the `main` branch to trigger automatic deployment.

## Environment Variables

Create a `.env` file:

```
NODE_ENV=production
PORT=3000
LOG_LEVEL=info
```

## API Endpoints

- `GET /` - Main endpoint
- `GET /health` - Health check
- `GET /api/status` - Application status

## Deployment Scripts

Located in `scripts/` directory:
- `stop_server.sh` - Stop the application
- `before_install.sh` - Pre-deployment setup
- `after_install.sh` - Install dependencies
- `start_application.sh` - Start the application
- `validate_service.sh` - Health checks

## Logs

Application logs are stored at:
- `/var/log/nodejs-app/app.log` - Application output
- `/var/log/nodejs-app/error.log` - Error logs
- `/var/log/aws/codedeploy-agent/` - Deployment logs

## Troubleshooting

### Check if app is running
```bash
pm2 list
```

### View application logs
```bash
pm2 logs my-app
```

### View deployment logs
```bash
tail -f /var/log/aws/codedeploy-agent/codedeploy-agent-deployments.log
```

### SSH to EC2
```bash
ssh -i your-key.pem ec2-user@your-instance-ip
```

## License

MIT