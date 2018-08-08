FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    make \
    python3 \
    python3-pip \
    astyle \
    # Install libcs50.
    && mkdir cs50 \
    && cd cs50 \
    && curl -s -L -o libcs50.tar.gz \
    $(curl -s https://api.github.com/repos/cs50/libcs50/releases/latest \
    | grep "tarball_url" \
    | cut -d '"' -f4) \
    && mkdir libcs50 \
    && tar xvf libcs50.tar.gz -C libcs50 --strip-components=1 \
    && make -C libcs50 install \
    # Install check50.
    && curl -s -L -o check50.tar.gz \
    $(curl -s https://api.github.com/repos/cs50/check50/releases/latest \
    | grep "tarball_url" \
    | cut -d '"' -f4) \
    && mkdir check50 \
    && tar xvf check50.tar.gz -C check50 --strip-components=1 \
    && cd check50 \
    && pip3 install check50 \
    # Install style50.
    && curl -s -L -o style50.tar.gz \
    $(curl -s https://api.github.com/repos/cs50/style50/releases/latest \
    | grep "tarball_url" \
    | cut -d '"' -f4) \
    && mkdir style50 \
    && tar xvf style50.tar.gz -C style50 --strip-components=1 \
    && pip3 install style50

CMD ["/usr/bin/env", "bash"]
