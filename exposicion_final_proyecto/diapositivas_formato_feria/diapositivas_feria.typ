// =====================================================================
// DIAPOSITIVAS - FORMATO FERIA DE PROYECTOS EPIS UNSA 2026
// CATEGORÍA II - INTERMEDIO (7 MINUTOS)
// =====================================================================

#set document(
  title: "Feria de Proyectos 2026 - Verificación Formal de Compuertas Agrícolas (VDM++ y UPPAAL)",
  author: "Grupo 3 - Escuela Profesional de Ingeniería de Sistemas - UNSA"
)

#set text(font: ("Arial", "Segoe UI"), size: 11pt, fill: black)

// Paleta oficial Feria de Proyectos UNSA (sin cajas grises, texto en #000000)
#let granate-unsa  = rgb("#7a1315")
#let naranja-feria = rgb("#ed7d31")
#let gris-texto    = rgb("#475569")
#let gris-borde    = rgb("#cbd5e1")

// Configuración de página 16:9 fiel a la plantilla oficial Feria de Proyectos
#set page(
  paper: "presentation-16-9",
  margin: (x: 1.3cm, top: 0.85cm, bottom: 1.95cm),
  footer-descent: 0.18cm,
  fill: white,
  footer: context {
    let p = counter(page).get().first()
    let total = counter(page).final().first()
    if p > 1 {
      line(length: 100%, stroke: 1.2pt + naranja-feria)
      v(0.06cm)
      grid(
        columns: (auto, 1fr, auto),
        align: (left + horizon, center + horizon, right + horizon),
        [
          #image("fig/unsa_horizontal.png", height: 0.88cm)
        ],
        [
          #text(size: 9.5pt, fill: black)[
            Verificación Formal de Compuertas Agrícolas con VDM++ y UPPAAL
          ]
        ],
        [
          #grid(
            columns: (auto, auto),
            gutter: 0.35cm,
            align: horizon,
            [
              #image("fig/epis.png", height: 1.05cm)
            ],
            [
              #text(size: 8.8pt, fill: granate-unsa, weight: "bold")[#p / #total]
            ]
          )
        ]
      )
    }
  }
)

#let slide-header(title, subtitle: none) = [
  #text(fill: black, size: 19pt, weight: "bold")[#title]
  #if subtitle != none [
    \ #v(-0.12cm)
    #text(fill: granate-unsa, size: 9.5pt, weight: "bold")[#subtitle]
  ]
  #v(0.22cm)
]

#let info-card(title, content, accent: false) = block(
  fill: white,
  stroke: if accent { 0.9pt + granate-unsa } else { 0.6pt + gris-borde },
  inset: (x: 10pt, y: 8pt),
  radius: 4pt,
  width: 100%,
  [
    #text(size: 10.5pt, weight: "bold", fill: granate-unsa)[#title] \
    #v(0.1cm)
    #text(size: 10pt, fill: black)[#content]
  ]
)

#let fig-box(path, caption, max-height: 5cm) = [
  #align(center)[
    #box(
      stroke: 0.5pt + gris-borde,
      inset: 3pt,
      radius: 2pt,
      image(path, height: max-height)
    ) \
    #v(-0.1cm)
    #text(size: 8.4pt, fill: black)[#caption]
  ]
]

// =====================================================================
// DIAPOSITIVA 1: PORTADA (PLANTILLA OFICIAL FERIA DE PROYECTOS 2026)
// =====================================================================
#v(-0.15cm)
#grid(
  columns: (auto, 1fr, auto),
  align: (left + top, center + top, right + top),
  [
    #image("fig/unsa_horizontal.png", width: 5.7cm)
  ],
  [],
  [
    #image("fig/epis.png", width: 6.6cm)
  ]
)

#v(0.3cm)

