# container-breakouts
Testing/collecting some container breakouts

## Buildspec
Silly buildspec for getting a reverse shell in a CI's build container.

## Filehandle
Pass a file handle via a unix socket. Run server where you have access to something you want to get access to in a container. Run worker where you have elevated privs (e.g. root) to gain access to server's resources with privs.
