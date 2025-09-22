import cosas.*

object camion {
	const property pesoVacio = 1000
	const property cosas = #{}
	var property nivelDeRuta = 20
		
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
		return self.cosas().any{cosa => cosa.pesa(num)}
	}

	method hayCosaQuePesaEntre(num1,num2){
		return self.cosas().any{cosa => (cosa.peso()> num1 && cosa.peso()< num2)}
	}
	method cosaMasPesada(){
		self.validarQueElCamionNoEstaVacio()
		return self.cosas().max{cosa => cosa.peso()}
	}
	method pesoDeCadaCosa(){
		return self.cosas().map({cosa => cosa.peso()})
	}
	
	method cosaTieneNivel(cosa,num){
		return cosa.nivelPeligrosidad() == num
	}
	method validarQueElCamionNoEstaVacio(){
		if(self.cosas().isEmpty()){
			self.error ("El camion esta vacio")
		}
	}
	method algoDeNivel(num){
		self.validacionHayAlgoDeNivel(num)
		return self.cosas().find{cosa => self.estoTieneNivel(cosa,num)}
	}
	method hayAlgoDeNivel(num) {
		return self.cosas().any{cosa => self.estoTieneNivel(cosa,num)}
	  
	}
	//method nivelEsMasDe(cosa,num){
	//	return cosa.nivelPeligrosidad() > num
	//}
	method cosasQueSuperanNivel(num){
		return self.cosas().filter{cosa => cosa.nivelPeligrosidad() > num}
	}
	method cosasMasPeligrosasQue(_cosa){
		return self.cosas().filter{cosa => cosa.nivelPeligrosidad() > _cosa.nivelPeligrosidad()} 
	}
	method validacionHayAlgoDeNivel(num){
		if( !self.hayAlgoDeNivel(num))
		{
			self.error ({"No hay cosa que pese" + num })
		}
	}
	method estoTieneNivel(cosa,num){
		return cosa.nivelPeligrosidad() == num
	}
	method estaExcedidoDePeso(){
		return (self.pesoVacio() + self.pesoDeTodasLasCosas() > 2500)
	}
	method puedeCircularEnRuta(){
		return (!self.estaExcedidoDePeso() && (self.cosasQueSuperanNivel(self.nivelDeRuta())) == #{})
	}
	method bultoDeTodasLasCosas() {
		return self.cosas().sum{cosa => cosa.bulto()}
	}
	method ocurreAccidente() {
		self.cosas().forEach{cosa => cosa.accidente()}
	}
	method transportar(destino,camino){
		self.validarCamino(camino)
		destino.depositarCosas()
		self.cosas().clear()
	}
	method validarCamino(camino){
		if( !camino.soportaViaje())
		{
			self.error ({camino + "No soporta el vaje" })
		}
	}
}
object almacen{
	var property cosasEnAlmacen = #{}
	method depositarCosas() {
		self.cosasEnAlmacen(self.cosasEnAlmacen().union(camion.cosas()))
	}
	method cargar(cosa) {
		self.validarQueNoEstaLaCosa(cosa)
		cosasEnAlmacen.add(cosa)
	}
	method descargar(cosa){
		self.validarQueEstaLaCosa(cosa)
		cosasEnAlmacen.remove(cosa)
	}
	method validarQueEstaLaCosa(cosa){
		if(!self.cosasEnAlmacen().contains(cosa)){
			self.error ("La" + cosa + "no esta en el almacen")
		}
	}
	method validarQueNoEstaLaCosa(cosa){
		if(self.cosasEnAlmacen().contains(cosa)){
			self.error ("La" + cosa + "esta en el almacen")
		}
	}
}
object ruta9{
	method soportaViaje(){
		return camion.puedeCircularEnRuta()
	}
}
object caminosVecinales{
	var property pesoPermitido = 0
	method soportaViaje(){
		return ((camion.pesoVacio() + camion.pesoDeTodasLasCosas()) <= self.pesoPermitido())
	}
}