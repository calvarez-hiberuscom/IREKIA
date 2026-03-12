$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()
$sel = $word.Selection

# --- CONSTANTES DE ESTILO (wdBuiltinStyle) ---
$wdStyleNormal     = -1
$wdStyleHeading1   = -2
$wdStyleHeading2   = -3
$wdStyleHeading3   = -4
$wdStyleTitle      = -63
$wdStyleSubtitle   = -75
$wdStyleListBullet = -49

# --- FUNCIONES AUXILIARES ---
function Write-Heading($text, $level) {
    switch ($level) {
        1 { $sel.Style = $doc.Styles.Item($wdStyleHeading1) }
        2 { $sel.Style = $doc.Styles.Item($wdStyleHeading2) }
        3 { $sel.Style = $doc.Styles.Item($wdStyleHeading3) }
    }
    $sel.TypeText($text)
    $sel.TypeParagraph()
}

function Write-Normal($text) {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.TypeText($text)
    $sel.TypeParagraph()
}

function Write-Bold($text) {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.Font.Bold = $true
    $sel.TypeText($text)
    $sel.Font.Bold = $false
    $sel.TypeParagraph()
}

function Write-BoldAndNormal($boldText, $normalText) {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.Font.Bold = $true
    $sel.TypeText($boldText)
    $sel.Font.Bold = $false
    $sel.TypeText($normalText)
    $sel.TypeParagraph()
}

function Write-Bullet($text) {
    $sel.Style = $doc.Styles.Item($wdStyleListBullet)
    $sel.TypeText($text)
    $sel.TypeParagraph()
}

function Write-BulletBoldAndNormal($boldText, $normalText) {
    $sel.Style = $doc.Styles.Item($wdStyleListBullet)
    $sel.Font.Bold = $true
    $sel.TypeText($boldText)
    $sel.Font.Bold = $false
    $sel.TypeText($normalText)
    $sel.TypeParagraph()
}

function Write-EmptyLine() {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.TypeParagraph()
}

# =============================================================================
# PORTADA
# =============================================================================
Write-EmptyLine
Write-EmptyLine
Write-EmptyLine

$sel.ParagraphFormat.Alignment = 1  # Center
$sel.Style = $doc.Styles.Item($wdStyleTitle)
$sel.TypeText("Proyecto Irekia Berria")
$sel.TypeParagraph()

$sel.Style = $doc.Styles.Item($wdStyleSubtitle)
$sel.TypeText("Planteamiento Inicial del Proyecto")
$sel.TypeParagraph()

Write-EmptyLine

$sel.Style = $doc.Styles.Item($wdStyleNormal)
$sel.Font.Color = 8421504  # Gris
$sel.TypeText("Estado: Borrador para alineamiento")
$sel.TypeParagraph()
$sel.TypeText("Fecha: 11 de marzo de 2026")
$sel.TypeParagraph()
$sel.TypeText("Autor: EJIE / Hiberus")
$sel.TypeParagraph()
$sel.Font.Color = 0
$sel.ParagraphFormat.Alignment = 0  # Left

$sel.InsertBreak(7)  # Page break

# =============================================================================
# INDICE
# =============================================================================
Write-Heading "Indice" 1

# Insertar tabla de contenido automatica (niveles 1-3)
$tocRange = $sel.Range
$doc.TablesOfContents.Add($tocRange, $true, 1, 3) | Out-Null
$sel.EndOf(6) | Out-Null  # wdStory
$sel.TypeParagraph()

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 1. RESUMEN EJECUTIVO
# =============================================================================

Write-Heading "1. Resumen ejecutivo" 1

Write-Normal "El proyecto Irekia Berria no es una evolucion de un portal, sino un programa de transformacion que involucra al menos seis bloques de trabajo interconectados:"

Write-EmptyLine

$table = $doc.Tables.Add($sel.Range, 7, 3)
$table.Borders.Enable = $true
$table.Cell(1,1).Range.Font.Bold = $true
$table.Cell(1,1).Range.Text = "Bloque"
$table.Cell(1,2).Range.Font.Bold = $true
$table.Cell(1,2).Range.Text = "Publica en"
$table.Cell(1,3).Range.Font.Bold = $true
$table.Cell(1,3).Range.Text = "Estado"

$table.Cell(2,1).Range.Text = "Portal Irekia Berria"
$table.Cell(2,2).Range.Text = "irekia.euskadi.eus"
$table.Cell(2,3).Range.Text = "Por disenar y desarrollar"

$table.Cell(3,1).Range.Text = "Gestion de Transparencia"
$table.Cell(3,2).Range.Text = "Irekia Berria"
$table.Cell(3,3).Range.Text = "Decisiones pendientes"

$table.Cell(4,1).Range.Text = "Gestion de Participacion"
$table.Cell(4,2).Range.Text = "Irekia Berria"
$table.Cell(4,3).Range.Text = "Definicion funcional pendiente"

$table.Cell(5,1).Range.Text = "Gestion de Prensa"
$table.Cell(5,2).Range.Text = "euskadi.eus / departamentales"
$table.Cell(5,3).Range.Text = "Levantamiento funcional necesario"

$table.Cell(6,1).Range.Text = "Diaspora"
$table.Cell(6,2).Range.Text = "Portales de sedes en el extranjero"
$table.Cell(6,3).Range.Text = "Requisitos por detallar"

$table.Cell(7,1).Range.Text = "Sistema de diseno"
$table.Cell(7,2).Range.Text = "Transversal"
$table.Cell(7,3).Range.Text = "Podria arrancar anticipadamente"

$sel.EndOf(15) | Out-Null  # wdStory
$sel.MoveDown() | Out-Null

Write-EmptyLine

Write-Normal "Las decisiones criticas pendientes son: la estrategia de repositorio de transparencia, el alcance funcional de la participacion, el detalle de modulos del CMS implicados (Sonia), y la priorizacion entre bloques."

Write-EmptyLine

Write-Normal "El siguiente hito inmediato es validar este documento y programar las sesiones de trabajo necesarias para resolver las dudas abiertas."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 2. CONTEXTO Y ENTENDIMIENTO DEL PROYECTO
# =============================================================================

Write-Heading "2. Contexto y entendimiento del proyecto" 1

Write-Heading "2.1. Situacion actual" 2

Write-Normal "El Gobierno Vasco dispone de un ecosistema de presencia web gestionado por EJIE, articulado en torno a euskadi.eus como portal unificado. Dentro de este ecosistema, Irekia (irekia.euskadi.eus) es el portal de Gobierno Abierto, que actualmente cubre funciones de comunicacion, transparencia, participacion ciudadana y canal multimedia."