#align(center)[
  #text(size: 14.5pt, fill: black)[
    Facultad de Ingeniería de Producción y Servicios
  ] \
  #v(0.08cm)
  #text(size: 19.5pt, weight: "bold", fill: black)[
    Escuela Profesional de Ingeniería de Sistemas
  ] \
  #v(0.35cm)
  #text(size: 16pt, weight: "bold", fill: granate-unsa)[
    FERIA DE PROYECTOS 2026 · CATEGORÍA II – INTERMEDIO
  ] \
  #v(0.2cm)
  #text(size: 18pt, weight: "bold", fill: black)[
    “Verificación Formal de Márgenes Temporales de Cierre (WCRT) y Control Preventivo en Compuertas Agrícolas con VDM++ y UPPAAL”
  ]
]

#v(0.45cm)

#grid(
  columns: (1.25fr, 1fr),
  gutter: 1.0cm,
  [
    #text(size: 10.5pt, weight: "bold", fill: granate-unsa)[Presentado por:] \
    #v(0.08cm)
    #text(size: 10.5pt, fill: black)[
      • Ayamamani Anasco, Francis Willian \
      • Choquehuanca Bedoya, Brayan Denilson \
      • Choquehuanca Berna, William Herderson \
      • Quispe Flores, Marco Ramiro
    ]
  ],
  [
    #text(size: 10.5pt, weight: "bold", fill: granate-unsa)[Docente Asesora:] \
    #v(0.08cm)
    #text(size: 11.5pt, weight: "bold", fill: black)[Mg. Maribel Molina Barriga] \
    #v(0.18cm)
    #text(size: 9.8pt, fill: gris-texto)[
      *Asignatura:* Aspectos Formales de Especificación y Verificación (AFEV) \
      *Caso de Estudio:* Represa Condoroma / Canal Majes Siguas
    ]
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 2: PROBLEMÁTICA Y JUSTIFICACIÓN (RESPONSABILIDAD SOCIAL)
// =====================================================================
#slide-header("Problemática y Justificación", subtitle: "CONTEXTO REAL EN MAJES SIGUAS Y RESPONSABILIDAD SOCIAL")

#grid(
  columns: (1fr, 1fr),
  gutter: 0.75cm,
  [
    #info-card("PROBLEMA EN CANALES DE RIEGO (AREQUIPA)", [
      - *Pérdida crítica de agua:* En redes abiertas como Condoroma y Majes Siguas se supera el *40% de pérdidas hídricas* por operación tardía y desbordes (ANA).
      - *Riesgo en control tradicional:* Los sistemas SCADA/PLC convencionales se prueban por casos aislados y asumen que la compuerta cierra al instante.
      - *Retardos reales ignorados:* No consideran el tiempo de lectura del sensor (`1 s`) ni los segundos que tarda el motor en bajar la compuerta.
    ])
  ],
  [
    #info-card("JUSTIFICACIÓN Y RESPONSABILIDAD SOCIAL", [
      - *Protección del recurso hídrico:* En una región árida como Arequipa, evitar un desborde protege cultivos, infraestructura de concreto y agua para miles de agricultores.
      - *Seguridad antes del hardware:* Verificar matemáticamente la lógica *antes* de programar un PLC evita fallos costosos en campo.
      - *Prevención de desgaste:* Evitar cierres bruscos y oscilaciones prolonga la vida útil de las compuertas.
    ], accent: true)
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 3: OBJETIVOS, ALCANCE Y PRINCIPAL APORTE
// =====================================================================
#slide-header("Objetivos, Alcance y Principal Aporte", subtitle: "DIFERENCIAL CON MÉTODOS FORMALES FRENTE A UN SCADA GENÉRICO")

