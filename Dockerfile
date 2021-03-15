# Use Alpine Base Image: this leads to immediate exit in runtime.
# FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine AS base
# FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS build
FROM debian


EXPOSE 80
EXPOSE 8888

#only for Alpine:
#RUN cd home && \ 
#    apk add git && \  
#    git clone https://github.com/terranigma-solutions/MLAPI.Relay.git

# only for Debian:    
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y git && \
    cd home && \
    wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 &&\
    git clone https://github.com/terranigma-solutions/MLAPI.Relay.git
    
RUN cd home/MLAPI.Relay/MLAPI.Relay && \
    cp -a ../MLAPI.Relay.Transports/Libraries/Unity/. Libs/ && \
    dotnet build -r linux-x64  && \
    cp -a Libs/. bin/Debug/netcoreapp5.0/ 

    
CMD cd home/MLAPI.Relay/MLAPI.Relay && \
    dotnet run . 