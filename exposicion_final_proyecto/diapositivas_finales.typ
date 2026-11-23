// =====================================================================
// DIAPOSITIVAS UNSA - ASPECTOS FORMALES DE ESPECIFICACIÓN Y VERIFICACIÓN
// =====================================================================

#set document(
  title: "Aspectos Formales de Especificación y Verificación - Proyecto Final",
  author: "UNSA - Escuela Profesional de Ingeniería de Sistemas"
)

#set text(font: ("Segoe UI", "Arial"), size: 11.5pt, fill: black)

// Paleta institucional UNSA (texto principal en #000000, sin cajas grises)
#let granate-unsa  = rgb("#7a1315")
#let texto-gris    = rgb("#475569")
#let borde-sutil   = rgb("#cbd5e1")

// Configuración general de página (16:9)
#set page(
  paper: "presentation-16-9",
  margin: (x: 1.4cm, top: 1.05cm, bottom: 1.25cm),
  footer-descent: 25%,
  background: place(
    center + horizon,
    rect(
      width: 97.4%,
      height: 94.8%,
      stroke: 1.4pt + granate-unsa,
      radius: 5pt
    )
  ),
  footer: context {
    let p = counter(page).get().first()
    let total = counter(page).final().first()
    grid(
      columns: (1fr, auto),
      align: (left, right),
      text(size: 8.5pt, fill: texto-gris)[
        #if p == 1 [
          Arequipa · 2026-B
        ] else [
          ASPECTOS FORMALES DE ESPECIFICACIÓN Y VERIFICACIÓN · Mg. Maribel Molina Barriga
        ]
      ],
      text(size: 8.5pt, fill: granate-unsa, weight: "bold")[#p / #total]
    )
  }
)

#show raw.where(block: true): it => block(
  fill: none,
  stroke: 0.6pt + borde-sutil,
  inset: (x: 8pt, y: 5pt),
  radius: 3pt,
  width: 100%,
  text(size: 9.2pt, fill: black, it)
)

#let callout-card(tag, content) = [
  #v(1fr)
  #block(
    fill: none,
    stroke: (left: 3.5pt + granate-unsa, top: 0.5pt + borde-sutil, right: 0.5pt + borde-sutil, bottom: 0.5pt + borde-sutil),
    inset: (x: 11pt, y: 6pt),
    radius: (right: 3pt),
    width: 100%,
    [
      #text(size: 9pt, weight: "bold", fill: granate-unsa)[#tag] \
      #v(-0.18cm)
      #text(size: 10.5pt, fill: black)[#content]
    ]
  )
]

#let content-header(title, breadcrumb) = [
  #grid(
    columns: (1fr, 2.9cm),
    gutter: 0.5cm,
    align: (left + horizon, right + horizon),
    [
      #rect(
        fill: granate-unsa,
        radius: 4pt,
        inset: (x: 11pt, y: 6pt),
        width: 100%,
        text(fill: white, size: 14pt, weight: "bold")[#title]
      )
    ],
    [
      #image("fig/unsa.png", width: 2.7cm)
    ]
  )
  #v(-0.14cm)
  #text(size: 8.3pt, fill: texto-gris, style: "italic")[#breadcrumb]
  #v(0.14cm)
]

#let fig-frame(path, caption, max-height: 4.5cm) = [
  #align(center)[
    #box(
      stroke: 0.5pt + borde-sutil,
      inset: 3pt,
      radius: 2pt,
      image(path, height: max-height)
    ) \
    #v(-0.12cm)
    #text(size: 8.2pt, fill: black)[#caption]
  ]
]

// =====================================================================
// DIAPOSITIVA 1: PORTADA
// =====================================================================
#grid(
  columns: (1fr, 3.3cm),
  align: (left + horizon, right + horizon),
  [
    #text(size: 12pt, weight: "bold", fill: granate-unsa)[
      UNIVERSIDAD NACIONAL DE SAN AGUSTÍN DE AREQUIPA
    ] \
    #text(size: 9.5pt, fill: texto-gris)[
      Facultad de Ingeniería de Producción y Servicios · Escuela Profesional de Ingeniería de Sistemas
    ]
  ],
  [
    #image("fig/unsa.png", width: 3.1cm)
  ]
)

#v(0.25cm)

