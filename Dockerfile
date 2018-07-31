FROM centos:7.5.1804
MAINTAINER not-me@na.com

RUN yum install epel-release -y && \
    yum update -y
RUN yum install -y \
    fluxbox \
    net-tools \
    novnc \
    numpy \
    octave \
    openssl \
    supervisor \
    which \
    x11vnc \
    xorg-x11-server-Xvfb

COPY supervisord.conf qt-settings /root/
 
RUN mv /usr/share/novnc/vnc_auto.html /usr/share/novnc/index.html && \
    mv /root/supervisord.conf /etc/supervisord.conf && \
    mkdir -p /root/.config/octave && \
    mv /root/qt-settings /root/.config/octave/qt-settings

# Set display
ENV DISPLAY :0 
ENV SCREEN_RESOLUTION 1024x768

# Expose Port (Note: if you change it do it as well in surpervisord.conf)
EXPOSE 8083
# CMD ["init"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
# https://www.server-world.info/en/note?os=CentOS_7&p=x&f=10
