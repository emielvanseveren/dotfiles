FROM debian
COPY . /opt/dots
WORKDIR  /opt/dots

# test setup2
CMD ["./setup2.sh"]
