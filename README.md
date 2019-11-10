# lando-update-host-ip
A helper script to update the host ip with a lando container when switching wireless networks, see https://github.com/lando/lando/issues/1700

## Usage

Run this script within a lando app, e.g. `bash lando-update-host-ip.sh`.

You will be prompted for your sudo passwords, as e.g. docker needs to be restarted during the process.
