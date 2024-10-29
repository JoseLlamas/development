FROM debian:latest

ARG DEFAULT_USER
ENV JAVA_HOME=/usr/lib/jvm/jdk-22-oracle-x64/

RUN apt update && apt upgrade -y && apt install libicu-dev vim curl wget tzdata \
	locales less sqlite3 libzip-dev git libpq-dev unzip -y

RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt autoclean && apt autoremove

RUN curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O "https://download.oracle.com/java/22/archive/jdk-22.0.1_linux-x64_bin.deb"
RUN dpkg -i jdk-22.0.1_linux-x64_bin.deb
RUN rm jdk-22.0.1_linux-x64_bin.deb

RUN sed -i -e 's/# es_MX.UTF-8 UTF-8/es_MX.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i -e 's/# es_MX.ISO-8859-1/es_MX.ISO-8859-1 ISO-8859-1/' /etc/locale.gen
RUN locale-gen
ENV LANG es_MX.UTF-8
ENV LANGUAGE es_MX:es
ENV LC_ALL es_MX.UTF-8

RUN echo 'root:asdf1234' | chpasswd

RUN groupadd -g 1000 ${DEFAULT_USER}
RUN useradd -u 1000 -g ${DEFAULT_USER} \
    --create-home --home-dir=/home/${DEFAULT_USER} \
    --shell=/bin/bash ${DEFAULT_USER}

RUN usermod -aG www-data ${DEFAULT_USER}

USER ${DEFAULT_USER}
WORKDIR /home/${DEFAULT_USER}

RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -
RUN curl -fsSL https://bun.sh/install | bash

RUN mkdir bin
ENV PATH $PATH:/home/${DEFAULT_USER}/bin

COPY .vimrc /home/${DEFAULT_USER}/.vimrc

CMD tail -F /var/log/noExists

