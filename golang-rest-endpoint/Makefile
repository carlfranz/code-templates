# type here the feature name in lowercase
# ex. statoCivile, appellativo
FEATURE="socialInfo"

OPTS=-DFEATURE=${FEATURE} -DENDPOINT=${ENDPOINT}
LIBS=-I/usr/share/doc/m4/examples/ -Ilib

ALL:
	m4 ${LIBS} ${OPTS} src/feature.handler.m4 > ./dist/${FEATURE}.handler.go
	m4 ${LIBS} ${OPTS} src/feature.dao.m4 > ./dist/${FEATURE}.dao.go


clean:
	rm dist/*.go
