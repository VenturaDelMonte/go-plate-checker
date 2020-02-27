package server

import (
	"context"
	"fmt"

	"github.com/VenturaDelMonte/go-plate-checker/backend/platechecker"
	"github.com/VenturaDelMonte/go-plate-checker/backend/store"
	"github.com/google/uuid"
	"github.com/indiependente/pkg/logger"
	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

// PlateCheckerServer exposes endpoints to serve plate checking capabilities.
type PlateCheckerServer struct {
	e  *echo.Echo
	pc platechecker.PlateChecker
	s  store.PlateStore
	l  logger.Logger
}

// NewPlateCheckerServer returns a new instance of a PlateCheckerServer.
func NewPlateCheckerServer(pc platechecker.PlateChecker, s store.PlateStore, l logger.Logger) PlateCheckerServer {
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Gzip())
	e.Use(middleware.RequestIDWithConfig(middleware.RequestIDConfig{
		Generator: func() string {
			return uuid.New().String()
		},
	}))
	e.HTTPErrorHandler = customErrorHandler

	return PlateCheckerServer{
		e:  e,
		pc: pc,
		s:  s,
		l:  l,
	}
}

// Start starts the server on the hostname and port provided in a separate goroutine, returns an error eventually.
func (pcs PlateCheckerServer) Start(hostnameport string) error {
	pcs.l.Info("starting server on " + hostnameport)
	go func() {
		err := pcs.e.Start(hostnameport)
		if err != nil {
			pcs.l.Fatal("could not start server: ", err)
		}
	}()
	return nil
}

// Shutdown stops the server. It can shut the server down thanks to context cancellation, returns an error eventually.
//
// Implements the TerminationFn type exposed in https://github.com/indiependente/pkg/blob/master/shutdown/shutdown.go#L15
func (pcs PlateCheckerServer) Shutdown(ctx context.Context) error {
	pcs.l.Info("shutting down server")
	err := pcs.e.Shutdown(ctx)
	if err != nil {
		return fmt.Errorf("could not shutdown server: %w", err)
	}
	return nil
}

func (pcs PlateCheckerServer) logWriteReturn(c echo.Context, code int, msg string, success bool, err error) *echo.HTTPError {
	pcs.l.Error(msg, err)
	_ = c.JSON(code, Response{
		Message: msg,
		Success: success,
	})
	return &echo.HTTPError{
		Code:     code,
		Message:  msg,
		Internal: err,
	}
}
