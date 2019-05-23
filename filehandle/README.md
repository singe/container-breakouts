A method for passing a file descriptor from outside a container to inside. Can be used to chroot as root inside the container and access the FD located outside the container.

It passes the file handle via a unix socket. Run the server where you have access to something you want to get access to in a container. Run worker where you have elevated privs (e.g. root) to gain access to server's resources with privs.

Original idea from https://kitctf.de/writeups/32c3ctf/docker 
