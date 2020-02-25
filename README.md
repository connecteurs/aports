# Alpine Ports

Test locally if a package can build using:

```sh
PACKAGE_NAME=cyrus-sasl
docker run --rm -P -it \
  -v$(pwd):/home/builder/aports \
  --workdir /home/builder/aports/${PACKAGE_NAME} \
  --name docker-abuild alpinelinux/docker-abuild -r
```
