# Use Alpine Linux as base image
FROM alpine:latest

# Install necessary packages
RUN apk update && apk add --no-cache bash curl openssh shadow

# Create user 'stoneflux' and set password
RUN useradd -m stoneflux && echo "stoneflux:stoneflux" | chpasswd

# Allow stoneflux to use bash
RUN chsh -s /bin/bash stoneflux

# Set working directory
WORKDIR /home/stoneflux

# Switch to user
USER stoneflux

# Launch bash as default
CMD ["/bin/bash"]
