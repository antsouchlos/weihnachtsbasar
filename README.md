# weihnachtsbasar

## Build and run

For both of the following commands, it is assumed that the working
directory is the repository root.

> **Warning** \
> The following commands use host networking.
> If different behavior is desired, they should be modified accordingly.

### Website

```bash
$ docker run --rm --net=host -it $(docker build -q flutter)
```

### Database service

```bash
$docker run --rm -v ./python:/usr/local/bin/app --net=host -it $(docker build -q python)
```

