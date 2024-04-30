# Alpine Ports

Test locally if a package can build using:

```sh
# configuration
PACKAGE_NAME=pam-pgsql
REPOSITORY=main

# run the build
docker run --rm -P -it \
  -v$(pwd)/${REPOSITORY}:/home/builder/aports \
  --workdir /home/builder/aports/${PACKAGE_NAME} \
  --name docker-abuild alpinelinux/docker-abuild -r
```

## License

This program is free software and is distributed under [AGPLv3+ License](./LICENSE).
