divert(-1)dnl
include(`foreach.m4')dnl
include(`capitalize.m4')dnl
define(`_space_to_dash', `translit($1,` ',`-')')dnl
define(`_form_row', `
  <div class="grid-header"> $1 </div>
  <div class="form-check">
    <input type="checkbox" class="form-check-input position-static" id="$2-prfexn" formControlName="$3PrfExn" />

  </div>
  <div class="form-check">
    <input type="checkbox" class="form-check-input position-static" id="$2-encspl" formControlName="$3EncSpl" />

  </div>
  <div class="form-check">
    <input type="checkbox" class="form-check-input position-static" id="$2-prtcnt" formControlName="$3PrtCnt" />

  </div>
  <div class="form-check">
    <input type="checkbox" class="form-check-input position-static" id="$2-stpkey" formControlName="$3StpKey" />

  </div>')dnl
define(`_cat', `$1$2$3')dnl
define(`inputdata', `(
  `(`technical consultant of the court', `cons-trib', `consTrib')',
  `(`court-expert', `per-trib', `perTrib')',
  `(`bankruptcy trustee', `cur-fal', `curFal')',
  `(`overindebtedness crisis manager', `occ', `occ')',
  `(`exclusive professional activity', `att-escl', `attEscl')',
  `(`teaching qualification', `abil-ins', `abilIns')',
  `(`bankruptcy proceedings', `proc-conc', `procConc')',
  `(`exhibitor', `non-eserc', `nonEserc')',
  `(`insurance', `ass', `ass')',
  `(`statutory auditor', `rev-leg', `revLeg')',
  `(`pension fund', `cassa-prev', `cassaPrev')',
)')dnl
divert(0)dnl
foreach(`x', inputdata, `_cat(`_form_row',x)')
