<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Clickhouse, verified and packaged by Elestio

[Clickhouse](https://github.com/ClickHouse/ClickHouse/) is an open-source column-oriented database management system that allows generating analytical data reports in real-time. 

<img src="https://raw.githubusercontent.com/elestio-examples/clickhouse/main/screenshot.png" alt="Clickhouse" width="800">

[![deploy](https://github.com/elestio-examples/clickhouse/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/clickhouse)

Deploy a <a target="_blank" href="https://elest.io/open-source/clickhouse">fully managed Clickhouse</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/clickhouse.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./pgdata
    chown -R 1000:1000 ./pgdata

Run the project with the following command

    docker-compose up -d
    ./scripts/postInstall.sh

You can access the Web UI at: `http://your-domain:28124`

## Docker-compose

Here are some example snippets to help you get started creating a container.

        version: "3.3"
        services:

        clickhouse:
            image: elestio4test/clickhouse-server:${SOFTWARE_VERSION_TAG}
            restart: unless-stopped
            volumes:
            - ./data:/var/lib/clickhouse
            - ./config/clickhouse-user-config.xml:/etc/clickhouse-server/users.d/logging.xml:ro
            - ./config/clickhouse-options.xml:/etc/clickhouse-server/config.d/options.xml:ro
            ports:
            - 172.17.0.1:28123:8123
            - 172.17.0.1:9000:9000
            - 172.17.0.1:3306:3306
            - 172.17.0.1:5432:5432
            environment:
            - CLICKHOUSE_USER=root
            - CLICKHOUSE_PASSWORD=${SOFTWARE_PASSWORD}
            - CLICKHOUSE_DB=default
            - CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1
            ulimits:
            nofile:
                soft: 262144
                hard: 262144

        tabix:
                image: spoonest/clickhouse-tabix-web-client
                ports:
                    - 172.17.0.1:28124:80
                depends_on:
                    - clickhouse
                restart: unless-stopped
                environment:
                    - CH_NAME=clickhouse
                    - CH_HOST=https://${DOMAIN}:18123
                    - CH_LOGIN=root
                    - CH_PASSWORD=${SOFTWARE_PASSWORD}



### Environment variables

|         Variable           |      Value (example)       |
| :------------------------: | :------------------------: |
|    SOFTWARE_VERSION_TAG    |         latest             |
|    HOST_DOMAIN             |         DOMAIN             |
|    SOFTWARE_PASSWORD       |         YOUR_PASSSWORD     |

# Maintenance

## Logging

The Elestio Clickhouse Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://clickhouse.com/docs/en/intro">Clickhouse documentation</a>

- <a target="_blank" href="https://github.com/ClickHouse/ClickHouse/">Clickhouse Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/clickhouse">Elestio/Clickhouse Github repository</a>
