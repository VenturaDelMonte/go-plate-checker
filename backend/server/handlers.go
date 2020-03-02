package server

import (
	"errors"
	"io"
	"net/http"
	"os"

	"github.com/labstack/echo"
)

// Response is a generic response type.
type Response struct {
	Message string `json:"message"`
	Success bool   `json:"success"`
}

// PlateCheckEndpoint returns the platecheck handler.
func (pcs PlateCheckerServer) PlateCheckEndpoint() echo.HandlerFunc {
	return func(c echo.Context) error {

		file, err := c.FormFile("image")
		if err != nil {
			return pcs.logWriteReturn(c, http.StatusBadRequest, "could not get image part", false, err)
		}
		src, err := file.Open()
		if err != nil {
			return pcs.logWriteReturn(c, http.StatusBadRequest, "could not open file", false, err)
		}
		defer src.Close() // nolint: errcheck

		// Destination
		dst, err := os.Create(file.Filename)
		if err != nil {
			return pcs.logWriteReturn(c, http.StatusInternalServerError, "could not create file", false, err)
		}
		defer dst.Close() // nolint: errcheck

		// Copy
		if _, err = io.Copy(dst, src); err != nil {
			return pcs.logWriteReturn(c, http.StatusInternalServerError, "could not copy file content", false, err)
		}

		return c.JSON(http.StatusOK, Response{
			Message: file.Filename + " uploaded successfully",
			Success: true,
		})
	}
}

func customErrorHandler(err error, c echo.Context) {
	code := http.StatusInternalServerError
	if errors.Is(err, &echo.HTTPError{}) {
		he := err.(*echo.HTTPError)
		code = he.Code
	}
	_ = c.JSON(code, Response{
		Message: err.Error(),
		Success: false,
	})
	c.Logger().Error(err)
}
