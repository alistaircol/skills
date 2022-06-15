#!/usr/bin/env bash
source "bin/build.sh"
envsubst < src/skills.dot > dot/skills.dot
