import camion.*
object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bulto() {return 1}
	method accidente() {}
}
object arenaAGranel {
	var property peso = 0
	method nivelPeligrosidad() { return 1 }
	method bulto() {return 1}
	method accidente() { self.peso(self.peso() + 20) }
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
	method bulto() {return 2}
	method accidente() {
		if (transformado == "auto"){
			self.transformado("robot")
		} else {
			self.transformado ("auto")
		}
	}
}
object paqueteDeLadrillos {
	var property cantidad = 0
	method accidente() {
		if (self.cantidad() >= 12){
			self.cantidad(self.cantidad() - 12)
		} else {
			self.cantidad(0)
		}
	}
	method peso() { return (2*self.cantidad()) }
	method nivelPeligrosidad() { return 2 }
	method bulto(){
		if(self.cantidad() < 100){
			return 1
		}else if (self.cantidad() > 101 && self.cantidad() < 300){
			return 2
		} else {
			return 3
		}
	}
}
object bateriaAntiaerea {
	var property hayMisiles = false
	method peso() {
		if (self.hayMisiles()){
			return 300
		} else {
			return 200}
		}
	method nivelPeligrosidad (){
		if (self.hayMisiles()){
			return 100
		}else{
			return 0}
	}
	method accidente() {
		self.hayMisiles(false)
	}
	method bulto(){
		if (self.hayMisiles()){
			return 2
		} else {return 1}
	}
}
object residuosRadioactivos {
	var property peso = 0
	method nivelPeligrosidad() { return 200 }
	method bulto() {return 1}
	method accidente() {self.peso(self.peso() + 15)}
}
object contenedorPortuario{
	const property cosas = #{}
	var property pesoBase = 0 
	method accidente() {
		self.cosas().forEach{cosa => cosa.accidente()}
	}
	method bulto(){
		return 1 + self.bultoDeTodasLasCosas()
	}
	method bultoDeTodasLasCosas() {
		return self.cosas().sum{cosa => cosa.bulto()}
	}
	method cargar(cosa) {
		self.validarQueNoEstaLaCosa(cosa)
		self.validarQueNoEstaLaCosaEnCamion(cosa)
		cosas.add(cosa)
	}
	method descargar(cosa){
		self.validarQueEstaLaCosa(cosa)
		cosas.remove(cosa)
	}
	method validarQueEstaLaCosa(cosa){
		if(!self.cosas().contains(cosa)){
			self.error ("La" + cosa + "no esta en la lista")
		}
	}
	method validarQueNoEstaLaCosa(cosa){
		if(self.cosas().contains(cosa)){
			self.error ("La" + cosa + "esta en la lista")
		}
	}
	method validarQueNoEstaLaCosaEnCamion(cosa){
		if(camion.cosas().contains(cosa)){
			self.error ("La" + cosa + "ya esta en el camion")
		}
	}
	method pesoDeTodasLasCosas() {
		return self.cosas().sum{cosa => cosa.peso()}
	}
	method peso(){
		return self.pesoBase() + self.pesoDeTodasLasCosas()
	}
	method nivelPeligrosidad(){
	    if (self.cosas().isEmpty()) {
        return 0
    } else {
        return self.cosas().max{ cosa => cosa.nivelPeligrosidad() }
    }
}

}
//method nivelPeligrosidad() {
//    return self.cosas().maxIfEmpty({ cosa => cosa.nivelPeligrosidad() }, 0)
//}
object embalajeDeSeguridad{
	var property cosaQueEmbala= null
	method peso(){
		return cosaQueEmbala.peso()
	}
	method nivelPeligrosidad(){
		return cosaQueEmbala.nivelPeligrosidad()/2
	}
	method bulto(){return 2}
	method accidente() {}
}



