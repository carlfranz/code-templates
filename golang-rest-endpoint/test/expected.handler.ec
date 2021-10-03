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

func SocialInfoList(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
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
			items := make([]*dto.SocialInfo, count)
			for i, a := range data {
				items[i] = dto.NewSocialInfo(a)
			}

			response := models.NewBaseResponse(items)
			response.WriteTo(w, http.StatusOK)
		}
	}
}

func SocialInfoPost(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var socialInfo dto.SocialInfo
		registryIdStr := mux.Vars(r)["registryId"]
		logger.Info(fmt.Sprintf("Creating social_info object for registry entry '%s'", registryIdStr))
		registryId, err := strconv.Atoi(registryIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		err = utilities.ReadRequestBody(r, &socialInfo)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		logger.With("social_info", socialInfo).Info("Received social_info")
		newId, err := dao.Create(db, socialInfo.ToModel(registryId))
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		newSocialInfo, err := dao.FindOne(db, newId)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := dto.NewSocialInfo(newSocialInfo)
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusCreated)
	}
}

func SocialInfoPut(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		pathIdStr := vars["socialInfoId"]
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
		var socialInfo dto.SocialInfo
		err = utilities.ReadRequestBody(r, &socialInfo)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}
		dao.Update(db, int64(pathId), socialInfo.ToModel(registryId))
		response := models.NewBaseResponse(socialInfo)
		response.WriteTo(w, http.StatusOK)
	}
}

func SocialInfoDelete(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		pathIdStr := mux.Vars(r)["socialInfoId"]
		logger.Info("Deleting social_info with id", pathIdStr)
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

func SocialInfoGet(db *gorm.DB, dao models.SocialInfoDAO) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		pathIdStr := mux.Vars(r)["socialInfoId"]
		logger.Info("Get social_info with id ", pathIdStr)
		pathId, err := strconv.Atoi(pathIdStr)
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusBadRequest)
			return
		}

		newSocialInfo, err := dao.FindOne(db, int64(pathId))
		if err != nil {
			response := models.NewBaseResponseError(err)
			response.WriteTo(w, http.StatusInternalServerError)
			return
		}
		sc := dto.NewSocialInfo(newSocialInfo)
		response := models.NewBaseResponse(sc)
		response.WriteTo(w, http.StatusOK)
	}
}
