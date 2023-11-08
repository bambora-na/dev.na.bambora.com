FROM ruby:2.6
EXPOSE 4567

RUN apt-get update && apt-get install -y git
RUN apt-get install -y nodejs --force-yes

ARG BRANCH=""
ARG REVISION=""
ARG BUILD_TIME=""
ARG BUILD_NUMBER=""
ARG APP_HOME=""

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
COPY version.json /usr/src/app/

RUN echo "Revision: ${APP_HOME}"
RUN echo "branch: ${BRANCH}"
RUN echo "Revision: ${REVISION}"
RUN echo "Build time ${BUILD_TIME}"
RUN echo "Build Number${BUILD_NUMBER}"
RUN ls ${APP_HOME}/*

#RUN ls /usr/src/app/

#RUN ls /usr/src/app/*
#RUN cat /usr/src/app/version.json

#RUN echo "Branch in dockerfile: "
#RUN echo $BRANCH
RUN sed -i 's|BRANCH|'${BRANCH}'|g' /usr/src/app/version.json
RUN sed -i 's|REVISION|'${REVISION}'|g' /usr/src/app//version.json
RUN sed -i 's|BUILD_TIME|'${BUILD_TIME}'|g' /usr/src/app/version.json
RUN sed -i 's|BUILD_NUMBER|'${BUILD_NUMBER}'|g' /usr/src/app/version.json

RUN cp /usr/src/app/version.json ${APP_HOME}/build/


#Specify bundler version to prevent Windows build error
ENV BUNDLER_VERSION='1.17.3'
COPY Rakefile /usr/src/app/
WORKDIR /usr/src/app
RUN gem install bundler -v 2.3.26
RUN bundle install

#RUN echo version.json
COPY . /usr/src/app
#RUN ls /usr/src/app/*
#RUN cat /usr/src/app/version.json


#RUN sed -i 's|BRANCH|$BRANCH|g' version.json


#COPY version_1.json /usr/src/app/

ENTRYPOINT ["rake"]
CMD ["dev"]


# 1) Build: docker build -t devbamboracom .
# 2) Run:   docker run -v `pwd`/source:/usr/src/app/source -w /usr/src/app -p 4567:4567 devbamboracom