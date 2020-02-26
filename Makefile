SRVFOLDER=server
CLNTFOLDER=client
GOROOT=$(shell go env GOROOT)
GOLANGCI_LINT_VERSION=v1.23.6

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

.PHONY: deps-init
deps-init:
	rm go.mod go.sum
	go mod init
	go mod tidy

.PHONY: docker
docker:
	@cd $(SRVFOLDER) && GOROOT=$(GOROOT) rice embed-go
	@docker build -f ./$(SRVFOLDER)/Dockerfile -t go-react .
	@cd $(SRVFOLDER) && rm rice-box.go

.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: lint
lint:
	command -v golangci-lint || (cd /usr/local ; wget -O - -q https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s $(GOLANGCI_LINT_VERSION))
	golangci-lint run

.PHONY: pre-build
pre-build:
	go get github.com/GeertJohan/go.rice
	go get github.com/GeertJohan/go.rice/rice

.PHONY: run
run:
	@cd $(SRVFOLDER) && ENV=dev go run main.go

.PHONY: ui
ui:
	@cd $(CLNTFOLDER) && npm i && npm run build

.PHONY: update_deps
update_deps:
	@go mod tidy