Write-Normal "La plataforma actual se apoya en:"
Write-Bullet "Un CMS corporativo donde los funcionarios crean contenidos por tipo (noticia, evento, contenido general)."
Write-Bullet "Un gestor de ejes de catalogacion que clasifica los contenidos por tematica (sanidad, vivienda, etc.)."
Write-Bullet "Una herramienta de portales basada en plantillas (cabecera, pie, menu, estructura central)."
Write-Bullet "Irekia actual: construido en Ruby on Rails, PostgreSQL, Linux (publicado como OpenIrekia)."
Write-Bullet "Gardena: portal de transparencia actual, que utiliza un modulo de Insight de Esri para visualizacion de datos."

Write-Heading "2.2. Detonante del proyecto" 2

Write-Normal "Se plantea una reorganizacion profunda del ecosistema de Gobierno Abierto del Gobierno Vasco. Los cambios fundamentales son:"

Write-BulletBoldAndNormal "Gardena desaparece. " "El portal actual de transparencia dejara de existir como portal independiente."
Write-BulletBoldAndNormal "Las noticias salen de Irekia. " "La comunicacion institucional y la gestion de prensa pasan a un nuevo sistema propio que publicara en euskadi.eus y en los portales departamentales, no en Irekia."
Write-BulletBoldAndNormal "Irekia se refunda " "como portal unificado de Transparencia y Participacion ciudadana (Irekia Berria)."
Write-BulletBoldAndNormal "Se necesitan sistemas de gestion (back-office) " "especificos para cada ambito, que se integren con el CMS actual de euskadi.eus via servicios/APIs."

Write-Heading "2.3. Vision arquitectonica" 2

Write-Normal "La filosofia es construir sistemas externos con interfaces amables que gestionen la logica de negocio de cada ambito, y que publiquen sus resultados en los portales correspondientes a traves del ecosistema de presencia web existente. Es decir:"

Write-Bullet "Los sistemas de gestion son aplicaciones independientes (back-office)."
Write-Bullet "La publicacion se realiza a traves del CMS/portales de euskadi.eus."
Write-Bullet "Todo debe desarrollarse con la tecnologia estandar de administracion digital (Kubernetes, ecosistema de presencia web de EJIE)."
Write-BulletBoldAndNormal "Desarrollo a medida. " "No se contempla la integracion de productos cerrados ni soluciones existentes de terceros."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 3. BLOQUES FUNCIONALES DEL PROYECTO
# =============================================================================

Write-Heading "3. Bloques funcionales del proyecto" 1

Write-Normal "A partir de la informacion disponible, se identifican los siguientes bloques de trabajo. Cada uno tiene entidad propia, pero todos comparten ecosistema tecnologico y deben funcionar de forma coordinada."

Write-EmptyLine

# --- BLOQUE 1: IREKIA BERRIA ---
Write-Heading "3.1. Bloque 1 - Nuevo portal Irekia (Irekia Berria)" 2

Write-BoldAndNormal "Objetivo: " "Construir el nuevo portal publico de Gobierno Abierto del Gobierno Vasco, centrado en dos pilares: Transparencia y Participacion."

Write-Heading "3.1.1. Alcance conocido" 3
Write-Bullet "Diseno y desarrollo del nuevo portal web."
Write-Bullet "Integracion de contenidos de transparencia (procedentes del sistema de gestion de transparencia)."
Write-Bullet "Integracion de procesos de participacion (procedentes del sistema de gestion de participacion)."
Write-Bullet "Desaparicion de las noticias como contenido propio de Irekia."
Write-Bullet "Sustitucion de la tecnologia actual (Ruby on Rails) por el stack estandar de EJIE."
Write-Bullet "Accesibilidad, bilinguismo euskera/castellano, diseno responsive."

Write-Heading "3.1.2. Dependencias" 3
Write-Bullet "Requiere que los sistemas de gestion de transparencia y participacion esten definidos (al menos funcionalmente)."
Write-Bullet "El diseno podria ser realizado por Hiberus mientras EJIE prepara pliegos."

Write-EmptyLine

# --- BLOQUE 2: SISTEMA DE GESTION DE TRANSPARENCIA ---
Write-Heading "3.2. Bloque 2 - Sistema de gestion de Transparencia" 2

Write-BoldAndNormal "Objetivo: " "Dotar de un sistema de gestion (back-office) que permita gestionar y publicar los contenidos de transparencia que se mostraran en Irekia Berria. Sustituye al actual portal Gardena."

Write-Heading "3.2.1. Alcance conocido" 3
Write-Bullet "Analizar el portal de transparencia actual (Gardena) y su modelo de publicacion."
Write-Bullet "Definir como se presentaran los datos de transparencia en el nuevo Irekia."
Write-Bullet "Sustituir el modulo Insight de Esri por una alternativa para la visualizacion de datos."
Write-Bullet "Replicar o mejorar los flujos actuales de publicacion que usan los funcionarios."
Write-Bullet "Integracion con el repositorio/CMS de contenidos existente (por definir si se reutiliza o se crea nuevo)."

Write-Heading "3.2.2. Decisiones pendientes" 3
Write-Bullet "Si se reutiliza el repositorio de contenido actual de Gardena o se crea uno nuevo."
Write-Bullet "Que herramienta o desarrollo sustituira a Insight de Esri."
Write-Bullet "Si se proponen mejoras funcionales de transparencia (pendiente de validacion con la Directora de Gobierno, via Alex)."
Write-Bullet "Donde esta la linea entre transparencia y open data en el contexto del Gobierno Vasco."

Write-EmptyLine

# --- BLOQUE 3: SISTEMA DE GESTION DE PARTICIPACION ---
Write-Heading "3.3. Bloque 3 - Sistema de gestion de Participacion" 2

Write-BoldAndNormal "Objetivo: " "Desarrollar un sistema que gestione todos los procesos de participacion ciudadana, tanto los asociados a normativa como los voluntarios."

Write-Normal "El sistema debera contemplar dos ramas de participacion:"

Write-Heading "3.3.1. Participacion formal (asociada a normativa)" 3
Write-Bullet "Existe un sistema interno (Tramitagune) por el cual un funcionario que crea una norma puede marcarla para participacion."
Write-Bullet "Actualmente se publica una ficha en euskadi.eus poco atractiva y el ciudadano debe hacer alegaciones formales (certificado digital, procedimiento de alegacion)."
Write-Bullet "Se quiere que esto se muestre en Irekia Berria de forma mas atractiva: permitir al usuario subir la normativa, ponerle foto, presentarla de forma accesible."

