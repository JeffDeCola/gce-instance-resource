#!/bin/bash
# gce-instance-resourceset-pipeline.sh

fly -t ci set-pipeline -p gce-instance-resource -c pipeline.yml --load-vars-from ../../../../../.credentials.yml
