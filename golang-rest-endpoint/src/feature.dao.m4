divert(-1)dnl
include(`capitalize.m4')dnl
define(lowercase,`downcase(`$1')')
define(m4_POJONAME, FEATURE)dnl
define(m4_SEQNAME, lowercase(FEATURE))dnl
define(SERVICENAME, `classname(FEATURE)Service')dnl
changequote(`«', `»')
divert(0)dnl
package models

import (
	"errors"
	"fmt"

	"albosmart.module/visura/backend/commons/logger"
	"gorm.io/gorm"
)

type m4_POJONAME struct {
	ID        int    `gorm:"primaryKey";default: nextval('m4_SEQNAME«_id_seq»')`
	Value     string
	DeletedAt gorm.DeletedAt
}

type m4_POJONAME«DAO» interface {
	FindAll(db *gorm.DB) (results []*m4_POJONAME, count int64, err error)
	Update(db *gorm.DB, id int64, arg *m4_POJONAME) (result *m4_POJONAME, err error)
	Create(db *gorm.DB, arg *m4_POJONAME) (id int64, err error)
	FindOne(db *gorm.DB, id int64) (result *m4_POJONAME, err error)
	Delete(db *gorm.DB, id int64) (err error)
}

func (di *m4_POJONAME) FindAll(db *gorm.DB) (results []*m4_POJONAME, count int64, err error) {
	table := db.Table("m4_SEQNAME")


	res := table.Find(&results)
	if res.Error != nil {
		fmt.Println("Error fetching data")
		return nil, 0, ErrGeneric
	}

	return results, res.RowsAffected, nil
}

func (di *m4_POJONAME) Update(db *gorm.DB, id int64, arg *m4_POJONAME) (result *m4_POJONAME, err error) {
	var m4_POJONAME m4_POJONAME
	db.Table("m4_SEQNAME").First(&m4_POJONAME, id)
	m4_POJONAME.Value = arg.Value
	db.Table("m4_SEQNAME").Save(&m4_POJONAME)
	return &m4_POJONAME, nil
}

func (di *m4_POJONAME) Create(db *gorm.DB, value *m4_POJONAME) (id int64, err error) {
	var m4_POJONAME m4_POJONAME
	logger.With("stato civile", value).Info("Creating stato civile in db", value.Value)
	result := db.Table("m4_SEQNAME").Model(&m4_POJONAME).Create(value)
	return int64(value.ID), result.Error
}

func (di *m4_POJONAME) FindOne(db *gorm.DB, id int64) (result *m4_POJONAME, err error) {
	logger.Info("Retrieving stato civile from db with id ", id)
	var m4_POJONAME m4_POJONAME
	res := db.Unscoped().Table("m4_SEQNAME").Model(&m4_POJONAME).First(&m4_POJONAME, id)
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return nil, ErrEntityNotFound
		} else {
			return nil, ErrGeneric
		}
	}
	return &m4_POJONAME, nil
}

func (di *m4_POJONAME) Delete(db *gorm.DB, id int64) (err error) {
	res := db.Table("m4_SEQNAME").Delete(&m4_POJONAME{}, uint(id))
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return nil, ErrEntityNotFound
		} else {
			return nil, ErrGeneric
		}
	}
	return nil
}
