#!/usr/bin/env bash
source "build.sh"
export SKILLS_DIRECTION="TB"

envsubst < src/environment.dot > bin/environment.dot
envsubst < src/devops.dot > bin/devops.dot
envsubst < src/ssg.dot > bin/ssg.dot
envsubst < src/servers.dot > bin/servers.dot
envsubst < src/proxies.dot > bin/proxies.dot
envsubst < src/db.dot > bin/db.dot
envsubst < src/queues.dot > bin/queues.dot
envsubst < src/cloud.dot > bin/cloud.dot
envsubst < src/php.dot > bin/php.dot
envsubst < src/css.dot > bin/css.dot
envsubst < src/js.dot > bin/js.dot
envsubst < src/misc.dot > bin/misc.dot
envsubst < src/concepts.dot > bin/concepts.dot
