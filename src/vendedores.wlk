import ciudades.*

class VendedorFijo {
	const certificaciones = []
	const property ciudadDondeVive
	
	// Agrega certificaciones
	method agregarCertificacion(certificacion) {
		certificaciones.add(certificacion)
	} 

	// Para saber si puede trabajar en **unaCiudad**
	method puedeTrabajarEn(unaCiudad) {
		return unaCiudad == ciudadDondeVive
	}
	
	// Para saber si el vendedor es versátil
	method esVersatil() {
		return 	certificaciones.size() >= 3 and
				certificaciones.any({c => c.esProducto()}) and
				certificaciones.any({c => not c.esProducto()})
	}
	
	// Para saber si es un vendedor firme
	method vendedorFirme() {
		return self.puntaje() >= 30
	}
	
	// Para saber si un vendedor es influyente
	method esInfluyente() {
		return false
	}
	
	// Para saber el puntaje por certificaciones
	method puntaje() {
		return certificaciones.sum({c => c.puntos()})
	}
	
	// Para saber si un vendedor es genérico
	method esGenerico() {
		return certificaciones.any({c => not c.esProducto()})
	}
	
	// Indica si un vendedor tiene afinidad con el centro
	method tieneAfinidad(centro) {
		return self.puedeTrabajarEn(centro.ciudad())
	}
	
	// Indica si un vendedor es candidato
	method esVendedorCandidato(unVendedor, centro) {
		return 	unVendedor.esVersatil() and
				unVendedor.tieneAfinidad(centro)
	}
}

class VendedorViajante {
	const certificaciones = []
	const provinciasDondeTrabaja = #{}
	
	// Agrega certificaciones
	method agregarCertificacion(certificacion) {
		certificaciones.add(certificacion)
	} 
	
	// Para saber si puede trabajar en **unaCiudad**
	method puedeTrabajarEn(unaCiudad) {
		return provinciasDondeTrabaja.contains(unaCiudad.provincia())
	}
	
	// Para saber si el vendedor es versátil
	method esVersatil() {
		return 	certificaciones.size() >= 3 and
				certificaciones.any({c => c.esProducto()}) and
				certificaciones.any({c => not c.esProducto()})
	}
	
	// Para saber si es un vendedor firme
	method vendedorFirme() {
		return self.puntaje() >= 30
	}
	
	// Para saber si un vendedor es influyente
	method esInfluyente() {
		return provinciasDondeTrabaja.sum({p => p.poblacion()}) >= 10000000
	}	
	
	// Para saber el puntaje por certificaciones
	method puntaje() {
		return certificaciones.sum({c => c.puntos()})
	}
	
	// Para saber si un vendedor es genérico
	method esGenerico() {
		return certificaciones.any({c => not c.esProducto()})
	}
	
	// Indica si un vendedor tiene afinidad con el centro
	method tieneAfinidad(centro) {
		return self.puedeTrabajarEn(centro.ciudad())
	}
	
	// Indica si un vendedor es candidato
	method esVendedorCandidato(unVendedor, centro) {
		return 	unVendedor.esVersatil() and
				unVendedor.tieneAfinidad(centro)
	}
}

class ComercioCorresponsal {
	const certificaciones = []
	const ciudadesConSucursales = #{} 
	
	method agregarCertificacion(certificacion) {
		certificaciones.add(certificacion)
	} 
	
	// Para saber si puede trabajar en **unaCiudad**
	method puedeTrabajarEn(unaCiudad) {
		return ciudadesConSucursales.contains(unaCiudad)
	}
	
	// Para saber si el vendedor es versátil
	method esVersatil() {
		return 	certificaciones.size() >= 3 and
				certificaciones.any({c => c.esProducto()}) and
				certificaciones.any({c => not c.esProducto()})
	}
	
	// Para saber si es un vendedor firme
	method vendedorFirme() {
		return self.puntaje() >= 30
	}
	
	// Para saber si un vendedor es influyente
	method esInfluyente() {
		return 	ciudadesConSucursales.size() >= 5 or
				self.provinciaDeCiudades().size() >= 3
	}
	
	// Devuelve un conjunto con las provincias de ciudadesConSucursales
	method provinciaDeCiudades() {
		return ciudadesConSucursales.map({c => c.provincia()}).asSet()
	}
	
	// Para saber el puntaje por certificaciones
	method puntaje() {
		return certificaciones.sum({c => c.puntos()})
	}
	
	// Para saber si un vendedor es genérico
	method esGenerico() {
		return certificaciones.any({c => not c.esProducto()})
	}
	
	// Indica si un vendedor tiene afinidad con el centro
	method tieneAfinidad(centro) {
		return 	self.puedeTrabajarEn(centro.ciudad()) and
				ciudadesConSucursales.any({c => not centro.puedeCubrir(c)})
	}
	
	// Indica si un vendedor es candidato
	method esVendedorCandidato(unVendedor, centro) {
		return 	unVendedor.esVersatil() and
				unVendedor.tieneAfinidad(centro)
	}
	
}

class Certificacion {
	var property puntos // Cantidad de puntos
	var property esProducto // Boolean
}