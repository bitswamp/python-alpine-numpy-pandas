# python-alpine-numpy-pandas

Not intended for general use. This image builds on `python:3.7-alpine` and includes specific versions of `numpy` and `pandas` for use in another project.

The image is created with a two-stage Dockerfile so that the final image does not include the dev toolchain including `musl-dev`, `openblas-dev`, `g++` and dependencies.
