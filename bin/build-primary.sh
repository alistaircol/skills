#!/usr/bin/env bash
source "build.sh"
envsubst < src/skills.dot > bin/skills.dot
