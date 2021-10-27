# type here the feature name in lowercase
# ex. stato-civile, appellativo, the application
# will provide to capitalize them
FEATURE="professional-info"

OPTS=-DFEATURE=${FEATURE}
LIBS=-I/usr/share/doc/m4/examples/ -Ilib

ALL:
	m4 ${LIBS} ${OPTS} src/feature.action.m4 > ./dist/${FEATURE}.action.ts
	m4 ${LIBS} ${OPTS} src/feature.effects.m4  > ./dist/${FEATURE}.effects.ts
	m4 ${LIBS} ${OPTS} src/feature.reducer.m4  > ./dist/${FEATURE}.reducer.ts
	m4 ${LIBS} ${OPTS} src/index.m4  > ./dist/index.ts

clean:
	rm dist/*.ts
