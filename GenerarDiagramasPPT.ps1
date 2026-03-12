# =============================================================================
# Script: GenerarDiagramasPPT.ps1
# Genera diagramas de flujo (cajas + flechas) en PowerPoint
# =============================================================================

Get-Process POWERPNT -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

$ppt = New-Object -ComObject PowerPoint.Application

$pres = $ppt.Presentations.Add($false)  # $false = no visible

# Dimensiones estandar de diapositiva (puntos): 960 x 540 (widescreen 16:9)
$slideW = $pres.PageSetup.SlideWidth
$slideH = $pres.PageSetup.SlideHeight

# ---- Colores (PowerPoint usa RGB directo) ----
function RGB($r, $g, $b) { [int]($r + $g * 256 + $b * 65536) }

$cSistemaFill   = RGB 214 234 248   # Azul claro  - sistemas de gestion
$cSistemaBorder = RGB 41 128 185    # Azul
$cPortalFill    = RGB 212 239 223   # Verde claro - portales / salidas
$cPortalBorder  = RGB 39 174 96     # Verde
$cAlmacFill     = RGB 255 249 222   # Amarillo claro - almacenamiento
$cAlmacBorder   = RGB 183 149 11    # Amarillo oscuro
$cProcesoFill   = RGB 235 222 240   # Lila claro  - procesos / entradas
$cProcesoBorder = RGB 142 68 173    # Lila
$cDudaFill      = RGB 253 235 232   # Rojo claro  - dudas / decisiones
$cDudaBorder    = RGB 192 57 43     # Rojo
$cFlecha        = RGB 100 100 100   # Flechas
$cNegro         = RGB 0 0 0
$cBlanco        = RGB 255 255 255
$cTituloBg      = RGB 44 62 80      # Azul oscuro titulos

# ---- Funcion: Caja redondeada ----
function Add-Box($slide, $left, $top, $width, $height, $text, $fillColor, $borderColor, [switch]$bold, [switch]$dashed, $fontSize = 11) {
    # msoShapeRoundedRectangle = 5
    $s = $slide.Shapes.AddShape(5, $left, $top, $width, $height)
    $s.TextFrame.TextRange.Text = $text
    $s.TextFrame.TextRange.Font.Size = $fontSize
    $s.TextFrame.TextRange.Font.Bold = [int]$bold.IsPresent
    $s.TextFrame.TextRange.Font.Color.RGB = $cNegro
    $s.TextFrame.TextRange.ParagraphFormat.Alignment = 2  # ppAlignCenter
    $s.TextFrame.WordWrap = -1
    $s.TextFrame.AutoSize = 0  # ppAutoSizeNone
    $s.TextFrame.MarginLeft = 8
    $s.TextFrame.MarginRight = 8
    $s.TextFrame.MarginTop = 6
    $s.TextFrame.MarginBottom = 6
    $s.Fill.ForeColor.RGB = $fillColor
    $s.Line.ForeColor.RGB = $borderColor
    $s.Line.Weight = 2
    if ($dashed) { $s.Line.DashStyle = 4 }
    return $s
}

# ---- Funcion: Flecha ----
function Add-Arrow($slide, $x1, $y1, $x2, $y2, $color = $cFlecha, [switch]$dashed, $weight = 2) {
    # msoConnectorStraight = 1
    $l = $slide.Shapes.AddConnector(1, $x1, $y1, $x2, $y2)
    $l.Line.EndArrowheadStyle = 2  # msoArrowheadTriangle
    $l.Line.ForeColor.RGB = $color
    $l.Line.Weight = $weight
    if ($dashed) { $l.Line.DashStyle = 4 }
    return $l
}

# ---- Funcion: Doble flecha ----
function Add-DoubleArrow($slide, $x1, $y1, $x2, $y2, $color = $cFlecha, $weight = 2) {
    $l = $slide.Shapes.AddConnector(1, $x1, $y1, $x2, $y2)
    $l.Line.BeginArrowheadStyle = 2
    $l.Line.EndArrowheadStyle = 2
    $l.Line.ForeColor.RGB = $color
    $l.Line.Weight = $weight
    return $l
}

