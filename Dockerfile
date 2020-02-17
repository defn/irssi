FROM letfn/container

USER root
RUN apk add screen irssi openssh
RUN ssh-keygen -A
RUN chown -R app:app /etc/ssh /run

USER app

RUN mkdir -p .irssi
RUN ln -nfs /efs/config/irssi/config .irssi/

RUN mkdir -p .ssh
RUN chmod 700 .ssh
COPY --chown=app:app authorized_keys .ssh/
RUN chmod 600 .ssh/authorized_keys

COPY service /service

ENTRYPOINT [ "/tini", "--", "/service" ]
