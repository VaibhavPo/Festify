# Vercel Deployment Guide for Festify

## Prerequisites
1. Vercel account (free tier available)
2. MongoDB Atlas account (free tier available)
3. All environment variables ready

## Step 1: Prepare Your Repository

### 1.1 Update Vite Config for Production
Update `web/vite.config.ts` to build correctly for Vercel:

```typescript
export default defineConfig({
  // ... existing config
  build: {
    outDir: "dist", // Changed from "../dist/web"
    emptyOutDir: true,
    reportCompressedSize: true,
    commonjsOptions: {
      transformMixedEsModules: true,
    },
  },
});
```

### 1.2 Update API Base URL
In your frontend code, update the API base URL to use environment variables:

```javascript
// In your API configuration
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000';
```

## Step 2: Deploy Backend (Server)

### 2.1 Deploy Server to Vercel
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your Git repository
4. **Important**: Set the root directory to `server`
5. Framework Preset: "Other"
6. Build Command: `npm run build`
7. Output Directory: `dist`

### 2.2 Set Environment Variables for Backend
In Vercel dashboard, go to your server project → Settings → Environment Variables:

```
NODE_ENV=production
MONGODB_URI=your_mongodb_atlas_connection_string
JWT_SECRET=your_jwt_secret_key
JWT_REFRESH_SECRET=your_jwt_refresh_secret_key
MAILING_SERVICE_HOST=smtp.gmail.com
MAILING_SERVICE_PORT=587
MAILING_SERVICE_USER=your_email@gmail.com
MAILING_SERVICE_USER_PASSWORD=your_app_password
CLIENT_EMAIL_VERIFICATION_URL=https://your-frontend-url.vercel.app/u/verify-email
CLIENT_RESET_PASSWORD_URL=https://your-frontend-url.vercel.app/u/reset-password
RAZORPAY_KEY_ID=your_razorpay_key_id
RAZORPAY_KEY_SECRET=your_razorpay_key_secret
FIREBASE_SERVICE_ACCOUNT_KEY=your_base64_encoded_firebase_key
```

### 2.3 Note Your Backend URL
After deployment, note your backend URL (e.g., `https://festify-backend.vercel.app`)

## Step 3: Deploy Frontend (Web)

### 3.1 Deploy Web to Vercel
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your Git repository
4. **Important**: Set the root directory to `web`
5. Framework Preset: "Vite"
6. Build Command: `npm run build`
7. Output Directory: `dist`

### 3.2 Set Environment Variables for Frontend
In Vercel dashboard, go to your web project → Settings → Environment Variables:

```
VITE_API_URL=https://your-backend-url.vercel.app
VITE_FIREBASE_API_KEY=your_firebase_api_key
VITE_FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your_project_id
VITE_FIREBASE_STORAGE_BUCKET=your_project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
VITE_FIREBASE_APP_ID=your_app_id
VITE_FIREBASE_MEASUREMENT_ID=your_measurement_id
VITE_CLIENT_EMAIL_VERIFICATION_URL=https://your-frontend-url.vercel.app/u/verify-email
VITE_CLIENT_RESET_PASSWORD_URL=https://your-frontend-url.vercel.app/u/reset-password
```

## Step 4: Update CORS Settings

Update your server's CORS configuration to allow your frontend domain:

```javascript
// In server/index.js
const corsOptions = {
  origin: [
    'http://localhost:3000',
    'https://your-frontend-url.vercel.app'
  ],
  credentials: true
};
```

## Step 5: Database Setup

1. Create a MongoDB Atlas cluster
2. Get your connection string
3. Add it to your backend environment variables
4. Update your database connection in `server/database.js` if needed

## Step 6: Test Your Deployment

1. Visit your frontend URL
2. Test user registration/login
3. Test admin panel access
4. Test payment verification features

## Troubleshooting

### Common Issues:

1. **Build Failures**: Check that all dependencies are in `package.json`
2. **CORS Errors**: Update CORS settings to include your frontend domain
3. **Database Connection**: Ensure MongoDB Atlas allows connections from Vercel
4. **Environment Variables**: Double-check all variables are set correctly

### Useful Commands:

```bash
# Test build locally
cd web && npm run build
cd server && npm run build

# Check environment variables
vercel env ls
```

## Alternative: Single Project Deployment

If you prefer to deploy both frontend and backend as a single Vercel project:

1. Use the root `vercel.json` configuration
2. Set root directory to project root
3. Configure build commands for both frontend and backend
4. Set up proper routing in `vercel.json`

## Support

- [Vercel Documentation](https://vercel.com/docs)
- [MongoDB Atlas Setup](https://docs.atlas.mongodb.com/getting-started/)
- [Vite Deployment Guide](https://vitejs.dev/guide/static-deploy.html)
