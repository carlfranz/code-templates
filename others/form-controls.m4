divert(-1)dnl
include(`foreach.m4')dnl
define(`concat',`$1$2')dnl
define(m4_form_control, `private readonly $1 = new FormControl(false);
')
define(`data', (picture, fiscalCode, vatNumber, birthDate, gender, studioAddress, studioEmail, studioPec, studioPecReginde, studioPhone, studioFax, residenceAddress, residenceEmail, residencePec, residencePecReginde, residencePhone, residenceFax, professionalDomicileAddress, professionalDomicileEmail, professionalDomicilePec, professionalDomicilePecReginde, professionalDomicilePhone, professionalDomicileFax, taxDomicileAddress, taxDomicileEmail, taxDomicilePec, taxDomicilePecReginde, taxDomicilePhone, taxDomicileFax, mailingAddressAddress, mailingAddressEmail, mailingAddressPec, mailingAddressPecReginde, mailingAddressPhone, mailingAddressFax, studioMobilePhone, residenceMobilePhone, professionalDomicileMobilePhone, taxDomicileMobilePhone, mailingAddressMobilePhone))
divert(0)dnl

foreach(`x', data, m4_form_control(x)))dnl
