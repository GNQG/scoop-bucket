# scoop bucket

A [scoop bucket](https://github.com/lukesampson/scoop/wiki/Buckets) for some tools.

- [circleci-cli](https://circleci.com/docs/2.0/local-cli/)
- [lab](https://zaquestion.github.io/lab/)
- [busybox-core](https://frippery.org/busybox)

    Same as [`busybox`](https://github.com/lukesampson/scoop/blob/master/bucket/busybox.json) in main bucket, but `bin` entry contains no aliases (contains only `busybox.exe`.)

## `update-manifest.ps1` (experimental)

Experimental support for `bin` entry depending on the version of the tool. See [`circleci-cli.json`](circleci-cli.json).