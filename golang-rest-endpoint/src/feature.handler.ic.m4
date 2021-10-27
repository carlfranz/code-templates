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
define(m4_KEYTYPE, `int')
changequote(`«', `»')
divert(0)dnl
package handlers

import (
	"fmt"
	"net/http"

	"albosmart.module/visura/backend/commons/logger"
	"albosmart.module/visura/backend/commons/models"
	"albosmart.module/visura/backend/commons/utilities"
	"albosmart.module/visura/backend/registry-ms/dto"
	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

func m4_POJONAME«List»(db *gorm.DB, dao models.m4_POJONAME«DAO», userDao models.CfUserDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		uid, err := utilities.ReadUserID(r)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		agencyId, err := utilities.ReadAgencyId(uid, db, userDao)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		data, count, err := dao.FindByAgencyId(db, agencyId)
		if err != nil {
			fmt.Println(err.Error())
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
		} else {
			items := make([]*dto.m4_POJONAME, count)
			for i, a := range data {
				items[i] = «dto.New»m4_POJONAME(a)
			}

			response := models.NewBaseResponse(items)
			response.WriteTo(w, http.StatusOK)
		}
	}
}

func m4_POJONAME«Post»(db *gorm.DB, dao models.m4_POJONAME«DAO», userDao models.CfUserDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var privacyTemplate dto.m4_POJONAME
		uid, err := utilities.ReadUserID(r)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		agencyId, err := utilities.ReadAgencyId(uid, db, userDao)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		logger.Info(fmt.Sprintf("Creating m4_TABLENAME object for agency '%d'", agencyId))
		err = utilities.ReadRequestBody(r, &privacyTemplate)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		logger.With("m4_TABLENAME", privacyTemplate).Info("Received m4_TABLENAME")
		newId, err := dao.Create(db, privacyTemplate.ToModel(agencyId))
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
		sc := «dto.New»m4_POJONAME(newm4_POJONAME)
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusCreated)
	}
}

func m4_POJONAME«Put»(db *gorm.DB, dao models.m4_POJONAME«DAO», userDao models.CfUserDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		uid, err := utilities.ReadUserID(r)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		agencyId, err := utilities.ReadAgencyId(uid, db, userDao)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		vars := mux.Vars(r)
		pathIdStr := vars["privacyTemplateId"]
		logger.Info("Changing object with id", pathIdStr)
		var privacyTemplate dto.m4_POJONAME
		err = utilities.ReadRequestBody(r, &privacyTemplate)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		logger.Info(fmt.Sprintf("Updating m4_TABLENAME '%s' for agency '%d'", pathIdStr, agencyId))
		dao.Update(db, models.m4_KEYTYPE{ProfileName: pathIdStr, AgencyId: agencyId}, privacyTemplate.ToModel(agencyId))
		response := models.NewBaseResponse(privacyTemplate)
		response.WriteTo(w, http.StatusOK)
	}
}

func m4_POJONAME«Delete»(db *gorm.DB, dao models.m4_POJONAME«DAO», userDao models.CfUserDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		uid, err := utilities.ReadUserID(r)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		agencyId, err := utilities.ReadAgencyId(uid, db, userDao)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		pathIdStr := mux.Vars(r)["privacyTemplateId"]
		logger.Info("Deleting m4_TABLENAME with id", pathIdStr)
		dao.Delete(db, models.m4_KEYTYPE{ProfileName: pathIdStr, AgencyId: agencyId})
		w.WriteHeader(http.StatusNoContent)
	}
}

func m4_POJONAME«Get»(db *gorm.DB, dao models.m4_POJONAME«DAO», userDao models.CfUserDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		uid, err := utilities.ReadUserID(r)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		agencyId, err := utilities.ReadAgencyId(uid, db, userDao)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		pathIdStr := mux.Vars(r)["privacyTemplateId"]
		logger.Info("Get m4_TABLENAME with id ", pathIdStr)
		«new»m4_POJONAME, err := dao.FindOne(db, models.m4_KEYTYPE{ProfileName: pathIdStr, AgencyId: agencyId})
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := «dto.New»m4_POJONAME(«new»m4_POJONAME)
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusOK)
	}
}
