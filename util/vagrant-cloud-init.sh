#!/bin/bash
# Check to see if we have done this already
if [ -f /.vagrant_build_done ]; then
    echo "Found, not running."
    exit
fi

# Make the box think it hasn't init-ed yet
rm -rf /var/lib/cloud/instance/*
rm -rf /var/lib/cloud/seed/nocloud-net/user-data

# Seed our own init scripts
cat << 'END_OF_FILE_CONTENTS' > /var/lib/cloud/seed/nocloud-net/user-data
users:
  - name: cloud-user
    ssh-authorized-keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwozn8dBYadFnL3Ww3k/1j5pDOMSYi2KbPIhX80ZXtMRcOna5gnLeWSbVAzYLPxpEmjIct/RQVxqrfGH+cU4rjWiAV9HsVntKOq3EIjPZjqOSEZrBak+YXiTExG82nHcMY/KPj1PeShQ/fSDmtLgGyY6oAHVuh13gzJgYYWv3B1zmejZAToXgi1XFuKGnAHdehKcfl7FsTLGveRu8j7JpnQw2enZ9ZbznT3ZosdbLEvjl1CYIoSz4guYcgrzew6CQULWnncP3jTElB1CSJSZlPr7dNF4XYdPvw1RKRkeknCACTuMvrvNVzUmxoSCVVAdCL7eZRi3OVBHgIoy7Zr5QCQ== root@hp-dl580g5-01.rhts.eng.bos.redhat.com
      - ssh-dss AAAAB3NzaC1kc3MAAACBAMNRyqehhvQ9BR0WnyNxu74uyK3F8nyOaQ2ah8j5aX5TC/hlsSATxLCIcT9UicnwvJi0kWL4acDQ0lFEuHtolxGJmRYiVxd7hHwlXuKLHjVbjTU4JURShOkFNuniErMZjFYUpSZrE2tIUkFySgB7zwnuQJEps67cW1lccBseoAAJAAAAFQDADzwRlUXfkk0Ae2GtuZYanmE25wAAAIBB9TxziLrlU7/G67xt2heYpojW7txPItfBPsr+MRZp8pzQqh9ogZcJ2/cyO7dZL1EyigDXL8AlebWO/rOkGIcyIeVjQDPsd3mWCW/lUeUacH87tUKn2cm9lOk+eeNC/Rxg6y+akgYKjncg8D/rGZrBvlZEWIcZpwojTczAPDZwzgAAAIEAnVChocD+icLr/tBV9Hq6Z5TOqck9AuXK4e4qrRzHJEWCQ2t3okvWYrF/CDJX3O9QtV45UsHuAAoJaY6oknq1OkWRSyxX3LYALJuSu+Kzdx+hB3qJYFaBH0abWb6fqsCgTx8IsmYBqoZcaGRXe0/Wp1ZThu0XFdLfNdb2GL0NMmw= bcrochet@bcrochet.usersys
END_OF_FILE_CONTENTS

# Re-run cloud-init
cloud-init init
cloud-init modules --mode init
cloud-init modules --mode config
cloud-init modules --mode final

# Do not let this run again
touch /.vagrant_build_done