# ---- Funcion: Etiqueta flotante ----
function Add-Label($slide, $left, $top, $width, $height, $text, $fontSize = 9, [switch]$bold, [switch]$italic, $color = $cNegro) {
    # msoTextOrientationHorizontal = 1
    $tb = $slide.Shapes.AddTextbox(1, $left, $top, $width, $height)
    $tb.TextFrame.TextRange.Text = $text
    $tb.TextFrame.TextRange.Font.Size = $fontSize
    $tb.TextFrame.TextRange.Font.Bold = [int]$bold.IsPresent
    $tb.TextFrame.TextRange.Font.Italic = [int]$italic.IsPresent
    $tb.TextFrame.TextRange.Font.Color.RGB = $color
    $tb.TextFrame.TextRange.ParagraphFormat.Alignment = 2  # center
    $tb.TextFrame.WordWrap = -1
    $tb.Fill.Visible = 0
    $tb.Line.Visible = 0
    return $tb
}

# ---- Funcion: Titulo de diapositiva (banda superior) ----
function Add-SlideTitle($slide, $text) {
    # Banda de titulo en la parte superior
    $band = $slide.Shapes.AddShape(1, 0, 0, $slideW, 52)  # Rectangle
    $band.Fill.ForeColor.RGB = $cTituloBg
    $band.Line.Visible = 0
    $band.TextFrame.TextRange.Text = $text
    $band.TextFrame.TextRange.Font.Size = 20
    $band.TextFrame.TextRange.Font.Bold = -1
    $band.TextFrame.TextRange.Font.Color.RGB = $cBlanco
    $band.TextFrame.TextRange.ParagraphFormat.Alignment = 1  # ppAlignLeft
    $band.TextFrame.MarginLeft = 30
    $band.TextFrame.MarginTop = 10
}

# ---- Funcion: Caja leyenda ----
function Add-LegendBox($slide, $left, $top, $width, $height, $fillColor, $borderColor, $text) {
    $s = $slide.Shapes.AddShape(1, $left, $top, $width, $height)  # Rectangle
    $s.Fill.ForeColor.RGB = $fillColor
    $s.Line.ForeColor.RGB = $borderColor
    $s.Line.Weight = 1

    $lb = Add-Label $slide ($left + $width + 4) ($top - 1) 160 $height $text 8
    $lb.TextFrame.TextRange.ParagraphFormat.Alignment = 1  # left
    return $s
}


# =============================================================================
# SLIDE 1 - PORTADA
# =============================================================================
$s1 = $pres.Slides.Add(1, 12)  # ppLayoutBlank

# Fondo oscuro
$s1.Background.Fill.ForeColor.RGB = $cTituloBg

# Titulo
$t1 = Add-Label $s1 60 100 840 80 "Diagramas de Flujo" 36 -bold
$t1.TextFrame.TextRange.Font.Color.RGB = $cBlanco

# Subtitulo
$t2 = Add-Label $s1 60 180 840 50 "Proyecto Irekia Berria" 24
$t2.TextFrame.TextRange.Font.Color.RGB = (RGB 174 214 241)

# Linea separadora
$line = $s1.Shapes.AddLine(80, 240, 400, 240)
$line.Line.ForeColor.RGB = (RGB 39 174 96)
$line.Line.Weight = 3

# Contenido
$tc = Add-Label $s1 60 265 840 170 "1. Transparencia: repositorio actual, Gardena y nuevo Irekia`n2. Participacion: Tramitagune y nuevo sistema`n3. Prensa y Noticias: sistema de gestion, CMS, DAM y publicacion`n4. Diaspora: gestion y portales de sedes en el extranjero" 14
$tc.TextFrame.TextRange.Font.Color.RGB = (RGB 213 219 219)
$tc.TextFrame.TextRange.ParagraphFormat.Alignment = 1  # left

