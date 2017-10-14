 # Create image based on the official Node 6 image from the dockerhub
FROM node:8.6
RUN apt-get update && apt-get install -y locales \
	&& localedef -i el_GR -c -f UTF-8 -A /usr/share/locale/locale.alias el_GR.UTF-8 \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8

USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone



#####################################
# Crontab
#####################################
USER root

COPY ./crontab /etc/cron.d
RUN chmod -R 644 /etc/cron.d

#####################################
# User Aliases
#####################################

USER node
COPY ./aliases.sh /home/node/aliases.sh
RUN echo "" >> ~/.bashrc && \
    echo "# Load Custom Aliases" >> ~/.bashrc && \
    echo "source /home/node/aliases.sh" >> ~/.bashrc && \
	echo "" >> ~/.bashrc && \
	sed -i 's/\r//' /home/node/aliases.sh && \
	sed -i 's/^#! \/bin\/sh/#! \/bin\/bash/' /home/node/aliases.sh

USER root
RUN echo "" >> ~/.bashrc && \
    echo "# Load Custom Aliases" >> ~/.bashrc && \
    echo "source /home/node/aliases.sh" >> ~/.bashrc && \
	echo "" >> ~/.bashrc && \
	sed -i 's/\r//' /home/node/aliases.sh && \
	sed -i 's/^#! \/bin\/sh/#! \/bin\/bash/' /home/node/aliases.sh

#####################################
# ssh:
#####################################
ARG INSTALL_NODE_SSH=false
ENV INSTALL_NODE_SSH ${INSTALL_NODE_SSH}

ADD git_access /tmp/id_rsa
ADD git_access.pub /tmp/id_rsa.pub
ADD authorized_keys /tmp/authorized_keys

RUN if [ ${INSTALL_NODE_SSH} = true ]; then \
    rm -f /etc/service/sshd/down && \
    cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
        && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
        && cat /tmp/id_rsa >> /root/.ssh/id_rsa \
        && cat /tmp/authorized_keys >> /root/.ssh/authorized_keys \
        && rm -f /tmp/id_rsa* \
        && rm -f /tmp/authorized_keys \
        && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
    && chmod 400 /root/.ssh/id_rsa \
;fi

#####################################
# Angular-cli:
#####################################

USER root

ARG NODE_INSTALL_ANGULAR_CLI=false
ENV NODE_INSTALL_ANGULAR_CLI ${NODE_INSTALL_ANGULAR_CLI}

RUN if [ ${NODE_INSTALL_ANGULAR_CLI} = true ]; then \
    yarn global add gulp bower @angular/cli@latest \
;fi

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Clean up
USER root

# Installing mysql client to run mysql commands
RUN apt-get install -y mysql-client

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set default work directory
WORKDIR /var/www

#
# Expose the port the app runs in
EXPOSE 3000
