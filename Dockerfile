# Use alpine:3.19 as the base image
FROM alpine:3.19

# Set the Reviewdog version as an environment variable
ENV REVIEWDOG_VERSION=v0.15.0

# Set the shell for the subsequent RUN instructions
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# Install necessary packages and tools
RUN apk --no-cache add git ruby ruby-dev ruby-etc build-base

# Download and install Reviewdog
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

# Install the theme-check Ruby gem
RUN gem install theme-check

# Copy the entrypoint.sh script from the local filesystem to the image
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint for the container
ENTRYPOINT ["/entrypoint.sh"]
