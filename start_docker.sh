# start docker in fedora with selinux enabled

setenforce 0
systemctl status --no-pager docker
if [ $? -eq 3 ]
then
    systemctl start docker
    if [ $? -eq 1 ]
    then
        echo "ERROR: Unable to start docker $?"
        exit
    fi
fi

systemctl start docker
docker-compose up
setenforce 1
