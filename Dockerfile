FROM alpine as build
MAINTAINER Tru Huynh <tru@pasteur.fr>

# build env
RUN apk update && apk upgrade && \
	apk add --no-cache git go g++ && \
	apk info -v > /apk-info-v-builder.txt && \
	git clone https://github.com/gohugoio/hugo.git && \
	cd hugo && go install --tags extended

# copy hugo to runtime
FROM alpine
COPY --from=build /root/go/bin/hugo /usr/bin/hugo
RUN apk update && apk upgrade && \
	apk add --no-cache libgcc libstdc++ && \
	apk info -v > /apk-info-v-runtime.txt && \
	date +"%Y-%m-%d-%H%M" > /last_update