# Fecha
$tf = Add-Label $s1 60 460 400 30 "Fecha: 12 de marzo de 2026" 11
$tf.TextFrame.TextRange.Font.Color.RGB = (RGB 150 160 170)
$tf.TextFrame.TextRange.ParagraphFormat.Alignment = 1


# =============================================================================
# SLIDE 2 - DIAGRAMA TRANSPARENCIA
# =============================================================================
$s2 = $pres.Slides.Add(2, 12)  # ppLayoutBlank
Add-SlideTitle $s2 "Diagrama 1 - Transparencia"

# -- Cajas --

# BD / Repositorio (centro superior)
$b_bd = Add-Box $s2 330 85 300 50 "BD / Repositorio de contenido`n(actual CMS)" $cAlmacFill $cAlmacBorder -bold -fontSize 11

# Gardena (izquierda medio)
$b_gard = Add-Box $s2 60 235 250 50 "Portal Gardena`n(actual - desaparece)" $cPortalFill $cPortalBorder -fontSize 11

# Sist. Gestion Transparencia (derecha medio) - DUDA
$b_sist = Add-Box $s2 620 220 280 65 "Sistema de gestion`nde Transparencia`n(¿nuevo o se reutiliza?)" $cDudaFill $cDudaBorder -dashed -bold -fontSize 11

# Irekia Berria (derecha abajo)
$b_irek = Add-Box $s2 620 395 280 50 "Irekia Berria`n(seccion Transparencia)" $cPortalFill $cPortalBorder -bold -fontSize 12

# -- Flechas --

# BD → Gardena (flujo actual, solido)
Add-Arrow $s2 410 135 185 235

# BD → Sist. Gestion (discontinua roja)
Add-Arrow $s2 550 135 760 220 -color $cDudaBorder -dashed

# Sist. Gestion → Irekia (discontinua roja)
Add-Arrow $s2 760 285 760 395 -color $cDudaBorder -dashed

# -- Etiquetas --
Add-Label $s2 160 170 150 25 "flujo actual" 9 -italic -color (RGB 100 100 100)

$ld = Add-Label $s2 580 165 200 30 "¿crear nuevo o reutilizar?" 9 -bold -color $cDudaBorder

# -- Leyenda --
Add-LegendBox $s2 60 440 14 14 $cAlmacFill $cAlmacBorder "Almacenamiento / BD"
Add-LegendBox $s2 60 460 14 14 $cPortalFill $cPortalBorder "Portal / salida"
Add-LegendBox $s2 60 480 14 14 $cDudaFill $cDudaBorder "Duda / decision pendiente"

# -- Nota inferior --
$nota2 = Add-Label $s2 330 445 620 70 "Duda central: ¿Se necesita un back-office nuevo de transparencia, o el repositorio de contenido actual que alimenta a Gardena puede servir directamente como fuente de datos para Irekia Berria?" 9 -italic -color (RGB 100 100 100)
$nota2.TextFrame.TextRange.ParagraphFormat.Alignment = 1  # left


# =============================================================================
# SLIDE 3 - DIAGRAMA PARTICIPACION
# =============================================================================
$s3 = $pres.Slides.Add(3, 12)
Add-SlideTitle $s3 "Diagrama 2 - Participacion"

# ---- COLUMNA IZQUIERDA: flujo actual ----

# Cabecera "Flujo actual"
$hdr1 = Add-Label $s3 20 60 200 22 "FLUJO ACTUAL" 10 -bold -color (RGB 100 100 100)
$hdr1.TextFrame.TextRange.ParagraphFormat.Alignment = 2

# Tramitagune
$p_tram = Add-Box $s3 30 90 180 42 "Tramitagune" $cSistemaFill $cSistemaBorder -bold -fontSize 11

# Creacion
$p_crea = Add-Box $s3 15 185 210 55 "Creacion de iniciativa`nlegislativa (funcionario)" $cProcesoFill $cProcesoBorder -fontSize 10

