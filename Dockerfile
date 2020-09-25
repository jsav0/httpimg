# docker run --rm -it -v $(pwd):/screenshots wfnintr/httpimg targets.txt
FROM debian:bullseye-slim
LABEL maintainer="wfnintr@null.net"
RUN apt-get update && apt-get install -y wkhtmltopdf curl
COPY httpimg /usr/local/bin
RUN chmod +x /usr/local/bin/httpimg
WORKDIR /screenshots
ENTRYPOINT ["httpimg"]
