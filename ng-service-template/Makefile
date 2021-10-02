# type here the feature name in lowercase
# ex. stato-civile, appellativo, the application
# will provide to capitalize them
FEATURE="legal-subject-social"
ENDPOINT="registries/{id}/socials"

OPTS=-DFEATURE=${FEATURE} -DENDPOINT=${ENDPOINT}
LIBS=-I/usr/share/doc/m4/examples/ -Ilib

ALL:
	m4 ${LIBS} ${OPTS} src/feature.service.m4 > ./dist/${FEATURE}.service.ts


clean:
	rm dist/*.ts
