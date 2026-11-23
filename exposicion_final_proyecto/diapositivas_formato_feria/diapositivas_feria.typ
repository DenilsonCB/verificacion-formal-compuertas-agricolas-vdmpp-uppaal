// =====================================================================
// DIAPOSITIVAS - FORMATO FERIA DE PROYECTOS EPIS UNSA 2026
// 11 LÁMINAS · DISEÑO LIMPIO SIN CAJAS DE TEXTO · 7 MINUTOS
// =====================================================================

#set document(
  title: "Feria de Proyectos 2026 - Verificación Formal de Compuertas Agrícolas (VDM++ y UPPAAL)",
  author: "Grupo 3 - Escuela Profesional de Ingeniería de Sistemas - UNSA"
)

#set text(font: ("Arial", "Segoe UI"), size: 12.5pt, fill: black)

// Paleta oficial Feria de Proyectos UNSA (sin cajas grises ni marcos de texto)
#let granate-unsa  = rgb("#7a1315")
#let naranja-feria = rgb("#ed7d31")
#let gris-texto    = rgb("#475569")
#let gris-borde    = rgb("#cbd5e1")
#let azul-kw       = rgb("#0d5caf")
#let teal-tipo     = rgb("#267f99")
#let verde-com     = rgb("#4b7f52")
#let rojo-quote    = rgb("#a31515")

// Configuración de página 16:9 fiel a la plantilla oficial Feria de Proyectos
#set page(
  paper: "presentation-16-9",
  margin: (x: 1.35cm, top: 0.85cm, bottom: 1.95cm),
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

#let slide-header(title) = [
  #text(fill: black, size: 21pt, weight: "bold")[#title]
  #v(0.28cm)
]

#let section-label(label) = [
  #text(fill: granate-unsa, size: 12.5pt, weight: "bold")[#label]
  #v(0.14cm)
]

#let vdm-code(title, start-line, code-str) = [
  #text(size: 9.5pt, weight: "bold", fill: granate-unsa)[#title]
  #v(-0.08cm)
  #block(
    fill: none,
    stroke: 0.5pt + gris-borde,
    inset: (x: 8pt, y: 6pt),
    radius: 2pt,
    width: 100%,
    {
      let lines = code-str.trim().split("\n")
      for (i, ln) in lines.enumerate() {
        let num = start-line + i
        box(width: 1.8em, align(right)[#text(font: ("Consolas", "Courier New"), size: 8pt, fill: gris-texto)[#num]])
        h(0.6em)
        show regex("\b(class|types|instance variables|operations|inv|pre|post|public|return|dcl|if|then|else|elseif|for|all|in|set|dom|elems|and|union)\b"): kw => text(fill: azul-kw, weight: "bold")[#kw]
        show regex("\b(token|real|bool|map|to|seq|of|Sensor|Compuerta|Canal|LecturaSensor|Caudal|NivelAlerta)\b"): ty => text(fill: teal-tipo)[#ty]
        show regex("(<[A-Z_]+>)"): q => text(fill: rojo-quote, weight: "bold")[#q]
        show regex("(--.*$)"): c => text(fill: verde-com, style: "italic")[#c]
        text(font: ("Consolas", "Courier New"), size: 8.4pt, fill: black)[#raw(ln)]
        if i < lines.len() - 1 { linebreak() }
      }
    }
  )
]

#let fig-clean(path, caption, max-height: 5cm) = [
  #align(center)[
    #image(path, height: max-height) \
    #v(-0.08cm)
    #text(size: 8.8pt, fill: black)[#caption]
  ]
]

// =====================================================================
// DIAPOSITIVA 1: PORTADA (FIEL A PLANTILLA OFICIAL FERIA DE PROYECTOS)
// =====================================================================
#v(-0.1cm)
#grid(
  columns: (auto, 1fr, auto),
  align: (left + top, center + top, right + top),
  [
    #image("fig/unsa_horizontal.png", width: 5.8cm)
  ],
  [],
  [
    #image("fig/epis.png", width: 6.7cm)
  ]
)

#v(0.55cm)

#align(center)[
  #text(size: 16pt, fill: black)[
    Facultad de Ingeniería de Producción y Servicios
  ] \
  #v(0.12cm)
  #text(size: 22pt, weight: "bold", fill: black)[
    Escuela Profesional de Ingeniería de Sistemas
  ] \
  #v(0.55cm)
  #text(size: 18pt, weight: "bold", fill: black)[
    FERIA DE PROYECTOS 2026
  ] \
  #v(0.32cm)
  #text(size: 19pt, weight: "bold", fill: granate-unsa)[
    “Verificación Formal de Márgenes Temporales de Cierre (WCRT) y Control Preventivo en Compuertas Agrícolas con VDM++ y UPPAAL”
  ] \
  #v(0.65cm)
  #text(size: 12pt, fill: black)[
    *Presentado por:* Ayamamani Anasco, Francis · Choquehuanca Bedoya, Brayan · Choquehuanca Berna, William · Quispe Flores, Marco
  ] \
  #v(0.35cm)
  #text(size: 12.5pt, fill: black)[
    *Docente asesora:* Mg. Maribel Molina Barriga
  ]
]

