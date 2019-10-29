# python-alpine-numpy-pandas

Not intended for general use. This image builds on `python:3.6-alpine` and includes specific versions of `numpy` and `pandas` for use in another project. It also includes `mysqlclient`.

The image is created with a three-stage Dockerfile so that the final image does not include the dev toolchain including `musl-dev`, `openblas-dev`, `g++` and dependencies.
