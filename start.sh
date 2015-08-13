#!/bin/bash
docker-compose stop -t 5
docker-compose up -d --x-smart-recreate
docker-compose logs
