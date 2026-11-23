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
  margin: (x: 1.35cm, top: 1.0cm, bottom: 1.2cm),
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

#let callout-card(tag, content) = [
  #v(1fr)
  #block(
    fill: none,
    stroke: (left: 3.5pt + granate-unsa, top: 0.5pt + borde-sutil, right: 0.5pt + borde-sutil, bottom: 0.5pt + borde-sutil),
    inset: (x: 11pt, y: 6pt),
    radius: (right: 3pt),
    width: 100%,
    [
      #text(size: 8.8pt, weight: "bold", fill: granate-unsa)[#tag] \
      #v(-0.18cm)
      #text(size: 10.3pt, fill: black)[#content]
    ]
  )
]

#let content-header(title, breadcrumb) = [
  #grid(
    columns: (1fr, 2.8cm),
    gutter: 0.5cm,
    align: (left + horizon, right + horizon),
    [
      #rect(
        fill: granate-unsa,
        radius: 4pt,
        inset: (x: 11pt, y: 5.5pt),
        width: 100%,
        text(fill: white, size: 13.8pt, weight: "bold")[#title]
      )
    ],
    [
      #image("fig/unsa.png", width: 2.6cm)
    ]
  )
  #v(-0.14cm)
  #text(size: 8.2pt, fill: texto-gris, style: "italic")[#breadcrumb]
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

#callout-card("PRINCIPAL APORTE DEL PROYECTO", [
  A diferencia de un SCADA convencional con pruebas básicas, aplicamos *métodos formales (VDM++ y UPPAAL)* antes de implementar en campo: demostramos cuándo falla un cierre lento ($T_("cierre") >= 9 upright(s)$), certificamos el límite seguro ($T_("cierre") <= 8 upright(s)$) y validamos respaldo ante atascos.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 2: PROBLEMA Y APORTE CON MÉTODOS FORMALES
// =====================================================================
#content-header(
  "1. Problema Técnico y Principal Aporte del Proyecto",
  "PROYECTO FINAL · POR QUÉ VALIDAR CON MÉTODOS FORMALES ANTES DEL PLC"
)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.9cm,
  [
    #block(
      stroke: 0.6pt + borde-sutil,
      inset: 11pt,
      radius: 4pt,
      width: 100%,
      [
        #text(weight: "bold", fill: granate-unsa, size: 12pt)[Limitación de los SCADA Tradicionales]
        #v(0.2cm)
        - *Pruebas parciales:* Solo prueban casos aislados sin garantizar que nunca ocurra un desborde.
        - *Cierre instantáneo irreal:* No consideran el tiempo que demora el sensor en leer (cada `1 s`) ni los segundos que tarda el motor en bajar la compuerta.
        - *Oscilación mecánica:* Al abrir y cerrar sobre un mismo umbral, la compuerta se desgasta o puede atascarse.
      ]
    )
  ],
  [
    #block(
      stroke: 0.9pt + granate-unsa,
      inset: 11pt,
      radius: 4pt,
      width: 100%,
      [
        #text(weight: "bold", fill: granate-unsa, size: 12pt)[Aporte con VDM++ y UPPAAL]
        #v(0.2cm)
        - *VDM++ (Overture):* Control preventivo en 3 niveles (`<NORMAL>`, `<PRECAUCION>` al 50%, `<CRITICO>`) con invariantes de seguridad en el canal.
        - *UPPAAL 5.0 (WCRT):* Simula el tiempo real de cierre y encuentra el punto exacto donde el canal se desborda (`9 s` o más).
        - *Tolerancia a fallos:* Si la compuerta se atasca, un temporizador de respaldo abre un aliviadero en `2 s`.
      ]
    )
  ]
)

#callout-card("VALOR AGREGADO", [
  No programamos un PLC empírico: certificamos matemáticamente los tiempos máximos de respuesta y las reglas de seguridad antes de llevar el sistema a campo.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 3: VDM++ Y COBERTURA REAL EN OVERTURE
// =====================================================================
#content-header(
  "2. Especificación en VDM++ y Cobertura en Overture v3.0.2",
  "PROYECTO FINAL · 5 CLASES FORMALES Y 100.0% DE COBERTURA"
)

