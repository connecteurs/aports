# Alpine Ports

Test locally if a package can build using:

```sh
# Configuration
PACKAGE_NAME=cyrus-sasl
REPOSITORY=main

# Run the build
docker run --rm -P -it \
  -v$(pwd)/${REPOSITORY}:/home/builder/aports \
  --workdir /home/builder/aports/${PACKAGE_NAME} \
  --name docker-abuild alpinelinux/docker-abuild -r
```

## Packages

### [cyrus-imapd](./main/cyrus-imapd)

Cyrus IMAP is an email, contacts and calendar server.

This package was not available in the official Alpine Linux repository, so we created it to allow the installation of the `cyrus-imapd` package easily.

### [cyrus-sasl](./main/cyrus-sasl)

Cyrus SASL is an implementation of the Simple Authentication and Security Layer framework.

We edit the package to include `linux-pam-dev` as a build dependency.

### [pam-pgsql](./main/pam-pgsql)

PAM module for authenticating with PostgreSQL.

This package includes a custom version of the `pam-pgsql` package that allows the use of multiple passwords for the same user.

## License

This program is free software and is distributed under [AGPLv3+ License](./LICENSE).
