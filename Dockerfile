FROM alpine

RUN /sbin/apk --no-cache add vsftpd \
    && /usr/sbin/adduser -h /data -s /bin/noshell -G nogroup -D -H ftpimages \
    && /bin/mkdir -p /data/images \
    && chown root:root /data && chmod 755 /data \
    && chown ftpimages:nogroup /data/images && chmod 777 /data/images
COPY ./vsftpd.conf /etc/vsftpd/

EXPOSE 20 21 10000-10010
VOLUME /data/images

CMD /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
