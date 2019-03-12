#!/bin/bash
# gce-instance-resource destroy-pipeline.sh

fly -t ci destroy-pipeline --pipeline gce-instance-resource
