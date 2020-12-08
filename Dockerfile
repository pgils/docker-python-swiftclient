ARG PYTHON=3.9

FROM python:${PYTHON}-alpine as build

RUN apk add --no-cache \
        build-base python3-dev linux-headers
RUN pip install -U \
        python-swiftclient \
        python-keystoneclient

FROM python:3-alpine
ARG PYTHON

COPY --from=build \
        /usr/local/lib/python${PYTHON}/site-packages \
        /usr/local/lib/python${PYTHON}/site-packages
COPY --from=build \
        /usr/local/bin \
        /usr/local/bin