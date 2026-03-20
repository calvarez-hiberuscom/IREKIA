# =============================================================================
# RellenarOferta.ps1
# Rellena la plantilla de oferta Irekia con contenido reutilizable
# =============================================================================

Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 3

$word = New-Object -ComObject Word.Application
$word.Visible = $false

$templatePath = "c:\Users\ClaudiaAlvarezDiaz\Documents\EJIE\Repo IREKIA\IREKIA\Oferta\Oferta EJIE 2026XX  - Irekia.docx"
$outputPath   = "c:\Users\ClaudiaAlvarezDiaz\Documents\EJIE\Repo IREKIA\IREKIA\Oferta\Oferta EJIE 2026XX  - Irekia - Borrador.docx"

# Copiar plantilla para no machacarla
Copy-Item $templatePath $outputPath -Force

$doc = $word.Documents.Open($outputPath)
$sel = $word.Selection

# --- Estilos (IDs numericos) ---
$wdStyleNormal     = -1
$wdStyleHeading1   = -2
$wdStyleHeading2   = -3
$wdStyleHeading3   = -4
$wdStyleHeading4   = -88
$wdStyleHeading5   = -89
$wdStyleListBullet = -49

# --- Funciones auxiliares ---
function Write-Heading($text, $level) {
    switch ($level) {
        1 { $sel.Style = $doc.Styles.Item($wdStyleHeading1) }
        2 { $sel.Style = $doc.Styles.Item($wdStyleHeading2) }
        3 { $sel.Style = $doc.Styles.Item($wdStyleHeading3) }
        4 { $sel.Style = $doc.Styles.Item($wdStyleHeading4) }
        5 { $sel.Style = $doc.Styles.Item($wdStyleHeading5) }
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

function Write-Placeholder($text) {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.Font.Color = 8421504  # Gris
    $sel.Font.Italic = $true
    $sel.TypeText("[TODO] $text")
    $sel.Font.Color = 0
    $sel.Font.Italic = $false
    $sel.TypeParagraph()
}

# =============================================================================
# Ir al final del documento (despues del indice y headings vacios)
# La plantilla tiene headings vacios. Vamos a buscar cada heading y escribir
# contenido debajo.
# =============================================================================

# Funcion para buscar un heading y posicionar cursor justo despues
function GoAfterHeading($headingText) {
    $find = $sel.Find
    $find.ClearFormatting()
    $find.Text = $headingText
    $find.Forward = $true
    $find.Wrap = 1  # wdFindContinue
    $find.MatchWholeWord = $false
    $find.MatchCase = $false
    $result = $find.Execute()
    if ($result) {
        $sel.MoveDown(5, 1) | Out-Null  # wdLine
        $sel.HomeKey(5) | Out-Null      # wdLine - inicio de linea
    }
    return $result
}

# =============================================================================
# SECCION 0.1 - IDENTIFICACION DEL PLIEGO
# =============================================================================
if (GoAfterHeading("Identificación del pliego")) {
    # Ya hay contenido parcial, no lo borramos
}

# =============================================================================
# SECCION 0.2 - PRESENTACION
# =============================================================================
if (GoAfterHeading("Presentación")) {
    Write-Normal "hiberus es una de las principales empresas tecnologicas espanolas, con mas de 3.200 profesionales y una facturacion superior a los 260 millones de euros. Organizada en mas de 20 unidades de negocio especializadas, ofrece servicios integrales de consultoria, desarrollo y transformacion digital."
    Write-EmptyLine
    Write-Normal "En el ambito de la Administracion Publica, hiberus cuenta con una amplia trayectoria en proyectos de modernizacion y digitalizacion para diferentes administraciones, con especial experiencia en el ecosistema del Gobierno Vasco a traves de su relacion con EJIE."
    Write-EmptyLine
    Write-Normal "Entre los proyectos mas relevantes de hiberus para EJIE destacan:"
    Write-Bullet "Toolkit Berria: desarrollo del nuevo framework de tramitacion del Gobierno Vasco, incluyendo arquitectura de microservicios, componentes reutilizables y plataforma Platea."
    Write-Bullet "Proyectos de administracion electronica para diversos departamentos del Gobierno Vasco (Medio Ambiente, Trabajo, Educacion, Desarrollo Economico, Igualdad y Justicia)."
    Write-Bullet "Diseno de servicios y simplificacion de procesos en el ambito de gobierno abierto."
    Write-EmptyLine
    Write-Normal "Esta experiencia acumulada en el ecosistema tecnologico de EJIE (microservicios, Platea, presencia web, accesibilidad, bilinguismo) constituye una base solida para afrontar el proyecto Irekia Berria con garantias."
}

# =============================================================================
# SECCION 1 - RESUMEN Y ELEMENTOS DIFERENCIALES
# =============================================================================
if (GoAfterHeading("Resumen y elementos diferenciales")) {
    Write-Normal "El proyecto Irekia Berria no es una evolucion de un portal, sino un programa de transformacion que involucra multiples sistemas de gestion interconectados, organizados en tres grandes columnas funcionales:"
    Write-EmptyLine
    Write-Bold "Columna 1 - Gobierno Abierto (Irekia Berria):"
    Write-Bullet "Portal unificado de Transparencia y Participacion ciudadana."
    Write-Bullet "Participacion: Iniciativas de Gobierno + Participacion Ciudadana."
    Write-Bullet "Transparencia: Programas/Planes + Contenidos de Transparencia + Open Data/visualizaciones."
    Write-EmptyLine
    Write-Bold "Columna 2 - Comunicacion Institucional:"
    Write-Bullet "Sistema de gestion integral de prensa y comunicacion (eventos, noticias, contenidos, activos)."
    Write-Bullet "Integrado con DAM y Streaming."
    Write-Bullet "Publica en euskadi.eus, homes departamentales y RRSS."
    Write-EmptyLine
    Write-Bold "Columna 3 - Diaspora:"
    Write-Bullet "Sistema de gestion de portales para sedes vascas en el extranjero."
    Write-EmptyLine
    Write-Bold "Elementos diferenciales de la propuesta de hiberus:"
    Write-Bullet "Conocimiento profundo del ecosistema tecnologico de EJIE: microservicios, Platea, Toolkit Berria, presencia web."
    Write-Bullet "Equipo multidisciplinar con experiencia en proyectos del Gobierno Vasco: analisis funcional, desarrollo back/front, diseno UX/UI, accesibilidad, QA."
    Write-Bullet "Capacidad de diseno de servicios centrados en el ciudadano: experiencia en simplificacion de procesos, rediseno de interfaces, accesibilidad y bilinguismo."
    Write-Bullet "Enfoque de desarrollo a medida, sin productos cerrados, alineado con el estandar tecnologico de administracion digital de EJIE."
    Write-Bullet "Integracion nativa con los modulos transversales existentes: Seguridad, Directorio, Etiquetas, Geocatalogacion, Publicador."
}

# =============================================================================
# SECCION 2 - ARQUITECTURA PROPUESTA
# =============================================================================
if (GoAfterHeading("Sistemas de Gestión")) {
    Write-Normal "La arquitectura propuesta se organiza en tres sistemas de gestion independientes que convergen en un publicador comun conectado al CMS de euskadi.eus, apoyados por una capa transversal de modulos compartidos."
    Write-EmptyLine
    Write-Bold "Sistema de Gestion de Gobierno Abierto (Irekia Berria):"
    Write-Bullet "Back-office de Participacion: gestion de iniciativas de gobierno y participacion ciudadana."
    Write-Bullet "Back-office de Transparencia: gestion de contenidos de transparencia, programas/planes, y conexion con open data."
    Write-Bullet "Portal publico Irekia Berria: capa de presentacion que consume los contenidos de ambos back-offices."
    Write-EmptyLine
    Write-Bold "Sistema de Gestion de Comunicacion Institucional:"
    Write-Bullet "Gestion de eventos y noticias, gestion de la actividad (evento), gestion de activos, gestion de contenidos de comunicacion."
    Write-Bullet "Integracion con DAM para almacenamiento de assets multimedia."
    Write-Bullet "Integracion con Streaming."
    Write-Bullet "Publicacion via CMS euskadi.eus hacia homes departamentales, home principal y RRSS."
    Write-EmptyLine
    Write-Bold "Sistema de Gestion de Diaspora:"
    Write-Bullet "Gestion de portales para sedes vascas en el extranjero."
    Write-Bullet "Modelo de plantilla comun con opciones configurables por sede."
}

# =============================================================================
# SECCION 2.1.1 - ARQUITECTURA DEL SISTEMA
# =============================================================================
if (GoAfterHeading("Arquitectura del sistema")) {
    Write-Normal "La arquitectura se basa en el estandar tecnologico de administracion digital de EJIE, con los siguientes principios:"
    Write-Bullet "Arquitectura de microservicios desplegados en Kubernetes."
    Write-Bullet "Desarrollo a medida, sin integracion de productos cerrados de terceros."
    Write-Bullet "Integracion con el ecosistema de presencia web de EJIE (CMS, publicador, portales)."
    Write-Bullet "APIs REST para la comunicacion entre sistemas."
    Write-Bullet "Compatibilidad con los modulos transversales existentes."
}

# =============================================================================
# SECCION 2.1.1.1 - TECNOLOGIA
# =============================================================================
if (GoAfterHeading("Tecnología")) {
    Write-Placeholder "Detallar stack tecnologico concreto una vez se conozca el pliego. Previsiblemente alineado con Toolkit Berria / Platea: Java, Spring Boot, microservicios, Kubernetes, etc."
}

# =============================================================================
# SECCION 2.1.1.2 - MODULOS / COMPONENTES
# =============================================================================
if (GoAfterHeading("Módulos / componentes")) {
    Write-Normal "Los sistemas se apoyaran en los modulos transversales existentes en el ecosistema de EJIE:"
    Write-Bullet "Seguridad: modulo transversal existente que requerira adaptaciones para los nuevos sistemas."
    Write-Bullet "Directorio: gestion centralizada de entidades y contactos."
    Write-Bullet "Etiquetas: sistema de clasificacion de contenidos."
    Write-Bullet "Geocatalogacion: catalogacion geografica de contenidos."
    Write-Bullet "Publicador: capa que conecta los sistemas de gestion con el CMS de euskadi.eus."
    Write-EmptyLine
    Write-Placeholder "Detallar modulos funcionales especificos de cada sistema una vez se concrete el alcance funcional."
}

# =============================================================================
# SECCION 2.1.1.3 - FRAMEWORKS
# =============================================================================
if (GoAfterHeading("Frameworks")) {
    Write-Placeholder "Detallar frameworks una vez se conozca el pliego. Previsiblemente: Spring Boot, Toolkit Berria, Platea, frameworks front del ecosistema EJIE."
}

# =============================================================================
# SECCION 2.1.1.4 - ASEGURAMIENTO CALIDAD Y TESTING
# =============================================================================
if (GoAfterHeading("Aseguramiento de la calidad")) {
    Write-Normal "La estrategia de calidad y testing se estructura en los siguientes ejes:"
    Write-EmptyLine
    Write-Bold "Estrategia de pruebas basada en riesgos:"
    Write-Bullet "Elaboracion de planes de pruebas diferenciados por tipo: funcionales, regresion, rendimiento, accesibilidad, seguridad."
    Write-Bullet "Priorizacion de pruebas segun criticidad funcional y riesgo de impacto."
    Write-Bullet "Criterios de inicio y finalizacion de cada ciclo de testing."
    Write-EmptyLine
    Write-Bold "Automatizacion:"
    Write-Bullet "Pruebas automatizadas end-to-end con Selenium, Playwright o tecnologia equivalente."
    Write-Bullet "Pruebas automatizadas de APIs con herramientas como Postman, RestAssured."
    Write-Bullet "Integracion de pruebas en pipelines CI/CD."
    Write-Bullet "Analisis estatico de codigo con SonarQube."
    Write-EmptyLine
    Write-Bold "Metodologia BDD:"
    Write-Bullet "Definicion de criterios de aceptacion en lenguaje Gherkin."
    Write-Bullet "Integracion de QA en fases tempranas del desarrollo (Shift Left)."
    Write-EmptyLine
    Write-Bold "Reporting:"
    Write-Bullet "Registro y seguimiento de defectos en Jira/XRay."
    Write-Bullet "Informes periodicos de KPIs de calidad."
}

# =============================================================================
# SECCION 2.1.1.5 - CONTROL DE VERSIONES
# =============================================================================
if (GoAfterHeading("control de versiones")) {
    Write-Placeholder "Detallar estrategia de branching, feature flags, etc. segun herramientas del ecosistema EJIE."
}

# =============================================================================
# SECCION 2.1.1.6 - SOPORTE DE ACCESIBILIDAD
# =============================================================================
if (GoAfterHeading("Soporte de accesibilidad")) {
    Write-Normal "hiberus cuenta con un equipo especializado en accesibilidad digital, liderado por profesionales certificados y con experiencia en multiples administraciones publicas (Gobierno de Aragon, Lantik, Gobierno de Navarra, Ministerio de Transportes, entre otros)."
    Write-EmptyLine
    Write-Normal "El enfoque de accesibilidad se integrara desde el inicio del proyecto:"
    Write-Bullet "Pruebas manuales con lectores de pantalla (NVDA, Jaws, VoiceOver, Talkback) para detectar disconformidades con la norma."
    Write-Bullet "Asesoramiento integral a los equipos de desarrollo durante todo el ciclo de vida, desde planificacion hasta cierre."
    Write-Bullet "Propuestas de adecuacion con fragmentos de codigo y ejemplos para cada caso."
    Write-Bullet "Cumplimiento del Real Decreto 1112/2018 y norma UNE-EN 301549."
    Write-Bullet "Soporte de accesibilidad cognitiva y lectura facil."
    Write-Bullet "Bilinguismo euskera/castellano integrado en todos los componentes, con soporte de ingles donde se requiera (selector trilingue)."
}

# =============================================================================
# SECCION 3 - APROXIMACION DE EJECUCION
# =============================================================================

# 3.1 Trasposicion de prototipos y marca
if (GoAfterHeading("Trasposición de prototipos")) {
    Write-Normal "Este bloque cubre la trasposicion del diseno visual al sistema tecnologico, asegurando que los prototipos y la marca se materializan fielmente en los portales y back-offices."
    Write-EmptyLine
    Write-Normal "Nota: La Personalite es la empresa responsable del diseno de concepto/servicio y visual de toda la parte web con salida al exterior. El equipo de hiberus trabajara coordinado con La Personalite para trasladar los prototipos al desarrollo."
}

# 3.1.1 Proceso de trabajo
if (GoAfterHeading("Proceso de trabajo")) {
    Write-Bullet "Recepcion y analisis de prototipos de La Personalite."
    Write-Bullet "Definicion de componentes UI reutilizables (sistema de diseno)."
    Write-Bullet "Maquetacion y desarrollo front alineado con accesibilidad y bilinguismo."
    Write-Bullet "Validacion con La Personalite y con EJIE de la fidelidad visual."
    Write-Bullet "Iteracion y ajuste."
}

# 3.1.2 Actividades (trasposicion)
if (GoAfterHeading("Actividades")) {
    # Primera coincidencia: actividades de trasposicion
    Write-Placeholder "Detallar actividades concretas de trasposicion una vez se disponga de los prototipos de La Personalite."
}

# 3.2 Construccion
if (GoAfterHeading("Construcción del sistema")) {
    Write-Normal "La construccion del sistema se abordara con metodologia Agile (Scrum), con sprints de 2-3 semanas y entregas incrementales."
}

# 3.2.1 Fases
if (GoAfterHeading("Fases")) {
    Write-Bold "Fase 1 - Analisis y Diseno (ASI):"
    Write-Bullet "Toma de requisitos detallada por bloque funcional."
    Write-Bullet "Documentacion funcional: casos de uso, historias de usuario, criterios de aceptacion."
    Write-Bullet "Validacion del alcance con EJIE y la consultora del ANS."
    Write-Bullet "Definicion de la arquitectura tecnica de cada sistema."
    Write-EmptyLine
    Write-Bold "Fase 2 - Desarrollo iterativo:"
    Write-Bullet "Sprints de desarrollo con entregas incrementales."
    Write-Bullet "Testing integrado en cada sprint (Shift Left)."
    Write-Bullet "Revisiones de sprint con el cliente."
    Write-Bullet "Integracion continua y despliegue en entornos de desarrollo/pre-produccion."
    Write-EmptyLine
    Write-Bold "Fase 3 - Integracion y pruebas:"
    Write-Bullet "Pruebas de integracion entre sistemas de gestion y modulos transversales."
    Write-Bullet "Pruebas de rendimiento."
    Write-Bullet "Pruebas de accesibilidad completas."
    Write-Bullet "Pruebas de aceptacion con usuarios reales."
    Write-EmptyLine
    Write-Bold "Fase 4 - Despliegue y puesta en produccion:"
    Write-Bullet "Despliegue en Kubernetes (entorno EJIE)."
    Write-Bullet "Migracion de datos (donde aplique)."
    Write-Bullet "Periodo de estabilizacion."
    Write-Bullet "Transferencia de conocimiento."
}

# 3.2.2 Actividades principales y objetivo (segundo "Actividades" en construccion)
if (GoAfterHeading("Actividades principales")) {
    Write-Bullet "Gestion del alcance, planificacion y riesgos del proyecto."
    Write-Bullet "Coordinacion de equipos internos (hiberus) y externos (La Personalite, consultora ANS, Sonia/EJIE)."
    Write-Bullet "Toma de requisitos funcionales y elaboracion de documentacion."
    Write-Bullet "Diseno de la arquitectura tecnica de cada sistema de gestion."
    Write-Bullet "Desarrollo de los sistemas back-office (Transparencia, Participacion, Comunicacion, Diaspora)."
    Write-Bullet "Desarrollo de los portales publicos (Irekia Berria, portal de comunicacion, portales de diaspora)."
    Write-Bullet "Integracion con modulos transversales (Seguridad, Directorio, Etiquetas, Geocatalogacion, Publicador)."
    Write-Bullet "Integracion con sistemas existentes (CMS euskadi.eus, Tramitagune, DAM)."
    Write-Bullet "Aseguramiento de la calidad y testing."
    Write-Bullet "Aseguramiento de la accesibilidad."
    Write-Bullet "Soporte al bilinguismo euskera/castellano (e ingles donde aplique)."
    Write-Bullet "Despliegue, migracion y transferencia de conocimiento."
}

# 3.2.3 Organizacion de los equipos de trabajo
if (GoAfterHeading("Organización de los equipos")) {
    Write-Normal "El equipo se organizara en celulas funcionales alineadas con los bloques del proyecto:"
    Write-EmptyLine
    Write-Bold "Equipo de Direccion y Gestion:"
    Write-Bullet "Directora de Servicio (MMZ): liderazgo del delivery, control economico y de calidad, coordinacion general."
    Write-Bullet "Jefa de Proyecto (CAD): gestion del alcance, planificacion, riesgos, seguimiento y reporting."
    Write-EmptyLine
    Write-Bold "Equipo de Analisis y Diseno de Servicios:"
    Write-Placeholder "Perfiles de analisis funcional y diseno UX/UI - por definir segun alcance."
    Write-EmptyLine
    Write-Bold "Equipo de Desarrollo:"
    Write-Placeholder "Perfiles de desarrollo back y front - por definir segun alcance y bloques."
    Write-EmptyLine
    Write-Bold "Equipo de QA y Accesibilidad:"
    Write-Placeholder "Perfiles de QA, testing y accesibilidad - por definir segun alcance."
}

# 3.2.4 Relacion con el entorno
if (GoAfterHeading("Relación con el entorno")) {
    Write-Normal "El proyecto interactua con multiples actores y sistemas del entorno:"
    Write-EmptyLine
    Write-Bold "Actores del entorno:"
    Write-Bullet "EJIE: cliente tecnologico, propietario del ecosistema de presencia web, responsable de infraestructura Kubernetes."
    Write-Bullet "Consultora ANS: responsable de la definicion funcional detallada."
    Write-Bullet "Sonia (EJIE): conocimiento de los modulos y sistemas del CMS actual."
    Write-Bullet "La Personalite: diseno de concepto/servicio y visual de los portales."
    Write-Bullet "Alex / Directora de Gobierno: decisiones sobre alcance de transparencia."
    Write-Bullet "Maria: vision funcional general del proyecto."
    Write-EmptyLine
    Write-Bold "Sistemas del entorno:"
    Write-Bullet "CMS de euskadi.eus: sistema de gestion de contenidos corporativo."
    Write-Bullet "Publicador: modulo que conecta los back-offices con el CMS."
    Write-Bullet "Tramitagune: sistema de tramitacion del que proceden las iniciativas legislativas con participacion."
    Write-Bullet "Modulos transversales: Seguridad, Directorio, Etiquetas, Geocatalogacion."
    Write-Bullet "DAM: almacenamiento de assets multimedia (existente o por implementar)."
    Write-Bullet "Portales existentes: euskadi.eus, homes departamentales, euskaletxeak.eus (diaspora)."
}

# =============================================================================
# SECCION 4 - PLANIFICACION
# =============================================================================

# 4.1 Calendario
if (GoAfterHeading("Calendario")) {
    Write-Placeholder "Definir calendario una vez se conozca el pliego, el alcance confirmado y la priorizacion entre bloques."
    Write-EmptyLine
    Write-Normal "Consideracion previa: algunos bloques podrian arrancar antes que otros. Por ejemplo, el diseno de Irekia Berria podria comenzar mientras se resuelven decisiones pendientes de transparencia y participacion."
}

# 4.2.1 Planificacion de recursos en el tiempo
if (GoAfterHeading("Planificación de recursos")) {
    Write-Placeholder "Definir distribucion de recursos en el tiempo una vez se confirme calendario y alcance."
}

# 4.2.2 Equipo
if (GoAfterHeading("Equipo que participará")) {
    Write-Normal "A continuacion se presenta el equipo propuesto para el proyecto. Los perfiles de Direccion ya estan confirmados. El resto de perfiles se definiran en funcion del alcance y los bloques que se aborden."
    Write-EmptyLine

    # --- PERFIL 1: MMZ ---
    Write-Heading "Directora de Servicio - (MMZ)" 5
    Write-EmptyLine
    Write-BoldAndNormal "Perfil: " "Directora de Servicio"
    Write-BoldAndNormal "Anos de experiencia: " "Mas de 30 anos"
    Write-BoldAndNormal "Titulacion academica: " "Ingenieria informatica"
    Write-EmptyLine
    Write-Bold "Experiencia:"
    Write-Normal "En consultoria, direccion y gestion de equipos y proyectos de transformacion digital, administracion electronica y modernizacion de procesos organizacionales. Especializada en analizar necesidades de cambio, disenar sistemas y nuevas estructuras organizativas y funcionales para la simplificacion y mejora de la actividad."
    Write-EmptyLine
    Write-Bold "Tareas principales:"
    Write-Bullet "Liderar el delivery del proyecto en plazo y forma, coordinar los equipos propios y multidisciplinares."
    Write-Bullet "Control economico y de calidad."
    Write-Bullet "Coordinacion y seguimiento con el cliente."
    Write-Bullet "Aportar propuestas al diseno del sistema."
    Write-EmptyLine
    Write-BoldAndNormal "Certificacion: " "Euskera B2"
    Write-EmptyLine

    # --- PERFIL 2: CAD ---
    Write-Heading "Directora del Servicio / Jefatura de Proyecto - (CAD)" 5
    Write-EmptyLine
    Write-BoldAndNormal "Perfil: " "Jefa de Proyecto"
    Write-BoldAndNormal "Anos de experiencia: " "Mas de 12 anos"
    Write-EmptyLine
    Write-Bold "Titulacion academica:"
    Write-Bullet "MBA Digital Business Management (IM Digital Business School, Barcelona)."
    Write-Bullet "Project Management Professional (PMI)."
    Write-Bullet "PSMI I Professional Scrum Master."
    Write-Bullet "Licenciatura en Traduccion e interpretacion por la Universidad Pontificia de Comillas, Madrid."
    Write-EmptyLine
    Write-Bold "Experiencia:"
    Write-Normal "Experiencia destacada en la gestion de proyectos estrategicos de desarrollo y consultoria, principalmente en proyectos con arquitectura de microservicios, en diferentes clientes: AAPP (EJIE), banca, salud, fintech y marketing digital, con enfoque en planificacion, ejecucion, mejora continua y gestion del cambio."
    Write-Normal "Capacidad demostrada para implementar procesos, liderar iniciativas de transformacion y optimizar recursos en entornos complejos y multiculturales. Fuerte experiencia internacional."
    Write-EmptyLine
    Write-Bold "Tareas principales:"
    Write-Bullet "Gestion del alcance del proyecto. Gestion de la planificacion. Gestion de Riesgos."
    Write-Bullet "Coordinacion equipo. Supervision de la ejecucion. Gestion del Cambio."
    Write-Bullet "Seguimiento y reporting. Validacion de entregables."
    Write-EmptyLine

    # --- PERFILES VACIOS ---
    Write-Heading "Analista Funcional - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Se definira en funcion del alcance funcional de los bloques."
    Write-EmptyLine

    Write-Heading "Consultora Diseno Servicios / UX - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Coordinacion con La Personalite para trasposicion de diseno."
    Write-EmptyLine

    Write-Heading "Arquitecto / Technical Leader - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Experiencia requerida en microservicios, ecosistema EJIE, Kubernetes."
    Write-EmptyLine

    Write-Heading "Analista Programador/a Back - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Desarrollo back-end de los sistemas de gestion."
    Write-EmptyLine

    Write-Heading "Analista Programador/a Front - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Desarrollo front-end de portales y back-offices."
    Write-EmptyLine

    Write-Heading "Programador/a Back - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar."
    Write-EmptyLine

    Write-Heading "Programador/a Front - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar."
    Write-EmptyLine

    Write-Heading "Responsable de Calidad / QA - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Estrategia de pruebas, automatizacion, reporting."
    Write-EmptyLine

    Write-Heading "QA Analyst / Tester - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Ejecucion de pruebas, automatizacion, gestion de defectos."
    Write-EmptyLine

    Write-Heading "Tecnica Accesibilidad - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Pruebas de accesibilidad, asesoramiento al equipo, cumplimiento normativo."
    Write-EmptyLine

    Write-Heading "Disenador/a UX/UI - (por definir)" 5
    Write-EmptyLine
    Write-Placeholder "Perfil por asignar. Diseno visual, prototipado, validacion con usuarios."
    Write-EmptyLine
}

# =============================================================================
# GUARDAR
# =============================================================================
$doc.Save()
$doc.Close()
$word.Quit()

Write-Host "Oferta borrador generada en: $outputPath"
