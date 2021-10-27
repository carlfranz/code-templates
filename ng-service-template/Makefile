# type here the feature name in lowercase
# ex. stato-civile, appellativo, the application
# will provide to capitalize them
FEATURE="professional-info"
ENDPOINT="{environment.registriesMsBaseApiUrl}/professional-info"

OPTS=-DFEATURE=${FEATURE} -DENDPOINT=${ENDPOINT}
LIBS=-I/usr/share/doc/m4/examples/ -Ilib

ALL:
	m4 ${LIBS} ${OPTS} src/feature.service.m4 > ./dist/${FEATURE}.service.ts


clean:
	rm dist/*.ts
