FROM systemd
RUN yum -y install openssh-server

# Change root password to default of "root" so that it can be changed later.
RUN sed -i -e '/^root:/c\root:$6$P0JmzfPq$l5Q9HPgY6/rpFiTsvp.4LJodAvB6E0lNsfrGtY.e54.uz2gd4SbBSjTz2drCiZeth7AFkjJO8kDSf9sE3TeAE/:17212:0:99999:7:::' /etc/shadow /etc/shadow-

# Permit SSH root logins.
RUN sed -i -e 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/init"]

# Usage:
# docker run -d --cap-add SYS_ADMIN -p 3418:22 remcentos
# ssh -p 3418 root@localhost
# Password = "root" (without the quotes)
