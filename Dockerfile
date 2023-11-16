FROM ruby:2.6
EXPOSE 4567

RUN apt-get update && apt-get install -y git
RUN apt-get install -y nodejs --force-yes

# Init variables 
ARG BRANCH=""
ARG REVISION=""
ARG BUILD_TIME=""
ARG BUILD_NUMBER=""
ARG APP_HOME=""

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
COPY version.json /usr/src/app/
#Specify bundler version to prevent Windows build error
ENV BUNDLER_VERSION='1.17.3'
COPY Rakefile /usr/src/app/
WORKDIR /usr/src/app
RUN gem install bundler -v 2.3.26
RUN bundle install

# Set values read from command line arguments 
RUN sed -i 's|BRANCH|'${BRANCH}'|g' /usr/src/app/source/version.json
RUN sed -i 's|REVISION|'${REVISION}'|g' /usr/src/app/source/version.json
RUN sed -i 's|BUILD_TIME|'${BUILD_TIME}'|g' /usr/src/app/source/version.json
RUN sed -i 's|BUILD_NUMBER|'${BUILD_NUMBER}'|g' /usr/src/app/source/version.json

COPY . /usr/src/app

ENTRYPOINT ["rake"]
CMD ["dev"]

# 1) Build: docker build -t devbamboracom .
# 2) Run:   docker run -v `pwd`/source:/usr/src/app/source -w /usr/src/app -p 4567:4567 devbamboracom
