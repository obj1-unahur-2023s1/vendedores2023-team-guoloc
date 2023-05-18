import vendedores.*
import ciudades.*

class CentroDeDistribucion {
	var property ciudad // Ciudad donde se encuentra
	const vendedores = #{} // Conjunto de vendedores con los que trabaja
	
	method agregarVendedor(unVendedor) { 
		if (vendedores.contains(unVendedor)) {
			self.error("El vendedor ya se encuentra en la lista") // El msj "error" deja de ejecutar el código
		}
		vendedores.add(unVendedor)
	}
	
	// El vendedor con mas puntaje por certificaciones
	method vendedorEstrella() {
		return vendedores.max({v => v.puntaje()})
	}
	
	// Si el centro puede cubrir una ciudad dada, es decir un vendedor puede trabajar en dicha ciudad
	method puedeCubrir(unaCiudad) {
		return vendedores.any({v => v.puedeTrabajarEn(unaCiudad)})
	}
	
	// Devuelve una colección de vendedores genéricos
	method vendedoresGenericos() {
		return vendedores.filter({v => v.esGenerico()})
	}
	
	// Al menos 3 de sus vendedores registrados es firme
	method esRobusto() {
		return self.vendedoresFirmes().size() >= 3
	}
	
	method vendedoresFirmes() {
		return vendedores.filter({v => v.vendedorFirme()})
	}
	
	// Agrega una certificación dada a cada vendedor
	method repartirCertificacion(unaCertificacion) {
		vendedores.forEach({v => v.agregarCertificacion(unaCertificacion)})
	}

}
