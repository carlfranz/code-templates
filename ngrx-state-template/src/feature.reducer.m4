divert(-1)
include(`shared.m4')dnl
define(ACTIONFILE, `./FEATURE.action')dnl
define(REDUCERNAME, `reducername(FEATURE)Reducer')dnl
define(REDUCERNAMEPVT, `reducername(FEATURE)ReducerPrivate')dnl
divert(0)dnl
// State for this feature
import { Action, createReducer, on } from '@ngrx/store';
import { success, load } from 'ACTIONFILE';

export const enum STATESTATUS {
  IDLE='IDLE', 
  LOADING='LOADING',
  DATA='DATA',
  ERROR='ERROR'
}

export interface STATENAME {
  status: STATESTATUS;	
  items: POJONAME[];
}

const initialState: STATENAME = {
  status: STATESTATUS.IDLE,
  items: []
};

const REDUCERNAMEPVT = createReducer<STATENAME>(
  initialState,
  on(success, (state: STATENAME, action: any) => ({
    ...state,
    status: STATESTATUS.DATA,
    items: action.items,
  })),
  on(load, (state: STATENAME, action) => ({
    ...state,
    items: [],
    status: STATESTATUS.LOADING
  }))
);

export function REDUCERNAME (state: STATENAME, action: Action) {
  return REDUCERNAMEPVT (state, action);
}
