FROM letfn/container

USER root
RUN apk add screen irssi openssh
RUN ssh-keygen -A
RUN chown -R app:app /etc/ssh /run

USER app

RUN mkdir -p .irssi
RUN ln -nfs /efs/config/irssi/config .irssi/

COPY service /service

ENTRYPOINT [ "/tini", "--", "/service" ]