Write-Heading "3.3.2. Participacion informal / voluntaria" 3
Write-Bullet "El Gobierno lanza consultas a la ciudadania sobre temas no vinculados a normativa (ej: consultas sobre iniciativas, propuestas, etc.)."
Write-Bullet "Se necesita un sistema para gestionar estas consultas de inicio a fin."

Write-Heading "3.3.3. Decisiones pendientes" 3
Write-Bullet "Si en las normativas con participacion obligatoria se debe abrir tambien a 'opinion' (ademas de las alegaciones formales)."
Write-Bullet "La parte funcional detallada la definira Sonia (modulos, etiquetas, flujos)."

Write-EmptyLine

# --- BLOQUE 4: SISTEMA DE GESTION DE PRENSA ---
Write-Heading "3.4. Bloque 4 - Sistema de gestion de Prensa y Comunicacion Institucional" 2

Write-BoldAndNormal "Objetivo: " "Desarrollar un sistema integral de gestion de prensa que cubra todo el ciclo de vida de un evento o accion comunicativa: desde la planificacion hasta la publicacion de todos los outputs generados."

Write-Bold "Importante: Este bloque NO publica en Irekia. Publica en euskadi.eus, homes departamentales y otros canales."

Write-Heading "3.4.1. Alcance conocido" 3
Write-Bullet "Gestion completa del proceso de eventos: calendarizacion, asignacion de recursos, produccion de contenidos."
Write-Bullet "Diferentes roles en el proceso: jefe de prensa (calendariza), PM y gestor de contenidos (detalles operativos), agencias externas (pueden acceder al sistema con permisos adecuados)."
Write-Bullet "Generacion de multiples tipos de output: fotos, videos, streaming, noticias texto, contenidos para RRSS."
Write-Bullet "Conexion con un DAM (Digital Asset Management) para almacenar, coordinar, etiquetar y reutilizar los assets de forma cruzada."
Write-Bullet "Los gabinetes de prensa de cada departamento deben poder usar el sistema y disponer de la informacion para publicar."
Write-Bullet "Publicacion en: home de euskadi.eus, homes departamentales, RRSS."
Write-Bullet "Debe simplificar y mejorar el proceso actual de creacion de noticias en euskadi.eus."

Write-Heading "3.4.2. Consideraciones" 3
Write-BulletBoldAndNormal "No se utilizara un producto cerrado. " "Se descarta la integracion de productos existentes (como Xalok u otros). El sistema sera un desarrollo a medida."
Write-Bullet "Gestion de recursos y equipamientos asociados a eventos: seran dos modulos separados por detras (gestion de evento + gestion de recursos generales), aunque el usuario vea una sola interfaz."
Write-Bullet "Hay una parte de infraestructura de media existente (directorio donde se guardan assets) que hay que tener en cuenta."

Write-EmptyLine

# --- BLOQUE 5: DIASPORA ---
Write-Heading "3.5. Bloque 5 - Diaspora (Sedes vascas en el extranjero)" 2

Write-BoldAndNormal "Objetivo: " "Dotar a las sedes vascas en el extranjero de herramientas para gestionar sus propias paginas web."

Write-Heading "3.5.1. Alcance conocido" 3
Write-Bullet "Modelo similar al sistema de bibliotecas: una plantilla comun con capacidad de personalizacion por sede."
Write-Bullet "Estructura de plantilla de portales + publicacion de contenidos."

Write-Heading "3.5.2. Problematica especifica" 3
Write-Bullet "Los usuarios en el extranjero no disponen de BAK ni certificado digital. Se necesita un sistema de autenticacion alternativo."
Write-Bullet "Existen soluciones intermedias actuales, pero se quiere un sistema especifico."

Write-EmptyLine

# --- BLOQUE 6: DISENO ---
Write-Heading "3.6. Bloque 6 - Sistema de diseno y aplicacion en euskadi.eus" 2

Write-BoldAndNormal "Objetivo: " "Disenar y aplicar un sistema de diseno coherente al ecosistema de portales."

Write-Heading "3.6.1. Alcance conocido" 3
Write-Bullet "Aplicar el sistema de diseno en euskadi.eus y portales departamentales."
Write-Bullet "No es objeto de este proyecto migrar euskadi.eus, pero todo tiene que ir acompasado."
Write-Bullet "Disenar el nuevo Irekia y preparar euskadi.eus y departamentales para mostrar los nuevos contenidos (prensa, transparencia, participacion)."

Write-Heading "3.6.2. Organizacion prevista" 3
Write-Bullet "Hiberus podria centrarse en disenar el nuevo Irekia."
Write-Bullet "Maria indica que la consultora puede contratar a Hiberus para realizar el diseno."
Write-Bullet "EJIE se centraria en el desarrollo tecnico y la redaccion de pliegos."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 4. MAPA DE SISTEMAS Y FLUJOS DE PUBLICACION
# =============================================================================

Write-Heading "4. Mapa de sistemas y flujos de publicacion" 1

Write-Normal "A continuacion se describe como se relacionan los sistemas de gestion con los canales de publicacion, segun la informacion disponible:"

Write-Heading "4.1. Sistema de gestion de Transparencia" 2
Write-Bullet "Fuente: repositorio de contenido de Gardena (o nuevo, pendiente de decidir)."
Write-Bullet "Destino de publicacion: Nuevo portal Irekia (seccion Transparencia)."

Write-Heading "4.2. Sistema de gestion de Participacion" 2
Write-Bullet "Fuente 1: Tramitagune (participacion formal / normativa)."
Write-Bullet "Fuente 2: Sistema propio de participacion voluntaria."
Write-Bullet "Destino de publicacion: Nuevo portal Irekia (seccion Participacion)."

Write-Heading "4.3. Sistema de gestion de Prensa" 2
Write-Bullet "Fuente: Sistema nuevo de gestion integral de eventos y comunicacion."
Write-Bullet "Almacenamiento de contenido: CMS actual de euskadi.eus."
Write-Bullet "Almacenamiento de assets: DAM (nuevo o existente)."
Write-Bullet "Destino de publicacion: Home de euskadi.eus, homes departamentales, RRSS."
Write-Bullet "NO publica en Irekia."

