# scoop-bucket

A [scoop bucket](https://github.com/lukesampson/scoop/wiki/Buckets) for some
tools.

## Manifests

- [busybox-core](https://frippery.org/busybox)

    Same as [`busybox`](https://github.com/lukesampson/scoop/blob/master/bucket/busybox.json)
    in main bucket, but `bin` entry contains no aliases (contains only
    `busybox.exe`.)
- [cross](https://github.com/cross-rs/cross)
- ~~[circleci-cli](https://circleci.com/docs/2.0/local-cli/)~~ (supported in main bucket)
- ~~[lab](https://zaquestion.github.io/lab/)~~ (supported in main bucket)
- ~~[pijul](https://pijul.org/)~~ (no longer available)

## `checkver.ps1` (experimental)

Experimental support for `bin` entry depending on the version of the tool. See
[`circleci-cli.json`](https://github.com/GNQG/scoop-bucket/blob/169c51f/bucket/circleci-cli.json).
