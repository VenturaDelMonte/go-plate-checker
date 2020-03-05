SRVFOLDER=backend
CLNTFOLDER=frontend
GOROOT=$(shell go env GOROOT)
GOLANGCI_LINT_VERSION=v1.23.6
IMGTAG=$(shell basename `pwd`)

all: deps lint test build run

.PHONY: build
build: clean
	@mkdir -p ./$(SRVFOLDER)/bin && \
	cd $(SRVFOLDER) && \
	CGO_ENABLED=0 go build -o ./bin/service .

.PHONY: clean
clean:
	@rm -rf ./$(SRVFOLDER)/bin
	@rm -rf ./$(CLNTFOLDER)/dist

.PHONY: deps
deps:
	@npm i
	@go mod download

.PHONY: deps-init
deps-init:
	rm go.mod go.sum
	go mod init
	go mod tidy

.PHONY: docker
docker:
	@docker build -f ./$(SRVFOLDER)/Dockerfile -t $(IMGTAG) .

.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: lint
lint:
	command -v golangci-lint || (cd /usr/local ; wget -O - -q https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s $(GOLANGCI_LINT_VERSION))
	golangci-lint run

.PHONY: run
run:
	@cd $(SRVFOLDER) && go run main.go

.PHONY: test
test:
	go test ./...

.PHONY: ui
ui:
	@cd $(CLNTFOLDER) && npm run build

.PHONY: update_deps
update_deps:
	@go mod tidy