Write-Heading "4.4. Diaspora" 2
Write-Bullet "Fuente: Sistema propio de gestion de contenidos de las sedes."
Write-Bullet "Destino: Portales individuales de cada sede vasca en el extranjero."

Write-Heading "4.5. Entidades y cargos publicos" 2
Write-Bullet "Actualmente en Irekia. Pendiente de definir si se mantiene en Irekia Berria o migra a otro sistema."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 5. RESTRICCIONES Y CONDICIONANTES TECNICOS
# =============================================================================

Write-Heading "5. Restricciones y condicionantes tecnicos" 1

Write-Bullet "Todo desarrollo debe seguir el estandar tecnologico de administracion digital de EJIE (Kubernetes, ecosistema de presencia web)."
Write-Bullet "Las aplicaciones deben ser iguales en tecnologia al resto del ecosistema."
Write-Bullet "Desarrollo a medida: no se integraran productos cerrados de terceros."
Write-Bullet "Existe un contrato con EJIE con tarifas por perfil ya establecidas."
Write-Bullet "No es objeto de este proyecto migrar euskadi.eus, pero los desarrollos deben ser compatibles y acompasados."
Write-Bullet "La parte funcional detallada la definira la consultora que lleva el ANS, apoyada por Sonia (modulos y sistemas del CMS actual)."
Write-Bullet "A nivel tecnologico, EJIE / Hiberus deben encargarse de que todo funcione dentro del ecosistema de presencia web."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 6. DUDAS ABIERTAS Y DECISIONES PENDIENTES
# =============================================================================

Write-Heading "6. Dudas abiertas y decisiones pendientes" 1

Write-Heading "6.1. Sobre Transparencia" 2
Write-Bullet "Se reutiliza el repositorio de contenido de Gardena o se desarrolla uno nuevo?"
Write-Bullet "Que sustituye al modulo Insight de Esri para la visualizacion de datos?"
Write-Bullet "Se proponen mejoras funcionales de transparencia o se replica el modelo actual con mejor presentacion? (Pendiente de validacion con la Directora de Gobierno, via Alex)."
Write-Bullet "Donde esta la linea entre transparencia y open data? Es transparencia publicar sueldos de cargos publicos, pero es open data publicar puntos de carga electrica? Como se delimita el alcance?"

Write-Heading "6.2. Sobre Participacion" 2
Write-Bullet "En la participacion formal (normativa), ademas de las alegaciones formales, se debe abrir a opinion publica?"
Write-Bullet "Cual es el detalle funcional de los procesos de participacion? (Pendiente de Sonia)."
Write-Bullet "Que nivel de interaccion se espera? Solo consulta y alegacion, o tambien debate, votacion, seguimiento?"
Write-Bullet "Como se conecta con Tramitagune? Via API, replicacion de datos, enlace?"

Write-Heading "6.3. Sobre Prensa y Comunicacion" 2
Write-Bullet "Cual es el proceso actual completo de gestion de un evento de prensa? Se necesita un levantamiento detallado."
Write-Bullet "Existe un DAM actual o hay que implementar uno nuevo?"
Write-Bullet "Que permisos y roles necesitan las agencias externas que participan en el proceso?"
Write-Bullet "Como se gestiona actualmente la publicacion de noticias en euskadi.eus? (Sonia debe mostrarlo)."
Write-Bullet "Que integracion se necesita con RRSS? Publicacion automatica, programada, manual?"

Write-Heading "6.4. Sobre Diaspora" 2
Write-Bullet "Cuantas sedes existen y cuales son sus necesidades especificas?"
Write-Bullet "Que solucion de autenticacion se contempla para usuarios sin BAK?"
Write-Bullet "Que nivel de autonomia tendran las sedes en la gestion de sus portales?"

Write-Heading "6.5. Sobre Diseno" 2
Write-Bullet "Existe un sistema de diseno corporativo definido o hay que crearlo desde cero?"
Write-Bullet "Quien lidera la definicion del diseno: Hiberus, la consultora, Gobierno?"
Write-Bullet "Hay directrices de accesibilidad y bilinguismo ya documentadas?"

Write-Heading "6.6. Sobre Organizacion y Gobierno del Proyecto" 2
Write-Bullet "Quien es el responsable funcional de cada bloque?"
Write-Bullet "Cual es la priorizacion entre bloques? Se abordan todos en paralelo o hay secuencia?"
Write-Bullet "Hay plazos comprometidos o hitos conocidos?"
Write-Bullet "Que papel juega la consultora del ANS frente a EJIE y frente a Hiberus?"
Write-Bullet "Cuando podra Sonia proporcionar el detalle de modulos y sistemas implicados?"

Write-Heading "6.7. Sobre Entidades y Cargos Publicos" 2
Write-Bullet "El modulo de entidades y cargos publicos que hoy esta en Irekia, se mantiene en Irekia Berria?"
Write-Bullet "Se necesita evolucion funcional o solo migracion?"

$sel.InsertBreak(7)  # Page break

# =============================================================================
# 7. SIGUIENTES PASOS PROPUESTOS
# =============================================================================

Write-Heading "7. Siguientes pasos propuestos" 1

Write-Normal "Para avanzar con la definicion y estimacion del proyecto, se proponen los siguientes pasos:"

Write-Heading "7.1. Paso 1 - Validacion de este documento" 2
Write-Bullet "Confirmar que el entendimiento reflejado aqui es correcto."
Write-Bullet "Corregir cualquier interpretacion erronea."
Write-Bullet "Identificar elementos que falten."

Write-Heading "7.2. Paso 2 - Resolucion de dudas criticas" 2
Write-Bullet "Resolver las decisiones pendientes de transparencia (Alex / Directora de Gobierno)."
Write-Bullet "Obtener de Sonia el detalle de modulos y sistemas del CMS actual implicados."
Write-Bullet "Confirmar la priorizacion entre bloques."

Write-Heading "7.3. Paso 3 - Levantamiento funcional por bloque" 2
Write-Bullet "Para cada bloque, documentar: procesos actuales (AS-IS), procesos objetivo (TO-BE), actores, datos, integraciones."
Write-Bullet "La consultora del ANS deberia liderar esta fase con apoyo de Sonia."

Write-Heading "7.4. Paso 4 - Definicion tecnica de alto nivel" 2
Write-Bullet "Arquitectura de cada sistema de gestion."
Write-Bullet "Modelo de integracion con el CMS y el ecosistema de presencia web."
Write-Bullet "Requisitos de infraestructura (Kubernetes, almacenamiento, etc.)."

