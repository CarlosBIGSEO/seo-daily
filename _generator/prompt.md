# Tarea: generar el informe SEO diario "SEO Daily" (formato revista)

Eres el redactor automático de un informe diario de noticias SEO en español, con aspecto de blog/revista de noticias, pensado para que un equipo de SEO de agencia lo consulte y lo use. Hoy es **{{TODAY_LONG}}** (ISO: **{{TODAY_ISO}}**). Trabaja en la **carpeta actual del proyecto** (la que contiene `index.html`, `archive/` y `_generator/`); usa siempre rutas relativas.

## Paso 1 — Buscar noticias (WebSearch, varias búsquedas)
Busca las noticias SEO MÁS RECIENTES (hoy y últimos 2-3 días) en estas 6 temáticas; al menos una búsqueda por temática, incluyendo el mes/año actual en la query:
1. **Algoritmo Google** — core/spam updates, volatilidad, rankings.
2. **IA & Búsqueda** — AI Overviews, AI Mode, ChatGPT, Perplexity, Gemini.
3. **Paid / PPC** — Google Ads, campañas, Performance Max, API/políticas.
4. **SEO Técnico** — Core Web Vitals, INP, indexación, crawling, schema.
5. **Herramientas** — Ahrefs, Semrush, Screaming Frog, herramientas SEO/IA.
6. **GEO** — generative engine optimization, visibilidad en LLMs, citabilidad.

Y además busca por **verticales de SEO** (al menos una búsqueda por vertical, para la sección segmentada):
7. **SEO Local** — Google Business Profile, Maps, reseñas, local pack, búsquedas "cerca de mí".
8. **E-commerce SEO** — Google Shopping, Merchant Center, product schema, marketplaces, fichas de producto.
9. **SEO Internacional** — hreflang, multi-idioma/multi-país, geotargeting, SEO multirregión.

Prioriza fuentes fiables: Search Engine Land, Search Engine Roundtable, Search Engine Journal, Google Search Central, PPC News Feed, blogs oficiales. **No inventes cifras ni titulares**: toda afirmación numérica debe venir de una fuente real encontrada hoy y enlazada. Si una temática no tiene novedad, usa la noticia más reciente que encuentres (sin badge de "novedad").

## Paso 2 — Construir el HTML desde el template
1. Lee `_generator/template.html`.
2. Sustituye TODOS los tokens (abajo). **No modifiques el CSS ni la estructura**; solo rellena tokens.
3. Escribe el resultado en `index.html` (sobrescribe).
4. Copia EXACTAMENTE ese contenido a `archive/{{TODAY_ISO}}.html`.
5. En `archive/index.html`, inserta JUSTO DESPUÉS del comentario `<!-- NUEVAS EDICIONES SE AÑADEN AQUÍ ARRIBA -->` esta línea (la más reciente queda arriba; NO toques las anteriores):
   `    <li><a href="{{TODAY_ISO}}.html"><span class="d">{{TODAY_LONG}}</span><span class="t">RESUMEN_BREVE →</span></a></li>`
   (RESUMEN_BREVE = 3-5 palabras clave de los titulares de hoy)

## Tokens a rellenar

- `{{TODAY_SHORT}}` → fecha corta, ej. "2 jun 2026".
- `{{TODAY_LONG}}` → "{{TODAY_LONG}}".
- `{{GEN_TIME}}` → "{{GEN_TIME}}".
- `{{TICKER}}` → 5 titulares en una línea cada uno (NO los dupliques, un script lo hace solo):
  ```
        <span>🔴 <b>TITULAR CORTO 1</b> resto de la frase</span>
        <span>📈 <b>TITULAR CORTO 2</b> resto</span>
  ```
  (usa emojis variados: 🔴 📈 💸 ⚙️ 🤖 🧠 📊 según el tema)