#pagebreak()

// =====================================================================
// DIAPOSITIVA 2: PROBLEMÁTICA Y JUSTIFICACIÓN
// =====================================================================
#slide-header("Problemática y Justificación")

#v(0.2cm)
#grid(
  columns: (1fr, 1fr),
  gutter: 1.4cm,
  [
    #section-label("Problemática en Canales de Riego")
    #set par(leading: 0.78em)
    - *Más del 40% de pérdida de agua* en redes como Majes Siguas y Condoroma por maniobras tardías y desbordes (ANA).
    #v(0.35cm)
    - *SCADA/PLC tradicionales:* Solo validan casos aislados y asumen cierre instantáneo de compuertas.
    #v(0.35cm)
    - *Retardos reales ignorados:* No consideran el muestreo del sensor (`1 s`) ni el tiempo mecánico de cierre del motor.
  ],
  [
    #section-label("Justificación e Impacto Social")
    #set par(leading: 0.78em)
    - *Cuidado del recurso hídrico:* En zonas áridas de Arequipa, prevenir desbordes protege cultivos y canales de concreto.
    #v(0.35cm)
    - *Seguridad previa al hardware:* Verificar matemáticamente la lógica *antes* de programar el PLC evita fallos en campo.
    #v(0.35cm)
    - *Menor desgaste mecánico:* Evitar aperturas y cierres repetidos prolonga la vida útil de las compuertas.
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 3: OBJETIVOS, REQUERIMIENTOS Y PRINCIPAL APORTE
// =====================================================================
#slide-header("Objetivos, Requerimientos y Principal Aporte")

#v(0.15cm)
#grid(
  columns: (1fr, 1.05fr),
  gutter: 1.3cm,
  [
    #section-label("Objetivos y Principal Aporte")
    #set par(leading: 0.72em)
    - *Especificación VDM++:* Control preventivo en 3 niveles (`<NORMAL>`, `<PRECAUCION>` al 50%, `<CRITICO>`) validado al *100%*.
    #v(0.28cm)
    - *Frontera WCRT en UPPAAL:* Demostrar por contraejemplo que con `>= 9 s` desborda (`105 m³`) y certificar `<= 8 s`.
    #v(0.28cm)
    - *Tolerancia a fallos:* Temporizador *Watchdog* (`5 s`) y `Aliviadero` (`2 s`) ante atasco mecánico.
  ],
  [
    #section-label("Requerimientos del Sistema")
    #set par(leading: 0.72em)
    - *RF-01 (Telemetría):* Clasificar el caudal en 3 niveles y registrar historial secuencial (`seq`).
    #v(0.22cm)
    - *RF-02 (Control gradual):* Reducir al 50% en precaución y cerrar totalmente en emergencia.
    #v(0.22cm)
    - *RF-03 (Seguridad hídrica):* Garantizar siempre `volumen <= capacidad_maxima`.
    #v(0.22cm)
    - *RNF-01 (Verificación formal):* Cobertura 100% en Overture y propiedades CTL sin *deadlock* en UPPAAL.
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 4: ARQUITECTURA Y DIAGRAMA DE CLASES (VDM++)
// =====================================================================
#slide-header("Arquitectura del Modelo Formal (VDM++)")

#align(center)[
  #image("fig/diagrama_clases_uml.svg", height: 9.3cm)
]
#v(0.12cm)
#align(center)[
  #text(size: 10.5pt, fill: black)[
    *Estructuras integradas en `Controlador`:* `Map` (`sensores`, `compuertas`, `canales`), `Set` (`alarmas_activas` sin duplicados) y `Seq` (`historial_telemetria`).
  ]
]

#pagebreak()

// =====================================================================
// DIAPOSITIVA 5: CÓDIGO CLAVE EN VDM++ (CONTRATOS Y CONTROL PREVENTIVO)
// =====================================================================
#slide-header("Especificación Formal en VDM++: Código Clave")

