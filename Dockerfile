# Maintainers: Nicola Luraghi
# GitRepo: https://github.com/wildstrategies/docker-mssql-server
# Based on work by Microsoft Corporation https://github.com/Microsoft/mssql-docker

# Base OS layer: Latest Ubuntu LTS
FROM ubuntu:18.04

# Install prerequistes since it is needed to get repo config for SQL server
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq curl apt-transport-https gnupg2 && \
    # Get official Microsoft repository configuration
    curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl -s https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    apt-get update && \
    # Install SQL Server from apt
    apt-get install -yq mssql-server mssql-server-fts && \
    # Cleanup the Dockerfile
    apt-get clean && \
    rm -rf /var/lib/apt/lists

EXPOSE 1433
ENV ACCEPT_EULA=
ENV SA_PASSWORD=
ENV MSSQL_PID=Express

VOLUME [ "/var/opt/mssql/data", "/var/backups" ]

# Run SQL Server process
CMD /opt/mssql/bin/sqlservr