# Content pipeline bug

This repository contains partial code from a real content pipeline. This pipeline is used to process large files in a streaming fashion.
The file is read in chunks of N bytes, which are then decoded and yielded forward in the pipeline. The pipeline is implemented using the [piperator](https://github.com/lautis/piperator) gem.

However, there is a bug in this code. The bug has been replicated in the test suite.

## Goals

- Explain what's causing the bug
- Fix the bug, and explain how the fix works

## Setup

Install gems

```shell
bundle install
```

## Testing

```shell
bundle exec rspec
```
