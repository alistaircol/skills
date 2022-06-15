#!/usr/dot/env bash
source "bin/build.sh"
export SKILLS_DIRECTION="TB"

envsubst < src/environment.dot > dot/environment.dot
envsubst < src/devops.dot > dot/devops.dot
envsubst < src/ssg.dot > dot/ssg.dot
envsubst < src/servers.dot > dot/servers.dot
envsubst < src/proxies.dot > dot/proxies.dot
envsubst < src/db.dot > dot/db.dot
envsubst < src/queues.dot > dot/queues.dot
envsubst < src/cloud.dot > dot/cloud.dot
envsubst < src/php.dot > dot/php.dot
envsubst < src/css.dot > dot/css.dot
envsubst < src/js.dot > dot/js.dot
envsubst < src/misc.dot > dot/misc.dot
envsubst < src/concepts.dot > dot/concepts.dot
