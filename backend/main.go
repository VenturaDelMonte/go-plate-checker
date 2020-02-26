package main

import (
	"context"
	"fmt"
	"log"
	"net/http"

	rice "github.com/GeertJohan/go.rice"
	dummychecker "github.com/VenturaDelMonte/go-plate-checker/backend/platechecker/dummy"
	"github.com/VenturaDelMonte/go-plate-checker/backend/server"
	dummystore "github.com/VenturaDelMonte/go-plate-checker/backend/store/dummy"
	"github.com/indiependente/pkg/logger"
	"github.com/indiependente/pkg/shutdown"
)

const (
	serviceName = `plate-checker`
)

type Message struct {
	Text string `json:"text"`
}

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
	assetHandler := http.FileServer(rice.MustFindBox("../frontend/dist").HTTPBox())
	srv.Routes(assetHandler)
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