#grid(
  columns: (1.02fr, 0.98fr),
  gutter: 0.7cm,
  align: (top, top),
  [
    #vdm-code("Sensor.vdmpp (Líneas 9–17) — Invariante de 3 niveles", 9, "public LecturaSensor ::
    sensor_id : token
    caudal    : Caudal
    alerta    : NivelAlerta
inv r ==
    ((r.caudal <= 10.0) <=> (r.alerta = <NORMAL>)) and
    ((r.caudal > 10.0 and r.caudal <= 15.0)
      <=> (r.alerta = <PRECAUCION>)) and
    ((r.caudal > 15.0) <=> (r.alerta = <CRITICO>));")
    #v(0.28cm)
    #vdm-code("Controlador.vdmpp (Líneas 9–17) — Invariantes de red", 9, "inv
  (alarmas_activas subset dom sensores) and
  (forall l in set elems historial_telemetria &
      l.sensor_id in set dom sensores) and
  (forall id in set dom sensores & (sensores(id)).id = id) and
  (forall id in set dom compuertas & (compuertas(id)).id = id) and
  (forall id in set dom canales & (canales(id)).id = id);")
  ],
  [
    #vdm-code("Controlador.vdmpp (Líneas 45–68) — Control preventivo EvaluarRed()", 45, "public EvaluarRed: () ==> ()
EvaluarRed() == (
  for all sid in set dom sensores do (
    dcl lectura := sensores(sid).GenerarLectura();
    historial_telemetria := historial_telemetria ^ [lectura];
    if lectura.alerta = <CRITICO> then (
      alarmas_activas := alarmas_activas union {sid};
      compuertas(sid).CerrarTotalmente();
      if canales(sid).volumen_actual >= 5.0 then
        canales(sid).DrenarAgua(5.0);
    )
    elseif lectura.alerta = <PRECAUCION> then (
      alarmas_activas := alarmas_activas \ {sid};
      compuertas(sid).ConfigurarParcial(50);
    )
    else alarmas_activas := alarmas_activas \ {sid};
  )
);")
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 6: VALIDACIÓN VDM++ — COBERTURA 100% EN OVERTURE
// =====================================================================
#slide-header("Validación VDM++: Cobertura 100.0% en Overture v3.0.2")

#align(center)[
  #image("fig/cobertura_overture.png", height: 9.4cm)
]
#v(0.1cm)
#align(center)[
  #text(size: 10.5pt, fill: black)[
    *Suite `Test.vdmpp` (6 escenarios):* `EjecutarPruebas() = true` · *100.0%* en `Canal` (10), `Compuerta` (16), `Controlador` (39), `Sensor` (18) y `Test` (30).
  ]
]

#pagebreak()