Write-Heading "7.5. Paso 5 - Estimacion" 2
Write-Bullet "Con el levantamiento funcional y la arquitectura tecnica, generar una estimacion por bloque."
Write-Bullet "Diferenciar: diseno, desarrollo back-office, desarrollo portal, integraciones, DAM, migracion de datos, QA."

Write-Heading "7.6. Paso 6 - Planificacion" 2
Write-Bullet "Definir fases, dependencias entre bloques, equipo necesario y calendario."
Write-Bullet "Identificar que puede arrancar antes (ej: diseno de Irekia Berria) y que necesita esperar a decisiones pendientes."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# ANEXO A: ANALISIS DEL PORTAL IREKIA ACTUAL
# =============================================================================

Write-Heading "Anexo A - Analisis del portal Irekia actual" 1

Write-Normal "Analisis realizado sobre el portal en produccion (irekia.euskadi.eus) a fecha 11 de marzo de 2026. El objetivo es inventariar todos los componentes y secciones existentes para poder mapear que se conserva, que se elimina y que se reinventa en Irekia Berria."

Write-Heading "A.1. Estructura general del portal" 2

Write-Normal "El portal se organiza en torno a una navegacion principal con las siguientes secciones:"

# Tabla estructura general
$tableA1 = $doc.Tables.Add($sel.Range, 11, 3)
$tableA1.Borders.Enable = $true
$tableA1.Cell(1,1).Range.Font.Bold = $true
$tableA1.Cell(1,1).Range.Text = "Seccion"
$tableA1.Cell(1,2).Range.Font.Bold = $true
$tableA1.Cell(1,2).Range.Text = "URL"
$tableA1.Cell(1,3).Range.Font.Bold = $true
$tableA1.Cell(1,3).Range.Text = "Descripcion"

$tableA1.Cell(2,1).Range.Text = "Home"
$tableA1.Cell(2,2).Range.Text = "irekia.euskadi.eus/es"
$tableA1.Cell(2,3).Range.Text = "Noticia destacada, TV en linea, carrusel de debates abiertos, acceso a participacion, videos y fotos recientes"

$tableA1.Cell(3,1).Range.Text = "Noticias"
$tableA1.Cell(3,2).Range.Text = "/es/news"
$tableA1.Cell(3,3).Range.Text = "Listado de noticias por departamento. +2.946 paginas. Incluye fotos, videos, audio. Filtro por departamento."

$tableA1.Cell(4,1).Range.Text = "Agenda / Eventos"
$tableA1.Cell(4,2).Range.Text = "/es/events"
$tableA1.Cell(4,3).Range.Text = "Calendario de eventos publicos. +1.483 paginas. Vista calendario mensual. Marca si Irekia cubre en directo."

$tableA1.Cell(5,1).Range.Text = "Propuestas de Gobierno (Debates)"
$tableA1.Cell(5,2).Range.Text = "/es/debates"
$tableA1.Cell(5,3).Range.Text = "Consultas publicas abiertas por el Gobierno. Votacion a favor/en contra. Comentarios. 33 paginas historicas."

$tableA1.Cell(6,1).Range.Text = "Peticiones Ciudadanas"
$tableA1.Cell(6,2).Range.Text = "/es/proposals"
$tableA1.Cell(6,3).Range.Text = "Peticiones creadas por la ciudadania. Votacion, comentarios. 313 paginas historicas. Cualquier usuario registrado puede crear una."

$tableA1.Cell(7,1).Range.Text = "Respuestas del Gobierno"
$tableA1.Cell(7,2).Range.Text = "/es/answers"
$tableA1.Cell(7,3).Range.Text = "Respuestas oficiales de departamentos a peticiones ciudadanas. 322 paginas. Cada departamento responde en su ambito."

$tableA1.Cell(8,1).Range.Text = "Encuestas"
$tableA1.Cell(8,2).Range.Text = "/es/surveys"
$tableA1.Cell(8,3).Range.Text = "Encuestas puntuales. Actualmente solo 1 activa. Formato sencillo de votacion."

$tableA1.Cell(9,1).Range.Text = "Videos / WebTV"
$tableA1.Cell(9,2).Range.Text = "/es/web_tv"
$tableA1.Cell(9,3).Range.Text = "Videoteca organizada por departamentos y categorias tematicas. +8.500 videos. Incluye seccion Podcasts, campanas, debates parlamentarios."

$tableA1.Cell(10,1).Range.Text = "Fotos"
$tableA1.Cell(10,2).Range.Text = "(dentro de noticias)"
$tableA1.Cell(10,3).Range.Text = "Galerias fotograficas asociadas a noticias. No es seccion independiente."

$tableA1.Cell(11,1).Range.Text = "Streaming / TV en linea"
$tableA1.Cell(11,2).Range.Text = "(home)"
$tableA1.Cell(11,3).Range.Text = "Widget de emision en directo en la home. Cubre plenos parlamentarios, aperturas de plicas, ruedas de prensa."

$sel.EndOf(15) | Out-Null
$sel.MoveDown() | Out-Null
Write-EmptyLine

Write-Heading "A.2. Componentes y elementos transversales" 2

Write-Heading "A.2.1. Cabecera" 3
Write-Bullet "Logo Irekia + enlace a euskadi.eus."
Write-Bullet "Selector de idioma: euskera, castellano, ingles."
Write-Bullet "Enlace a Insuit (accesibilidad) y Lectura Facil."
Write-Bullet "Enlaces a contacto, accesibilidad y sede electronica de euskadi.eus."

Write-Heading "A.2.2. Barra de participacion (persistente)" 3
Write-Bullet "Peticiones Ciudadanas / Propuestas de Gobierno / Respuestas del Gobierno / Encuestas."
Write-Bullet "Boton 'Ayudanos a mejorar' (enlace a contacto)."
Write-Bullet "Boton 'Crea una peticion publica' (acceso directo a formulario)."

Write-Heading "A.2.3. Sidebar derecho (en secciones de noticias)" 3
Write-Bullet "Widget de TV en linea (streaming en directo)."
Write-Bullet "Calendario mensual de eventos."
Write-Bullet "Enlaces a: Guia de Comunicacion, Comision de Etica Publica, Apertura de Plicas."

Write-Heading "A.2.4. Banners laterales (sidebar en participacion)" 3
Write-Bullet "Planes de Gobierno (Plan de Accion Gobierno Abierto, Programa de Gobierno, Presupuestos, planes sectoriales)."
Write-Bullet "Rotacion de banners con links a documentos clave."

