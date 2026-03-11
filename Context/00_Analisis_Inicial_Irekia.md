# Análisis Inicial del Proyecto Irekia — Ordenación de Ideas y Preguntas Abiertas

> **Fecha:** 6 de marzo de 2026  
> **Estado:** Borrador para refinamiento conjunto  
> **Fuentes:** Documentación disponible en `/Context/Contexto público/`  
> **Principio:** Este documento no contiene suposiciones ni información inventada. Todo lo reflejado procede de la documentación existente. Las lagunas se señalan como preguntas abiertas.

---

## 1. Entendimiento general del contexto

### 1.1. ¿Qué es Irekia?

Según la documentación disponible:

- **Irekia** (`irekia.euskadi.eus`) es el portal oficial de **Gobierno Abierto** del Gobierno Vasco.
- Su función principal es facilitar la **transparencia, participación y colaboración** entre la ciudadanía y la Administración.
- **No** es un portal informativo general ni un gestor de trámites. Es la "ventana de apertura y relación bidireccional" del Gobierno Vasco.

Funciones que cubre actualmente:

| Función | Descripción |
|---|---|
| Transparencia | Publicación de actualidad, agenda, contenidos multimedia, decisiones del Gobierno |
| Participación | Comentarios, debates públicos, aportaciones a iniciativas y anteproyectos |
| Propuestas ciudadanas | Espacio para crear y elevar propuestas al Ejecutivo |
| Colaboración | Interacción con ciudadanía, empresas, organizaciones y otras administraciones |
| Tecnología abierta | Construido con software libre y publicado como OpenIrekia |
| Canal multimedia | Noticias, streaming, fotos, vídeos y agregación de RRSS |

### 1.2. ¿Qué es euskadi.eus?

- Portal **unificado** del Gobierno Vasco: información institucional, servicios digitales, trámites, sedes electrónicas y portales sectoriales.
- Punto de entrada único para ciudadanía, empresas y profesionales.
- Su arquitectura, gestión y despliegues técnicos están **gestionados por EJIE**.

### 1.3. Relación entre Irekia y euskadi.eus

Según la documentación, Irekia:

- Es un portal **independiente** dentro de la red de portales del ecosistema euskadi.eus.
- Complementa euskadi.eus añadiendo la capa de **interacción democrática** (debate público, consultas, propuestas ciudadanas).
- Funciona con gestión de contenidos **descentralizada** (editores departamentales) y administración técnica **centralizada**.
- Se apoya en software libre (Ruby on Rails, PostgreSQL, Linux) y su código se publicó como **OpenIrekia**.

---

## 2. Ecosistema técnico-funcional (según documentación pública)

### 2.1. Arquitectura macro de euskadi.eus (donde Irekia se inserta)

| Capa | Componentes mencionados |
|---|---|
| **Presentación** | Portales de euskadi.eus, portales temáticos, intranets, blogs |
| **Servicios corporativos** | Sede electrónica, Mi Carpeta, buscador, pago online, traducciones, notificaciones, identificación (Izenpe, BAKQ) |
| **Plataformas transversales (EJIE)** | Infraestructura cloud/on-premise, plataforma web corporativa, seguridad, interoperabilidad, analítica |
| **Sistemas sectoriales** | Osakidetza, Lanbide, Vivienda, Educación, Medio ambiente, etc. |

### 2.2. Stack tecnológico conocido de Irekia

- Ruby on Rails
- PostgreSQL
- Linux
- Publicación como software libre (OpenIrekia)

### 2.3. Modelo de gestión del ecosistema

- **EJIE**: operador tecnológico — infraestructura, seguridad, comunicaciones, despliegue, mantenimiento evolutivo.
- **Servicio Web del Gobierno Vasco**: gestión de portales, contenidos, accesibilidad, SEO, catálogos, permisos, bilingüismo, analítica web.
- **CMS corporativo** con roles (editor, revisor, gestor, admin), plantillas, libros de estilo, componentes reutilizables.

---

## 3. ¿Qué sabemos sobre lo que hay que hacer?

**Respuesta honesta: no lo sabemos aún con suficiente precisión.** La documentación disponible describe el contexto y el ecosistema, pero **no define un encargo concreto, un alcance de proyecto ni unos requisitos funcionales explícitos**.

A partir de lo leído, se pueden inferir **líneas de trabajo potenciales**, pero todas requieren confirmación:

### 3.1. Líneas de trabajo que podrían estar en alcance (SIN CONFIRMAR)

A continuación se listan posibles líneas que podrían derivarse del contexto, **pero ninguna está confirmada como requisito**:

1. **Evolución o modernización del portal Irekia** (¿rediseño?, ¿migración tecnológica?, ¿nuevo desarrollo?).
2. **Integración de Irekia con servicios transversales de euskadi.eus** (identidad digital, Mi Carpeta, sede electrónica, etc.).
3. **Mejora de funcionalidades de participación ciudadana** (comentarios, debates, propuestas).
4. **Actualización del stack tecnológico** (Ruby on Rails → ¿otro framework?, ¿mantenimiento del actual?).
5. **Mejora de la gestión editorial y de contenidos** (CMS, roles, workflow).
6. **Accesibilidad, bilingüismo, diseño responsive**.
7. **Nuevas funcionalidades multimedia** (streaming, vídeo, integración RRSS).

---

## 4. Preguntas abiertas (esenciales para definir alcance)

### 4.A — Sobre el encargo y alcance

