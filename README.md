# Clickhouse + Tabix docker compose on Elestio

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/docker-compose-clickhouse"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Example application and CI/CD pipeline showing how to deploy a clickhouse + tabix docker-compose to elestio.


## CI/CD on Elestio

Fork this repository to create your own copy that you can modify and use in a CI/CD pipeline

When configuring your pipeline, pay attention to ports and reverse proxy. If you try to deploy multiple pipelines to the same CICD target ports will be already in use. To avoid that if you want to deploy a second instance of this app to the same target you will have to change the ports in the docker-compose.yml and also in the reverse proxy configuration.

## Once deployed

You can connect to your instance with the Web UI:

    Host: https://[CI_CD_DOMAIN]:28125/
    Login: root
    Password: [SOFTWARE_PASSWORD]

HTTPS API is available on port: 18123 with same credentials

    https://[CI_CD_DOMAIN]:18123/
    HTTPS URI: clickhouse://root:[SOFTWARE_PASSWORD]@[CI_CD_DOMAIN]:18123/default?protocol=https

Native clickhouse protocol is available on port: 29000 with same credentials

    CH Native host: [CI_CD_DOMAIN]
    CH Native port: 29000
    Native URI: clickhouse://root:[SOFTWARE_PASSWORD]@[CI_CD_DOMAIN]:29000/default?protocol=native


Your ClickHouse instance can also be used with MySQL & Postgres protocol:

    MySQL protocol:
    Host: [CI_CD_DOMAIN]
    Port: 24306
    Login: root
    Password: [SOFTWARE_PASSWORD]
    URI: mysql://root:[SOFTWARE_PASSWORD]@[CI_CD_DOMAIN]:24306/default

    Postgres protocol:
    Host: [CI_CD_DOMAIN]
    Port: 25432
    Login: root
    Password: [SOFTWARE_PASSWORD]
    URI: postgres://root:[SOFTWARE_PASSWORD]@[CI_CD_DOMAIN]:25432/default


ClickHouse documentation: https://clickhouse.tech/docs/en/

Tabix Documentation: https://tabix.io/doc/

Tabix Tips: https://tabix.io/doc/Tips/




# Sample usage with Node.js

    const ClickHouse = require('@apla/clickhouse')
    const ch = new ClickHouse({
        "host": "[CI_CD_DOMAIN]",
        "protocol": "https:",
        "port": 18123,
        "user": "root",
        "password": "[SOFTWARE_PASSWORD]"
    });

    (async () => {
            var result = await ch.querying("SELECT 1");
            console.log(result);
    })();

