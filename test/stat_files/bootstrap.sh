#!/bin/bash

yum -y update
yum -y install httpd

cat <<-EOF
<html>
<body bgcolor="black>
<h2><font color="gold"> HEllo from ME!!</h2>

</html>
EOF


sudo service httpd start
chkconfig httpd on