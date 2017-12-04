API GATEWAY DEMO
================

This is an example how to test nginx api gateway with ruby rspec.

# Prerequisites
* [docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* [ruby 2.4.0](https://www.ruby-lang.org/en/news/2016/12/25/ruby-2-4-0-released/)
* [bundler](http://bundler.io/)

# Project structure explained
~~~bash
├── nginx (gateway configuration)
│   ├── conf.d
│   │   └── api-gateway.conf (Location directives)
│   ├── dns.conf (DNS resolver)
│   └── nginx.conf (Main config)
└── tests
    ├── hosts
    │   └── hosts (DNS resolutions for internal services)
    ├── nginx
    │   ├── conf.d
    │   │   └── services.conf (Internal services mock)
    │   └── dns.conf (Test DNS resolver)
~~~

Setting up the test docker container required 3 extra steps on top of the target Nginx setup:
* Install and run dnsmasq (Step 1)
* Override /etc/hosts file with DNS names for our internal services (Step 2)
* Override production DNS resolver and inject virtual server configuration mocking internal services (Step 3)

~~~
# Production config
COPY nginx/*              /etc/nginx/
COPY nginx/conf.d/*       /etc/nginx/conf.d/


# Test setup

# Step 1
RUN apt-get update; apt-get install dnsmasq -y

# Step 2
COPY tests/hosts/hosts    /etc/test.hosts
# Step 3
COPY tests/nginx          /etc/nginx/
~~~

# Run tests
Set up testing environment:
~~~bash
$ make compose-up-test
~~~

Execute tests:
~~~bash
$ make test
~~~
