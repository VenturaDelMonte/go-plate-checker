SRVFOLDER=server
CLNTFOLDER=client
GOROOT=$(shell go env GOROOT)
IMGTAG=$(shell basename `pwd`)

all: deps build run

.PHONY: build
build: clean ui pre-build
	mkdir -p ./$(SRVFOLDER)/bin && \
	CGO_ENABLED=0 go build -o ./$(SRVFOLDER)/bin/service ./$(SRVFOLDER)

.PHONY: clean
clean:
	@rm -rf ./$(SRVFOLDER)/bin
	@rm -rf ./$(CLNTFOLDER)/build

.PHONY: deps
deps:
	@go mod download

.PHONY: docker
docker:
	@docker build -f ./$(SRVFOLDER)/Dockerfile -t $(IMGTAG) .

.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: run
run:
	@cd $(SRVFOLDER) && ENV=dev go run main.go

.PHONY: ui
ui:
	@cd $(CLNTFOLDER) && npm i && npm run build

.PHONY: pre-build
pre-build:
	go get github.com/GeertJohan/go.rice
	go get github.com/GeertJohan/go.rice/rice

.PHONY: update_deps
update_deps:
	@go mod tidy
