package bootstrap

import (
	"net/http"
	"github.com/cloudreve/Cloudreve/v3/pkg/util"
	"github.com/gin-contrib/static"
)

const StaticFolder = "statics"

type GinFS struct {
	FS http.FileSystem
}

type staticVersion struct {
	Name    string `json:"name"`
	Version string `json:"version"`
}

// StaticFS 内置静态文件资源
var StaticFS static.ServeFileSystem

// Open 打开文件
func (b *GinFS) Open(name string) (http.File, error) {
	return b.FS.Open(name)
}

// Exists 文件是否存在
func (b *GinFS) Exists(prefix string, filepath string) bool {
	return false
}

// InitStatic 初始化静态资源文件
func InitStatic() {
}

// Eject 抽离内置静态资源
func Eject() {
	util.Log().Info("内置静态资源导出完成")
}