#block(
  stroke: (left: 5pt + granate-unsa),
  inset: (left: 16pt, y: 4pt),
  [
    #text(size: 21pt, weight: "bold", fill: black)[
      PROYECTO FINAL: MÉTODOS FORMALES
    ] \
    #v(-0.04cm)
    #text(size: 14.8pt, weight: "bold", fill: granate-unsa)[
      Verificación Formal de Márgenes Temporales de Cierre (WCRT) y Control Preventivo en Compuertas Agrícolas con VDM++ y UPPAAL
    ] \
    #v(-0.08cm)
    #text(size: 10pt, fill: texto-gris, style: "italic")[
      VIII SEMESTRE · PERIODO 2026-B · Caso de Estudio: Represa Condoroma / Canal Majes Siguas
    ]

    #v(0.35cm)
    #grid(
      columns: (1fr, 1.45fr),
      gutter: 1cm,
      [
        #text(size: 11pt, weight: "bold", fill: granate-unsa)[Docente:] \
        #v(0.04cm)
        #text(size: 12.5pt, fill: black)[Mg. Maribel Molina Barriga]
      ],
      [
        #text(size: 11pt, weight: "bold", fill: granate-unsa)[Integrantes:] \
        #v(0.04cm)
        #text(size: 11pt, fill: black)[
          1. Ayamamani Anasco, Francis Willian \
          2. Choquehuanca Bedoya, Brayan Denilson \
          3. Choquehuanca Berna, William Herderson \
          4. Quispe Flores, Marco Ramiro
        ]
      ]
    )
  ]
)

#callout-card("APORTE CENTRAL", [
  Sustituir el control On-Off idealizado por una especificación formal verificada: demostrar mediante contraejemplo cuándo falla un cierre lento ($T_("cierre") >= 9 upright(s)$), certificar la cota segura ($T_("cierre") <= 8 upright(s)$) con histéresis y validar tolerancia a fallos mediante Watchdog y aliviadero.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 2: CONTEXTO Y APORTE DIFERENCIAL
// =====================================================================
#content-header(
  "1. Problema Técnico y Enfoque con Métodos Formales",
  "PROYECTO FINAL · ESPECIFICACIÓN Y VERIFICACIÓN PREVIA AL DESPLIEGUE EN CAMPO"
)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.9cm,
  [
    #block(
      stroke: 0.6pt + borde-sutil,
      inset: 10pt,
      radius: 4pt,
      width: 100%,
      [
        #text(weight: "bold", fill: granate-unsa, size: 12pt)[Limitación de los SCADA Convencionales]
        #v(0.15cm)
        - *Pruebas de caja negra:* Los PLC agrícolas operan con umbrales empíricos sin probar ausencia de desborde en todos los escenarios de concurrencia.
        - *Cierre idealizado:* Asumir actuación instantánea ignora el periodo de muestreo del sensor ($T_s = 1 upright(s)$) y el tiempo mecánico de cierre ($T_("cierre")$).
        - *Chattering mecánico:* Sin banda de histéresis ni control gradual, las compuertas oscilan alrededor del umbral y sufren fatiga o atascos por sedimentos.
      ]
    )
  ],
  [
    #block(
      stroke: 0.8pt + granate-unsa,
      inset: 10pt,
      radius: 4pt,
      width: 100%,
      [
        #text(weight: "bold", fill: granate-unsa, size: 12pt)[Solución Formal en Dos Niveles]
        #v(0.15cm)
        - *VDM++ (Overture v3.0.2):* Control preventivo en tres estados (`<NORMAL>`, `<PRECAUCION>` al 50%, `<CRITICO>`), invariantes de volumen en `Canal` y registro secuencial `seq`.
        - *UPPAAL 5.0 (WCRT):* Modela el estado `Compuerta.Cerrando` acoplado al llenado de `MedioAmbiente` y la histéresis $[60, 80] upright(m)^3$.
        - *Extensión Tolerante a Fallos:* Incorpora fallo no determinista `Compuerta.Atascada`, temporizador Watchdog ($5 upright(s)$) y quinto autómata `Aliviadero` ($2 upright(s)$).
      ]
    )
  ]
)

#callout-card("CRITERIO DE INGENIERÍA", [
  La verificación formal permite certificar los límites temporales de hardware y las reglas de contención antes de parametrizar controladores industriales en campo.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 3: VDM++ Y COBERTURA REAL EN OVERTURE
