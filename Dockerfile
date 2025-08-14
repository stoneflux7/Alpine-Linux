FROM alpine:latest

# Install openssh, bash, shadow (for user management), and curl
RUN apk update && apk add --no-cache openssh bash shadow curl

# Set root password (optional, you can skip this if you only want stoneflux user)
RUN echo "root:stoneflux" | chpasswd

# Create user stoneflux and set password
RUN adduser -D stoneflux && echo "stoneflux:stoneflux" | chpasswd

# Allow stoneflux user to use bash shell
RUN chsh -s /bin/bash stoneflux

# Setup SSH server configuration (allow password login)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create SSH host keys
RUN ssh-keygen -A

# Expose SSH port
EXPOSE 22

# Start SSH daemon and keep container running
CMD ["/usr/sbin/sshd", "-D"]

