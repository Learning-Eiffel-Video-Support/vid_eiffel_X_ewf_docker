FROM ubuntu:18.04

# Install wget
RUN apt-get update
RUN apt-get install -y wget

# Add 32-bit architecture
RUN dpkg --add-architecture i386
RUN apt-get update

# Install Wine
RUN apt-get update
RUN apt-get install -f -y wine-stable

# Turn off Fixme warnings
ENV WINEDEBUG=fixme-all

# Setup Wine prefix
ENV WINEARCH=win64
RUN winecfg

# Copy in EWF web-app/server and configuration
COPY hello.exe .
COPY ewf.ini .

# Run application
ENTRYPOINT ["wine"]
CMD ["hello.exe"]

# BUILD: docker build --tag:ewfdockerhello:1.0 .
# RUN: docker run --publish 9999:9999 --detach 