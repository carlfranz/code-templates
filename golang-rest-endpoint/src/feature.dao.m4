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
package models

import (
	"errors"
	"fmt"

	"albosmart.module/visura/backend/commons/logger"
	"gorm.io/gorm"
)

var (
	ErrGeneric = errors.New("")
	«Err»m4_POJONAME«Found» = errors.New("")
	ErrEntityNotFound = errors.New("")
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
	table := db.Table("m4_TABLENAME")

	res := table.Find(&results)
	if res.Error != nil {
		fmt.Println("Error fetching data")
		return nil, 0, ErrGeneric
	}

	return results, res.RowsAffected, nil
}

func (di *m4_POJONAME) Update(db *gorm.DB, id int64, arg *m4_POJONAME) (result *m4_POJONAME, err error) {
	var m4_INSTANCENAME m4_POJONAME
	db.Table("m4_TABLENAME").First(&m4_INSTANCENAME, id)
	m4_INSTANCENAME.Value = arg.Value
	db.Table("m4_TABLENAME").Save(&m4_INSTANCENAME)
	return &m4_INSTANCENAME, nil
}

func (di *m4_POJONAME) Create(db *gorm.DB, value *m4_POJONAME) (id int64, err error) {
	var m4_INSTANCENAME m4_POJONAME
	logger.With("m4_INSTANCENAME", value).Info("Creating m4_INSTANCENAME in db")
	result := db.Table("m4_TABLENAME").Model(&m4_INSTANCENAME).Create(value)
	return int64(value.ID), result.Error
}

func (di *m4_POJONAME) FindOne(db *gorm.DB, id int64) (result *m4_POJONAME, err error) {
	logger.Info("Retrieving m4_INSTANCENAME from db with id ", id)
	var m4_INSTANCENAME m4_POJONAME
	res := db.Unscoped().Table("m4_TABLENAME").Model(&m4_INSTANCENAME).First(&m4_INSTANCENAME, id)
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return nil, «Err»m4_POJONAME«Found»
		} else {
			return nil, ErrGeneric
		}
	}
	return &m4_INSTANCENAME, nil
}

func (di *m4_POJONAME) Delete(db *gorm.DB, id int64) (err error) {
	res := db.Table("m4_TABLENAME").Delete(&m4_POJONAME{}, uint(id))
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return ErrEntityNotFound
		} else {
			return ErrGeneric
		}
	}
	return nil
}
