FROM ubuntu:bionic

    # Disable Universe and Multiverse repositories.
RUN sed -i 's/^\(deb.*universe\)$/# \1/g' /etc/apt/sources.list \
    # Install required packages.
    && apt-get update && apt-get install -y \
    curl \
    gcc \
    make \
    # TODO Will need to check ccache is working.
    ccache \
    python3 \
    astyle \
    # Docker build dependencies.
    python3-pip \
    # Prepare to install cs50 utilities.
    && mkdir cs50 \
    && cd cs50 \
    # Install libcs50.
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
    && pip3 install check50 \
    # Install style50.
    && curl -s -L -o style50.tar.gz \
    $(curl -s https://api.github.com/repos/cs50/style50/releases/latest \
    | grep "tarball_url" \
    | cut -d '"' -f4) \
    && mkdir style50 \
    && tar xvf style50.tar.gz -C style50 --strip-components=1 \
    && pip3 install style50 \
    && cd / \
    # Remove all cs50 utility install files.
    && rm -rf cs50 \
    && apt-get autoremove -y --purge \
    # pip has about 200MB of dependencies, so remove it unless totally necessary.
    python3-pip \
    curl \
    # Delete all apt list files.
    && rm -rf /var/lib/apt/lists/* 

CMD ["/usr/bin/env", "bash"]

