# SqlServer docker image with FTS

A SqlServer for linux docker image based on `Ubuntu 16.04` with `FullTextSearch` support.

Please set those environment variables to run the container:

```
ENV ACCEPT_EULA=
ENV SA_PASSWORD=
```

The default edition is `Express`, if you want to change the edition please set set following environment variable

```
ENV MSSQL_PID=
```

The port used by the server is `1433`  
To persists storage please map the following volumes:

```
/var/opt/mssql/data
/var/backups
```