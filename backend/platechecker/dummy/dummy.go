package dummy

import "github.com/VenturaDelMonte/go-plate-checker/backend/models"

// PlateChecker implements a noop PlateChecker.
type PlateChecker struct{}

// PlateCheck is a noop and returns no errors.
func (pc PlateChecker) PlateCheck(models.Plate) error {
	return nil
}