// =====================================================================
#content-header(
  "2. Especificación en VDM++ y Cobertura Real en Overture v3.0.2",
  "PROYECTO FINAL · 5 CLASES FORMALES, INVARIANTES Y 100.0% DE COBERTURA"
)

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.65cm,
  align: (top, top),
  [
    #block(stroke: 0.6pt + borde-sutil, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[1. `Sensor.vdmpp`:]
      #text(size: 9.4pt)[ Invariante biunívoco en `LecturaSensor` para tres rangos de caudal (`<= 10`, `10..15`, `> 15` $m^3\/s$).]
    ]
    #v(0.06cm)
    #block(stroke: 0.6pt + borde-sutil, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[2. `Compuerta.vdmpp` y 3. `Canal.vdmpp`:]
      #text(size: 9.4pt)[ Compuerta con `<ABIERTA>`, `<PARCIAL>` (50%) y `<CERRADA>` bajo bloques `atomic`; canal con `volumen_actual <= capacidad_maxima`.]
    ]
    #v(0.06cm)
    #block(stroke: 0.8pt + granate-unsa, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[4. `Controlador.vdmpp`:]
      #text(size: 9.4pt)[ Integra `Map` (`sensores`, `compuertas`, `canales`), `Set` (`alarmas_activas`) y `Seq` (`historial_telemetria`). `EvaluarRed()` estrangula al 50% en `<PRECAUCION>` y cierra con alivio en `<CRITICO>`.]
    ]
    #v(0.06cm)
    #block(stroke: 0.6pt + borde-sutil, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[5. `Test.vdmpp`:]
      #text(size: 9.4pt)[ 6 escenarios con `AssertTrue`: `EjecutarPruebas() = true`, 24 operaciones y 113 invocaciones sin errores de sintaxis ni tipos.]
    ]
  ],
  [
    #fig-frame(
      "fig/cobertura_overture.png",
      [Captura real de Overture Tool v3.0.2: cobertura `100.0%` en `Canal` (10), `Compuerta` (16), `Controlador` (39), `Sensor` (18) y `Test` (30).],
      max-height: 7.0cm
    )
  ]
)

#callout-card("VALIDACIÓN VDM++", [
  El acceso directo a atributos `.id` dentro de `inv` y `pre` mantiene contratos puros verificables en Overture Tool v3.0.2 con cobertura total en las cinco clases.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 4: AUTÓMATAS TEMPORIZADOS Y SIMULACIÓN EN UPPAAL 5.0
// =====================================================================
#content-header(
  "3. Autómatas Temporizados y Simulación en UPPAAL 5.0",
  "PROYECTO FINAL · CIERRE ELECTROMECÁNICO, HISTÉRESIS Y ACOPLAMIENTO CON EL CANAL"
)

#grid(
  columns: (1.05fr, 1.0fr),
  gutter: 0.65cm,
  align: (top, top),
  [
    #fig-frame(
      "fig/automata_compuerta.png",
      [(a) `Compuerta`: cierre gradual en `Cerrando` ($t_("act") <= T_("CIERRE")$).],
      max-height: 3.7cm
    )
    #v(0.12cm)
    #fig-frame(
      "fig/automata_sensor.png",
      [(b) `Sensor`: banda de histéresis $[60, 80] upright(m)^3$ con muestreo cada $1 upright(s)$.],
      max-height: 3.3cm
    )
  ],
  [
    #fig-frame(
      "fig/simulacion_inicio_cierre.png",
      [(c) Simulador concreto: al alcanzar `volumen = 80`, `Sensor` emite `alerta_peligro` y `Controlador` ordena `cerrar_compuerta`.],
      max-height: 6.3cm
    )
    #v(0.1cm)
    #text(size: 9.5pt)[
      *Acoplamiento físico:* Durante `Compuerta.Cerrando`, `MedioAmbiente` permanece en `Llenando` (`+5 m³/2s`); recién conmuta a `Drenando` al sincronizar `compuerta_cerrada?`.
    ]
  ]
)

#callout-card("HISTÉRESIS Y CICLO DE RECUPERACIÓN", [
  La compuerta solo recibe la orden de reapertura cuando el volumen desciende hasta `NIVEL_SEGURO = 60`, evitando oscilaciones en el umbral crítico de `80 m³`.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 5: BARRIDO WCRT, CERTIFICACIÓN VERDE Y CONTRAEJEMPLO ROJO
