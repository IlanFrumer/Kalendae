kal=src/intro_standalone.js \
	src/main.js \
	src/util.js \
	src/auto.js \
	src/input.js \
	src/MinPubSub.js \
	src/moment.js \
	src/moment.ext.js \
	src/jq.js \
	src/outro.js

kmomentless= src/intro.js \
	src/main.js \
	src/util.js \
	src/auto.js \
	src/input.js \
	src/MinPubSub.js \
	src/moment.ext.js \
	src/jq.js \
	src/outro.js

all: build/kalendae.js build/kalendae.standalone.js

clean:
	rm -f build/*.js

minified: build/kalendae.min.js build/kalendae.standalone.min.js

minified-test: build/kalendae.min.errors

build/kalendae.standalone.js: $(kal) src/header.js
	cat src/header.js > $@
	echo "(function (undefined) {" >> $@
	echo "" >> $@
	cat $(kal) >> $@
	echo "" >> $@
	echo "})();" >> $@

build/kalendae.js: $(kmomentless) src/header.js
	cat src/header.js > $@
	echo "" >> $@
	cat $(kmomentless) >> $@

build/kalendae.min.js: build/kalendae.js
	cat src/header.js > $@
	node_modules/.bin/uglifyjs build/kalendae.js --compress --mangle >> $@
	gzip -c build/kalendae.min.js | wc -c

build/kalendae.standalone.min.js: build/kalendae.standalone.js
	cat src/header.js > $@
	node_modules/.bin/uglifyjs build/kalendae.standalone.js --compress --mangle >> $@
	gzip -c build/kalendae.standalone.min.js | wc -c
