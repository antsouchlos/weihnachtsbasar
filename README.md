# weihnachtsbasar



## Build and run

For all  following commands, it is assumed that the working  directory
is the repository root.

> **Warning** \
> The following commands configure the containers to use host
> networking.
> If different behavior is desired, they should be modified accordingly.


### Using `docker-compose`

```bash
$ docker-compose up -d
```

### Manually using `docker`

1. Run web app:
    ```bash
    $ docker run --rm --net=host -it $(docker build -q flutter)
    ```
   
2. Run database service
    ```bash
    $ docker run --rm -v ./python:/usr/local/bin/app --net=host -it $(docker build -q python)
    ```

