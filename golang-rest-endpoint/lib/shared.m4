include(`capitalize.m4')dnl
# define(classname, `patsubst(capitalize($1), `-', `')')dnl
# define(reducername, `patsubst(classname($1), `^\([A-Z]\)', `downcase(`\1')')')dnl
# define(STATENAME, `classname(FEATURE)State')dnl
# define(POJONAME, `classname(FEATURE)')dnl
# define(STATESTATUS, `classname(FEATURE)Status')dnl
# define(STORENAME, `reducername(FEATURE)')dnl