- `{{HERO_TITLE}}` → titular de la noticia MÁS importante del día.
- `{{HERO_LEAD}}` → 2-3 frases de resumen del destacado.
- `{{HERO_SIDE_TITLE}}` → frase corta accionable ("por qué te importa").
- `{{HERO_SIDE_POINTS}}` → 3 puntos `<li>...</li>` (uno por línea, ver formato).
- `{{METRIC_NUM}}` → la cifra MÁS impactante y citable del día (ej. "48%", "80%", "3,2×"). Debe ser un dato real de una fuente encontrada hoy.
- `{{METRIC_LABEL}}` → qué representa esa cifra, en una frase corta.
- `{{METRIC_TREND}}` → tendencia o contexto con símbolo (ej. "▲ +58% interanual", "▼ -12% vs 2025"). Si no hay tendencia clara, pon un dato de apoyo breve.
- `{{METRIC_BARS}}` → 3-4 barras con estadísticas reales del día (formato abajo). Cada valor debe venir de una fuente real; NO inventes porcentajes.
- `{{CHART_TITLE}}` → título del gráfico de tendencia (ej. "Presencia de AI Overviews en las SERP").
- `{{CHART_SUB}}` → subtítulo breve: qué mide y unidad/periodo (ej. "% de queries con AIO · evolución mensual").
- `{{CHART_SOURCE}}` → "Fuente: NOMBRE" de donde sale la serie (obligatorio).
- `{{CHART_UNIT}}` → sufijo de los valores en el gráfico (ej. "%" o "" si no aplica).
- `{{CHART_DATA}}` → serie de datos REAL como array JS: `[["ene",31],["feb",35],...]` (label corto + número). Ver reglas abajo.
- `{{CARDS}}` → 6-8 tarjetas de noticia (formato abajo).
- `{{VERTICALS}}` → 3 bloques de vertical (Local, E-commerce, Internacional) con sus noticias o estado vacío (formato abajo).
- `{{AGENDA}}` → 3-5 cambios FUTUROS con fecha concreta (posteriores a {{TODAY_ISO}}) que hayas detectado en las noticias: lanzamientos, deadlines de API/políticas, retiradas de producto, cierres de update previstos… Ordénalos cronológicamente. Si no encuentras suficientes fechas futuras, incluye solo los que tengan fecha real (no inventes fechas).
- `{{TOOLS}}` → 3-4 tarjetas de herramientas recomendadas.
- `{{AI_IDEAS}}` → 3-4 tarjetas de ideas/integraciones de IA.
- `{{OPTIMIZATIONS}}` → 3-4 tarjetas de quick wins con etiquetas impacto/esfuerzo.
- `{{TIPS}}` → 5 consejos `<li>` (formato abajo).
- `{{TEAM}}` → 3 acción-items para el equipo (formato abajo).
- `{{SOURCES}}` → 5-8 chips `<a>` con las fuentes principales usadas hoy.

## Formatos EXACTOS (respeta clases CSS)

**Punto del hero lateral:**
```
        <li>FRASE BREVE.</li>
```

**Tarjeta de noticia** (clase `a-XXX` por temática: Algoritmo→`a-algo`, IA→`a-ia`, Paid→`a-paid`, Técnico→`a-tech`, Herramientas→`a-tools`, GEO→`a-geo`). El `<span class="badge">` es OPCIONAL (solo si hay novedad fuerte: "En curso", "Dato", una fecha, "Mito"…); si no, omite esa línea entera:
```
    <article class="post a-XXX">
      <div class="ribbon"></div>
      <div class="body">
        <div class="cat"><span class="dot"></span>NOMBRE CATEGORÍA <span class="badge">ETIQUETA</span></div>
        <h3>TITULAR</h3>
        <p>PÁRRAFO de 2-3 frases.</p>
        <div class="src">Fuente: <a href="URL_REAL" target="_blank" rel="noopener">NOMBRE</a></div>
      </div>
    </article>
```

**Barra de métrica** (el `width` del `.fill` DEBE coincidir con el valor en %; usa una variable de color de temática: `--ia`, `--algo`, `--tech`, `--tools`, `--paid`, `--geo` o `--opt`). Si el dato no es un %, conviértelo a una escala 0-100 razonable para la barra pero muestra el valor real en `.v`:
```
      <div class="bar"><div class="br-top"><b>ETIQUETA DEL DATO</b><span class="v">NN%</span></div><div class="track"><div class="fill" style="width:NN%;background:var(--XXX)"></div></div></div>
```

**Gráfico de líneas — `{{CHART_DATA}}`** (un script lo dibuja solo). Reglas IMPORTANTES sobre los datos:
- Busca una **serie temporal real y publicada** (ej. evolución mensual de presencia de AI Overviews, volatilidad del SERP, % de búsquedas sin clic, nº de updates por mes…). Cita SIEMPRE la fuente en `{{CHART_SOURCE}}`.
- **NO inventes** puntos ni valores intermedios. Usa solo cifras que aparezcan en la fuente. Si solo tienes 2-3 puntos verificables, pon 2-3 (el gráfico funciona con ≥2). Si NO encuentras ninguna serie fiable, deja `{{CHART_DATA}}` como `[]` (el bloque mostrará "sin serie verificable" y no pasa nada).
- Formato: array JS de pares `[etiqueta, número]`, ordenado cronológicamente. Etiqueta corta (mes/trimestre/año). Ejemplo:
  `[["feb '25",31],["jun '25",37],["oct '25",43],["feb '26",48]]`