#grid(
  columns: (1fr, 1fr),
  gutter: 0.75cm,
  [
    #info-card("OBJETIVOS DEL PROYECTO", [
      - *Objetivo general:* Especificar y verificar formalmente el control de compuertas agrícolas para certificar ausencia de desbordes bajo retardos reales.
      - *Específico 1 (VDM++):* Modelar control preventivo en 3 niveles e invariantes de capacidad con *100% de cobertura* en Overture.
      - *Específico 2 (UPPAAL):* Determinar el tiempo máximo seguro de cierre (*WCRT*) mediante contraejemplo y verificación CTL.
      - *Específico 3 (Respaldo):* Verificar un mecanismo tolerante a fallos ante atascos mecánicos.
    ])
  ],
  [
    #info-card("ALCANCE Y PRINCIPAL APORTE", [
      - *Alcance:* Especificación y verificación formal matemática previa al despliegue en PLC (sin código propietario de hardware).
      - *Aporte 1 (Control gradual):* En nivel `<PRECAUCION>` reduce apertura al *50%* antes de llegar a emergencia.
      - *Aporte 2 (Frontera WCRT):* Demuestra que con cierre `>= 9 s` el canal desborda (`105 m³`) y certifica seguridad para `<= 8 s`.
      - *Aporte 3 (Modo fallo seguro):* Temporizador *Watchdog* (`5 s`) y *Aliviadero* (`2 s`) si la compuerta se atasca.
    ], accent: true)
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 4: METODOLOGÍA Y ARTEFACTOS EMPLEADOS
// =====================================================================
#slide-header("Metodología y Artefactos Empleados", subtitle: "PROCESO FORMAL EN TRES FASES Y HERRAMIENTAS DE VERIFICACIÓN")

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.55cm,
  [
    #info-card("FASE 1 · ESPECIFICACIÓN (VDM++)", [
      - *Herramienta:* Overture Tool v3.0.2 (estándar VDM-10).
      - *Artefactos:* Invariantes de clase, pre/postcondiciones, bloques `atomic`, `Map`, `Set` y `Seq`.
      - *Validación:* Suite automatizada `Test.vdmpp` con aserciones y reporte de cobertura.
    ])
  ],
  [
    #info-card("FASE 2 · MODEL CHECKING (UPPAAL)", [
      - *Herramienta:* UPPAAL 5.0.0 (`verifyta.exe` y simulador concreto).
      - *Artefactos:* Red de 4 autómatas temporizados con relojes continuos y canales `broadcast`.
      - *Validación:* 7 propiedades CTL (seguridad, vivacidad, histéresis y ausencia de bloqueo).
    ], accent: true)
  ],
  [
    #info-card("FASE 3 · TOLERANCIA A FALLOS", [
      - *Herramienta:* UPPAAL 5.0.0 (modelo independiente).
      - *Artefactos:* Falla no determinista `Atascada`, reloj *Watchdog* (`5 s`) y quinto autómata `Aliviadero` (`2 s`).
      - *Validación:* 6 propiedades CTL verificadas exhaustivamente.
    ])
  ]
)

#v(0.35cm)
#block(
  stroke: (left: 4pt + naranja-feria, top: 0.5pt + gris-borde, right: 0.5pt + gris-borde, bottom: 0.5pt + gris-borde),
  inset: (x: 11pt, y: 7pt),
  radius: (right: 3pt),
  width: 100%,
  [
    #text(size: 9.8pt, fill: black)[
      *Complementariedad:* *VDM++* garantiza que los datos y reglas de control nunca violen sus contratos; *UPPAAL* garantiza que el sistema responda a tiempo en todos los escenarios posibles de concurrencia.
    ]
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 5: ARTEFACTO DESARROLLADO 1 — VDM++ Y COBERTURA OVERTURE
// =====================================================================
#slide-header("Artefacto Desarrollado: Especificación VDM++", subtitle: "5 CLASES FORMALES Y 100.0% DE COBERTURA EN OVERTURE TOOL v3.0.2")

