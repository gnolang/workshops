#!/bin/sh

curl --location --request POST 'localhost:4591/system/create' \
--header 'Content-Type: application/json' \
--data-raw '{
    "code": "package postit\r\n\r\nvar posts string \r\n\r\nfunc Post(p string) {\r\n\tposts += \"<p>\" + p + \"<\/p>\"\r\n}\r\n\r\nfunc Render(_ string) string {\r\n\treturn \"<html>\" + posts + \"<\/html>\"\r\n}",
    "syncable": true
}'

curl --location --request POST 'localhost:4592/system/install-remote' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "postit",
    "address": "localhost:4591"
}'

curl --location --request POST 'localhost:4591/system/call' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "postit",
    "func": "Post",
    "args": ["first post"]
}'

curl --location --request POST 'localhost:4592/system/call' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "postit",
    "func": "Post",
    "args": ["hello Alice, this is Bob"]
}'

curl --location --request POST 'localhost:4591/system/call' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "postit",
    "func": "Post",
    "args": ["oh hey Bob"]
}'