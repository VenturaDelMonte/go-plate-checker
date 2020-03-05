package server

const (
	plateCheckEndpoint = `platecheck`
)

// Routes builds the server's routing table.
func (pcs PlateCheckerServer) Routes() {
	pcs.e.POST(plateCheckEndpoint, pcs.PlateCheckEndpoint())
}
