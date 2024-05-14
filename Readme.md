# MikroTik RouterOS Docker Container

This is a Dockerized version of MikroTik RouterOS.

## Prerequisites

Ensure you have Docker installed on your system. Additionally, make sure the following ports are available:
- Port 2222: SSH access for secure command-line management.
- Port 81: Web interface access for graphical configuration.
- Port 8728: MikroTik API service for external application communication.
- Port 8291: Winbox access for graphical configuration utility.

## Installation

1. **Clone the repository to your local machine:**
    ```bash
    $ git clone https://github.com/kbmakwa/MikroTik-RouterOS-Docker.git
    ```
    This will clone the repository containing the Docker setup files to your local machine.

2. **Change into the cloned directory:**
    ```bash
    $ cd MikroTik-RouterOS-Docker
    ```

3. **Change into the mikrotik-docker directory:**
    ```bash
    $ cd mikrotik-docker
    ```

4. **Build the Docker container using the following command:**
    ```bash
    $ docker build -t mikrotik .
    ```
   This will create a Docker image named mikrotik using the Dockerfile in the current directory.

5. **Once the image is built, you can start a container by running the following command:**
    ```bash
    $ sudo docker-compose up -d
    ```
   This will start a new Docker container running MikroTik RouterOS with the above ports mapped to the host system. The `--cap-add=NET_ADMIN` option is required to grant the container permission to modify the network stack.

6. **You can connect to the MikroTik command line by using the command:**
    ```bash
    $ ssh admin@0.0.0.0 -p 2222
    ```
   There is no password.

7. **You can also access the web interface from [http://0.0.0.0:81](http://0.0.0.0:81).**

## Configuration

Before starting the container, ensure that the listed ports are not in use or modify them in the docker-compose.yml file. To install the container, decompress the provided file, build the Docker image with the given command, and start a new container using the `sudo docker-compose up -d` command. The provided Makefile shows the configuration details including specified ports, device permissions, and restart options. Connection to the MikroTik command line and web platform is available.