Write-Heading "A.2.5. Pie de pagina" 3
Write-Bullet "RSS de Noticias, Boletin de noticias (suscripcion email), ICS de Agenda."
Write-Bullet "Registro de periodistas."
Write-Bullet "Enlace a Transparencia Euskadi (gardena.euskadi.eus) - portal separado."
Write-Bullet "Enlace a Open Data Euskadi (opendata.euskadi.eus) - portal separado."
Write-Bullet "Enlace a Acceso a la Informacion Publica (tramite en euskadi.eus)."
Write-Bullet "Graficos de elecciones (subdominio grafikoak.irekia)."
Write-Bullet "FAQ, Codigo fuente (OpenIrekia), Informacion legal, Cookies, Condiciones de uso, Privacidad."

Write-Heading "A.3. Funcionalidades de participacion (detalle)" 2

Write-Heading "A.3.1. Propuestas de Gobierno (/es/debates)" 3
Write-Bullet "El Gobierno publica una iniciativa (decreto, orden, anteproyecto...)."
Write-Bullet "El ciudadano puede votar a favor o en contra."
Write-Bullet "El ciudadano puede comentar (texto libre)."
Write-Bullet "Se muestra el porcentaje de votos a favor/en contra."
Write-Bullet "Filtro por departamento."
Write-Bullet "Carrusel explicativo de 3 fases: Presentacion, Debate y Conclusiones."

Write-Heading "A.3.2. Peticiones Ciudadanas (/es/proposals)" 3
Write-Bullet "Cualquier usuario registrado crea una peticion publica dirigida al Gobierno."
Write-Bullet "Otros usuarios pueden votar y comentar."
Write-Bullet "El departamento correspondiente puede responder oficialmente."
Write-Bullet "Incluye enlace adicional a: contacto privado con el Gobierno, tramite formal de acceso a informacion publica, contacto con Comision Etica, Registro Electronico."

Write-Heading "A.3.3. Respuestas del Gobierno (/es/answers)" 3
Write-Bullet "Feed cronologico de respuestas oficiales de los departamentos a peticiones ciudadanas."
Write-Bullet "Cada respuesta enlaza a la peticion original."
Write-Bullet "Los departamentos responden con su nombre institucional en euskera."

Write-Heading "A.3.4. Encuestas (/es/surveys)" 3
Write-Bullet "Formato muy sencillo de encuesta de opcion."
Write-Bullet "Actualmente solo 1 encuesta activa."
Write-Bullet "Uso infrecuente."

Write-Heading "A.4. Seccion multimedia (detalle)" 2

Write-Heading "A.4.1. WebTV (/es/web_tv)" 3
Write-Bullet "Organizacion por departamentos (todos los del Gobierno Vasco)."
Write-Bullet "Categorias tematicas adicionales: Parlamento Vasco, Ruedas de prensa Consejo de Gobierno, Campanas, Astekonomia, Gobierno Abierto, Paz y Convivencia, PCTI, Topaketak, Tutoriales."
Write-Bullet "Volumen: miles de videos por departamento (ej: Lehendakaritza +2.632, Seguridad +2.961)."
Write-Bullet "Seccion separada de Podcasts."

Write-Heading "A.4.2. Streaming" 3
Write-Bullet "Widget en la home de TV en linea."
Write-Bullet "Se usa para plenos parlamentarios, aperturas de plicas, eventos institucionales."

Write-Heading "A.5. Mapeo: que pasa con cada componente en Irekia Berria" 2

# Tabla mapeo
$tableA5 = $doc.Tables.Add($sel.Range, 13, 3)
$tableA5.Borders.Enable = $true
$tableA5.Cell(1,1).Range.Font.Bold = $true
$tableA5.Cell(1,1).Range.Text = "Componente actual"
$tableA5.Cell(1,2).Range.Font.Bold = $true
$tableA5.Cell(1,2).Range.Text = "Destino en Irekia Berria"
$tableA5.Cell(1,3).Range.Font.Bold = $true
$tableA5.Cell(1,3).Range.Text = "Notas"

$tableA5.Cell(2,1).Range.Text = "Noticias"
$tableA5.Cell(2,2).Range.Text = "SALE de Irekia"
$tableA5.Cell(2,3).Range.Text = "Va al nuevo sistema de prensa. Publica en euskadi.eus y departamentales."

$tableA5.Cell(3,1).Range.Text = "Agenda / Eventos"
$tableA5.Cell(3,2).Range.Text = "SALE de Irekia"
$tableA5.Cell(3,3).Range.Text = "Va al sistema de gestion de prensa (calendarizacion de eventos)."

$tableA5.Cell(4,1).Range.Text = "Propuestas de Gobierno (Debates)"
$tableA5.Cell(4,2).Range.Text = "SE REINVENTA en Irekia"
$tableA5.Cell(4,3).Range.Text = "Nucleo del pilar de Participacion. Se mejora presentacion y UX."

$tableA5.Cell(5,1).Range.Text = "Peticiones Ciudadanas"
$tableA5.Cell(5,2).Range.Text = "SE REINVENTA en Irekia"
$tableA5.Cell(5,3).Range.Text = "Nucleo del pilar de Participacion. Participacion informal/voluntaria."

$tableA5.Cell(6,1).Range.Text = "Respuestas del Gobierno"
$tableA5.Cell(6,2).Range.Text = "SE REINVENTA en Irekia"
$tableA5.Cell(6,3).Range.Text = "Ligado al ciclo de participacion."

$tableA5.Cell(7,1).Range.Text = "Encuestas"
$tableA5.Cell(7,2).Range.Text = "POR DECIDIR"
$tableA5.Cell(7,3).Range.Text = "Uso actual minimo. Valorar si se mantiene o se integra en el modulo de participacion."

$tableA5.Cell(8,1).Range.Text = "Videos / WebTV"
$tableA5.Cell(8,2).Range.Text = "SALE de Irekia"
$tableA5.Cell(8,3).Range.Text = "Va al DAM + sistema de prensa. Pendiente definir si Irekia mantiene algun acceso a videos."

$tableA5.Cell(9,1).Range.Text = "Streaming / TV en linea"
$tableA5.Cell(9,2).Range.Text = "POR DECIDIR"
$tableA5.Cell(9,3).Range.Text = "Es infraestructura de media. Por definir si se mantiene en Irekia o migra a euskadi.eus."

