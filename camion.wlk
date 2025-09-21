import cosas.*

object camion {
	const property pesoVacio = 1000
	const property cosas = #{}
		
	method cargar(cosa) {
		self.validarQueNoEstaLaCosa(cosa)
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
	method pesoDeTodasLasCosas() {
		return self.cosas().sum{cosa => cosa.peso()}
	}
	method pesoDeTodasLasCosasEsPar(){
		return self.pesoEsPar(self.pesoDeTodasLasCosas())
	}
	method pesoEsPar(num){
		return (num%2 == 0)
	}
	//con find si no encuentra algo devuelve null, por eso el assert cuando espera false y recibe null pone error,mientras que con any, si no encuentra lo que busca manda un false que con ese si puedo usar assert que solo entiende con booleanos(false,true).
	method hayAlgoQuePesa(num){
		return self.cosas().any{cosa => self.estoPesa(cosa,num)}
	}
	method estoPesa(cosa,num){
		return cosa.peso() == num
	}
	method estaExcedidoDePeso(){
		return (self.pesoVacio() + self.pesoDeTodasLasCosas() > 2500)
	}
}
