package server

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/VenturaDelMonte/go-plate-checker/backend/platechecker"
	"github.com/VenturaDelMonte/go-plate-checker/backend/store"
	"github.com/golang/mock/gomock"
	"github.com/indiependente/pkg/logger"
	"github.com/labstack/echo"
	"github.com/stretchr/testify/assert"
)

func TestPlateCheckerServer_PlateCheckEndpoint(t *testing.T) {
	t.Parallel()
	expectedJSON := "{\"message\":\"could not get image part\",\"success\":false}\n"

	ctrl := gomock.NewController(t)
	req := httptest.NewRequest(http.MethodPost, "/"+plateCheckEndpoint, nil)
	rec := httptest.NewRecorder()
	pcmock := platechecker.NewMockPlateChecker(ctrl)
	storemock := store.NewMockPlateStore(ctrl)
	log := logger.GetLogger("test", logger.DISABLED)
	pcs := NewPlateCheckerServer(pcmock, storemock, log)
	c := pcs.e.NewContext(req, rec)
	c.SetParamNames("image")
	c.SetParamValues(`this is not an image`)
	handler := pcs.PlateCheckEndpoint()
	err := handler(c).(*echo.HTTPError)

	if assert.EqualError(t, err, "code=400, message=could not get image part") {
		assert.Equal(t, http.StatusBadRequest, err.Code)
		assert.Equal(t, expectedJSON, rec.Body.String())
	}
}
