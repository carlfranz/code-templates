divert(-1)dnl
include(`capitalize.m4')dnl
define(m4_capitalize_first, `regexp(`$1', `\(^\w\)\(.+\)', `upcase(`\1')'`\2')')dnl
dnl
dnl
define(lowercase,`downcase(`$1')')dnl
define(m4_snake_case, `downcase(patsubst(`$1', `[A-Z]', `_\&'))')dnl
define(m4_INSTANCENAME, FEATURE)dnl
define(m4_POJONAME, m4_capitalize_first(FEATURE))dnl
define(m4_SEQNAME, lowercase(FEATURE))dnl
define(m4_TABLENAME, m4_snake_case(FEATURE))dnl
define(SERVICENAME, `classname(FEATURE)Service')dnl
changequote(`«', `»')
divert(0)dnl
package handlers

import (
	"fmt"
	"net/http"
	"strconv"

	"albosmart.module/visura/backend/commons/logger"
	"albosmart.module/visura/backend/commons/models"
	"albosmart.module/visura/backend/commons/utilities"
	"albosmart.module/visura/backend/registry-ms/dto"
	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

func m4_POJONAME«List»(db *gorm.DB, dao models.m4_POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
		registryIdStr := vars["registryId"]
		registryId, err := strconv.Atoi(registryIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		data, count, err := dao.FindByRegistryId(db, registryId)
		if err != nil {
			fmt.Println(err.Error())
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
		} else {
			items := make([]*dto.m4_POJONAME, count)
			for i, a := range data {
				items[i] = dto.«New»m4_POJONAME«(a)»
			}

			response := models.NewBaseResponse(items)
			response.WriteTo(w, http.StatusOK)
		}
	}
}

func m4_POJONAME«Post»(db *gorm.DB, dao models.m4_POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var m4_INSTANCENAME dto.m4_POJONAME
    registryIdStr := mux.Vars(r)["registryId"]
		logger.Info(fmt.Sprintf("Creating m4_TABLENAME object for registry entry '%s'", registryIdStr))
		registryId, err := strconv.Atoi(registryIdStr)
    if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		err = utilities.ReadRequestBody(r, &m4_INSTANCENAME)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		logger.With("m4_TABLENAME", m4_INSTANCENAME).Info("Received m4_TABLENAME")
		newId, err := dao.Create(db, m4_INSTANCENAME.ToModel(registryId))
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		«new»m4_POJONAME, err := dao.FindOne(db, newId)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := dto.«New»m4_POJONAME«(new»m4_POJONAME«)»
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusCreated)
	}
}

func m4_POJONAME«Put»(db *gorm.DB, dao models.m4_POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		pathIdStr := vars["m4_INSTANCENAME«Id»"]
		registryIdStr := vars["registryId"]
		logger.Info("Changing object with id", pathIdStr)
		pathId, err := strconv.Atoi(pathIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
    registryId, err := strconv.Atoi(registryIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		var m4_INSTANCENAME dto.m4_POJONAME
		err = utilities.ReadRequestBody(r, &m4_INSTANCENAME)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		dao.Update(db, int64(pathId), m4_INSTANCENAME.ToModel(registryId))
		response := models.NewBaseResponse(m4_INSTANCENAME)
		response.WriteTo(w, http.StatusOK)
	}
}

func m4_POJONAME«Delete»(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		pathIdStr := mux.Vars(r)["m4_INSTANCENAME«Id»"]
		logger.Info("Deleting m4_TABLENAME with id", pathIdStr)
		pathId, err := strconv.Atoi(pathIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}

		dao.Delete(db, int64(pathId))
		w.WriteHeader(http.StatusNoContent)
	}
}

func m4_POJONAME«Get»(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		pathIdStr := mux.Vars(r)["m4_INSTANCENAME«Id»"]
		logger.Info("Get m4_TABLENAME with id ", pathIdStr)
		pathId, err := strconv.Atoi(pathIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}

		«new»m4_POJONAME, err := dao.FindOne(db, int64(pathId))
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := «dto.New»m4_POJONAME«(new»m4_POJONAME«)»
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusOK)
	}
}
