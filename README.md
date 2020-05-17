API GATEWAY DEMO
================

This is an example of how to set up a test environment for an Nginx gateway, with tests
implemented using [pytest](https://docs.pytest.org/en/latest/).


Based on this post: [Lightweight Tests for your Nginx API Gateway](http://underthehood.meltwater.com/blog/2017/12/12/lightweight-tests-for-your-nginx-api-gateway/)

# Prerequisites
* [docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* [Python 3.7](https://wiki.python.org/moin/BeginnersGuide/Download)

# Project structure explained
~~~bash
├── nginx (Gateway configuration)
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

Setting up the test docker container required 4 extra steps on top of the target Nginx setup:
* Install and run `dnsmasq` (Step 1)
* Override `/etc/hosts` file with DNS names for our internal services (Step 2)
* Override production DNS resolver and inject virtual server configuration mocking internal services (Step 3)
* Include self signed ssl certificate used in internal services mock (Step 4)


# Run tests
Set up testing environment:
~~~bash
$ make start
~~~

Execute tests:
~~~bash
$ make test
~~~

Reload [api-gateway.conf](nginx/conf.d/api-gateway.conf):
~~~bash
$ make reload
~~~

Stop:
~~~bash
$ make stop
~~~