#grid(
  columns: (0.72fr, 1.38fr),
  gutter: 0.55cm,
  align: (top, top),
  [
    #info-card("ARQUITECTURA DE 5 CLASES", [
      - *`Sensor`:* Clasifica el caudal en 3 niveles (`<NORMAL>`, `<PRECAUCION>`, `<CRITICO>`).
      - *`Compuerta`:* Apertura al 100%, 50% o 0% bajo cambios atómicos.
      - *`Canal`:* Garantiza `volumen <= capacidad_maxima`.
      - *`Controlador`:* Gestiona mapas, alarmas activas (`Set`) e historial (`Seq`).
      - *`Test`:* 6 escenarios; `EjecutarPruebas() = true` sin errores.
    ])
  ],
  [
    #fig-box(
      "fig/cobertura_overture.png",
      [Overture Tool v3.0.2: cobertura `100.0%` en `Canal` (10), `Compuerta` (16), `Controlador` (39), `Sensor` (18) y `Test` (30).],
      max-height: 8.8cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 6: ARTEFACTO DESARROLLADO 2 — AUTÓMATAS EN UPPAAL 5.0
// =====================================================================
#slide-header("Artefacto Desarrollado: Autómatas Temporizados", subtitle: "CIERRE FÍSICO GRADUAL, HISTÉRESIS Y SIMULACIÓN EN UPPAAL 5.0")

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.55cm,
  align: (top, top),
  [
    #fig-box(
      "fig/automata_compuerta.png",
      [(a) `Compuerta`: permanece en `Cerrando` durante `T_CIERRE` antes de cerrar.],
      max-height: 4.5cm
    )
    #v(0.18cm)
    #fig-box(
      "fig/automata_sensor.png",
      [(b) `Sensor`: dispara alerta en `>= 80 m³` y reabre recién en `<= 60 m³` (histéresis).],
      max-height: 3.5cm
    )
  ],
  [
    #fig-box(
      "fig/simulacion_inicio_cierre.png",
      [(c) Simulador concreto: en `volumen = 80`, `Sensor` alerta y `Controlador` ordena cerrar mientras el canal sigue llenándose.],
      max-height: 8.3cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 7: RESULTADOS WCRT — VERDE VS CONTRAEJEMPLO ROJO
// =====================================================================
#slide-header("Resultados WCRT: Certificación y Contraejemplo", subtitle: "FRONTERA TEMPORAL DEMOSTRADA EXHAUSTIVAMENTE EN UPPAAL 5.0")

#grid(
  columns: (0.88fr, 1.22fr),
  gutter: 0.6cm,
  align: (top, top),
  [
    #text(weight: "bold", fill: granate-unsa, size: 11pt)[Barrido de Tiempos de Cierre]
    #v(0.12cm)
    #table(
      columns: (auto, auto, 1fr),
      inset: 5.5pt,
      stroke: 0.6pt + gris-borde,
      fill: (x, y) => if y == 0 { granate-unsa } else { white },
      [*#text(fill: white, size: 9.5pt)[$T_("CIERRE")$]*],
      [*#text(fill: white, size: 9.5pt)[Pico]*],
      [*#text(fill: white, size: 9.5pt)[`volumen <= 100`]*],
      [#text(size: 9.5pt)[6 s (Nominal)]], [#text(size: 9.5pt)[95 $m^3$]], [#text(size: 9.5pt)[Conforme (7/7 CTL)]],
      [#text(size: 9.5pt)[8 s (Límite)]], [#text(size: 9.5pt)[100 $m^3$]], [#text(size: 9.5pt)[Conforme (límite)]],
      [#text(size: 9.5pt)[9 s]], [#text(size: 9.5pt)[105 $m^3$]], [#text(size: 9.5pt, fill: granate-unsa, weight: "bold")[Falla (desborde)]],
      [#text(size: 9.5pt)[10 s (Contraej.)]], [#text(size: 9.5pt)[105 $m^3$]], [#text(size: 9.5pt, fill: granate-unsa, weight: "bold")[Falla en `Cerrando`]],
    )
    #v(0.25cm)
    #info-card("HALLAZGO PRINCIPAL", [
      Si la compuerta tarda `9 s` o más en bajar, el canal alcanza `105 m³` y desborda. La cota segura certificada es `T_CIERRE <= 8 s`.
    ], accent: true)
  ],
  [
    #fig-box(
      "fig/verificacion_propiedades.png",
      [(a) Modelo nominal (`6 s`): 7/7 propiedades CTL satisfechas en verde.],
      max-height: 3.2cm
    )
    #v(0.18cm)
    #fig-box(
      "fig/contraejemplo_desborde.png",
      [(b) Contraejemplo (`10 s`): violación en rojo de `A[] volumen <= MAX_CAPACIDAD`.],
      max-height: 4.9cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 8: TOLERANCIA A FALLOS — ATASCO Y WATCHDOG
// =====================================================================
#slide-header("Extensión Tolerante a Fallos: Atasco y Watchdog", subtitle: "RESPUESTA ANTE FALLA MECÁNICA DE LA COMPUERTA (PARTE 1)")

#text(size: 10.2pt)[
  Para cubrir obstrucciones por sedimentos, se agregó la falla no determinista `Atascada` en `Compuerta` y un temporizador de vigilancia (*Watchdog* de `5 s`) en `Controlador`.
]
#v(0.2cm)

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.6cm,
  align: (center + top, center + top),
  [
    #fig-box(
      "fig/automata_compuerta_fallos.png",
      [(a) `Compuerta`: si falla durante `Cerrando`, pasa al estado `Atascada`.],
      max-height: 7.4cm
    )
  ],
  [
    #fig-box(
      "fig/automata_controlador_fallos.png",
      [(b) `Controlador`: si expira `t_wd == 5 s` sin confirmación, activa el aliviadero y entra en `ModoFalloSeguro`.],
      max-height: 7.4cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 9: TOLERANCIA A FALLOS — ALIVIADERO Y VERIFICACIÓN CTL
// =====================================================================
#slide-header("Extensión Tolerante a Fallos: Aliviadero y CTL", subtitle: "CERTIFICACIÓN DE SEGURIDAD ANTE ATASCO (PARTE 2)")

#text(size: 10.2pt)[
  Al expirar el *Watchdog*, el quinto autómata `Aliviadero` abre en `2 s` y desvía el caudal excedente. Las *6 propiedades CTL* se verificaron en verde sin bloqueos.
]
#v(0.25cm)

#grid(
  columns: (1fr, 1.05fr),
  gutter: 0.65cm,
  align: (center + horizon, center + top),
  [
    #align(center)[
      #box(
        stroke: 0.5pt + gris-borde,
        inset: 4pt,
        radius: 2pt,
        image("fig/automata_aliviadero.png", width: 100%)
      ) \
      #v(-0.1cm)
      #text(size: 8.4pt, fill: black)[(a) Quinto autómata `Aliviadero`: abre en `2 s` y emite `alivio_activo!`.]
    ]
  ],
  [
    #fig-box(
      "fig/verificacion_tolerante_fallos.png",
      [(b) Verifier UPPAAL 5.0: 6/6 propiedades CTL en verde (`not deadlock`, `volumen <= 100` y coherencia de fallo seguro).],
      max-height: 7.1cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 10: CIERRE Y GRACIAS (PLANTILLA OFICIAL FERIA 2026)
// =====================================================================
#v(0.3cm)
#text(size: 38pt, weight: "bold", fill: black)[Gracias...]
#v(0.35cm)

#grid(
  columns: (1.25fr, 0.95fr),
  gutter: 0.8cm,
  [
    #info-card("CONCLUSIONES VERIFICADAS", [
      - *VDM++ (Overture v3.0.2):* 5 clases con control preventivo gradual y *100.0% de cobertura*.
      - *UPPAAL 5.0 (WCRT):* Contraejemplo demostrado en `>= 9 s` y seguridad certificada en `<= 8 s` (7/7 CTL).
      - *Tolerancia a fallos:* *Watchdog* (`5 s`) + `Aliviadero` (`2 s`) garantizan contención aun con compuerta atascada (6/6 CTL).
    ])
  ],
  [
    #block(
      stroke: (left: 4pt + granate-unsa),
      inset: (left: 14pt, y: 10pt),
      [
        #text(size: 13pt, style: "italic", fill: black)[
          “Las pruebas pueden mostrar la presencia de errores, pero solo la verificación formal demuestra seguridad antes de que el agua desborde.”
        ]
        #v(0.35cm)
        #text(size: 9pt, fill: gris-texto)[
          *Repositorio GitHub:* \
          `github.com/DenilsonCB/verificacion-formal-compuertas-agricolas-vdmpp-uppaal`
        ]
      ]
    )
  ]
)
