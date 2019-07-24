#!/bin/bash
USERID=$(id -u)

echo "${USERID}";

docker-compose up --build 