$tableA5.Cell(10,1).Range.Text = "Transparencia (enlace a Gardena)"
$tableA5.Cell(10,2).Range.Text = "SE INTEGRA en Irekia"
$tableA5.Cell(10,3).Range.Text = "Gardena desaparece. La transparencia pasa a ser pilar de Irekia Berria."

$tableA5.Cell(11,1).Range.Text = "Banners laterales (planes)"
$tableA5.Cell(11,2).Range.Text = "POR DECIDIR"
$tableA5.Cell(11,3).Range.Text = "Vinculados a comunicacion del programa de gobierno. Que rol juegan en el nuevo portal?"

$tableA5.Cell(12,1).Range.Text = "Entidades y cargos publicos"
$tableA5.Cell(12,2).Range.Text = "POR DECIDIR"
$tableA5.Cell(12,3).Range.Text = "Actualmente en Irekia. Podria encajar en transparencia o migrar a euskadi.eus."

$tableA5.Cell(13,1).Range.Text = "Registro de periodistas"
$tableA5.Cell(13,2).Range.Text = "SALE de Irekia"
$tableA5.Cell(13,3).Range.Text = "Ligado a prensa. Debe ir al sistema de gestion de prensa."

$sel.EndOf(15) | Out-Null
$sel.MoveDown() | Out-Null
Write-EmptyLine

Write-Heading "A.6. Observaciones sobre el portal actual" 2

Write-Bullet "El portal tiene un volumen de contenido historico muy alto: +2.947 paginas de noticias, +1.483 de eventos, +313 de peticiones, +8.500 videos."
Write-Bullet "La participacion (debates, peticiones) muestra niveles de interaccion generalmente bajos: muchas propuestas con 0 votos y 0 comentarios."
Write-Bullet "La UX es funcional pero anticuada. El diseno no transmite modernidad."
Write-Bullet "Transparencia no esta en Irekia: es un enlace externo a Gardena. No hay integracion visual ni funcional."
Write-Bullet "El streaming y la videoteca ocupan un peso importante en el portal, pero conceptualmente son comunicacion, no participacion ni transparencia."
Write-Bullet "La barra de participacion (Peticiones/Propuestas/Respuestas/Encuestas) es el unico elemento que permanecera conceptualmente en Irekia Berria."
Write-Bullet "El selector trilingue (eu/es/en) debera mantenerse."

$sel.InsertBreak(7)  # Page break

# =============================================================================
# ANEXO B: BENCHMARKING TRANSPARENCIA EUROPEA
# =============================================================================

Write-Heading "Anexo B - Mejores portales de transparencia en Europa: comparativa con Gardena" 1

Write-Normal "Se analizan tres referentes europeos en transparencia gubernamental y se comparan con el portal actual de Gardena (gardena.euskadi.eus) para identificar buenas practicas aplicables a Irekia Berria."

Write-Heading "B.1. Los tres referentes seleccionados" 2

Write-Heading "B.1.1. Francia - Haute Autorite pour la Transparence de la Vie Publique (hatvp.fr)" 3
Write-Bullet "Organo independiente dedicado a la probidad y transparencia de los cargos publicos."
Write-Bullet "Publicacion de declaraciones patrimoniales e intereses de todos los responsables publicos."
Write-Bullet "Registro de representantes de intereses (lobbies)."
Write-Bullet "Registro de influencia extranjera (unico en Europa)."
Write-Bullet "Fichas nominativas consultables por cualquier ciudadano (las mas vistas: Presidente, ministros)."
Write-Bullet "Deliberaciones y avisos publicados integramente."
Write-Bullet "Recursos documentales y guias deontologicas accesibles."

Write-Heading "B.1.2. Reino Unido - data.gov.uk + GOV.UK Transparency" 3
Write-Bullet "Portal de datos abiertos mas maduro de Europa."
Write-Bullet "Organizacion por temas (Business, Crime, Defence, Education, Environment, Government, Spending, Health, Mapping, Society, Transport...)."
Write-Bullet "Todos los pagos de gobierno por encima de 25.000 libras publicados como dato abierto."
Write-Bullet "Busqueda potente sobre datasets."
Write-Bullet "APIs abiertas con licencia Open Government Licence."
Write-Bullet "Construido por GDS (Government Digital Service) con estandares de diseno reutilizables."
Write-Bullet "Complementado por GOV.UK donde la transparencia se integra en cada departamento."

Write-Heading "B.1.3. Finlandia - Suomi.fi + opendata.fi + Tutkihallintoa.fi" 3
Write-Bullet "Tradicion nordica de acceso a documentos publicos como derecho fundamental."
Write-Bullet "Tutkihallintoa.fi: portal que permite consultar sueldos, gastos y decisiones de cualquier organismo publico."
Write-Bullet "Transparencia integrada en el funcionamiento del gobierno, no como portal separado."
Write-Bullet "Cualquier ciudadano puede solicitar acceso a cualquier documento de la administracion (principio de publicidad desde 1766)."
Write-Bullet "Datos abiertos con estandares CKAN, actualizacion regular."
Write-Bullet "Contexto comparable: bilinguismo oficial (fines/sueco), region con identidad fuerte."

Write-Heading "B.2. Comparativa con Gardena (portal actual)" 2

# Tabla comparativa
$tableB2 = $doc.Tables.Add($sel.Range, 10, 5)
$tableB2.Borders.Enable = $true
$tableB2.Cell(1,1).Range.Font.Bold = $true
$tableB2.Cell(1,1).Range.Text = "Aspecto"
$tableB2.Cell(1,2).Range.Font.Bold = $true
$tableB2.Cell(1,2).Range.Text = "Gardena actual"
$tableB2.Cell(1,3).Range.Font.Bold = $true
$tableB2.Cell(1,3).Range.Text = "Francia (HATVP)"
$tableB2.Cell(1,4).Range.Font.Bold = $true
$tableB2.Cell(1,4).Range.Text = "Reino Unido"
$tableB2.Cell(1,5).Range.Font.Bold = $true
$tableB2.Cell(1,5).Range.Text = "Finlandia"

$tableB2.Cell(2,1).Range.Text = "Foco principal"
$tableB2.Cell(2,2).Range.Text = "Visualizacion de datos + informacion institucional"
$tableB2.Cell(2,3).Range.Text = "Probidad y patrimonio de cargos publicos"
$tableB2.Cell(2,4).Range.Text = "Datos abiertos reutilizables"
$tableB2.Cell(2,5).Range.Text = "Acceso universal a documentos publicos"

