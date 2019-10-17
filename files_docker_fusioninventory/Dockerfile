FROM ubuntu:19.04


#RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

# instalando dependencias e o agente do fusioninventory
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install nano \
    && apt-get -y install iputils-ping \
    && apt-get -y install dmidecode hwdata ucf hdparm \
    && apt-get -y install perl libuniversal-require-perl libwww-perl libparse-edid-perl \
    && apt-get -y install libproc-daemon-perl libfile-which-perl libhttp-daemon-perl \
    && apt-get -y install libxml-treepp-perl libyaml-perl libnet-cups-perl libnet-ip-perl \
    && apt-get -y install libdigest-sha-perl libsocket-getaddrinfo-perl libtext-template-perl \
    && apt-get -y install libxml-xpath-perl \
    && apt-get -y install libnet-snmp-perl libcrypt-des-perl libnet-nbname-perl \
    && apt-get -y install libdigest-hmac-perl \
    && apt-get -y install fusioninventory-agent \
    && apt-get -y install fusioninventory-agent-task-network \
    && apt-get -y install fusioninventory-agent-task-collect \
    && apt-get -y install tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the locale
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=pt_BR.UTF-8

ENV LANG pt_BR.UTF-8 

# Defining container's timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata


COPY agent.cfg /etc/fusioninventory/agent.cfg

COPY fusioninventory-foreground.sh /bin/fusioninventory-foreground.sh
RUN chmod 775 /bin/fusioninventory-foreground.sh


EXPOSE 62354

CMD ["/bin/fusioninventory-foreground.sh"]