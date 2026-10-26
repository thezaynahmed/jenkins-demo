# Installing Jenkins as Docker container
# Use official Jenkins image with Java 21
FROM jenkins/jenkins:latest-jdk21

# Switch to root to install packages needed for Lab 2, Docker & Kubernetes
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    python3-pytest \
    python3-flask \
    zip \
    curl \
    ca-certificates \
    && curl -fsSL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && ARCH=$(uname -m) \
    && curl -fsSL "https://download.docker.com/linux/static/stable/${ARCH}/docker-27.5.1.tgz" -o /tmp/docker.tgz \
    && tar -xzf /tmp/docker.tgz -C /tmp \
    && mv /tmp/docker/docker /usr/local/bin/docker \
    && chmod +x /usr/local/bin/docker \
    && rm -rf /tmp/docker* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Switch back to Jenkins user
USER jenkins

# Set Jenkins home directory
ENV JENKINS_HOME=/var/jenkins_home

# Jenkins web interface
EXPOSE 8000

# Jenkins inbound agent port
EXPOSE 50000