# euskadi.eus
$p_eusk = Add-Box $s3 30 310 180 42 "euskadi.eus" $cPortalFill $cPortalBorder -bold -fontSize 12

# Flechas izquierda
Add-Arrow $s3 120 132 120 185
Add-Arrow $s3 120 240 120 310

Add-Label $s3 130 260 70 20 "Publicar" 9 -bold

# ---- COLUMNA DERECHA: nuevo sistema ----

# Cabecera "Nuevo sistema"
$hdr2 = Add-Label $s3 450 60 420 22 "NUEVO SISTEMA DE PARTICIPACION" 10 -bold -color (RGB 100 100 100)
$hdr2.TextFrame.TextRange.ParagraphFormat.Alignment = 2

# Entrada 1: Iniciativa participativa
$p_inic = Add-Box $s3 430 90 200 55 "Iniciativa participativa`n(funcionario)" $cProcesoFill $cProcesoBorder -fontSize 10

# Entrada 2: Voluntaria
$p_volu = Add-Box $s3 680 90 230 55 "Participacion voluntaria`n(sin requisito legal)" $cProcesoFill $cProcesoBorder -fontSize 10

# Sistema de gestion central
$p_sist = Add-Box $s3 470 225 240 55 "Sistema de gestion`nde Participacion" $cSistemaFill $cSistemaBorder -bold -fontSize 12

# Irekia Berria Participacion
$p_irek = Add-Box $s3 470 385 240 48 "Irekia Berria`n(seccion Participacion)" $cPortalFill $cPortalBorder -bold -fontSize 12

# Flechas derecha
Add-Arrow $s3 530 145 560 225       # Iniciativa → Sist
Add-Arrow $s3 795 145 720 225       # Voluntaria → Sist
Add-Arrow $s3 590 280 590 385       # Sist → Irekia

Add-Label $s3 600 325 70 20 "Publicar" 9 -bold

# ---- Flecha de conexion entre columnas ----
$ac = Add-Arrow $s3 225 210 470 250 -color $cProcesoBorder -dashed
Add-Label $s3 270 195 180 30 "rama participativa" 8 -italic -color $cProcesoBorder

# ---- Separador vertical ----
$sep = $s3.Shapes.AddLine(380, 70, 380, 440)
$sep.Line.ForeColor.RGB = (RGB 200 200 200)
$sep.Line.DashStyle = 4
$sep.Line.Weight = 1

# -- Leyenda --
Add-LegendBox $s3 30 420 14 14 $cSistemaFill $cSistemaBorder "Sistemas de gestion"
Add-LegendBox $s3 30 440 14 14 $cProcesoFill $cProcesoBorder "Procesos / entradas"
Add-LegendBox $s3 30 460 14 14 $cPortalFill $cPortalBorder "Portales / salidas"


# =============================================================================
# SLIDE 4 - DIAGRAMA PRENSA Y NOTICIAS
# =============================================================================
$s4 = $pres.Slides.Add(4, 12)
Add-SlideTitle $s4 "Diagrama 3 - Prensa y Noticias"

# Fila 1: Sistema central
$pr_sist = Add-Box $s4 310 80 340 52 "Sistema de gestion de Prensa" $cSistemaFill $cSistemaBorder -bold -fontSize 14

# Fila 2: Almacenamientos
$pr_cont = Add-Box $s4 100 210 260 48 "Almacenamiento de contenido" $cAlmacFill $cAlmacBorder -fontSize 11
$pr_asse = Add-Box $s4 600 210 260 48 "Almacenamiento de assets" $cAlmacFill $cAlmacBorder -fontSize 11

# Fila 3: Destinos de almacen
$pr_cms = Add-Box $s4 100 310 260 48 "CMS actual de euskadi.eus" $cSistemaFill $cSistemaBorder -bold -fontSize 11
$pr_dam = Add-Box $s4 600 310 260 48 "DAM`n(Digital Asset Management)" $cSistemaFill $cSistemaBorder -bold -fontSize 11

