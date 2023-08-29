const path = require('path');
const nextEnv = require('next-env');
const dotenvLoad = require('dotenv-load');
const withCSS = require('@zeit/next-css');
const withOptimizedImages = require('next-optimized-images');
const withImages = require("next-images");

dotenvLoad();

const withNextEnv = nextEnv();

module.exports = withNextEnv(
  {
    basePath: process.env.BASE_PATH,
    publicRuntimeConfig: {
      REACT_APP_API_URL: process.env.REACT_APP_API_URL,
      REACT_APP_API_KEY: process.env.REACT_APP_API_KEY,
      REACT_APP_ONE_ACCOUNT_API_URL: process.env.REACT_APP_ONE_ACCOUNT_API_URL,
      REACT_APP_ONE_ACCOUNT_API_KEY: process.env.REACT_APP_ONE_ACCOUNT_API_KEY,
      REACT_APP_AMPLITUDE_API_KEY: process.env.REACT_APP_AMPLITUDE_API_KEY,
      REACT_APP_LOGROCKET_APP_ID: process.env.REACT_APP_LOGROCKET_APP_ID,
      REACT_APP_QUIZ_API_URL: process.env.REACT_APP_QUIZ_API_URL,
      REACT_APP_PRACTICE_PLUS_URL: process.env.REACT_APP_PRACTICE_PLUS_URL,
      REACT_APP_GOOGLE_ANALYTICS_ID: process.env.REACT_APP_GOOGLE_ANALYTICS_ID,
      ENABLE_SCHOOL_REQUEST: process.env.ENABLE_SCHOOL_REQUEST,
      REACT_APP_SCHOOL_ADMIN_URL: process.env.REACT_APP_SCHOOL_ADMIN_URL,
      REACT_APP_TEACHING_WEB_URL: process.env.REACT_APP_TEACHING_WEB_URL,
      REACT_APP_EBOOK_API_URL: process.env.REACT_APP_EBOOK_API_URL,
      REACT_APP_EBOOK_API_KEY: process.env.REACT_APP_EBOOK_API_KEY,
      REACT_APP_NO_SCHOOL_ID_URL: process.env.REACT_APP_NO_SCHOOL_ID_URL,
      REACT_APP_TEACHING_WEB_API_URL:
        process.env.REACT_APP_TEACHING_WEB_API_URL,
      REACT_APP_TEACHING_WEB_API_KEY:
        process.env.REACT_APP_TEACHING_WEB_API_KEY,
      ENABLE_TEACHER_COURSE_LEVEL: process.env.ENABLE_TEACHER_COURSE_LEVEL,
      ENABLE_TEACHING: process.env.ENABLE_TEACHING,
      ENABLE_AOL: process.env.ENABLE_AOL,
      CURRENT_CONSENT_VERSION: process.env.CURRENT_CONSENT_VERSION,
      GTM_CONTAINER_ID: process.env.GTM_CONTAINER_ID,
      ENABLE_TEACHER_ASSIGNMENT: process.env.ENABLE_TEACHER_ASSIGNMENT,
      ENABLE_CLASSROOM_TEACHER: process.env.ENABLE_CLASSROOM_TEACHER,
      ENABLE_EVALUATION: process.env.ENABLE_EVALUATION,
      BASE_PATH: process.env.BASE_PATH,
      ASSET_UPLOAD_MAX_TEACHER_MEDIA_UPLOAD_SIZE: process.env.ASSET_UPLOAD_MAX_TEACHER_MEDIA_UPLOAD_SIZE,
      ASSET_UPLOAD_ALLOW_TEACHER_MEDIA_FILE_FILE_TYPE: process.env.ASSET_UPLOAD_ALLOW_TEACHER_MEDIA_FILE_FILE_TYPE,
      REACT_APP_ONET_URL: process.env.REACT_APP_ONET_URL,
      ASSET_USER_AVATAR_MEDIA_UPLOAD_SIZE: process.env.ASSET_USER_AVATAR_MEDIA_UPLOAD_SIZE
    },
    async redirects() {
      return [
        {
          source: '/',
          destination: '/course',
          permanent: true
        },
        {
          source: '/my-media/myCourse',
          destination: '/my-media?tab=my-course',
          permanent: true
        },
        {
          source: '/my-media/mySpecialCourse',
          destination: '/my-media?tab=my-special-course',
          permanent: true
        }
      ];
    },
    webpack: (config) => {
      config.plugins = config.plugins || [];

      config.resolve.modules.push(path.resolve('./src'));

      config.module.rules.push({
        test: /\.svg$/,
        use: [
          {
            loader: '@svgr/webpack',
            options: { svgoConfig: { plugins: [{ removeViewBox: false }] } }
          }
        ]
      });

      config.module.rules.push({
        test: /\.(eot|woff|woff2|ttf|svg|png|jpg|gif)$/,
        use: {
          loader: 'url-loader',
          options: {
            limit: 100000,
            name: '[name].[ext]'
          }
        }
      });

      return config;
    }
  },
  withCSS({ cssModules: false }),
  withOptimizedImages(),

module.exports = withImages({
    images: {
        domains: ['assets.aol-pro.aksorn.com']
    },
    webpack(config, options) {
        return config;
    }
})

);
