package platechecker

import "github.com/VenturaDelMonte/go-plate-checker/backend/models"

// PlateChecker defines the behaviour of a component able to perform a plate check.
type PlateChecker interface {
	PlateCheck(models.Plate) error
}
