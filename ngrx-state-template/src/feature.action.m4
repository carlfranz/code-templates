divert(-1)
include(`shared.m4')dnl
divert(0)dnl
import { createAction, props } from '@ngrx/store';

export const load = createAction('[FEATURE] Load');

export const error = createAction('[FEATURE] Error', props<{ error: Error }>())

export const success = createAction('[FEATURE] Success', props<{ items: POJONAME[] }>());


