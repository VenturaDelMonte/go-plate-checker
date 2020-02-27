package dummy

import "github.com/VenturaDelMonte/go-plate-checker/backend/models"

// Store implements a noop store.
type Store struct {
}

// Get always returns an empty plate object and no errors.
func (s Store) Get(models.PlateID) (models.Plate, error) {
	return models.Plate{}, nil
}

// Set does not store its arguments and returns no errors.
func (s Store) Set(models.PlateID, models.Plate) error {
	return nil
}
