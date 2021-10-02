divert(-1)
include(`shared.m4')dnl
divert(0)dnl
// selectors
import { createSelector } from '@ngrx/store';
import { State } from 'src/app/state/app.state';

const selectState = (state: State) => state.STORENAME;

export const selectStatus = createSelector<State, STATENAME, STATESTATUS>(selectState, (s1) => s1.status);

