# mssql-agent-fts-ha-tools
# Maintainers: Nicola Luraghi
# GitRepo: https://github.com/wildstrategies/docker-mssql-server
# Based on work by Microsoft Corporation https://github.com/Microsoft/mssql-docker

# Base OS layer: Latest Ubuntu LTS
FROM ubuntu:16.04

# Install prerequistes since it is needed to get repo config for SQL server
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq curl apt-transport-https && \
    # Get official Microsoft repository configuration
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    apt-get update && \
    # Install SQL Server from apt
    apt-get install -y mssql-server && \
    # Install optional packages
    # apt-get install -y mssql-server-ha && \
    apt-get install -y mssql-server-fts && \
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