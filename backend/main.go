package main

import (
	"context"
	"fmt"
	"log"

	dummychecker "github.com/VenturaDelMonte/go-plate-checker/backend/platechecker/dummy"
	"github.com/VenturaDelMonte/go-plate-checker/backend/server"
	dummystore "github.com/VenturaDelMonte/go-plate-checker/backend/store/dummy"
	"github.com/indiependente/pkg/logger"
	"github.com/indiependente/pkg/shutdown"
)

const (
	serviceName = `plate-checker`
)

func main() {
	if err := run(); err != nil {
		log.Fatalf("Error while running: %s", err)
	}
}

func run() error {
	log := logger.GetLogger(serviceName, logger.INFO)
	ctx, cancel := context.WithCancel(context.Background())
	pc := dummychecker.PlateChecker{}
	store := dummystore.Store{}
	srv := server.NewPlateCheckerServer(pc, store, log)
	srv.Routes()
	err := srv.Start(":8000")
	if err != nil {
		return fmt.Errorf("server startup failed: %w", err)
	}
	err = shutdown.Wait(ctx, cancel, srv.Shutdown)
	if err != nil {
		return fmt.Errorf("server shutdown failed: %w", err)
	}
	return nil
}