// =====================================================================
#content-header(
  "4. Análisis WCRT: Certificación Verde y Contraejemplo Rojo",
  "PROYECTO FINAL · FRONTERA TEMPORAL DE SEGURIDAD EN UPPAAL 5.0"
)

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.7cm,
  align: (top, top),
  [
    #text(weight: "bold", fill: granate-unsa, size: 11.5pt)[Barrido de Frontera WCRT (`verifyta.exe`)]
    #v(0.12cm)
    #table(
      columns: (auto, auto, 1fr),
      inset: 5.5pt,
      stroke: 0.6pt + borde-sutil,
      fill: (x, y) => if y == 0 { granate-unsa } else { white },
      [*#text(fill: white, size: 9.5pt)[$T_("CIERRE")$]*],
      [*#text(fill: white, size: 9.5pt)[Pico]*],
      [*#text(fill: white, size: 9.5pt)[`A[] volumen <= 100`]*],
      [#text(size: 9.5pt)[6 s (Nominal)]], [#text(size: 9.5pt)[95 $m^3$]], [#text(size: 9.5pt)[Conforme (7/7 CTL)]],
      [#text(size: 9.5pt)[8 s (Límite)]], [#text(size: 9.5pt)[100 $m^3$]], [#text(size: 9.5pt)[Conforme (cota máxima)]],
      [#text(size: 9.5pt)[9 s]], [#text(size: 9.5pt)[105 $m^3$]], [#text(size: 9.5pt, fill: granate-unsa, weight: "bold")[Falla (desborde)]],
      [#text(size: 9.5pt)[10 s (Contraej.)]], [#text(size: 9.5pt)[105 $m^3$]], [#text(size: 9.5pt, fill: granate-unsa, weight: "bold")[Falla en `Cerrando`]],
    )
    #v(0.2cm)
    #text(size: 9.6pt)[
      *Causa del contraejemplo:* Con $1 upright(s)$ de desfase de muestreo del sensor y llenado cada $2 upright(s)$, un cierre de $T_("CIERRE") >= 9 upright(s)$ permite cinco pulsos adicionales ($80 + 5 times 5 = 105 upright(m)^3 > 100 upright(m)^3$).
    ]
  ],
  [
    #fig-frame(
      "fig/verificacion_propiedades.png",
      [(a) `ControlRiesgo.xml` ($T_("CIERRE") = 6 upright(s)$): 7/7 propiedades CTL satisfechas en verde.],
      max-height: 3.1cm
    )
    #v(0.12cm)
    #fig-frame(
      "fig/contraejemplo_desborde.png",
      [(b) `ControlRiesgo_Contraejemplo.xml` ($T_("CIERRE") = 10 upright(s)$): violación en rojo de `A[] volumen <= MAX_CAPACIDAD`.],
      max-height: 4.1cm
    )
  ]
)

#callout-card("COTA CERTIFICADA", [
  UPPAAL demuestra de forma exhaustiva que el actuador debe cerrar en $T_("CIERRE") <= 8 upright(s)$ para garantizar contención sin desbordamiento bajo el peor caso de desfase temporal.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 6: EXTENSIÓN TOLERANTE A FALLOS (WATCHDOG Y ALIVIADERO)
// =====================================================================
#content-header(
  "5. Extensión Tolerante a Fallos Mecánicos (Watchdog y Aliviadero)",
  "PROYECTO FINAL · MODELO ControlRiesgo_ToleranteFallos.xml (6/6 PROPIEDADES CTL)"
)

#text(size: 9.6pt)[
  Para cubrir atascos físicos por sedimentos, se verificó un modelo independiente con $T_("CIERRE") = 4 upright(s)$, temporizador Watchdog $T_("WATCHDOG") = 5 upright(s)$ en `Controlador.EsperandoCierre` y un quinto autómata `Aliviadero` ($T_("ALIVIO") = 2 upright(s)$). Si la compuerta pasa a `Atascada`, el controlador deriva el caudal al aliviadero y queda bloqueado en `ModoFalloSeguro`.
]
#v(0.1cm)