# Fila 4: Salidas
$pr_home = Add-Box $s4 40 430 220 42 "Home de euskadi.eus" $cPortalFill $cPortalBorder -bold -fontSize 11
$pr_dept = Add-Box $s4 290 430 220 42 "Homes departamentales" $cPortalFill $cPortalBorder -bold -fontSize 11
$pr_rrss = Add-Box $s4 540 430 220 42 "RRSS y otros canales" $cPortalFill $cPortalBorder -bold -fontSize 11

# Nota: No publica en Irekia
$pr_nota = Add-Box $s4 790 430 140 42 "NO publica`nen Irekia" $cDudaFill $cDudaBorder -bold -fontSize 10

# -- Flechas --

# Sist → Almacenamientos
Add-Arrow $s4 400 132 230 210
Add-Arrow $s4 560 132 730 210

# Almacenamientos → destinos
Add-Arrow $s4 230 258 230 310
Add-Arrow $s4 730 258 730 310

# CMS ↔ DAM (vinculados)
Add-DoubleArrow $s4 360 334 600 334 -weight 3

Add-Label $s4 420 338 120 22 "vinculados" 9 -italic -color (RGB 100 100 100)

# Publicar: desde zona central inferior
Add-Arrow $s4 230 358 150 430       # → Home
Add-Arrow $s4 400 358 400 430       # → Departamentales
Add-Arrow $s4 630 358 650 430       # → RRSS

Add-Label $s4 340 385 120 22 "Publicar" 10 -bold

# -- Leyenda --
Add-LegendBox $s4 40 492 14 14 $cSistemaFill $cSistemaBorder "Sistemas"
Add-LegendBox $s4 220 492 14 14 $cAlmacFill $cAlmacBorder "Almacenamiento"
Add-LegendBox $s4 400 492 14 14 $cPortalFill $cPortalBorder "Salidas"


# =============================================================================
# SLIDE 5 - DIAGRAMA DIASPORA
# =============================================================================
$s5 = $pres.Slides.Add(5, 12)
Add-SlideTitle $s5 "Diagrama 4 - Diaspora (Sedes vascas en el extranjero)"

# Caja: Sistema de gestion
$di_sist = Add-Box $s5 310 100 340 55 "Sistema de gestion`nde Diaspora" $cSistemaFill $cSistemaBorder -bold -fontSize 14

# Caja: Plantilla
$di_plan = Add-Box $s5 250 240 460 55 "Estructura de plantilla de portales`n+ publicacion de contenidos" $cProcesoFill $cProcesoBorder -fontSize 12

# Caja: Portales de salida
$di_port = Add-Box $s5 260 390 440 55 "Portales de sedes vascas`nen el extranjero" $cPortalFill $cPortalBorder -bold -fontSize 13

# Flechas
Add-Arrow $s5 480 155 480 240
Add-Arrow $s5 480 295 480 390

# Nota problemática autenticacion
$di_nota = Add-Box $s5 60 290 160 65 "Problematica:`nUsuarios sin BAK`nni certificado digital" $cDudaFill $cDudaBorder -dashed -fontSize 9
Add-Arrow $s5 220 320 310 280 -color $cDudaBorder -dashed

# -- Leyenda --
Add-LegendBox $s5 60 440 14 14 $cSistemaFill $cSistemaBorder "Sistemas de gestion"
Add-LegendBox $s5 60 460 14 14 $cProcesoFill $cProcesoBorder "Procesos"
Add-LegendBox $s5 60 480 14 14 $cPortalFill $cPortalBorder "Portales / salidas"
Add-LegendBox $s5 60 500 14 14 $cDudaFill $cDudaBorder "Dudas / pendiente"


# =============================================================================
# GUARDAR
# =============================================================================
$savePath = "c:\Users\ClaudiaAlvarezDiaz\Documents\EJIE\Repo IREKIA\IREKIA\Diagramas Flujo Irekia Berria.pptx"
$pres.SaveAs($savePath)
$pres.Close()
$ppt.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ppt) | Out-Null

Write-Host "Presentacion generada en: $savePath"
