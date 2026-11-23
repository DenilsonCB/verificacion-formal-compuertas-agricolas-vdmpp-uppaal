// Propiedad 1: Ausencia de interbloqueos (Deadlock-freedom)
A[] not deadlock

// Propiedad 2: Ausencia matematica de desbordamiento (Safety WCRT)
A[] volumen <= MAX_CAPACIDAD

// Propiedad 3: Alcanzabilidad del estado de emergencia (Reachability)
E<> Controlador.Emergencia

// Propiedad 4: Respuesta de cierre fisico completo ante deteccion critica (Liveness)
Sensor.Critico --> Compuerta.Cerrada

// Propiedad 5: Capacidad de drenaje fisico tras el cierre real (Reachability)
E<> MedioAmbiente.Drenando

// Propiedad 6: Coherencia fisica entre estado abierto de compuerta y llenado del canal
A[] (Compuerta.Abierta imply MedioAmbiente.Llenando)

// Propiedad 7: Recuperacion completa hasta nivel seguro por histeresis sin chattering
Sensor.Critico --> (Controlador.Monitoreando and volumen <= NIVEL_SEGURO)
