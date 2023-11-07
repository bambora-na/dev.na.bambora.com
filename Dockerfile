FROM ruby:2.6
EXPOSE 4567

RUN apt-get update && apt-get install -y git
RUN apt-get install -y nodejs --force-yes

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
#Specify bundler version to prevent Windows build error
ENV BUNDLER_VERSION='1.17.3'
COPY Rakefile /usr/src/app/
WORKDIR /usr/src/app
RUN gem install bundler -v 2.3.26
RUN bundle install

#RUN echo version.json
COPY . /usr/src/app

#RUN sed -i 's|BRANCH|$BRANCH|g' version.json
RUN echo "Branch in dockerfile: $BRANCH"

#COPY version_1.json /usr/src/app/

ENTRYPOINT ["rake"]
CMD ["dev"]

RUN sed -i 's|BRANCH|$BRANCH|g' version.json

# 1) Build: docker build -t devbamboracom .
# 2) Run:   docker run -v `pwd`/source:/usr/src/app/source -w /usr/src/app -p 4567:4567 devbamboracom
