class Nave{
	var property velocidad 

	method propulsar() {
		velocidad = (velocidad + 20000).min(30000)
	}

	method prepararParaViajar() {
		velocidad = (velocidad + 15000).min(300000) 
	}

	method encontrarseConUnEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	} 

	method recibirAmenaza() 

}

class NaveDeCarga inherits Nave{

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros inherits Nave{

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
	
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	method emitirMensaje() {
	  modo.mesaje(self)
	}

	method mensajeDeReposo() = "Saliendo en misión"

	method mensajeDeAtaque() = "Volviendo a la base"
}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method mesaje(nave) = nave.mensajeDeReposo()

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method mesaje(nave) = nave.mensajeDeAtaque()

}


class NaveDeResiduoRadictivo inherits Nave{
	var property selladaAlVacio = false

	override method recibirAmenaza() {
		if (selladaAlVacio)
		 self.velocidad(0) 
		else super()
	}

	override method prepararParaViajar() {
		super()
		selladaAlVacio = true
	}
	
}
