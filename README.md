# gce-instance-resource

```text
*** THE REPO IS UNDER CONSTRUCTION - CHECK BACK SOON ***
```

[![Go Report Card](https://goreportcard.com/badge/github.com/JeffDeCola/gce-instance-resource)](https://goreportcard.com/report/github.com/JeffDeCola/gce-instance-resource)
[![GoDoc](https://godoc.org/github.com/JeffDeCola/gce-instance-resource?status.svg)](https://godoc.org/github.com/JeffDeCola/gce-instance-resource)
[![Maintainability](https://api.codeclimate.com/v1/badges/6bdbf329d966437eec99/maintainability)](https://codeclimate.com/github/JeffDeCola/gce-instance-resource/maintainability)
[![Issue Count](https://codeclimate.com/github/JeffDeCola/gce-instance-resource/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/gce-instance-resource/issues)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)

_A concourse resource type to check for a new Google Compute Engine (GCE) Instance.
It is tested, built and pushed to DockerHub using Concourse._

Table of Contents,

* [SCRIPTS](https://github.com/JeffDeCola/gce-instance-resource#scripts)
* [SOURCE CONFIGURATION](https://github.com/JeffDeCola/gce-instance-resource#source-configuration)
* [BEHAVIOR](https://github.com/JeffDeCola/gce-instance-resource#behavior)
  * [CHECK (a resource version(s))](https://github.com/JeffDeCola/gce-instance-resource#check-a-resource-versions)
  * [IN (fetch a resource)](https://github.com/JeffDeCola/gce-instance-resource#in-fetch-a-resource)
  * [OUT (update a resouce)](https://github.com/JeffDeCola/gce-instance-resource#out-update-a-resouce)
* [PIPELINE EXAMPLE USING PUT](https://github.com/JeffDeCola/gce-instance-resource#pipeline-example-using-put)

Documentation and references,

* The `gce-instance-resource`
  [Docker Image](https://hub.docker.com/r/jeffdecola/gce-instance-resource)
  on DockerHub

[GitHub Webpage](https://jeffdecola.github.io/gce-instance-resource/)
_built with
[concourse ci](https://github.com/JeffDeCola/gce-instance-resource/blob/master/ci-README.md)_

## SCRIPTS

The 3 bash script files located in _/assets-bash_.

## SOURCE CONFIGURATION

These are just placeholders that you can update where your source is.

* `source1`: Just a placeholder.

* `source2`: Just a placeholder.

## BEHAVIOR

### CHECK (a resource version(s))

CHECK will mimic getting the list of versions from a resource.

#### CHECK stdin

```json
{
  "source": {
    "source1": "sourcefoo1",
    "source2": "sourcefoo2"
  },
  "version": {
    "ref": "123 ",
  }
}
```

123 is the current version.

#### CHECK stdout

```json
[
  { "ref": "123" },
  { "ref": "3de" },
  { "ref": "456" }
  { "ref": "777" }
]
```

777 is the latest version that will be used.

The last number 777 will become the current ref version that will be used by IN.

#### CHECK - go run

```bash
echo '{
"params": {"param1": "Hello Clif","param2": "Nice to meet you"},
"source": {"source1": "sourcefoo1","source2": "sourcefoo2"},
"version":{"ref": "123"}}' |
go run main.go check $PWD
```

### IN (fetch a resource)

IN will mimic fetching a resource and placing a file in the working directory.

#### IN Parameters

* `param1`: Just a placeholder.

* `param2`: Just a placeholder.

#### IN stdin

```json
{
  "params": {
    "param1": "Hello Clif",
    "param2": "Nice to meet you"
  },
  "source": {
    "source1": "sourcefoo1",
    "source2": "sourcefoo2"
  },
  "version": {
    "ref": "777",
  }
```

#### IN stdout

```json
{
  "version":{ "ref": "777" },
  "metadata": [
    { "name": "nameofmonkey", "value": "Larry" },
    { "name": "author","value": "Jeff DeCola" }
  ]
}
```

#### file fetched (fetch.json)

The IN will mimic a fetch and place a fake file `fetched.json` file
in the working directory:

#### IN - go run

```bash
echo '{
"params": {"param1": "Hello Clif","param2": "Nice to meet you"},
"source": {"source1": "sourcefoo1","source2": "sourcefoo2"},
"version":{"ref": "777"}}' |
go run main.go in $PWD
```

### OUT (update a resouce)

OUT will mimic updating a resource.

#### OUT Parameters

* `param1`: Just a placeholder.

* `param2`: Just a placeholder

#### OUT stdin

```json
{
  "params": {
    "param1": "Hello Jeff",
    "param2": "How are you?"
  },
  "source": {
    "source1": "sourcefoo1",
    "source2": "sourcefoo2"
  },
  "version": {
    "ref": ""
  }
}
```

#### OUT stdout

```json
{
  "version":{ "ref": "777" },
  "metadata": [
    { "name": "nameofmonkey","value": "Henry" },
    { "name": "author","value": "Jeff DeCola" }
  ]
}
```

where 777 is the version you wanted to update.

#### OUT - go run

```bash
echo '{
"params": {"param1": "Hello Jeff","param2": "How are you?"},
"source": {"source1": "sourcefoo1","source2": "sourcefoo2"},
"version":{"ref": ""}}' |
go run main.go out $PWD
```

## PIPELINE EXAMPLE USING PUT

```yaml
jobs:
...
- name: your-job-name
  plan:
    ...
  - put: gce-instance-resource
    params: { param1: "hello jeff", param2: "How are you?" }

resource_types:
  ...
- name: jeffs-resource
  type: docker-image
  source:
   repository: jeffdecola/gce-instance-resource
   tag: latest

resources:
  ...
- name: gce-instance-resource
  type: jeffs-resource
  source:
    source1: foo1
    source1: foo2
```

GET would look similiar.
