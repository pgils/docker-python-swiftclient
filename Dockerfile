ARG PYTHON=3.9

FROM python:${PYTHON}-alpine as build

COPY requirements.txt .
RUN apk add --no-cache \
        build-base python3-dev linux-headers
RUN pip install -r requirements.txt

FROM python:${PYTHON}-alpine
ARG PYTHON

COPY --from=build \
        /usr/local/lib/python${PYTHON}/site-packages \
        /usr/local/lib/python${PYTHON}/site-packages
COPY --from=build \
        /usr/local/bin \
        /usr/local/bin