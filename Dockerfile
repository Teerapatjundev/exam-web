ARG WEB_DIR=/frontend/teacher-academy-web
ARG SDK_DIR=/sdk

FROM node:12-alpine AS installed
ARG WEB_DIR

ARG REACT_APP_API_URL
ARG REACT_APP_API_KEY
ARG REACT_APP_ONE_ACCOUNT_API_URL
ARG REACT_APP_ONE_ACCOUNT_API_KEY
ARG REACT_APP_EBOOK_API_URL
ARG REACT_APP_EBOOK_API_KEY
ARG REACT_APP_TEACHING_WEB_API_URL
ARG REACT_APP_TEACHING_WEB_API_KEY
ARG REACT_APP_QUIZ_API_URL
ARG REACT_APP_PRACTICE_PLUS_URL
ARG REACT_APP_SCHOOL_ADMIN_URL
ARG REACT_APP_TEACHING_WEB_URL
ARG GTM_CONTAINER_ID
ARG ENABLE_SCHOOL_REQUEST
ARG ENABLE_TEACHER_COURSE_LEVEL
ARG BASE_PATH
ARG ENABLE_TEACHING
ARG ENABLE_AOL
ARG ENABLE_TEACHER_ASSIGNMENT
ARG ENABLE_CLASSROOM_TEACHER
ARG ENABLE_EVALUATION
ARG ASSET_UPLOAD_MAX_TEACHER_MEDIA_UPLOAD_SIZE
ARG ASSET_UPLOAD_ALLOW_TEACHER_MEDIA_FILE_FILE_TYPE
ARG REACT_APP_AMPLITUDE_API_KEY
ARG ASSET_USER_AVATAR_MEDIA_UPLOAD_SIZE



ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV REACT_APP_API_KEY=$REACT_APP_API_KEY
ENV REACT_APP_ONE_ACCOUNT_API_URL=$REACT_APP_ONE_ACCOUNT_API_URL
ENV REACT_APP_ONE_ACCOUNT_API_KEY=$REACT_APP_ONE_ACCOUNT_API_KEY
ENV REACT_APP_EBOOK_API_URL=$REACT_APP_EBOOK_API_URL
ENV REACT_APP_EBOOK_API_KEY=$REACT_APP_EBOOK_API_KEY
ENV REACT_APP_TEACHING_WEB_API_URL=$REACT_APP_TEACHING_WEB_API_URL
ENV REACT_APP_TEACHING_WEB_API_KEY=$REACT_APP_TEACHING_WEB_API_KEY
ENV REACT_APP_QUIZ_API_URL=$REACT_APP_QUIZ_API_URL
ENV REACT_APP_PRACTICE_PLUS_URL=$REACT_APP_PRACTICE_PLUS_URL
ENV REACT_APP_SCHOOL_ADMIN_URL=$REACT_APP_SCHOOL_ADMIN_URL
ENV REACT_APP_TEACHING_WEB_URL=$REACT_APP_TEACHING_WEB_URL
ENV GTM_CONTAINER_ID=$GTM_CONTAINER_ID
ENV ENABLE_SCHOOL_REQUEST=$ENABLE_SCHOOL_REQUEST
ENV ENABLE_TEACHER_COURSE_LEVEL=$ENABLE_TEACHER_COURSE_LEVEL
ENV BASE_PATH=$BASE_PATH
ENV ENABLE_TEACHING=$ENABLE_TEACHING
ENV ENABLE_AOL=$ENABLE_AOL
ENV ENABLE_TEACHER_ASSIGNMENT=$ENABLE_TEACHER_ASSIGNMENT
ENV ENABLE_CLASSROOM_TEACHER=$ENABLE_CLASSROOM_TEACHER
ENV ENABLE_EVALUATION=$ENABLE_EVALUATION
ENV ASSET_UPLOAD_MAX_TEACHER_MEDIA_UPLOAD_SIZE=$ASSET_UPLOAD_MAX_TEACHER_MEDIA_UPLOAD_SIZE
ENV ASSET_UPLOAD_ALLOW_TEACHER_MEDIA_FILE_FILE_TYPE=$ASSET_UPLOAD_ALLOW_TEACHER_MEDIA_FILE_FILE_TYPE
ENV REACT_APP_AMPLITUDE_API_KEY=$REACT_APP_AMPLITUDE_API_KEY
ENV ASSET_USER_AVATAR_MEDIA_UPLOAD_SIZE=$ASSET_USER_AVATAR_MEDIA_UPLOAD_SIZE

ENV CURRENT_CONSENT_VERSION='3'

WORKDIR /home/node/app/$WEB_DIR
COPY $WEB_DIR/package.json yarn.lock ./
RUN yarn install --pure-lockfile

FROM installed AS build
ARG SDK_DIR
WORKDIR /home/node/app/$SDK_DIR
COPY $SDK_DIR ./


ARG WEB_DIR
WORKDIR /home/node/app/$WEB_DIR
COPY \
  $WEB_DIR/.babelrc \
  $WEB_DIR/next-env.d.ts \
  $WEB_DIR/next.config.js \
  $WEB_DIR/postcss.config.js \
  $WEB_DIR/tailwind.config.js \
  $WEB_DIR/tsconfig.json \
  ./
COPY $WEB_DIR/pages pages
COPY $WEB_DIR/public public
COPY $WEB_DIR/src src
RUN yarn build



FROM installed AS production
ARG WEB_DIR
WORKDIR /home/node/app/$WEB_DIR
RUN yarn install --pure-lockfile --offline --force --production \
  && yarn cache clean --all
COPY --from=build /home/node/app/$WEB_DIR/.next .next
COPY $WEB_DIR/public public
COPY $WEB_DIR/next.config.js next.config.js
COPY $WEB_DIR/index.js .
CMD yarn start
