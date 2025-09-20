# 🚀 Vercel Deployment Guide for Festify

This guide will help you deploy your Festify project (both backend and frontend) to Vercel.

## 📋 Prerequisites

1. **Vercel Account**: Sign up at [vercel.com](https://vercel.com)
2. **GitHub Repository**: Your code should be in a GitHub repository
3. **MongoDB Database**: Set up MongoDB Atlas or use another MongoDB service
4. **Environment Variables**: Prepare all required environment variables

## 🏗️ Project Structure

```
Festify/
├── server/          # Backend (Node.js/Express)
├── web/            # Frontend (React/Vite)
├── vercel.json     # Root Vercel config (monorepo setup)
└── vercel.env.example # Environment variables template
```

## 🔧 Deployment Options

### Option 1: Separate Deployments (Recommended)

Deploy backend and frontend as separate Vercel projects for better performance and scaling.

#### Step 1: Deploy Backend

1. **Import Backend Project**:
   - Go to [Vercel Dashboard](https://vercel.com/dashboard)
   - Click "New Project"
   - Import your GitHub repository
   - Select **Root Directory**: `server`

2. **Configure Backend**:
   - **Framework Preset**: Other
   - **Root Directory**: `server`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`

3. **Add Environment Variables**:
   - Go to Project Settings → Environment Variables
   - Add all variables from `vercel.env.example`
   - **Important**: Replace placeholder values with your actual values

#### Step 2: Deploy Frontend

1. **Import Frontend Project**:
   - Create another Vercel project
   - Import the same GitHub repository
   - Select **Root Directory**: `web`

2. **Configure Frontend**:
   - **Framework Preset**: Vite
   - **Root Directory**: `web`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`

3. **Update API URL**:
   - After backend deployment, get your backend URL
   - Update `web/vercel.json` with your actual backend URL:
   ```json
   {
     "rewrites": [
       {
         "source": "/api/(.*)",
         "destination": "https://your-actual-backend-url.vercel.app/api/$1"
       }
     ]
   }
   ```

4. **Add Frontend Environment Variables**:
   - `VITE_API_URL`: Your backend URL (e.g., `https://your-backend.vercel.app`)

### Option 2: Monorepo Deployment

Deploy both backend and frontend in a single Vercel project.

1. **Import Project**:
   - Import your GitHub repository
   - Use the root `vercel.json` configuration

2. **Configure Project**:
   - **Framework Preset**: Other
   - **Root Directory**: (leave empty)
   - The `vercel.json` will handle the routing

3. **Add Environment Variables**:
   - Add all variables from `vercel.env.example`

## 🔐 Environment Variables Setup

### Backend Environment Variables

Copy these variables to your Vercel project settings:

```bash
# Database
APPLICATION_MONGO_URI=mongodb+srv://username:password@cluster.mongodb.net/festify

# JWT Secrets (generate strong secrets)
JWT_SECRET=your_very_secure_jwt_secret_here_at_least_32_characters
JWT_REFRESH_SECRET=your_very_secure_jwt_refresh_secret_here_at_least_32_characters
JWT_EMAIL_VERIFICATION_SECRET=your_email_verification_secret_here
JWT_RESET_PASSWORD_SECRET=your_reset_password_secret_here

# CORS (update with your actual domains)
ALLOWED_ORIGINS=https://your-frontend-domain.vercel.app,https://your-admin-domain.vercel.app

# Email Configuration
MAILING_SERVICE_HOST=smtp.gmail.com
MAILING_SERVICE_PORT=587
MAILING_SERVICE_USER=your_email@gmail.com
MAILING_SERVICE_USER_PASSWORD=your_app_password

# Client URLs
CLIENT_EMAIL_VERIFICATION_URL=https://your-frontend-domain.vercel.app/verify-email
CLIENT_RESET_PASSWORD_URL=https://your-frontend-domain.vercel.app/reset-password

# Firebase Configuration (from your secret file)
FIREBASE_PROJECT_ID=eventmanagement-fc36a
FIREBASE_PRIVATE_KEY_ID=3276368a456ecb9daecbe2047a92542715ca8f4c
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCckuclrJ6bT/L7\nodA4ie6n3jdSKb8yulCFQpZQlCtv9u8NyMwS20zWIws/w/+WjOk30WnaD6XSiUff\nypahg8WfCK4uYlhC/GSEYfSliuoiHi4MNMhzYHFjdFaBjsL2Ug7aP3OKJV3GADIJ\nH32X2NQy6a+Ki+jB0uzah5l4x4RjVddP6xqgVUvlhznQji1LCoGVXqcVV0t41h/B\n1pxp5h7dA4Qjn2EwgF+SRQFJYiMiFNkqD0enzkCJGIEkZCFHgRthU6F3Uy3Cn9K0\nktRnK01NeF8Sc+yjZphykest3Q26pGZJB2MrhJvVeAgV0BWBg4hOM04/Nlvjt52x\n6b/dojvnAgMBAAECggEAObxn9PoC4IWqNYT1OawPL6KfJrKTORsADyu/LwZ8QATA\nIQaezgNFAZ+ZidF2AaeDZlxX2puzi3+o28qiIfvr1xmF1T/ZiRX14OUYKCUh8iPL\n2h9qnTT+iux+67ZfiSI4LN2B9vqRai5vRPLyRpijowSOARpXYYWsZmbjPmjgFhqh\nCAvSJ3hOU3NUUogzN7jljDf+yW4hYVv6qB/F+xBNOmg8OqXEbWWQU+nOZziObEQN\nk9dNgSpPU2lDWhm3mu+rKXhONQ8x4JOoObW3OsB93Xb2kxaI87Brr2YFjfGbciXX\nf/gicwza2Rp8IfTuAGK9XYP494zxV68Kmo8w8XZsZQKBgQDRJuj31jiT3J5oDnGZ\n4vcEWv+9TqDLy4b6XpJ3z7CJr0TZKbJxp5uvBYlAkcwMN+rrG4PtBUY3wQuU78Rd\ndGyLcp/irSeiV0xzeehBTFbc9kPA5P4qRnOfXanbNmM5K0SwRm0/XO9V5EYS2Kgk\npb6YqrifpTcVpZCRIacFejS6BQKBgQC/pRUd4xdgdVLcBkXvKQDOJIxhCPVMDnoA\nJXdhjUxsf6mHGo10CwUeR4baOEySQ3bq3+t0/FpXOhRs1wb/ocmRGfx3Lmi4ixVq\nIuFEkTzvGVvtwh5A/dWWvehoOrrynuvuaQVT6faWqEYDfhzbBG26+4VVate0Z7oI\nGkwWTcLF+wKBgEF7xD8sdCRfU71SoGDE/gAAGcgEoTWNcKJdD9CxVx2UoaK4emU5\nS/Ydbp6nx1IgA84+nCyOlTCJoX2tIDb+Z6m1ZrfK7PjYClixV3VyWFPwSsBPMgC8\ndCD2a2L2AVT55hSmyDepeknTIdluuh5XQnh8Izfgu4Fsh/nYpnmBjJadAoGBAI9g\nq27Dwm6I+CfijZnDHHYdg+To9dQkFIRdg3Y5Z07ZJ/ULGX8S645exvYmHqtiy+on\nAppwXgpaSoOvT+4alZn4ThjAYNqIO8o/NDe/TU44s70qeMX44j438FNidRElcq/Y\nZIMGTFUkqdTdGiuFoa69lGB2YdD3tYdwXTJmlOzXAoGBAJFJ2WLwJXPVU3Lt32Fd\nyxao3++Lszefw2I6vLBp+4QYcwa7gZJ+XWCDDo00P87dYbD3dL67yT5pAFtXIrj7\n5SQsYwRWcF4gAlqyQt64lPSCquZ4P6af/wtashVVnkDhCL0FRWL17x6dFs0QHFMr\nRtl4HqzadHEJ1dg6R+VMZFF5\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-fbsvc@eventmanagement-fc36a.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=110429856440030502846

# Optional: Cloudinary (for image uploads)
CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
CLOUDINARY_API_KEY=your_cloudinary_api_key
CLOUDINARY_API_SECRET=your_cloudinary_api_secret

# Optional: Razorpay (for payments)
RAZORPAY_KEY_ID=your_razorpay_key_id
RAZORPAY_KEY_SECRET=your_razorpay_key_secret
RAZORPAY_WEBHOOK_SECRET=your_razorpay_webhook_secret

# Server Configuration
NODE_ENV=production
PORT=5000
```

### Frontend Environment Variables

```bash
VITE_API_URL=https://your-backend-url.vercel.app
```

## 🔄 Build Configuration

### Backend Build Process

The backend uses esbuild for production builds:

1. **Build Command**: `npm run build`
2. **Output**: `dist/build.js`
3. **Start Command**: `npm start`

### Frontend Build Process

The frontend uses Vite for production builds:

1. **Build Command**: `npm run build`
2. **Output**: `dist/`
3. **Framework**: Vite

## 🚀 Deployment Steps

### Quick Deployment (Separate Projects)

1. **Deploy Backend**:
   ```bash
   # Connect your GitHub repo to Vercel
   # Set Root Directory to: server
   # Add all environment variables
   # Deploy
   ```

2. **Deploy Frontend**:
   ```bash
   # Create new Vercel project
   # Set Root Directory to: web
   # Update vercel.json with backend URL
   # Add VITE_API_URL environment variable
   # Deploy
   ```

### Custom Domain Setup

1. **Backend Domain**:
   - Go to Project Settings → Domains
   - Add your custom domain (e.g., `api.yourdomain.com`)

2. **Frontend Domain**:
   - Add your main domain (e.g., `yourdomain.com`)
   - Update CORS settings in backend with new domain

## 🔧 Post-Deployment Configuration

1. **Update CORS Origins**:
   ```bash
   ALLOWED_ORIGINS=https://yourdomain.com,https://admin.yourdomain.com
   ```

2. **Update Client URLs**:
   ```bash
   CLIENT_EMAIL_VERIFICATION_URL=https://yourdomain.com/verify-email
   CLIENT_RESET_PASSWORD_URL=https://yourdomain.com/reset-password
   ```

3. **Test API Endpoints**:
   ```bash
   curl https://your-backend.vercel.app/api/health
   ```

## 🐛 Troubleshooting

### Common Issues

1. **Build Failures**:
   - Check Node.js version compatibility
   - Ensure all dependencies are in package.json
   - Check build logs in Vercel dashboard

2. **Environment Variables**:
   - Verify all required variables are set
   - Check variable names match exactly
   - Ensure Firebase private key has proper newlines

3. **CORS Issues**:
   - Update ALLOWED_ORIGINS with correct domains
   - Check frontend API URL configuration

4. **Database Connection**:
   - Verify MongoDB URI is correct
   - Check network access in MongoDB Atlas
   - Ensure database user has proper permissions

### Debugging Tips

1. **Check Logs**:
   - Vercel Dashboard → Functions → View Function Logs
   - Look for startup errors and runtime issues

2. **Test Locally**:
   ```bash
   # Backend
   cd server
   npm run build
   npm start
   
   # Frontend
   cd web
   npm run build
   npm run serve
   ```

## 📚 Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Node.js on Vercel](https://vercel.com/docs/concepts/functions/serverless-functions)
- [Vite on Vercel](https://vercel.com/guides/deploying-vite)
- [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)

## ✅ Deployment Checklist

- [ ] Backend deployed successfully
- [ ] Frontend deployed successfully
- [ ] Environment variables configured
- [ ] Database connection working
- [ ] API endpoints responding
- [ ] CORS configured correctly
- [ ] Custom domains set up (if needed)
- [ ] SSL certificates active
- [ ] Performance optimized

---

🎉 **Congratulations!** Your Festify application should now be live on Vercel!
