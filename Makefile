NAME=bambora/devbamboracom
VERSION=latest

# Can specify arbitrary docker arguments on the command line.  Ex:
# make DOCKERBUILDARGS=--no-cache build
# will pass --no-cache to the docker build command
DOCKERBUILDARGS?=

# We need to list our targets using .PHONY so make knows they don't rely on an actual file.
# (E.g. if we don't list "build" under .PHONY, then if make sees a file/folder called "build",
# it will decide that it doesn't need to be rebuilt. It's confusing.)
.PHONY: build run static clean

# Build docker image which runs "rake dev" by default, see Dockerfile and Rakefile.
build:
	docker build $(DOCKERBUILDARGS) -t $(NAME):$(VERSION) --rm .

# Run the live updating development server
# (More specifically, run "rake dev" in the docker image, see Rakefile for details)
run: build
	docker run --rm -v $(shell pwd):/usr/src/app/ -p 4567:4567 -w /usr/src/app $(NAME):$(VERSION) development_server

# Build the static site
# (More specifically, run "rake static" in the docker image, see Rakefile for details)
static: build
	mkdir -p build
	docker run -e ONBOARDING_HOST=test-onboardingapi -v `pwd`/build:/usr/src/app/build bambora/devbamboracom static

clean:
	# preceding dash is to prevent the makefile from erroring if the file/image doesn't exist
	# see: https://superuser.com/a/523510/150897
	-docker rmi $(NAME):$(VERSION)

	# Removing the "build" directory created by "static" target:
	#
	#     sudo rm -rf build
	#
	# ...The files within "build" directory are owned by root, because they are generated from within a
	# docker container.
	# It's kind of a weird situation which could probably be fixed somehow -- maybe the "static" target
	# could specify that its commands be run as a user other than root within the container?.. :shrug:
