#! /bin/sh

if [ $# -ne 1 ]; then
  echo Usage: $0 VIRTUAL_ENV_DIR
  exit 1
fi

ORIG_DIR="$PWD"
mkdir "$1" || exit 1
cd "$1"
SETUP_VIRTUALENV="$PWD"
cd "$ORIG_DIR"
rmdir "$1" || exit 1

# NOTE: It is important that you setup a Python 2.7 virtualenv and not
# a Python 3 venv.
virtualenv --system-site-packages "$SETUP_VIRTUALENV"
curl -L http://downloads.sourceforge.net/project/sshpass/sshpass/1.06/sshpass-1.06.tar.gz | tar -zxf -
cd sshpass-1.06
./configure --prefix="$SETUP_VIRTUALENV"
make
make install
cd ..
rm -rf sshpass-1.06
source "$SETUP_VIRTUALENV"/bin/activate
if python --version 2>&1 | grep -F 'Python 2.7'; then
  true
else
  echo 'ERROR: Invalid version of Python.' >/dev/stderr
  deactivate
  rm -rf "$SETUP_VIRTUALENV"
  exit 1
fi
pip install ansible
