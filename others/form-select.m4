divert(-1)dnl
include(`capitalize.m4')dnl
include(`foreach.m4')dnl
define(`m4_snake_case', `downcase(`patsubst(`$1', `[A-Z]', `_\&'))'')dnl
define(m4_select, `
<label for="$1" class="col-form-label sr-only" i18n>$1</label>
<app-circle-icon [status]="form.value.$1"></app-circle-icon>
<select id="$1" class="albosmart-text-input" name="$1" formControlName="$1">
	<option value="AUTHORIZED" i18n>authorized</option>
	<option value="NOT_AUTHORIZED" i18n>not authorized</option>
	<option value="AUTHORIZED_FORCED" i18n>authorized forced</option>
	<option value="NOT_AUTHORIZED_FORCED" i18n>not authorized forced</option>
</select>
')dnl
define(`data', (picture, fiscalCode, vatNumber, birthDate, gender, studioAddress, studioEmail, studioPec, studioPecReginde, studioPhone, studioFax, residenceAddress, residenceEmail, residencePec, residencePecReginde, residencePhone, residenceFax, professionalDomicileAddress, professionalDomicileEmail, professionalDomicilePec, professionalDomicilePecReginde, professionalDomicilePhone, professionalDomicileFax, taxDomicileAddress, taxDomicileEmail, taxDomicilePec, taxDomicilePecReginde, taxDomicilePhone, taxDomicileFax, mailingAddressAddress, mailingAddressEmail, mailingAddressPec, mailingAddressPecReginde, mailingAddressPhone, mailingAddressFax, studioMobilePhone, residenceMobilePhone, professionalDomicileMobilePhone, taxDomicileMobilePhone, mailingAddressMobilePhone))
divert(0)dnl
foreach(`x', data, m4_select(x))dnl
