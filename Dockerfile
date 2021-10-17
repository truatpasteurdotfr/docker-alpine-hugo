FROM alpine as build
MAINTAINER Tru Huynh <tru@pasteur.fr>

# build env
RUN apk update && apk upgrade && \
	apk add --no-cache  libgcc libstdc++
	git clone https://github.com/gohugoio/hugo.git && \
	cd hugo && go install --tags extended

# copy hugo to runtime
FROM alpine
RUN apk update && apk upgrade
RUN date +"%Y-%m-%d-%H%M" > /last_update
COPY --from=build /root/go/bin/hugo /usr/bin/hugo

