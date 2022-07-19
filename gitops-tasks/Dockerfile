FROM ubi8/s2i-core:rhel8.6

RUN INSTALL_PKGS="git \
  unzip \
  wget \
  which" && \
  yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
  rpm -V $INSTALL_PKGS && \
  yum -y clean all --enablerepo='*'
