# weihnachtsbasar

A registration website for the Christmas bazaar of the
German School of Athens.

This project is split in two parts:
* The `flutter` directory contains
the frontend code, developed using [flutter](https://flutter.dev/).
* The `python` directory contains the backend code, implementing
a REST API using [flask](https://flask.palletsprojects.com/en/3.0.x/).

## Build and run

For all following commands, it is assumed that the working directory
is the repository root.

> **Warning** \
> The following commands configure the containers to use host
> networking.
> If different behavior is desired, they should be modified accordingly.

### Using `docker-compose`

```bash
$ docker-compose up -d --build
```

### Manually, using `docker`

1. Run web app:
    ```bash
    $ docker run --rm --net=host -it $(docker build -q flutter)
    ```

2. Run database service
    ```bash
    $ docker run --rm -v ./python:/usr/local/bin/app --net=host -it $(docker build -q python)
    ```

