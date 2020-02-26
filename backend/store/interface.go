package store

import "github.com/VenturaDelMonte/go-plate-checker/backend/models"

// PlateStore defines the behaviour of a component capable of storing and retrieving a plate.
type PlateStore interface {
	Get(models.PlateID) (models.Plate, error)
	Set(models.PlateID, models.Plate) error
}
