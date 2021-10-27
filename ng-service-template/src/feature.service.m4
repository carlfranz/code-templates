divert(-1)dnl
include(`capitalize.m4')dnl
define(classname, `patsubst(capitalize($1), `-', `')')dnl
define(POJONAME, classname(FEATURE))dnl
define(SERVICENAME, `classname(FEATURE)«Service»')dnl
changequote(`«', `»')
divert(0)dnl
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { pluck } from "rxjs/operators";
import { POJONAME } from "src/app/models/POJONAME";
import { UtilsService } from "src/app/services/utils.service";
import { environment } from "src/environments/environment";

@Injectable({
  providedIn: "root"
})
export class SERVICENAME {
  constructor(private http: HttpClient) {}

  list(): Observable<POJONAME[]> {
    console.info("Retrieving a list of POJONAME from server");
    return this.http.get(`ENDPOINT`);
  }

  get(id: string): Observable<POJONAME> {
    console.info("Retrieving the POJONAME with id "+ id);
    return this.http.get<POJONAME>(`ENDPOINT/${id}`);
  }

  save(id: number, entity: POJONAME): Observable<POJONAME> {
    if (id === 0) {
      return this.create(entity);
    } else {
      return this.update(id, entity);
    }
  }

  create(entity: POJONAME): Observable<POJONAME> {
    console.info("Creating a new POJONAME");
    return this.http.post<POJONAME>(`ENDPOINT`, entity);
  }

  update(id: number, entity: POJONAME): Observable<POJONAME> {
    console.info("Updating the POJONAME with id "+id);
    return this.http.put<POJONAME>(`ENDPOINT/${id}`, entity);
  }

  remove(id: number): Observable<{}> {
    console.info("Deleting the POJONAME with id"+ id);
    return this.http.delete<{}>(`ENDPOINT/${id}`);
  }
}
