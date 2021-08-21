#!/bin/sh -e

echo Your IPs:
hostname -I

echo Restarting machine...
shutdown -r +0

