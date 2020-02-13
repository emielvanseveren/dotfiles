FROM debian
COPY . /opt/dots/
RUN make
WORKDIR  /opt/dots

# test setup2
CMD ["./setup2.sh"]
