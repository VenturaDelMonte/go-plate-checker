package server

import (
	"net/http"

	"github.com/labstack/echo"
)

const (
	plateCheckEndpoint = `platecheck`
)

// Routes builds the server's routing table.
func (pcs PlateCheckerServer) Routes(assetHandler http.Handler) {
	// the file backend serves the index.html from the rice box
	pcs.e.GET("/", echo.WrapHandler(assetHandler))
	// servers other static files
	pcs.e.GET("/*", echo.WrapHandler(http.StripPrefix("/", assetHandler)))
	pcs.e.POST(plateCheckEndpoint, pcs.PlateCheckEndpoint())
}
