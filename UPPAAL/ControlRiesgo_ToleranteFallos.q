// Propiedad 1: Ausencia de interbloqueos incluso en ModoFalloSeguro
A[] not deadlock

// Propiedad 2: Seguridad de contencion aun bajo atasco mecanico
A[] volumen <= MAX_CAPACIDAD

// Propiedad 3: Alcanzabilidad de la falla fisica (atasco)
E<> Compuerta.Atascada

// Propiedad 4: Alcanzabilidad de la contingencia (aliviadero lateral)
E<> Aliviadero.Abierto

// Propiedad 5: Vivacidad tolerante a fallos (cierre o desfogue garantizado)
Sensor.Critico --> (Compuerta.Cerrada or Aliviadero.Abierto)

// Propiedad 6: Coherencia del estado seguro de mantenimiento
A[] (Controlador.ModoFalloSeguro imply Compuerta.Atascada)
