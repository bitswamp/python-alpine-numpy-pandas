# stage 1 - build mysqlclient wheel
FROM python:3.6-alpine AS build-mysqlclient-wheel
ENV PYTHONUNBUFFERED=1

RUN apk add --update --no-cache mariadb-dev g++

ARG MYSQLCLIENT_VERSION=1.4.2.post1
RUN pip wheel -w /wheel mysqlclient==${MYSQLCLIENT_VERSION}

# stage 2 - build numpy and pandas wheels
FROM python:3.6-alpine AS build-wheel

COPY --from=build-mysqlclient-wheel /wheel /wheel

# dependencies to build numpy and pandas
RUN apk add --update --no-cache musl-dev openblas-dev g++

ARG NUMPY_VERSION=1.17.3
RUN pip wheel -w /wheel numpy==${NUMPY_VERSION}

ARG PANDAS_VERSION=0.24.2
# pandas needs numpy installed
RUN pip install --no-index --find-links=/wheel numpy
RUN pip wheel -w /wheel pandas==${PANDAS_VERSION}

# stage 3 - install wheels
FROM python:3.6-alpine AS install-wheel
ENV PYTHONUNBUFFERED=1

COPY --from=build-wheel /wheel /wheel

RUN apk add --update --no-cache libstdc++ openblas mariadb-connector-c

RUN pip install --no-index --find-links=/wheel mysqlclient numpy pandas

# run numpy tests; on alpine some failures are expected
RUN pip install pytest
RUN python -c 'import numpy; numpy.test()'

# uncomment to run pandas tests, which may return a non-zero exit code and prevent docker build
# RUN pip install hypothesis
# RUN python -c 'import pandas; pandas.test();'
