FROM ubi8/ubi:8.6

RUN INSTALL_PKGS="git \
  unzip \
  wget \
  which" && \
  yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
  rpm -V $INSTALL_PKGS && \
  yum -y clean all --enablerepo='*'

# GitHub CLI
RUN dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo && \
  dnf install gh
