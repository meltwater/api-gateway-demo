#!/usr/bin/env python
import sys
import pytest
import requests
import json

URL = "http://localhost:81"   

def request_and_assert_status(method, url, expected = 200, headers = {}, payload = {}):
    response = requests.request(method, URL + url, headers=headers, data = payload)
    assert response.status_code == expected, url + " should return HTTP " + str(expected)
    return response

def test_health():
    request_and_assert_status("GET", "/health")

def test_legacy_exact_match():
    request_and_assert_status("POST", "/legacy/anotherthing", 404)

def test_legacy_without_headers():
    request_and_assert_status("POST", "/legacy", 404)

def test_legacy_op_invalid():
    request_and_assert_status("POST", "/legacy", 404, {'op': ''})
    request_and_assert_status("POST", "/legacy", 404, {'op': 'service1/'})
    request_and_assert_status("POST", "/legacy", 404, {'op': 'service1'})

def test_legacy_op_proxy_pass():
    response = request_and_assert_status("POST", "/legacy", 200, {'op': 'service2/doGet'})
    assert response.text == "https://service2/doGet", "/legacy should proxy_pass by op"

def test_legacy_pre_login_flow_invalid():
    request_and_assert_status("POST", "/legacy", 404, {'pre-login-flow': ''})
    request_and_assert_status("POST", "/legacy", 404, {'pre-login-flow': 'service2/'})

def test_legacy_pre_login_flow_proxy_pass():
    response = request_and_assert_status("POST", "/legacy", 200, {'pre-login-flow': 'service3'})
    assert response.text == "https://service3/doLogon", "/legacy should proxy_pass by pre-login-flow"

def test_api_invalid():
    request_and_assert_status("POST", "/anotherthing/api/x/y", 404)
    request_and_assert_status("POST", "/api/", 404)
    request_and_assert_status("POST", "/api", 404)

def test_api_proxy_pass_root():
    response = request_and_assert_status("POST", "/api/service1", 200)
    assert response.text == "https://service1/", "/api should proxy_pass root"

    response = request_and_assert_status("POST", "/api/service1/", 200)
    assert response.text == "https://service1/", "/api should proxy_pass root"

def test_api_proxy_pass_path():
    response = request_and_assert_status("POST", "/api/service1/path1/path2", 200)
    assert response.text == "https://service1/path1/path2", "/api should proxy_pass path"

def test_api_proxy_pass_query():
    response = request_and_assert_status("POST", "/api/service1/path1/path2?a=x&b=y", 200)
    assert response.text == "https://service1/path1/path2?a=x&b=y", "/api should proxy_pass query"