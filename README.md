
Zencoder
--------

A ColdFusion component for interacting with the [Zencoder](http://zencoder.com) API.

### Getting Started

Copy the `zencoder` folder into your web root or create a mapping to it.

Create an instance of the Zencoder client. This will accept an API key.

```
client = new zencoder.Zencoder("API_KEY")
```

## [Jobs](https://app.zencoder.com/docs/api/jobs)

Create a [new job](https://app.zencoder.com/docs/api/jobs/create).

```
client.createJob(input="s3://bucket/key.mp4",
  outputs=[{'label': 'vp8 for the web', 'url': 's3://bucket/key_output.webm'}])
```

The response includes a Job ID, and one or more Output IDs (one for every output file created).

```
response = client.createJob('s3://bucket/key.mp4')
response.id     # 12345
```

[List jobs](https://app.zencoder.com/docs/api/jobs/list).


```
client.listJobs()
```

Get [details](https://app.zencoder.com/docs/api/jobs/show) about a job.

The number passed to `details` is the ID of a Zencoder job.

```
client.getJobDetails(1)
```

Get [progress](https://app.zencoder.com/docs/api/jobs/progress) on a job.

The number passed to `progress` is the ID of a Zencoder job.

```
client.jobProgress(1)
```

[Resubmit](https://app.zencoder.com/docs/api/jobs/resubmit) a job

The number passed to `resubmit` is the ID of a Zencoder job.

```
client.resubmitJob(1)
```

[Cancel](https://app.zencoder.com/docs/api/jobs/cancel) a job

The number passed to `cancel` is the ID of a Zencoder job.

```
client.cancelJob(1)
```

## [Inputs](https://app.zencoder.com/docs/api/inputs)

Get [details](https://app.zencoder.com/docs/api/inputs/show) about an input.

The number passed to `details` is the ID of a Zencoder job.

```
client.getInputDetails(1)
```

Get [progress](https://app.zencoder.com/docs/api/inputs/progress) for an input.

The number passed to `progress` is the ID of a Zencoder job.

```
client.inputProgress(1)
```
## [Outputs](https://app.zencoder.com/docs/api/outputs)

Get [details](https://app.zencoder.com/docs/api/outputs/show) about an output.

The number passed to `details` is the ID of a Zencoder job.

```
client.getOutputDetails(1)
```

Get [progress](https://app.zencoder.com/docs/api/outputs/progress) for an output.

The number passed to `progress` is the ID of a Zencoder job.

```
client.outputProgress(1)
```
