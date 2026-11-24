# Verificación Formal de Compuertas Agrícolas (VDM++ y UPPAAL)

Especificación formal en **VDM++** (Overture Tool v3.0.2, VDM-10) y verificación temporal **WCRT** (*Worst-Case Response Time*) mediante *model checking* en **UPPAAL 5.0.0** para el control automatizado de compuertas en redes de riego (caso Represa Condoroma / Canal Majes Siguas).

**Curso:** Aspectos Formales de Especificación y Verificación (AFEV)  
**Institución:** Universidad Nacional de San Agustín de Arequipa (UNSA) — EPIS  
**Video de sustentación:** https://youtu.be/bUNeQdU5SAA

## Integrantes
- Ayamamani Anasco, Francis Willian (`fayamamani@unsa.edu.pe`)
- Choquehuanca Bedoya, Brayan Denilson (`bchoquehuancab@unsa.edu.pe`)
- Choquehuanca Berna, William Herderson (`wchoquehuancab@unsa.edu.pe`)
- Quispe Flores, Marco Ramiro (`mquispeflores@unsa.edu.pe`)

## Estructura del Repositorio

```text
├── ControlRiesgo/                            # Proyecto VDM++ (Overture v3.0.2)
│   ├── .project                              # Descriptor de proyecto Overture (VDM-10)
│   ├── Sensor.vdmpp                          # Caudal, niveles y LecturaSensor (3 niveles)
│   ├── Compuerta.vdmpp                       # Actuador <ABIERTA>/<PARCIAL>/<CERRADA>
│   ├── Canal.vdmpp                           # Capacidad fisica e invariante de contencion
│   ├── Controlador.vdmpp                     # Control preventivo, Map/Set/Seq y balance
│   └── Test.vdmpp                            # Suite de 6 escenarios con AssertTrue
├── UPPAAL/                                   # Modelos y consultas CTL (UPPAAL 5.0.0)
│   ├── ControlRiesgo.xml                     # Escenario certificado VERDE (T_CIERRE = 6s)
│   ├── ControlRiesgo_Contraejemplo.xml       # Contraejemplo ROJO de desborde (T_CIERRE = 10s)
│   ├── ControlRiesgo.q                       # 7 consultas CTL base
│   ├── ControlRiesgo_ToleranteFallos.xml     # Variante con atasco, Watchdog y Aliviadero
│   └── ControlRiesgo_ToleranteFallos.q       # 6 consultas CTL de tolerancia a fallos
└── entrega_final_proyecto/
    └── articulo_y_diapositivas_unificado.pdf # Articulo IEEE y diapositivas en un solo PDF
```

## Resumen

1. **Especificación Formal en VDM++ (`ControlRiesgo/`):**
   - Modela cinco clases (`Sensor`, `Compuerta`, `Canal`, `Controlador`, `Test`) con acceso directo a `.id` en invariantes y precondiciones.
   - Define clasificación en tres niveles (`<NORMAL>`, `<PRECAUCION>` con estrangulamiento al `50%`, `<CRITICO>` con cierre y alivio), balance hídrico en `Canal` y registro cronológico `historial_telemetria` (`seq`), integrando `Set`, `Seq` y `Map`.
2. **Verificación Temporal WCRT en UPPAAL 5.0.0 (`UPPAAL/`):**
   - Modela cuatro autómatas acoplados (`Sensor`, `Controlador`, `Compuerta`, `MedioAmbiente`) con retardo mecánico real en `Compuerta.Cerrando` (`T_CIERRE`) y banda de histéresis (`NIVEL_SEGURO = 60`, `NIVEL_PELIGRO = 80`).
   - Demuestra mediante contraejemplo que para `T_CIERRE >= 9s` el volumen supera `MAX_CAPACIDAD = 100` (`105 m³` con `T_CIERRE = 10s`) y certifica la cota segura `T_CIERRE <= 8s` (`7/7` propiedades CTL satisfechas con `T_CIERRE = 6s`, pico `95 m³`).
   - Incluye la variante independiente `ControlRiesgo_ToleranteFallos.xml` con estado `Atascada`, temporizador *Watchdog* (`5s`) y quinto autómata `Aliviadero` (`2s`) (`6/6` propiedades CTL satisfechas).

## Reproducibilidad

### VDM++ (Overture Tool v3.0.2)
1. Abrir Overture Tool v3.0.2 e importar `ControlRiesgo/` (`File -> Import... -> Existing Projects into Workspace`).
2. Ejecutar `new Test().EjecutarPruebas()` en la consola de depuración (`true` con `100.0%` de cobertura).

También se puede validar desde línea de comandos con el *commandline tool* de Overture v3.0.2:
```bash
java -jar commandlinetool-3.0.2-jar-with-dependencies.jar -vdmpp -e "new Test().EjecutarPruebas()" ControlRiesgo
```

### UPPAAL 5.0.0
Abrir los archivos `.xml` y `.q` en la interfaz de UPPAAL 5.0.0 (pestaña *Verifier*), o ejecutar `verifyta`:
```bash
verifyta UPPAAL/ControlRiesgo.xml UPPAAL/ControlRiesgo.q
verifyta -t1 -o1 UPPAAL/ControlRiesgo_Contraejemplo.xml UPPAAL/ControlRiesgo.q
verifyta UPPAAL/ControlRiesgo_ToleranteFallos.xml UPPAAL/ControlRiesgo_ToleranteFallos.q
```
