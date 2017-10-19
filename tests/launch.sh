#!/bin/bash
cat /etc/test.hosts >> /etc/hosts
dnsmasq
nginx -g 'daemon off;'
