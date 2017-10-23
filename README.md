API GATEWAY DEMO
================

This is an example how to test nginx api gateway with ruby rspec.

# Prerequisites
* [docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* [ruby 2.4.0](https://www.ruby-lang.org/en/news/2016/12/25/ruby-2-4-0-released/)
* [bundler](http://bundler.io/)

# Run tests
Set up testing environment:
~~~bash
$ make compose-up-test
~~~

Execute tests:
~~~bash
$ make test
~~~
