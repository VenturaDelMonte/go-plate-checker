package server

import (
	"fmt"
	"io"
	"net/http"
	"os"

	"github.com/labstack/echo"
)

// PlateCheckEndpoint returns the platecheck handler.
func (pcs PlateCheckerServer) PlateCheckEndpoint() echo.HandlerFunc {
	return func(c echo.Context) error {
		file, err := c.FormFile("image")
		if err != nil {
			return fmt.Errorf("could not get image part: %w", err)
		}
		src, err := file.Open()
		if err != nil {
			return fmt.Errorf("could not open file: %w", err)
		}
		defer src.Close() // nolint: errcheck

		// Destination
		dst, err := os.Create(file.Filename)
		if err != nil {
			return fmt.Errorf("could not create file: %w", err)
		}
		defer dst.Close() // nolint: errcheck

		// Copy
		if _, err = io.Copy(dst, src); err != nil {
			return fmt.Errorf("could not copy file content: %w", err)
		}

		return c.HTML(http.StatusOK, fmt.Sprintf("<p>File %s uploaded successfully</p>", file.Filename))
	}
}