$tableB2.Cell(3,1).Range.Text = "Datos de cargos publicos"
$tableB2.Cell(3,2).Range.Text = "Si (RPT, puestos)"
$tableB2.Cell(3,3).Range.Text = "Si (declaraciones patrimoniales individuales)"
$tableB2.Cell(3,4).Range.Text = "Si (pagos +25K libras)"
$tableB2.Cell(3,5).Range.Text = "Si (sueldos y decisiones por organismo)"

$tableB2.Cell(4,1).Range.Text = "Visualizacion de datos"
$tableB2.Cell(4,2).Range.Text = "Si (Insight de Esri)"
$tableB2.Cell(4,3).Range.Text = "No (fichas textuales)"
$tableB2.Cell(4,4).Range.Text = "Limitada (datasets descargables)"
$tableB2.Cell(4,5).Range.Text = "Moderada"

$tableB2.Cell(5,1).Range.Text = "Datos abiertos / APIs"
$tableB2.Cell(5,2).Range.Text = "No (enlace a Open Data Euskadi)"
$tableB2.Cell(5,3).Range.Text = "Algunas APIs"
$tableB2.Cell(5,4).Range.Text = "Si, muy potente"
$tableB2.Cell(5,5).Range.Text = "Si (CKAN)"

$tableB2.Cell(6,1).Range.Text = "Derecho de acceso"
$tableB2.Cell(6,2).Range.Text = "Si (enlace a tramite)"
$tableB2.Cell(6,3).Range.Text = "No es su foco"
$tableB2.Cell(6,4).Range.Text = "Si (FOI integrado)"
$tableB2.Cell(6,5).Range.Text = "Si (derecho fundamental)"

$tableB2.Cell(7,1).Range.Text = "Lobbies / influencias"
$tableB2.Cell(7,2).Range.Text = "No"
$tableB2.Cell(7,3).Range.Text = "Si (registro obligatorio)"
$tableB2.Cell(7,4).Range.Text = "Parcial"
$tableB2.Cell(7,5).Range.Text = "No"

$tableB2.Cell(8,1).Range.Text = "UX / Diseno"
$tableB2.Cell(8,2).Range.Text = "Funcional, anticuado, basado en Esri"
$tableB2.Cell(8,3).Range.Text = "Moderno, limpio"
$tableB2.Cell(8,4).Range.Text = "Excelente (GDS)"
$tableB2.Cell(8,5).Range.Text = "Funcional, sobrio"

$tableB2.Cell(9,1).Range.Text = "Integracion con participacion"
$tableB2.Cell(9,2).Range.Text = "No (portal separado)"
$tableB2.Cell(9,3).Range.Text = "No"
$tableB2.Cell(9,4).Range.Text = "No"
$tableB2.Cell(9,5).Range.Text = "No"

$tableB2.Cell(10,1).Range.Text = "Bilinguismo"
$tableB2.Cell(10,2).Range.Text = "Si (eu/es)"
$tableB2.Cell(10,3).Range.Text = "Solo frances"
$tableB2.Cell(10,4).Range.Text = "Solo ingles"
$tableB2.Cell(10,5).Range.Text = "Si (fi/sv)"

$sel.EndOf(15) | Out-Null
$sel.MoveDown() | Out-Null
Write-EmptyLine

Write-Heading "B.3. Lecciones aplicables a Irekia Berria" 2

Write-BulletBoldAndNormal "De Francia (HATVP): " "La transparencia con nombre y apellidos genera confianza. Las fichas nominativas de cargos publicos (patrimonio, intereses, actividades) son lo mas consultado. Si Irekia Berria integra entidades y cargos publicos con transparencia, deberia hacerlo con ese nivel de detalle."
Write-BulletBoldAndNormal "De Reino Unido (data.gov.uk): " "La clave es la reutilizacion. Publicar datos en formatos abiertos con APIs y busqueda potente convierte la transparencia en algo util, no solo informativo. La visualizacion es secundaria si los datos son descargables y estructurados."
Write-BulletBoldAndNormal "De Finlandia: " "Integrar la transparencia en el funcionamiento del gobierno, no como portal aislado. Que la transparencia no sea un sitio web sino la forma en que opera la administracion. Relevante porque Irekia Berria quiere hacer esto."
Write-BulletBoldAndNormal "Ninguno integra transparencia con participacion: " "Esto confirma que el enfoque unificado de Irekia Berria es singular. No hay modelo que copiar, hay que disenar uno nuevo."

Write-Heading "B.4. Situacion actual de Gardena" 2

Write-Normal "El portal Gardena (gardena.euskadi.eus) presenta actualmente las siguientes secciones:"

Write-Bullet "Informacion sobre la Comunidad Autonoma vasca."
Write-Bullet "Relaciones con la ciudadania y la sociedad."
Write-Bullet "Transparencia economico-financiera."
Write-Bullet "Contrataciones de obras, servicios y suministros."
Write-Bullet "Derecho de acceso a la informacion publica."
Write-Bullet "Visualizaciones de datos (destacada: Relaciones de Puestos de Trabajo / RPT)."
Write-Bullet "Comision de Control y Transparencia de la Policia del Pais Vasco."
Write-Bullet "Sistema Interno de Informacion (BiS)."
Write-Bullet "Distribucion de ayudas concedidas."
Write-Bullet "Enlaces a proyectos de transparencia: euskadi.eus, irekia, Open Data Euskadi, Contratacion Publica, Legegunea."

Write-EmptyLine
Write-Bold "Observaciones sobre Gardena:"
Write-Bullet "La herramienta de visualizacion (Insight de Esri) es el componente mas visible pero tambien el que se quiere sustituir."
Write-Bullet "El contenido es fundamentalmente estatico: fichas informativas con estructura de CMS."
Write-Bullet "No hay interactividad con el ciudadano (no hay comentarios, valoraciones ni procesos participativos)."
Write-Bullet "El portal depende del ecosistema visual de euskadi.eus (cabecera, pie, estructura comun)."
Write-Bullet "Open Data Euskadi es un portal separado. La linea entre transparencia y datos abiertos no esta clara."

# --- GUARDAR ---
$savePath = "c:\Users\ClaudiaAlvarezDiaz\Documents\EJIE\Repo IREKIA\IREKIA\Planteamiento Proyecto Irekia Berria.docx"
$doc.SaveAs([ref]$savePath, [ref]16)  # wdFormatDocumentDefault = 16
$doc.Close()
$word.Quit()

Write-Host "Documento generado en: $savePath"