#grid(
  columns: (1fr, 1.15fr),
  column-gutter: 0.6cm,
  row-gutter: 0.12cm,
  align: (center + top, center + top),
  [
    #fig-frame(
      "fig/automata_compuerta_fallos.png",
      [(a) `Compuerta`: transición no determinista hacia `Atascada`.],
      max-height: 3.7cm
    )
  ],
  [
    #fig-frame(
      "fig/automata_controlador_fallos.png",
      [(b) `Controlador`: Watchdog (`t_wd <= T_WATCHDOG`) y `ModoFalloSeguro`.],
      max-height: 3.7cm
    )
  ],
  [
    #fig-frame(
      "fig/automata_aliviadero.png",
      [(c) Quinto autómata `Aliviadero` ($T_("ALIVIO") = 2 upright(s)$).],
      max-height: 2.6cm
    )
  ],
  [
    #fig-frame(
      "fig/verificacion_tolerante_fallos.png",
      [(d) Verifier de UPPAAL 5.0: 6/6 fórmulas CTL satisfechas en verde.],
      max-height: 3.2cm
    )
  ]
)

#callout-card("GARANTÍA ANTE ATASCO MECÁNICO", [
  Se verificó `A[] volumen <= MAX_CAPACIDAD`, `Sensor.Critico --> (Compuerta.Cerrada or Aliviadero.Abierto)` y `A[] (Controlador.ModoFalloSeguro imply Compuerta.Atascada)` sin bloqueos (`A[] not deadlock`).
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 7: CONCLUSIONES Y REFERENCIAS CLAVE
// =====================================================================
#content-header(
  "6. Conclusiones y Referencias Clave",
  "PROYECTO FINAL · SÍNTESIS DE RESULTADOS VERIFICADOS"
)

#grid(
  columns: (1.05fr, 1.05fr),
  gutter: 0.85cm,
  [
    #text(weight: "bold", fill: granate-unsa, size: 12pt)[Conclusiones]
    #v(0.12cm)
    - *Especificación VDM++:* Se consolidaron cinco clases formales con control preventivo en tres niveles, balance de volumen en `Canal` e historial secuencial, obteniendo 100.0% de cobertura en Overture Tool v3.0.2.
    - *Cota WCRT en UPPAAL 5.0:* El modelado del cierre electromecánico y la histéresis $[60, 80]$ demostró mediante contraejemplo el desborde para $T_("CIERRE") >= 9 upright(s)$ y certificó las siete propiedades CTL para $T_("CIERRE") <= 8 upright(s)$ (pico de $95 upright(m)^3$ a $6 upright(s)$).
    - *Tolerancia a fallos:* La arquitectura con Watchdog ($5 upright(s)$) y `Aliviadero` ($2 upright(s)$) garantizó contención segura aun ante atasco de la compuerta principal (6/6 propiedades CTL).
    - *Trabajo futuro:* Traducción formal de las reglas certificadas hacia lógica de PLC mediante PLCverif y modelado hidrodinámico de tramos en cascada.
  ],
  [
    #text(weight: "bold", fill: granate-unsa, size: 12pt)[Referencias Bibliográficas]
    #v(0.12cm)
    #text(size: 9.5pt)[
      [1] B. Wahlin y D. Zimbelman, _Canal Automation for Irrigation Systems (ASCE MOP 131)_, Reston, VA: ASCE, 2016. \
      #v(0.12cm)
      [2] M. Kristjansen, K. G. Larsen y M. Muñiz, “Safe and Near-Optimal Gate Control”, _Electronic Proceedings in Theoretical Computer Science (EPTCS)_, 2022. \
      #v(0.12cm)
      [3] M. Goorden, P. G. Jensen, K. G. Larsen et al., “Learning safe and optimal control strategies for storm water detention ponds”, _IFAC ADHS_, 2021. \
      #v(0.12cm)
      [4] P. G. Larsen, K. Lausdahl, N. Battle, J. Fitzgerald y S. Wolff, _The VDM-10 Language Manual_, Overture Technical Report TR-001, 2010. \
      #v(0.12cm)
      [5] G. Behrmann, A. David y K. G. Larsen, “A tutorial on Uppaal”, _Formal Methods for the Design of Real-Time Systems_, Springer LNCS 3185, 2004.
    ]
  ]
)

#callout-card("CIERRE", [
  La combinación de VDM++ y UPPAAL transforma el diseño de compuertas de riego en una especificación auditable con márgenes temporales y mecanismos de contingencia demostrados matemáticamente.
])