| # | Pregunta |
|---|---|
| A1 | **¿Cuál es el encargo concreto?** ¿Se trata de una evolución del portal actual, una migración, un rediseño completo, o una intervención parcial sobre funcionalidades concretas? |
| A2 | **¿Quién es el cliente / interlocutor funcional?** ¿Es la Dirección de Gobierno Abierto, el Servicio Web, otro organismo? |
| A3 | **¿Existe un pliego, contrato o documento formal** que defina el alcance esperado por el cliente? |
| A4 | **¿Cuál es el detonante del proyecto?** ¿Ha habido una petición concreta (obsolescencia técnica, nueva normativa, nueva estrategia de participación, etc.)? |
| A5 | **¿Hay plazo o hitos comprometidos?** ¿Se espera una estimación para una licitación, una planificación interna, un presupuesto? |
| A6 | **¿Qué rol tiene EJIE en este proyecto?** ¿Somos los ejecutores técnicos, los consultores, los estimadores, o todo lo anterior? |

### 4.B — Sobre el estado actual de Irekia

| # | Pregunta |
|---|---|
| B1 | **¿Cuál es el estado actual del portal Irekia?** ¿Está operativo en producción? ¿Hay problemas conocidos de rendimiento, seguridad, accesibilidad? |
| B2 | **¿Qué versión de Ruby on Rails y PostgreSQL se usa actualmente?** ¿Hay deuda técnica relevante? |
| B3 | **¿Existe documentación técnica del sistema actual** (arquitectura, modelo de datos, APIs, integraciones)? |
| B4 | **¿Cuántos editores/gestores de contenido trabajan actualmente en Irekia?** ¿Cuál es su flujo de trabajo? |
| B5 | **¿Qué integraciones tiene hoy Irekia con otros sistemas de euskadi.eus?** ¿Hay APIs, feeds, SSO, servicios compartidos? |
| B6 | **¿Existe el código fuente de OpenIrekia disponible y actualizado**, o el portal en producción ha divergido del código publicado? |

### 4.C — Sobre requisitos funcionales y no funcionales

| # | Pregunta |
|---|---|
| C1 | **¿Hay requisitos funcionales documentados** para lo que se quiere conseguir? (Si los hay, necesitamos incorporarlos a la carpeta `/requisitos`.) |
| C2 | **¿Hay requisitos normativos específicos** que apliquen (RGPD, ENS, accesibilidad WCAG, Ley de Transparencia, normativa autonómica)? |
| C3 | **¿Se espera mantener el bilingüismo euskera/castellano?** ¿Con qué nivel de exigencia (traducción simultánea, contenidos independientes por idioma)? |
| C4 | **¿Hay expectativas sobre accesibilidad** (nivel AA, AAA)? |
| C5 | **¿Se contemplan nuevas funcionalidades** no presentes hoy (ej. IA para participación, analítica avanzada, dashboards de transparencia, integración con datos abiertos)? |

### 4.D — Sobre integraciones y sistemas implicados

| # | Pregunta |
|---|---|
| D1 | **¿Con qué servicios transversales de euskadi.eus debe integrarse Irekia?** (Mi Carpeta, Sede Electrónica, Izenpe/BAKQ, notificaciones, pago online…) |
| D2 | **¿Hay dependencias con otros proyectos en curso en EJIE o en el Gobierno Vasco** que condicionen el enfoque? |
| D3 | **¿Se prevé integración con redes sociales**, y si es así, ¿cuáles y con qué profundidad? |
| D4 | **¿El CMS corporativo de euskadi.eus es el mismo que usa Irekia**, o Irekia tiene su propio sistema de gestión de contenidos? |

### 4.E — Sobre el equipo y la organización del trabajo

| # | Pregunta |
|---|---|
| E1 | **¿Qué equipos participarán en el proyecto?** (frontend, backend, UX, QA, analistas funcionales, integraciones…) |
| E2 | **¿Hay proveedor actual de mantenimiento de Irekia?** ¿Se asume que EJIE toma el relevo completo? |
| E3 | **¿Cuál es la metodología esperada?** (Agile, cascada, híbrida, marcada por contrato) |

---

## 5. Resumen de situación

| Aspecto | Estado |
|---|---|
| Contexto general del ecosistema | **Disponible** — documentación suficiente para entender dónde encaja Irekia |
| Encargo concreto / alcance | **No definido** — no hay documento de requisitos ni pliego |
| Requisitos funcionales | **No disponibles** — carpeta `/requisitos` vacía |
| Requisitos técnicos | **Parcialmente conocidos** — se sabe el stack actual pero no el objetivo |
| Integraciones | **Mencionadas a alto nivel** — sin detalle de cuáles aplican a Irekia |
| Restricciones y plazos | **Desconocidos** |
| Equipo y organización | **Desconocidos** |

---

## 6. Próximos pasos recomendados

1. **Responder las preguntas del bloque A** (encargo y alcance) — es el paso más crítico para poder avanzar con cualquier estimación.
2. **Obtener o generar documentación técnica del estado actual** de Irekia (arquitectura, modelo de datos, integraciones).
3. **Incorporar requisitos** a la carpeta `/requisitos` a medida que se vayan obteniendo del cliente o de reuniones.
4. **Refinar este documento** iterativamente conforme se vayan resolviendo las preguntas abiertas.

---

> **Nota:** Este documento se irá actualizando conforme se incorpore nueva información. Cualquier decisión de alcance debe quedar reflejada aquí antes de proceder a la estimación.
