package models

import (
	"errors"
	"fmt"

	"albosmart.module/visura/backend/commons/logger"
	"gorm.io/gorm"
)

type SocialInfo struct {
	Id        int `gorm:"primaryKey";default: nextval('socialinfo_id_seq')`
	Link      string
	LinkType  string
	RegistryId int
	DeletedAt gorm.DeletedAt
}

type SocialInfoDAO interface {
	FindAll(db *gorm.DB) (results []*SocialInfo, count int64, err error)
	FindByRegistryId(db *gorm.DB, registryId int) (results []*SocialInfo, count int64, err error)
	Update(db *gorm.DB, id int64, arg *SocialInfo) (result *SocialInfo, err error)
	Create(db *gorm.DB, arg *SocialInfo) (id int64, err error)
	FindOne(db *gorm.DB, id int64) (result *SocialInfo, err error)
	Delete(db *gorm.DB, id int64) (err error)
}

func (di *SocialInfo) FindAll(db *gorm.DB) (results []*SocialInfo, count int64, err error) {
	table := db.Table("social_info")
	res := table.Find(&results)
	if res.Error != nil {
		fmt.Println("Error fetching data")
		return nil, 0, ErrGeneric
	}

	return results, res.RowsAffected, nil
}

func (di *SocialInfo) FindByRegistryId(db *gorm.DB, registryId int) (results []*SocialInfo, count int64, err error) {
	table := db.Table("social_info")
	res := table.Where(&SocialInfo{RegistryId: registryId}).Find(&results)
	if res.Error != nil {
		fmt.Println("Error retrieving data")
		return nil, 0, ErrGeneric
	}
	return results, res.RowsAffected, nil
}

func (di *SocialInfo) Update(db *gorm.DB, id int64, arg *SocialInfo) (result *SocialInfo, err error) {
	var socialInfo SocialInfo
	db.Table("social_info").First(&socialInfo, id)
	socialInfo.Link = arg.Link
	socialInfo.LinkType = arg.LinkType
	db.Table("social_info").Save(&socialInfo)
	return &socialInfo, nil
}

func (di *SocialInfo) Create(db *gorm.DB, value *SocialInfo) (id int64, err error) {
	var socialInfo SocialInfo
	logger.With("social info", value).Info("Creating social info in db")
	result := db.Table("social_info").Model(&socialInfo).Create(value)
	return int64(value.Id), result.Error
}

func (di *SocialInfo) FindOne(db *gorm.DB, id int64) (result *SocialInfo, err error) {
	logger.Info("Retrieving social info from db with id ", id)
	var socialInfo SocialInfo
	res := db.Unscoped().Table("social_info").Model(&socialInfo).First(&socialInfo, id)
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return nil, ErrSocialInfoNotFound
		} else {
			return nil, ErrGeneric
		}
	}
	return &socialInfo, nil
}

func (di *SocialInfo) Delete(db *gorm.DB, id int64) (err error) {
	res := db.Table("social_info").Delete(&SocialInfo{}, uint(id))
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return ErrSocialInfoNotFound
		} else {
			return ErrGeneric
		}
	}
	return nil
}
