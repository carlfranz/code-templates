divert(-1)dnl
include(`capitalize.m4')dnl
define(classname, `patsubst(capitalize($1), `-', `')')dnl
define(POJONAME, FEATURE)dnl
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

func POJONAME«List»(db *gorm.DB, dao models.POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		data, count, err := dao.FindAll(db)

		if err != nil {
			fmt.Println(err.Error())
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
		} else {
			items := make([]*dto.POJONAME, count)
			for i, a := range data {
				items[i] = dto.«New»POJONAME(a)
			}

			response := models.NewBaseResponse(items)
			response.WriteTo(w, http.StatusOK)
		}
	}
}

func POJONAME«Post»(db *gorm.DB, dao models.POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var statoCivile dto.POJONAME
		err := utilities.ReadRequestBody(r, &statoCivile)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		logger.With("stato civile", statoCivile).Info("Received statocivile")
		newId, err := dao.Create(db, statoCivile.ToModel())
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		«new»POJONAME, err := dao.Get(db, newId)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := dto.«New»POJONAME(«new»POJONAME)
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusCreated)
	}
}

func POJONAME«Put»(db *gorm.DB, dao models.POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		pathIdStr := vars["id"]
		logger.Info("Changing object with id", pathIdStr)
		pathId, err := strconv.Atoi(pathIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		var statoCivile dto.POJONAME
		err = utilities.ReadRequestBody(r, &statoCivile)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		dao.Update(db, int64(pathId), statoCivile.ToModel())
		response := models.NewBaseResponse(statoCivile)
		response.WriteTo(w, http.StatusOK)
	}
}

func POJONAME«Delete»(db *gorm.DB, dao models.POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		pathIdStr := mux.Vars(r)["id"]
		logger.Info("Deleting object with id", pathIdStr)
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

func POJONAME«Get»(db *gorm.DB, dao models.POJONAME«DAO») http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		pathIdStr := mux.Vars(r)["id"]
		logger.Info("Get object with id ", pathIdStr)
		pathId, err := strconv.Atoi(pathIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}

		«new»POJONAME, err := dao.Get(db, int64(pathId))
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := dto.«New»POJONAME(«new»POJONAME)
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusOK)
	}
}
