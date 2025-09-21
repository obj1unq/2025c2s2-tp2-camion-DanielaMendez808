object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}
object arenaAGranel {
	var property peso = 0
	method nivelPeligrosidad() { return 1 }
}
object bumblebee {
	var property transformado = "auto"
	method peso() { return 800 }
	method nivelPeligrosidad() {
		if (self.transformado() == "auto") {
			return 15 
		}else {
			return 30
		}
		}
}
object paqueteDeLadrillos {
	var property cantidad = 0
	method peso() { return (2*self.cantidad()) }
	method nivelPeligrosidad() { return 2 }
}
object bateriaAntiaerea {
	var property hayMisiles = false
	method peso() {
		if (self.hayMisiles()){
			return 300
		} else {
			return 200}
		}
	method nivePeligrosidad (){
		if (self.hayMisiles()){
			return 100
		}else{
			return 0}
	}
}
object residuosReactivos {
	var property peso = 0
	method nivelPeligrosidad() { return 200 }
}



