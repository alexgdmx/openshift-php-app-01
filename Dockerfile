FROM centos:7

MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40

ENV HOSTNAME apache.localhost
RUN yum -y --setopt=tsflags=nodocs update && \
    yum install epel-release yum-utils -y && \
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y --setopt=tsflags=nodocs install httpd php mod_php && \
    yum clean all

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
ADD index.php /var/www/html/index.php
RUN chmod -v +x /run-httpd.sh && \
    rm -rf /run/httpd/* /tmp/httpd*

CMD ["/run-httpd.sh"]
