# type here the feature name in lowercase
# ex. statoCivile, appellativo
# config
FEATURE="socialInfo"
TEST_FEATURE="socialInfo"

TEST_DAO_OUTPUT=./test/actual.dao.go
TEST_DAO_EC_OUTPUT=./test/actual.dao.ec.go
TEST_HANDLER_EC_OUTPUT=./test/actual.handler.ec.go

TEST_OUTPUTS = ${TEST_DAO_OUTPUT} ${TEST_DAO_EC_OUTPUT} ${TEST_HANDLER_EC_OUTPUT}


# auto variables
OPTS=-DFEATURE=${FEATURE} -DENDPOINT=${ENDPOINT}
TEST_OPTS=-DFEATURE=${TEST_FEATURE} -DENDPOINT=${ENDPOINT}
LIBS=-I/usr/share/doc/m4/examples/ -Ilib

ALL:
	m4 ${LIBS} ${OPTS} src/feature.handler.m4 > ./dist/${FEATURE}.handler.go
	m4 ${LIBS} ${OPTS} src/feature.dao.m4 > ./dist/${FEATURE}.dao.go

test: ${TEST_OUTPUTS}

${TEST_DAO_OUTPUT}:
	m4 ${LIBS} ${TEST_OPTS} src/feature.dao.m4 > ${TEST_DAO_OUTPUT}

${TEST_DAO_EC_OUTPUT}:
	m4 ${LIBS} ${TEST_OPTS} src/feature.dao.ec.m4 > ${TEST_DAO_EC_OUTPUT}

${TEST_HANDLER_EC_OUTPUT}:
	m4 ${LIBS} ${TEST_OPTS} src/feature.handler.ec.m4 > ${TEST_HANDLER_EC_OUTPUT}

clean:
	rm -f dist/*.go
	rm -f test/*.go