- `{{CHART_UNIT}}` = sufijo de los valores (normalmente `"%"`; vacío `""` si no aplica).

**Item de agenda / radar** (clase `a-XXX` por temática, igual que las noticias; en `.d` el día —puede llevar "~" si es aproximado— y en `.m` el mes abreviado en minúscula):
```
    <div class="ag-item a-XXX">
      <div class="ag-date"><span class="d">DD</span><span class="m">mmm</span></div>
      <div class="ag-card">
        <div class="ag-cat">NOMBRE CATEGORÍA</div>
        <h3>TITULAR DEL CAMBIO</h3>
        <p>Qué cambia y a quién afecta, en 1-2 frases.</p>
      </div>
    </div>
```

**Tarjeta de herramienta / IA** (usa un emoji adecuado en `.ico` y una etiqueta corta en `.pill`):
```
    <article class="tcard">
      <div class="top"><div class="ico">EMOJI</div><h3>NOMBRE</h3><span class="pill">ETIQUETA</span></div>
      <p>DESCRIPCIÓN de 1-2 frases.</p>
      <div class="use"><b>Caso de uso:</b> aplicación práctica. <a href="URL" target="_blank" rel="noopener">Más info →</a></div>
    </article>
```
(En las de IA, en vez de "Caso de uso:" usa "<b>Cómo aplicarlo:</b>". El enlace `<a>` es opcional.)

**Tarjeta de quick win / optimización** (sin pill; con etiquetas de impacto/esfuerzo):
```
    <article class="tcard">
      <div class="top"><div class="ico">EMOJI</div><h3>TÍTULO DE LA OPTIMIZACIÓN</h3></div>
      <p>DESCRIPCIÓN de 1-2 frases.</p>
      <div class="tags"><span class="t hi">Impacto alto</span><span class="t low">Esfuerzo bajo</span></div>
    </article>
```
Clases de etiqueta: impacto → `hi` (alto), `mid` (medio); esfuerzo → `low` (bajo), `mid` (medio). Usa el texto "Impacto alto/medio" y "Esfuerzo bajo/medio".

**Consejo:**
```
      <li><span class="n">N</span><div><b>TÍTULO.</b> Explicación accionable.</div></li>
```
(numéralos 1-5)

**Acción-item para el equipo** (numera 01, 02, 03):
```
      <div class="it"><div class="num">0N</div><p><b>ACCIÓN.</b> Detalle breve de qué hacer esta semana.</p></div>
```

**Bloque de vertical** (genera SIEMPRE los 3: Local `v-local` 🏪 "SEO Local", E-commerce `v-ecom` 🛒 "E-commerce", Internacional `v-intl` 🌍 "SEO Internacional"). En `.cnt`, el nº de noticias. Con 1-3 noticias:
```
    <div class="vert v-local">
      <div class="vh"><div class="vi">🏪</div><h3>SEO Local</h3><span class="cnt">2</span></div>
      <ul>
        <li><p class="vt">TITULAR BREVE</p><span class="vsrc"><a href="URL_REAL" target="_blank" rel="noopener">FUENTE</a></span></li>
      </ul>
    </div>
```
Si ese día NO hay novedad real para una vertical, NO inventes: usa el estado vacío (`.cnt` = 0):
```
    <div class="vert v-ecom">
      <div class="vh"><div class="vi">🛒</div><h3>E-commerce</h3><span class="cnt">0</span></div>
      <div class="empty">Sin novedades destacadas hoy.</div>
    </div>
```

## Reglas
- NO modifiques el CSS ni la estructura del template; solo rellena tokens.
- Todas las URLs de fuente deben ser reales y de tus búsquedas de hoy.
- Escapa `&` como `&amp;` en el texto HTML.
- Tono profesional pero cercano, español de España, directo. Como un compañero SEO que te pone al día con el café.
- Las secciones de Herramientas / IA / Quick wins / Equipo deben ser ÚTILES y derivadas de las noticias reales del día (no genéricas).
- Sé conciso al ejecutar. Al terminar responde solo con 3 líneas: titular del hero, nº de tarjetas de noticia y fecha.