#grid(
  columns: (0.72fr, 1.38fr),
  gutter: 0.55cm,
  align: (top, top),
  [
    #block(stroke: 0.6pt + borde-sutil, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[1. `Sensor.vdmpp`:]
      #text(size: 9.2pt)[ Clasifica el caudal en 3 niveles (`<NORMAL>`, `<PRECAUCION>`, `<CRITICO>`).]
    ]
    #v(0.08cm)
    #block(stroke: 0.6pt + borde-sutil, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[2. `Compuerta.vdmpp` y 3. `Canal.vdmpp`:]
      #text(size: 9.2pt)[ Apertura al 100%, 50% o 0%; el volumen nunca supera la capacidad máxima.]
    ]
    #v(0.08cm)
    #block(stroke: 0.8pt + granate-unsa, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[4. `Controlador.vdmpp`:]
      #text(size: 9.2pt)[ Coordina mapas de sensores/compuertas/canales, alarmas e historial cronológico.]
    ]
    #v(0.08cm)
    #block(stroke: 0.6pt + borde-sutil, inset: (x: 8pt, y: 5pt), radius: 3pt, width: 100%)[
      #text(fill: granate-unsa, weight: "bold", size: 10pt)[5. `Test.vdmpp`:]
      #text(size: 9.2pt)[ 6 escenarios de prueba; `EjecutarPruebas() = true` sin errores.]
    ]
  ],
  [
    #fig-frame(
      "fig/cobertura_overture.png",
      [Overture Tool v3.0.2: cobertura `100.0%` en `Canal`, `Compuerta`, `Controlador`, `Sensor` y `Test` (113 invocaciones).],
      max-height: 8.1cm
    )
  ]
)

#callout-card("VALIDACIÓN ESTÁTICA", [
  Las cinco clases cumplen todos sus invariantes y precondiciones con cobertura total verificada en Overture Tool v3.0.2.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 4: AUTÓMATAS TEMPORIZADOS Y SIMULACIÓN EN UPPAAL 5.0
// =====================================================================
#content-header(
  "3. Autómatas Temporizados y Simulación en UPPAAL 5.0",
  "PROYECTO FINAL · CIERRE GRADUAL, HISTÉRESIS Y DINÁMICA DEL CANAL"
)

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.55cm,
  align: (top, top),
  [
    #fig-frame(
      "fig/automata_compuerta.png",
      [(a) `Compuerta`: cierre físico en `Cerrando` ($t_("act") <= T_("CIERRE")$).],
      max-height: 4.35cm
    )
    #v(0.15cm)
    #fig-frame(
      "fig/automata_sensor.png",
      [(b) `Sensor`: cierra en `>= 80 m³` y reabre recién en `<= 60 m³`.],
      max-height: 3.35cm
    )
  ],
  [
    #fig-frame(
      "fig/simulacion_inicio_cierre.png",
      [(c) Simulador: al llegar a `volumen = 80`, el sensor alerta y el controlador ordena cerrar mientras el canal sigue llenándose.],
      max-height: 7.45cm
    )
  ]
)

#callout-card("HISTÉRESIS ANTI-OSCILACIÓN", [
  La compuerta no se reabre apenas baja de `80 m³`: espera hasta `NIVEL_SEGURO = 60 m³` para evitar aperturas y cierres repetidos.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 5: BARRIDO WCRT, CERTIFICACIÓN VERDE Y CONTRAEJEMPLO ROJO
// =====================================================================
#content-header(
  "4. Análisis WCRT: Certificación Verde y Contraejemplo Rojo",
  "PROYECTO FINAL · LÍMITE TEMPORAL DE SEGURIDAD EN UPPAAL 5.0"
)

#grid(
  columns: (0.88fr, 1.22fr),
  gutter: 0.6cm,
  align: (top, top),
  [
    #text(weight: "bold", fill: granate-unsa, size: 11.5pt)[Barrido de Tiempos de Cierre]
    #v(0.12cm)
    #table(
      columns: (auto, auto, 1fr),
      inset: 5.5pt,
      stroke: 0.6pt + borde-sutil,
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
    #text(size: 9.8pt)[
      *Por qué falla con `>= 9 s`:* Mientras la compuerta baja lentamente, el agua sigue entrando cada `2 s` y alcanza `105 m³` (superando el máximo de `100 m³`).
    ]
  ],
  [
    #fig-frame(
      "fig/verificacion_propiedades.png",
      [(a) Modelo nominal (`6 s`): 7/7 propiedades CTL en verde.],
      max-height: 2.95cm
    )
    #v(0.15cm)
    #fig-frame(
      "fig/contraejemplo_desborde.png",
      [(b) Contraejemplo (`10 s`): propiedad `volumen <= MAX_CAPACIDAD` en rojo.],
      max-height: 4.55cm
    )
  ]
)

#callout-card("COTA CERTIFICADA", [
  UPPAAL demuestra matemáticamente que el motor de la compuerta debe cerrar en `8 segundos o menos` para evitar desbordamientos.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 6: TOLERANCIA A FALLOS (AUTÓMATAS DE COMPUERTA Y CONTROLADOR)
