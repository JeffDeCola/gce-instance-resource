#!/bin/bash
# gce-instance-resource update_concourse.sh

fly -t ci set-pipeline -p gce-instance-resource -c ci/pipeline.yml --load-vars-from ../.credentials.yml
