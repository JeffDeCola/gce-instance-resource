#!/bin/bash
# gce-instance-resource unit-test.sh

set -e -x

# The code is located in /gce-instance-resource
# /coverage-results already created becasue of yml file
echo "List whats in the current directory"
ls -lat 

# Setup the gopath based on current directory.
export GOPATH=$PWD

# Now we must move our code from the current directory ./gce-instance-resource to $GOPATH/src/github.com/JeffDeCola/gce-instance-resource
mkdir -p src/github.com/JeffDeCola/
cp -R ./gce-instance-resource src/github.com/JeffDeCola/.

# All set and everything is in the right place for go
echo "Gopath is: " $GOPATH
echo "pwd is: " $PWD
cd src/github.com/JeffDeCola/gce-instance-resource

# RUN unit_tests and it shows the percentage coverage
# print to stdout and file using tee
go test -cover ./... | tee test_coverage.txt

# add some whitespace to the begining of each line
sed -i -e 's/^/     /' test_coverage.txt

# Move to coverage-results directory.
mv test_coverage.txt $GOPATH/coverage-results/.
