divert(-1)dnl
include(`shared.m4')dnl
define(CLASSNAME, `classname(FEATURE)Effects')dnl
define(ACTIONFILE, `./FEATURE.action')dnl
divert(0)dnl
import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { load, error, success } from 'ACTIONFILE';
import { map, mergeMap } from 'rxjs/operators';

@Injectable()
export class CLASSNAME {
  
  load$ = createEffect(() =>
    this.actions$.pipe(
      ofType(load),
      map(() => success({items: []}))
    )
  );

  constructor(private actions$: Actions) {}
}
