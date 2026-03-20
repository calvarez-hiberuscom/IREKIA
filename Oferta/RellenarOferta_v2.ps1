# =============================================================================
# RellenarOferta_v2.ps1
# Genera la oferta Irekia desde cero respetando la estructura de la plantilla
# =============================================================================

Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 3

$word = New-Object -ComObject Word.Application
$word.Visible = $false

$outputPath = "c:\Users\ClaudiaAlvarezDiaz\Documents\EJIE\Repo IREKIA\IREKIA\Oferta\Oferta EJIE 2026XX  - Irekia - Borrador.docx"

# Crear documento nuevo
$doc = $word.Documents.Add()
$sel = $word.Selection

# --- Estilos (IDs numericos para Word en espanol) ---
$wdStyleNormal     = -1
$wdStyleHeading1   = -2
$wdStyleHeading2   = -3
$wdStyleHeading3   = -4
$wdStyleHeading4   = -88
$wdStyleHeading5   = -89
$wdStyleListBullet = -49
$wdStyleTitle      = -63
$wdStyleSubtitle   = -75

# --- Funciones auxiliares ---
function Write-Heading($text, $level) {
    $styleId = switch ($level) {
        1 { $wdStyleHeading1 }
        2 { $wdStyleHeading2 }
        3 { $wdStyleHeading3 }
        4 { $wdStyleHeading4 }
        5 { $wdStyleHeading5 }
    }
    $sel.Style = $doc.Styles.Item($styleId)
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

function Write-BulletBoldNormal($boldText, $normalText) {
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
# PORTADA
# =============================================================================
$sel.Style = $doc.Styles.Item($wdStyleTitle)
$sel.TypeText("OFERTA TÉCNICA")
$sel.TypeParagraph()

$sel.Style = $doc.Styles.Item($wdStyleSubtitle)
$sel.TypeText("Irekia Berria – Plataforma de Gobierno Abierto del Gobierno Vasco")
$sel.TypeParagraph()

Write-Normal "hiberus"
Write-Normal "Marzo 2026"
Write-EmptyLine

# =============================================================================
# INDICE (se actualizara al final)
# =============================================================================
$doc.TablesOfContents.Add($sel.Range, $true, 1, 3) | Out-Null
$sel.EndKey(6) | Out-Null  # wdStory - ir al final
# Salto de pagina
$sel.InsertBreak(7) | Out-Null  # wdSectionBreakNextPage

# =============================================================================
# 0. INTRODUCCION
# =============================================================================
Write-Heading "Introducción" 1
Write-EmptyLine

# 0.1 Identificacion del pliego
Write-Heading "Identificación del pliego al que responde la propuesta" 2
Write-Normal "El presente documento corresponde a la oferta que presenta hiberus relativa al pliego publicado bajo el título «XXXXXX», nº de expediente EJIE-XXX-2026."
Write-EmptyLine
Write-Normal "hiberus pone a disposición de EJIE su experiencia, recursos y conocimiento, así como profesionales de alto nivel que aportarán a lo largo de la memoria técnica un enfoque diferencial alineado con los objetivos de negocio de EJIE."
Write-EmptyLine

# 0.2 Presentacion
Write-Heading "Presentación" 2
Write-Normal "hiberus es una de las principales empresas tecnológicas españolas, con más de 3.200 profesionales y una facturación superior a los 260 millones de euros. Organizada en más de 20 unidades de negocio especializadas, ofrece servicios integrales de consultoría, desarrollo y transformación digital."
Write-EmptyLine
Write-Normal "En el ámbito de la Administración Pública, hiberus cuenta con una amplia trayectoria en proyectos de modernización y digitalización para diferentes administraciones, con especial experiencia en el ecosistema del Gobierno Vasco a través de su relación con EJIE."
Write-EmptyLine
Write-Normal "Entre los proyectos más relevantes de hiberus para EJIE destacan:"
Write-Bullet "Toolkit Berria: desarrollo del nuevo framework de tramitación del Gobierno Vasco, incluyendo arquitectura de microservicios, componentes reutilizables y plataforma Platea."
Write-Bullet "Proyectos de administración electrónica para diversos departamentos del Gobierno Vasco (Medio Ambiente, Trabajo, Educación, Desarrollo Económico, Igualdad y Justicia)."
Write-Bullet "Diseño de servicios y simplificación de procesos en el ámbito de gobierno abierto."
Write-EmptyLine
Write-Normal "Esta experiencia acumulada en el ecosistema tecnológico de EJIE (microservicios, Platea, presencia web, accesibilidad, bilingüismo) constituye una base sólida para afrontar el proyecto Irekia Berria con garantías."
Write-EmptyLine

# =============================================================================
# 1. RESUMEN Y ELEMENTOS DIFERENCIALES
# =============================================================================
Write-Heading "Resumen y elementos diferenciales de la oferta" 1
Write-Normal "El proyecto Irekia Berria no es una evolución de un portal, sino un programa de transformación que involucra múltiples sistemas de gestión interconectados, organizados en tres grandes columnas funcionales:"
Write-EmptyLine
Write-Bold "Columna 1 – Gobierno Abierto (Irekia Berria):"
Write-Bullet "Portal unificado de Transparencia y Participación ciudadana."
Write-Bullet "Participación: Iniciativas de Gobierno + Participación Ciudadana."
Write-Bullet "Transparencia: Programas/Planes + Contenidos de Transparencia + Open Data/visualizaciones."
Write-EmptyLine
Write-Bold "Columna 2 – Comunicación Institucional:"
Write-Bullet "Sistema de gestión integral de prensa y comunicación (eventos, noticias, contenidos, activos)."
Write-Bullet "Integrado con DAM y Streaming."
Write-Bullet "Publica en euskadi.eus, homes departamentales y RRSS."
Write-EmptyLine
Write-Bold "Columna 3 – Diáspora:"
Write-Bullet "Sistema de gestión de portales para sedes vascas en el extranjero (euskaletxeak.eus)."
Write-EmptyLine
Write-Bold "Capa transversal:"
Write-Bullet "Módulos compartidos: Seguridad, Directorio, Etiquetas, Geocatalogación."
Write-Bullet "Publicador: capa común que conecta los tres sistemas con el CMS de euskadi.eus."
Write-EmptyLine
Write-Bold "Elementos diferenciales de la propuesta de hiberus:"
Write-Bullet "Conocimiento profundo del ecosistema tecnológico de EJIE: microservicios, Platea, Toolkit Berria, presencia web."
Write-Bullet "Equipo multidisciplinar con experiencia directa en proyectos del Gobierno Vasco: análisis funcional, desarrollo back/front, diseño UX/UI, accesibilidad, QA."
Write-Bullet "Capacidad de diseño de servicios centrados en el ciudadano: experiencia en simplificación de procesos, rediseño de interfaces, accesibilidad y bilingüismo."
Write-Bullet "Enfoque de desarrollo a medida, sin productos cerrados, alineado con el estándar tecnológico de administración digital de EJIE."
Write-Bullet "Integración nativa con los módulos transversales existentes: Seguridad, Directorio, Etiquetas, Geocatalogación, Publicador."
Write-EmptyLine

# =============================================================================
# 2. ARQUITECTURA PROPUESTA
# =============================================================================
Write-Heading "Arquitectura propuesta" 1
Write-EmptyLine

# 2.1 Sistemas de Gestion
Write-Heading "Sistemas de Gestión" 2
Write-Normal "La arquitectura propuesta se organiza en tres sistemas de gestión independientes que convergen en un Publicador común conectado al CMS de euskadi.eus, apoyados por una capa transversal de módulos compartidos."
Write-EmptyLine
Write-Bold "Sistema de Gestión de Gobierno Abierto (Irekia Berria):"
Write-Bullet "Back-office de Participación: gestión de iniciativas de gobierno y participación ciudadana (con conexión a Tramitagune para las iniciativas legislativas)."
Write-Bullet "Back-office de Transparencia: gestión de contenidos de transparencia, programas/planes, y conexión con open data."
Write-Bullet "Portal público Irekia Berria: capa de presentación que consume los contenidos de ambos back-offices."
Write-EmptyLine
Write-Bold "Sistema de Gestión de Comunicación Institucional:"
Write-Bullet "Gestión de eventos y noticias."
Write-Bullet "Gestión de la actividad (evento)."
Write-Bullet "Gestión de activos."
Write-Bullet "Gestión de contenidos de comunicación."
Write-Bullet "Integración con DAM para almacenamiento de assets multimedia."
Write-Bullet "Integración con Streaming."
Write-Bullet "Publicación vía CMS euskadi.eus hacia homes departamentales, home principal y RRSS."
Write-EmptyLine
Write-Bold "Sistema de Gestión de Diáspora:"
Write-Bullet "Gestión de portales para sedes vascas en el extranjero (actualmente euskaletxeak.eus)."
Write-Bullet "Modelo de plantilla común con opciones configurables por sede."
Write-Bullet "Nota: pendiente de definir visibilidad del portal de diáspora en euskadi.eus."
Write-EmptyLine

# 2.1.1 Arquitectura del sistema
Write-Heading "Arquitectura del sistema" 3
Write-Normal "La arquitectura se basa en el estándar tecnológico de administración digital de EJIE, con los siguientes principios:"
Write-Bullet "Arquitectura de microservicios desplegados en Kubernetes."
Write-Bullet "Desarrollo a medida, sin integración de productos cerrados de terceros."
Write-Bullet "Integración con el ecosistema de presencia web de EJIE (CMS, Publicador, portales)."
Write-Bullet "APIs REST para la comunicación entre sistemas."
Write-Bullet "Compatibilidad con los módulos transversales existentes (Seguridad, Directorio, Etiquetas, Geocatalogación, Publicador)."
Write-EmptyLine

# 2.1.1.1 Tecnologia
Write-Heading "Tecnología" 4
Write-Placeholder "Detallar stack tecnológico concreto una vez se conozca el pliego. Previsiblemente alineado con Toolkit Berria / Platea: Java, Spring Boot, microservicios, Kubernetes, PostgreSQL, etc."
Write-EmptyLine

# 2.1.1.2 Modulos / componentes
Write-Heading "Módulos / componentes" 4
Write-Normal "Los sistemas se apoyarán en los módulos transversales existentes en el ecosistema de EJIE:"
Write-BulletBoldNormal "Seguridad: " "módulo transversal existente que requerirá adaptaciones para los nuevos sistemas."
Write-BulletBoldNormal "Directorio: " "gestión centralizada de entidades y contactos."
Write-BulletBoldNormal "Etiquetas: " "sistema de clasificación de contenidos."
Write-BulletBoldNormal "Geocatalogación: " "catalogación geográfica de contenidos."
Write-BulletBoldNormal "Publicador: " "capa que conecta los sistemas de gestión con el CMS de euskadi.eus."
Write-EmptyLine
Write-Placeholder "Detallar módulos funcionales específicos de cada sistema de gestión una vez se concrete el alcance funcional."
Write-EmptyLine

# 2.1.1.3 Frameworks
Write-Heading "Frameworks" 4
Write-Placeholder "Detallar frameworks una vez se conozca el pliego. Previsiblemente: Spring Boot, Toolkit Berria, Platea, frameworks front del ecosistema EJIE."
Write-EmptyLine

# 2.1.1.4 Aseguramiento de la calidad y testing
Write-Heading "Aseguramiento de la calidad y testing" 4
Write-Normal "La estrategia de calidad y testing se estructura en los siguientes ejes:"
Write-EmptyLine
Write-Bold "Estrategia de pruebas basada en riesgos:"
Write-Bullet "Elaboración de planes de pruebas diferenciados por tipo: funcionales, regresión, rendimiento, accesibilidad, seguridad."
Write-Bullet "Priorización de pruebas según criticidad funcional y riesgo de impacto."
Write-Bullet "Criterios de inicio y finalización de cada ciclo de testing."
Write-EmptyLine
Write-Bold "Automatización:"
Write-Bullet "Pruebas automatizadas end-to-end con Selenium, Playwright o tecnología equivalente."
Write-Bullet "Pruebas automatizadas de APIs con herramientas como Postman, RestAssured."
Write-Bullet "Integración de pruebas en pipelines CI/CD."
Write-Bullet "Análisis estático de código con SonarQube."
Write-EmptyLine
Write-Bold "Metodología BDD:"
Write-Bullet "Definición de criterios de aceptación en lenguaje Gherkin."
Write-Bullet "Integración de QA en fases tempranas del desarrollo (Shift Left)."
Write-EmptyLine
Write-Bold "Reporting:"
Write-Bullet "Registro y seguimiento de defectos en Jira/XRay."
Write-Bullet "Informes periódicos de KPIs de calidad."
Write-EmptyLine

# 2.1.1.5 Control de versiones
Write-Heading "Soporte para control de versiones y activación de funcionalidades" 4
Write-Placeholder "Detallar estrategia de branching, feature flags, etc. según herramientas del ecosistema EJIE."
Write-EmptyLine

# 2.1.1.6 Soporte de accesibilidad
Write-Heading "Soporte de accesibilidad" 4
Write-Normal "hiberus cuenta con un equipo especializado en accesibilidad digital, liderado por profesionales certificados y con experiencia en múltiples administraciones públicas (Gobierno de Aragón, Lantik, Gobierno de Navarra, Ministerio de Transportes, entre otros)."
Write-EmptyLine
Write-Normal "El enfoque de accesibilidad se integrará desde el inicio del proyecto:"
Write-Bullet "Pruebas manuales con lectores de pantalla (NVDA, Jaws, VoiceOver, Talkback) para detectar disconformidades con la norma."
Write-Bullet "Asesoramiento integral a los equipos de desarrollo durante todo el ciclo de vida, desde planificación hasta cierre."
Write-Bullet "Propuestas de adecuación con fragmentos de código y ejemplos para cada caso."
Write-Bullet "Cumplimiento del Real Decreto 1112/2018 y norma UNE-EN 301549."
Write-Bullet "Soporte de accesibilidad cognitiva y lectura fácil."
Write-Bullet "Bilingüismo euskera/castellano integrado en todos los componentes, con soporte de inglés donde se requiera (selector trilingüe)."
Write-EmptyLine

# =============================================================================
# 3. APROXIMACION DE EJECUCION
# =============================================================================
Write-Heading "Aproximación de ejecución" 1
Write-Normal "En este apartado se detalla cómo se aproxima la ejecución a nivel metodológico en dos áreas:"
Write-EmptyLine

# 3.1 Trasposicion de prototipos y marca
Write-Heading "Trasposición de prototipos y marca" 2
Write-Normal "Este bloque cubre la trasposición del diseño visual al sistema tecnológico, asegurando que los prototipos y la marca se materialicen fielmente en los portales y back-offices."
Write-EmptyLine
Write-Normal "La Personalité es la empresa responsable del diseño de concepto/servicio y visual de toda la parte web con salida al exterior. El equipo de hiberus trabajará coordinado con La Personalité para trasladar los prototipos al desarrollo."
Write-EmptyLine

# 3.1.1 Proceso de trabajo
Write-Heading "Proceso de trabajo" 3
Write-Bullet "Recepción y análisis de prototipos de La Personalité."
Write-Bullet "Definición de componentes UI reutilizables (sistema de diseño)."
Write-Bullet "Maquetación y desarrollo front alineado con accesibilidad y bilingüismo."
Write-Bullet "Validación con La Personalité y con EJIE de la fidelidad visual."
Write-Bullet "Iteración y ajuste."
Write-EmptyLine

# 3.1.2 Actividades
Write-Heading "Actividades" 3
Write-Placeholder "Detallar actividades concretas de trasposición una vez se disponga de los prototipos de La Personalité."
Write-EmptyLine

# 3.2 Construccion del sistema
Write-Heading "Construcción del sistema" 2
Write-Normal "La construcción del sistema se abordará con metodología Agile (Scrum), con sprints de 2-3 semanas y entregas incrementales."
Write-EmptyLine

# 3.2.1 Fases
Write-Heading "Fases" 3
Write-Bold "Fase 1 – Análisis y Diseño (ASI):"
Write-Bullet "Toma de requisitos detallada por bloque funcional."
Write-Bullet "Documentación funcional: casos de uso, historias de usuario, criterios de aceptación."
Write-Bullet "Validación del alcance con EJIE y la consultora del ANS."
Write-Bullet "Definición de la arquitectura técnica de cada sistema."
Write-EmptyLine
Write-Bold "Fase 2 – Desarrollo iterativo:"
Write-Bullet "Sprints de desarrollo con entregas incrementales."
Write-Bullet "Testing integrado en cada sprint (Shift Left)."
Write-Bullet "Revisiones de sprint con el cliente."
Write-Bullet "Integración continua y despliegue en entornos de desarrollo/pre-producción."
Write-EmptyLine
Write-Bold "Fase 3 – Integración y pruebas:"
Write-Bullet "Pruebas de integración entre sistemas de gestión y módulos transversales."
Write-Bullet "Pruebas de rendimiento."
Write-Bullet "Pruebas de accesibilidad completas."
Write-Bullet "Pruebas de aceptación con usuarios reales."
Write-EmptyLine
Write-Bold "Fase 4 – Despliegue y puesta en producción:"
Write-Bullet "Despliegue en Kubernetes (entorno EJIE)."
Write-Bullet "Migración de datos (donde aplique)."
Write-Bullet "Periodo de estabilización."
Write-Bullet "Transferencia de conocimiento."
Write-EmptyLine

# 3.2.2 Actividades principales y objetivo
Write-Heading "Actividades principales y objetivo" 3
Write-Bullet "Gestión del alcance, planificación y riesgos del proyecto."
Write-Bullet "Coordinación de equipos internos (hiberus) y externos (La Personalité, consultora ANS, Sonia/EJIE)."
Write-Bullet "Toma de requisitos funcionales y elaboración de documentación."
Write-Bullet "Diseño de la arquitectura técnica de cada sistema de gestión."
Write-Bullet "Desarrollo de los sistemas back-office (Transparencia, Participación, Comunicación, Diáspora)."
Write-Bullet "Desarrollo de los portales públicos (Irekia Berria, portal de comunicación, portales de diáspora)."
Write-Bullet "Integración con módulos transversales (Seguridad, Directorio, Etiquetas, Geocatalogación, Publicador)."
Write-Bullet "Integración con sistemas existentes (CMS euskadi.eus, Tramitagune, DAM)."
Write-Bullet "Aseguramiento de la calidad y testing."
Write-Bullet "Aseguramiento de la accesibilidad."
Write-Bullet "Soporte al bilingüismo euskera/castellano (e inglés donde aplique)."
Write-Bullet "Despliegue, migración y transferencia de conocimiento."
Write-EmptyLine

# 3.2.3 Organizacion de los equipos de trabajo
Write-Heading "Organización de los equipos de trabajo" 3
Write-Normal "El equipo se organizará en células funcionales alineadas con los bloques del proyecto:"
Write-EmptyLine
Write-Bold "Equipo de Dirección y Gestión:"
Write-Bullet "Directora de Servicio (MMZ): liderazgo del delivery, control económico y de calidad, coordinación general."
Write-Bullet "Jefa de Proyecto (CAD): gestión del alcance, planificación, riesgos, seguimiento y reporting."
Write-EmptyLine
Write-Bold "Equipo de Análisis y Diseño de Servicios:"
Write-Placeholder "Perfiles de análisis funcional y diseño UX/UI – por definir según alcance."
Write-EmptyLine
Write-Bold "Equipo de Desarrollo:"
Write-Placeholder "Perfiles de desarrollo back y front – por definir según alcance y bloques."
Write-EmptyLine
Write-Bold "Equipo de QA y Accesibilidad:"
Write-Placeholder "Perfiles de QA, testing y accesibilidad – por definir según alcance."
Write-EmptyLine

# 3.2.4 Relacion con el entorno
Write-Heading "Relación con el entorno" 3
Write-Normal "El proyecto interactúa con múltiples actores y sistemas del entorno:"
Write-EmptyLine
Write-Bold "Actores del entorno:"
Write-Bullet "EJIE: cliente tecnológico, propietario del ecosistema de presencia web, responsable de infraestructura Kubernetes."
Write-Bullet "Consultora ANS: responsable de la definición funcional detallada."
Write-Bullet "Sonia (EJIE): conocimiento de los módulos y sistemas del CMS actual."
Write-Bullet "La Personalité: diseño de concepto/servicio y visual de los portales."
Write-Bullet "Álex / Directora de Gobierno: decisiones sobre alcance de transparencia."
Write-Bullet "María: visión funcional general del proyecto."
Write-EmptyLine
Write-Bold "Sistemas del entorno:"
Write-Bullet "CMS de euskadi.eus: sistema de gestión de contenidos corporativo."
Write-Bullet "Publicador: módulo que conecta los back-offices con el CMS."
Write-Bullet "Tramitagune: sistema de tramitación del que proceden las iniciativas legislativas con participación."
Write-Bullet "Módulos transversales: Seguridad, Directorio, Etiquetas, Geocatalogación."
Write-Bullet "DAM: almacenamiento de assets multimedia (existente o por implementar)."
Write-Bullet "Portales existentes: euskadi.eus, homes departamentales, euskaletxeak.eus (diáspora)."
Write-EmptyLine

# =============================================================================
# 4. PLANIFICACION
# =============================================================================
Write-Heading "Planificación" 1
Write-EmptyLine

# 4.1 Calendario
Write-Heading "Calendario" 2
Write-Placeholder "Definir calendario una vez se conozca el pliego, el alcance confirmado y la priorización entre bloques."
Write-EmptyLine
Write-Normal "Consideración previa: algunos bloques podrían arrancar antes que otros. Por ejemplo, el diseño de Irekia Berria podría comenzar mientras se resuelven decisiones pendientes de transparencia y participación."
Write-EmptyLine

# 4.2 Recursos
Write-Heading "Recursos" 2
Write-EmptyLine

# 4.2.1 Planificacion de recursos en el tiempo
Write-Heading "Planificación de recursos en el tiempo" 3
Write-Placeholder "Definir distribución de recursos en el tiempo una vez se confirme calendario y alcance."
Write-EmptyLine

# 4.2.2 Equipo
Write-Heading "Equipo que participará en cada uno de los paquetes de trabajo" 3
Write-Normal "A continuación se presenta el equipo propuesto para el proyecto. Los perfiles de Dirección están confirmados. El resto de perfiles se definirán en función del alcance y los bloques que se aborden."
Write-EmptyLine

# =========================================================================
# PERFIL 1: MMZ - Directora de Servicio
# =========================================================================
Write-Heading "Directora de Servicio – (MMZ)" 4
Write-EmptyLine

# Tabla para MMZ
$table = $doc.Tables.Add($sel.Range, 8, 2)
$table.Borders.Enable = $true
$table.Columns.Item(1).Width = 150
$table.Columns.Item(2).Width = 330

$table.Cell(1,1).Range.Font.Bold = $true
$table.Cell(1,1).Range.Text = "Perfil"
$table.Cell(1,2).Range.Text = "Directora de Servicio"

$table.Cell(2,1).Range.Font.Bold = $true
$table.Cell(2,1).Range.Text = "Años de experiencia"
$table.Cell(2,2).Range.Text = "Más de 30 años"

$table.Cell(3,1).Range.Font.Bold = $true
$table.Cell(3,1).Range.Text = "Titulación académica"
$table.Cell(3,2).Range.Text = "Ingeniería informática"

$table.Cell(4,1).Range.Font.Bold = $true
$table.Cell(4,1).Range.Text = "Certificaciones"
$table.Cell(4,2).Range.Text = "Euskera B2"

$table.Cell(5,1).Range.Font.Bold = $true
$table.Cell(5,1).Range.Text = "Experiencia"
$table.Cell(5,2).Range.Text = "En consultoría, dirección y gestión de equipos y proyectos de transformación digital, administración electrónica y modernización de procesos organizacionales. Especializada en analizar necesidades de cambio, diseñar sistemas y nuevas estructuras organizativas y funcionales para la simplificación y mejora de la actividad."

$table.Cell(6,1).Range.Font.Bold = $true
$table.Cell(6,1).Range.Text = "Experiencia EJIE"
$table.Cell(6,2).Range.Text = "Proyectos de administración electrónica y transformación digital para múltiples departamentos del Gobierno Vasco."

$table.Cell(7,1).Range.Font.Bold = $true
$table.Cell(7,1).Range.Text = "Tareas en el proyecto"
$table.Cell(7,2).Range.Text = "Liderar el delivery del proyecto en plazo y forma. Coordinar los equipos propios y multidisciplinares. Control económico y de calidad. Coordinación y seguimiento con el cliente. Aportar propuestas al diseño del sistema."

$table.Cell(8,1).Range.Font.Bold = $true
$table.Cell(8,1).Range.Text = "% dedicación estimado"
$table.Cell(8,2).Range.Text = "[TODO] Por definir"

# Mover cursor despues de la tabla
$sel.EndKey(6) | Out-Null
Write-EmptyLine

# =========================================================================
# PERFIL 2: CAD - Jefa de Proyecto
# =========================================================================
Write-Heading "Jefa de Proyecto – (CAD)" 4
Write-EmptyLine

$table2 = $doc.Tables.Add($sel.Range, 8, 2)
$table2.Borders.Enable = $true
$table2.Columns.Item(1).Width = 150
$table2.Columns.Item(2).Width = 330

$table2.Cell(1,1).Range.Font.Bold = $true
$table2.Cell(1,1).Range.Text = "Perfil"
$table2.Cell(1,2).Range.Text = "Jefa de Proyecto"

$table2.Cell(2,1).Range.Font.Bold = $true
$table2.Cell(2,1).Range.Text = "Años de experiencia"
$table2.Cell(2,2).Range.Text = "Más de 12 años"

$table2.Cell(3,1).Range.Font.Bold = $true
$table2.Cell(3,1).Range.Text = "Titulación académica"
$table2.Cell(3,2).Range.Text = "MBA Digital Business Management (IM Digital Business School, Barcelona). Licenciatura en Traducción e Interpretación (Universidad Pontificia de Comillas, Madrid)."

$table2.Cell(4,1).Range.Font.Bold = $true
$table2.Cell(4,1).Range.Text = "Certificaciones"
$table2.Cell(4,2).Range.Text = "PMP – Project Management Professional (PMI). PSMI I – Professional Scrum Master."

$table2.Cell(5,1).Range.Font.Bold = $true
$table2.Cell(5,1).Range.Text = "Experiencia"
$table2.Cell(5,2).Range.Text = "Experiencia destacada en la gestión de proyectos estratégicos de desarrollo y consultoría, principalmente en proyectos con arquitectura de microservicios, en diferentes clientes: AAPP (EJIE), banca, salud, fintech y marketing digital, con enfoque en planificación, ejecución, mejora continua y gestión del cambio. Capacidad demostrada para implementar procesos, liderar iniciativas de transformación y optimizar recursos en entornos complejos y multiculturales. Fuerte experiencia internacional."

$table2.Cell(6,1).Range.Font.Bold = $true
$table2.Cell(6,1).Range.Text = "Experiencia EJIE"
$table2.Cell(6,2).Range.Text = "Gestión de proyectos de desarrollo en arquitectura de microservicios para EJIE."

$table2.Cell(7,1).Range.Font.Bold = $true
$table2.Cell(7,1).Range.Text = "Tareas en el proyecto"
$table2.Cell(7,2).Range.Text = "Gestión del alcance del proyecto. Gestión de la planificación. Gestión de riesgos. Coordinación equipo. Supervisión de la ejecución. Gestión del cambio. Seguimiento y reporting. Validación de entregables."

$table2.Cell(8,1).Range.Font.Bold = $true
$table2.Cell(8,1).Range.Text = "% dedicación estimado"
$table2.Cell(8,2).Range.Text = "[TODO] Por definir"

$sel.EndKey(6) | Out-Null
Write-EmptyLine

# =========================================================================
# PERFILES VACÍOS - Cajas por rellenar
# =========================================================================
$roles = @(
    @{ titulo = "Analista Funcional – (por definir)"; desc = "Toma de requisitos, elaboración de documentación funcional, historias de usuario, criterios de aceptación. Interlocución con consultora ANS y usuarios finales." },
    @{ titulo = "Consultora Diseño Servicios / UX – (por definir)"; desc = "Diseño de servicios centrado en el ciudadano. Coordinación con La Personalité para trasposición de prototipos. Pruebas con usuarios." },
    @{ titulo = "Arquitecto / Technical Leader – (por definir)"; desc = "Definición de la arquitectura técnica de los sistemas de gestión. Microservicios, Kubernetes, ecosistema EJIE. Supervisión técnica del equipo de desarrollo." },
    @{ titulo = "Analista Programador/a Back – (por definir)"; desc = "Desarrollo back-end de los sistemas de gestión (Gobierno Abierto, Comunicación, Diáspora). APIs REST, integraciones con módulos transversales." },
    @{ titulo = "Analista Programador/a Front – (por definir)"; desc = "Desarrollo front-end de portales públicos y back-offices. Maquetación accesible, bilingüismo, responsive." },
    @{ titulo = "Programador/a Back – (por definir)"; desc = "Desarrollo back-end. Apoyo en integraciones y módulos funcionales." },
    @{ titulo = "Programador/a Front – (por definir)"; desc = "Desarrollo front-end. Apoyo en maquetación y componentes UI." },
    @{ titulo = "Responsable de Calidad / QA – (por definir)"; desc = "Estrategia de pruebas, automatización, reporting de KPIs de calidad. Coordinación del equipo de QA." },
    @{ titulo = "QA Analyst / Tester – (por definir)"; desc = "Ejecución de pruebas funcionales, de regresión y automatizadas. Gestión de defectos." },
    @{ titulo = "Técnica Accesibilidad – (por definir)"; desc = "Pruebas de accesibilidad con lectores de pantalla. Asesoramiento al equipo de desarrollo. Cumplimiento RD 1112/2018 y UNE-EN 301549." },
    @{ titulo = "Diseñador/a UX/UI – (por definir)"; desc = "Diseño visual, prototipado, validación con usuarios. Coordinación con La Personalité. Ecosistema Gobierno Vasco." }
)

foreach ($rol in $roles) {
    Write-Heading $rol.titulo 4
    Write-EmptyLine

    $t = $doc.Tables.Add($sel.Range, 8, 2)
    $t.Borders.Enable = $true
    $t.Columns.Item(1).Width = 150
    $t.Columns.Item(2).Width = 330

    $t.Cell(1,1).Range.Font.Bold = $true
    $t.Cell(1,1).Range.Text = "Perfil"
    $t.Cell(1,2).Range.Font.Color = 8421504
    $t.Cell(1,2).Range.Font.Italic = $true
    $t.Cell(1,2).Range.Text = "[Por asignar]"

    $t.Cell(2,1).Range.Font.Bold = $true
    $t.Cell(2,1).Range.Text = "Años de experiencia"
    $t.Cell(2,2).Range.Font.Color = 8421504
    $t.Cell(2,2).Range.Font.Italic = $true
    $t.Cell(2,2).Range.Text = "[Por asignar]"

    $t.Cell(3,1).Range.Font.Bold = $true
    $t.Cell(3,1).Range.Text = "Titulación académica"
    $t.Cell(3,2).Range.Font.Color = 8421504
    $t.Cell(3,2).Range.Font.Italic = $true
    $t.Cell(3,2).Range.Text = "[Por asignar]"

    $t.Cell(4,1).Range.Font.Bold = $true
    $t.Cell(4,1).Range.Text = "Certificaciones"
    $t.Cell(4,2).Range.Font.Color = 8421504
    $t.Cell(4,2).Range.Font.Italic = $true
    $t.Cell(4,2).Range.Text = "[Por asignar]"

    $t.Cell(5,1).Range.Font.Bold = $true
    $t.Cell(5,1).Range.Text = "Experiencia"
    $t.Cell(5,2).Range.Font.Color = 8421504
    $t.Cell(5,2).Range.Font.Italic = $true
    $t.Cell(5,2).Range.Text = "[Por asignar]"

    $t.Cell(6,1).Range.Font.Bold = $true
    $t.Cell(6,1).Range.Text = "Experiencia EJIE"
    $t.Cell(6,2).Range.Font.Color = 8421504
    $t.Cell(6,2).Range.Font.Italic = $true
    $t.Cell(6,2).Range.Text = "[Por asignar]"

    $t.Cell(7,1).Range.Font.Bold = $true
    $t.Cell(7,1).Range.Text = "Tareas en el proyecto"
    $t.Cell(7,2).Range.Text = $rol.desc

    $t.Cell(8,1).Range.Font.Bold = $true
    $t.Cell(8,1).Range.Text = "% dedicación estimado"
    $t.Cell(8,2).Range.Font.Color = 8421504
    $t.Cell(8,2).Range.Font.Italic = $true
    $t.Cell(8,2).Range.Text = "[TODO] Por definir"

    $sel.EndKey(6) | Out-Null
    Write-EmptyLine
}

# =============================================================================
# Actualizar TDC y guardar
# =============================================================================
foreach ($toc in $doc.TablesOfContents) {
    $toc.Update()
}

$doc.SaveAs([ref]$outputPath, [ref]16)  # wdFormatDocumentDefault
$doc.Close()
$word.Quit()

Write-Host "Oferta borrador generada correctamente en: $outputPath"