// =====================================================================
#content-header(
  "5. Extensión Tolerante a Fallos: Atasco y Watchdog",
  "PROYECTO FINAL · MODELO ControlRiesgo_ToleranteFallos.xml (PARTE 1)"
)

#text(size: 10pt)[
  Para cubrir atascos mecánicos por sedimentos, se agregó el estado `Atascada` en `Compuerta` y un temporizador de vigilancia (*Watchdog* de `5 s`) en `Controlador`.
]
#v(0.18cm)

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.6cm,
  align: (center + top, center + top),
  [
    #fig-frame(
      "fig/automata_compuerta_fallos.png",
      [(a) `Compuerta`: si falla durante `Cerrando`, pasa al estado `Atascada`.],
      max-height: 6.7cm
    )
  ],
  [
    #fig-frame(
      "fig/automata_controlador_fallos.png",
      [(b) `Controlador`: si expira `t_wd == 5 s` sin confirmación de cierre, activa el aliviadero y entra en `ModoFalloSeguro`.],
      max-height: 6.7cm
    )
  ]
)

#callout-card("DETECCIÓN DE FALLO", [
  Si la compuerta no confirma su cierre dentro de los `5 s` del *Watchdog*, el controlador asume atasco y evita seguir operando la compuerta dañada.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 7: TOLERANCIA A FALLOS (ALIVIADERO Y VERIFICACIÓN CTL)
// =====================================================================
#content-header(
  "6. Extensión Tolerante a Fallos: Aliviadero y Verificación CTL",
  "PROYECTO FINAL · MODELO ControlRiesgo_ToleranteFallos.xml (PARTE 2)"
)

#text(size: 10pt)[
  Al detectarse el atasco, entra en acción el quinto autómata `Aliviadero` (`2 s` de apertura), logrando contener el nivel de agua sin bloqueos en las 6 propiedades CTL.
]
#v(0.2cm)

#grid(
  columns: (1fr, 1.05fr),
  gutter: 0.65cm,
  align: (center + horizon, center + top),
  [
    #align(center)[
      #box(
        stroke: 0.5pt + borde-sutil,
        inset: 4pt,
        radius: 2pt,
        image("fig/automata_aliviadero.png", width: 100%)
      ) \
      #v(-0.12cm)
      #text(size: 8.2pt, fill: black)[(a) Quinto autómata `Aliviadero`: abre en `2 s` y emite `alivio_activo!`.]
    ]
  ],
  [
    #fig-frame(
      "fig/verificacion_tolerante_fallos.png",
      [(b) Verifier de UPPAAL 5.0: 6/6 fórmulas CTL satisfechas en verde.],
      max-height: 6.4cm
    )
  ]
)

#callout-card("GARANTÍA DE SEGURIDAD ANTE ATASCO", [
  Se certificaron `not deadlock`, `volumen <= MAX_CAPACIDAD` y `Sensor.Critico --> (Compuerta.Cerrada or Aliviadero.Abierto)`.
])

#pagebreak()

// =====================================================================
// DIAPOSITIVA 8: CONCLUSIONES Y REFERENCIAS CLAVE
// =====================================================================
#content-header(
  "7. Conclusiones y Referencias Clave",
  "PROYECTO FINAL · SÍNTESIS DE RESULTADOS VERIFICADOS"
)

#grid(
  columns: (1.05fr, 1.05fr),
  gutter: 0.85cm,
  [
    #text(weight: "bold", fill: granate-unsa, size: 12pt)[Conclusiones]
    #v(0.15cm)
    - *Especificación VDM++:* Cinco clases formales con control preventivo gradual y balance de volumen en `Canal`, validadas al 100.0% en Overture Tool v3.0.2.
    - *Cota WCRT en UPPAAL 5.0:* Se demostró por contraejemplo el desborde para `T_CIERRE >= 9 s` y se certificó seguridad total para `T_CIERRE <= 8 s` (pico de `95 m³` a `6 s`).
    - *Tolerancia a fallos:* Con *Watchdog* (`5 s`) y `Aliviadero` (`2 s`), el sistema contiene el caudal aun ante atasco mecánico (6/6 propiedades CTL).
    - *Trabajo futuro:* Traducción a lógica de PLC mediante PLCverif y acoplamiento de múltiples canales en cascada.
  ],
  [
    #text(weight: "bold", fill: granate-unsa, size: 12pt)[Referencias Bibliográficas]
    #v(0.15cm)
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
  La verificación formal conjunta con VDM++ y UPPAAL convierte el control de compuertas en una especificación auditable con garantías matemáticas demostradas.
])