// =====================================================================
// DIAPOSITIVA 7: AUTÓMATAS TEMPORIZADOS Y SIMULACIÓN EN UPPAAL 5.0
// =====================================================================
#slide-header("Verificación Temporal: Autómatas en UPPAAL 5.0")

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.65cm,
  align: (top, top),
  [
    #fig-clean(
      "fig/automata_compuerta.png",
      [(a) `Compuerta`: cierre físico en `Cerrando` (`T_CIERRE`).],
      max-height: 4.3cm
    )
    #v(0.14cm)
    #fig-clean(
      "fig/automata_sensor.png",
      [(b) `Sensor`: histéresis (`>= 80` cierra, `<= 60` reabre).],
      max-height: 3.3cm
    )
  ],
  [
    #fig-clean(
      "fig/simulacion_inicio_cierre.png",
      [(c) Simulador concreto: en `volumen = 80` se ordena el cierre mientras el canal aún se llena.],
      max-height: 8.0cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 8: RESULTADOS WCRT — CERTIFICACIÓN VS CONTRAEJEMPLO
// =====================================================================
#slide-header("Resultados WCRT: Certificación Verde vs Contraejemplo")

#grid(
  columns: (0.85fr, 1.25fr),
  gutter: 0.7cm,
  align: (top, top),
  [
    #section-label("Barrido en verifyta.exe")
    #table(
      columns: (auto, auto, 1fr),
      inset: 6pt,
      stroke: 0.6pt + gris-borde,
      fill: (x, y) => if y == 0 { granate-unsa } else { white },
      [*#text(fill: white, size: 10pt)[$T_("CIERRE")$]*],
      [*#text(fill: white, size: 10pt)[Pico]*],
      [*#text(fill: white, size: 10pt)[`volumen <= 100`]*],
      [#text(size: 10pt)[6 s (Nominal)]], [#text(size: 10pt)[95 $m^3$]], [#text(size: 10pt)[Conforme (7/7 CTL)]],
      [#text(size: 10pt)[8 s (Límite)]], [#text(size: 10pt)[100 $m^3$]], [#text(size: 10pt)[Conforme (límite)]],
      [#text(size: 10pt)[9 s]], [#text(size: 10pt)[105 $m^3$]], [#text(size: 10pt, fill: granate-unsa, weight: "bold")[Falla (desborde)]],
      [#text(size: 10pt)[10 s (Contraej.)]], [#text(size: 10pt)[105 $m^3$]], [#text(size: 10pt, fill: granate-unsa, weight: "bold")[Falla en `Cerrando`]],
    )
    #v(0.45cm)
    #text(size: 12pt, fill: black)[
      *Cota certificada:* el motor debe cerrar en *8 segundos o menos* para impedir desbordes (`105 > 100 m³`).
    ]
  ],
  [
    #fig-clean(
      "fig/verificacion_propiedades.png",
      [(a) Modelo nominal (`6 s`): 7/7 propiedades CTL en verde.],
      max-height: 3.0cm
    )
    #v(0.16cm)
    #fig-clean(
      "fig/contraejemplo_desborde.png",
      [(b) Contraejemplo (`10 s`): falla en rojo de `volumen <= MAX_CAPACIDAD`.],
      max-height: 4.6cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 9: TOLERANCIA A FALLOS — ATASCO Y WATCHDOG
// =====================================================================
#slide-header("Tolerancia a Fallos: Atasco y Watchdog")

#text(size: 11.5pt)[
  Ante obstrucciones por sedimentos, `Compuerta` puede pasar a `Atascada` y `Controlador` vigila el cierre con un *Watchdog* de `5 s`.
]
#v(0.25cm)

#grid(
  columns: (0.95fr, 1.15fr),
  gutter: 0.65cm,
  align: (center + top, center + top),
  [
    #fig-clean(
      "fig/automata_compuerta_fallos.png",
      [(a) `Compuerta` con fallo no determinista `Atascada`.],
      max-height: 7.0cm
    )
  ],
  [
    #fig-clean(
      "fig/automata_controlador_fallos.png",
      [(b) `Controlador` con *Watchdog* (`t_wd <= 5`) y `ModoFalloSeguro`.],
      max-height: 7.0cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 10: TOLERANCIA A FALLOS — ALIVIADERO Y VERIFICACIÓN CTL
// =====================================================================
#slide-header("Tolerancia a Fallos: Aliviadero y Verificación CTL")

#text(size: 11.5pt)[
  Al expirar el *Watchdog*, el quinto autómata `Aliviadero` abre en `2 s` y contiene el caudal (`6/6` propiedades CTL en verde).
]
#v(0.3cm)

#grid(
  columns: (1fr, 1.05fr),
  gutter: 0.7cm,
  align: (center + horizon, center + top),
  [
    #align(center)[
      #image("fig/automata_aliviadero.png", width: 100%) \
      #v(-0.08cm)
      #text(size: 8.8pt, fill: black)[(a) Quinto autómata `Aliviadero` (`T_ALIVIO = 2 s`).]
    ]
  ],
  [
    #fig-clean(
      "fig/verificacion_tolerante_fallos.png",
      [(b) Verifier UPPAAL 5.0: 6/6 fórmulas CTL satisfechas sin bloqueos.],
      max-height: 7.6cm
    )
  ]
)

#pagebreak()

// =====================================================================
// DIAPOSITIVA 11: CIERRE Y GRACIAS (PLANTILLA OFICIAL FERIA)
// =====================================================================
#v(0.45cm)
#text(size: 40pt, weight: "bold", fill: black)[Gracias...]
#v(0.55cm)

#grid(
  columns: (1.2fr, 1fr),
  gutter: 1.2cm,
  [
    #section-label("Conclusiones Principales")
    #set par(leading: 0.75em)
    - *VDM++ (Overture v3.0.2):* 5 clases con control preventivo gradual y *100.0% de cobertura*.
    #v(0.25cm)
    - *UPPAAL 5.0 (WCRT):* Contraejemplo en `>= 9 s` y seguridad certificada en `<= 8 s` (7/7 CTL).
    #v(0.25cm)
    - *Tolerancia a fallos:* *Watchdog* (`5 s`) + `Aliviadero` (`2 s`) garantizan contención ante atasco (6/6 CTL).
  ],
  [
    #v(0.2cm)
    #text(size: 14pt, style: "italic", fill: black)[
      “Las pruebas pueden mostrar la presencia de errores, pero solo la verificación formal demuestra seguridad antes de que el agua desborde.”
    ]
    #v(0.6cm)
    #text(size: 9.8pt, fill: gris-texto)[
      *Repositorio GitHub:* \
      `github.com/DenilsonCB/verificacion-formal-compuertas-agricolas-vdmpp-uppaal`
    ]
  ]
)
