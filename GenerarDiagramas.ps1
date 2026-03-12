# =============================================================================
# Script: GenerarDiagramas.ps1
# Genera diagramas de flujo (cajas + flechas) para el proyecto Irekia Berria
# =============================================================================

# Cerrar Word si queda abierto
Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()
$sel = $word.Selection

# ---- Estilos (IDs numericos para independencia de idioma) ----
$wdStyleNormal   = -1
$wdStyleHeading1 = -2
$wdStyleHeading2 = -3
$wdStyleTitle    = -63
$wdStyleSubtitle = -75

# ---- Funciones de texto ----
function Write-Heading($text, $level) {
    switch ($level) {
        1 { $sel.Style = $doc.Styles.Item($wdStyleHeading1) }
        2 { $sel.Style = $doc.Styles.Item($wdStyleHeading2) }
    }
    $sel.TypeText($text)
    $sel.TypeParagraph()
}
function Write-Normal($text) {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.TypeText($text)
    $sel.TypeParagraph()
}
function Write-EmptyLine() {
    $sel.Style = $doc.Styles.Item($wdStyleNormal)
    $sel.TypeParagraph()
}

# ---- Colores (Word BGR: R + G*256 + B*65536) ----
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
$cGrisFill      = RGB 245 245 245   # Gris claro
$cGrisBorder    = RGB 150 150 150   # Gris
$cFlecha        = RGB 100 100 100   # Flechas
$cNegro         = RGB 0 0 0
$cBlanco        = RGB 255 255 255

# ---- Funciones de formas ----

# Caja redondeada con texto
function Add-Box($left, $top, $width, $height, $text, $fillColor, $borderColor) {
    $s = $doc.Shapes.AddShape(5, $left, $top, $width, $height)  # 5 = RoundedRectangle
    $s.WrapFormat.Type = 3  # In front of text
    $s.TextFrame.TextRange.Text = $text
    $s.TextFrame.TextRange.Font.Size = 9
    $s.TextFrame.TextRange.Font.Bold = 0
    $s.TextFrame.TextRange.Font.Color = $cNegro
    $s.TextFrame.TextRange.ParagraphFormat.Alignment = 1  # Center
    $s.TextFrame.MarginLeft = 4
    $s.TextFrame.MarginRight = 4
    $s.TextFrame.MarginTop = 3
    $s.TextFrame.MarginBottom = 3
    $s.Fill.ForeColor.RGB = $fillColor
    $s.Line.ForeColor.RGB = $borderColor
    $s.Line.Weight = 1.5
    return $s
}

# Flecha (linea con punta)
function Add-Arrow($x1, $y1, $x2, $y2) {
    $l = $doc.Shapes.AddLine($x1, $y1, $x2, $y2)
    $l.WrapFormat.Type = 3
    $l.Line.EndArrowheadStyle = 2  # Triangulo
    $l.Line.ForeColor.RGB = $cFlecha
    $l.Line.Weight = 1.5
    return $l
}

# Flecha doble
function Add-DoubleArrow($x1, $y1, $x2, $y2) {
    $l = $doc.Shapes.AddLine($x1, $y1, $x2, $y2)
    $l.WrapFormat.Type = 3
    $l.Line.BeginArrowheadStyle = 2
    $l.Line.EndArrowheadStyle = 2
    $l.Line.ForeColor.RGB = $cFlecha
    $l.Line.Weight = 1.5
    return $l
}

# Etiqueta flotante (sin borde ni fondo)
function Add-Label($left, $top, $width, $height, $text) {
    $tb = $doc.Shapes.AddTextbox(1, $left, $top, $width, $height)
    $tb.WrapFormat.Type = 3
    $tb.TextFrame.TextRange.Text = $text
    $tb.TextFrame.TextRange.Font.Size = 8
    $tb.TextFrame.TextRange.Font.Color = $cNegro
    $tb.TextFrame.TextRange.Font.Italic = -1
    $tb.TextFrame.TextRange.ParagraphFormat.Alignment = 1
    $tb.TextFrame.MarginLeft = 2
    $tb.TextFrame.MarginRight = 2
    $tb.TextFrame.MarginTop = 1
    $tb.TextFrame.MarginBottom = 1
    $tb.Fill.Visible = 0
    $tb.Line.Visible = 0
    return $tb
}

# =============================================================================
# PORTADA
# =============================================================================
Write-EmptyLine
Write-EmptyLine
Write-EmptyLine

$sel.ParagraphFormat.Alignment = 1
$sel.Style = $doc.Styles.Item($wdStyleTitle)
$sel.TypeText("Diagramas de Flujo")
$sel.TypeParagraph()

$sel.Style = $doc.Styles.Item($wdStyleSubtitle)
$sel.TypeText("Proyecto Irekia Berria")
$sel.TypeParagraph()
$sel.ParagraphFormat.Alignment = 0

Write-EmptyLine

Write-Normal "Diagramas basicos de cajas que representan los flujos de datos y sistemas implicados en cada bloque del proyecto."
Write-EmptyLine
Write-Normal "Contenido:"
Write-Normal "  1. Transparencia: repositorio actual, Gardena y nuevo Irekia"
Write-Normal "  2. Participacion: Tramitagune y nuevo sistema de participacion"
Write-Normal "  3. Prensa y Noticias: sistema de gestion, CMS, DAM y publicacion"
Write-Normal "  4. Diaspora: gestion y portales de sedes en el extranjero"
Write-EmptyLine
Write-Normal "Fecha: 12 de marzo de 2026"

$sel.InsertBreak(7)  # Page break

# =============================================================================
# DIAGRAMA 1 - TRANSPARENCIA
# =============================================================================
Write-Heading "Diagrama 1 - Transparencia" 1
Write-EmptyLine

# -- Cajas --

# Fila 1: Fuente de datos
$b1 = Add-Box 115 25 220 48 "BD / Repositorio de contenido (actual CMS)" $cAlmacFill $cAlmacBorder
$b1.TextFrame.TextRange.Font.Bold = -1

# Fila 2 izquierda: destino actual
$b2a = Add-Box 10 145 185 45 "Portal Gardena (actual)" $cPortalFill $cPortalBorder

# Fila 2 derecha: posible nuevo sistema (borde discontinuo = duda)
$b2b = Add-Box 255 140 195 58 "Sistema de gestion de Transparencia (¿nuevo?)" $cDudaFill $cDudaBorder
$b2b.Line.DashStyle = 4

# Fila 3: salida final
$b3 = Add-Box 255 270 195 48 "Irekia Berria (Transparencia)" $cPortalFill $cPortalBorder
$b3.TextFrame.TextRange.Font.Bold = -1

# -- Flechas --

# BD → Gardena (flujo actual, solido)
Add-Arrow 225 73 100 145

# BD → Sist. Gestion (dashed rojo = duda)
$a1d = Add-Arrow 225 73 352 140
$a1d.Line.DashStyle = 4
$a1d.Line.ForeColor.RGB = $cDudaBorder

# Sist. Gestion → Irekia (dashed rojo)
$a2d = Add-Arrow 352 198 352 270
$a2d.Line.DashStyle = 4
$a2d.Line.ForeColor.RGB = $cDudaBorder

# -- Etiquetas --
$lb1 = Add-Label 25 95 130 22 "flujo actual"
$lb2 = Add-Label 255 100 195 22 "¿crear nuevo o reutilizar?"
$lb2.TextFrame.TextRange.Font.Color = $cDudaBorder

# -- Leyenda / nota al pie (en flujo de texto, debajo del diagrama) --
for ($i = 0; $i -lt 24; $i++) { Write-EmptyLine }

Write-Heading "Nota" 2
Write-Normal "Duda central: ¿Se necesita un sistema de gestion de transparencia nuevo (back-office), o el repositorio de contenido actual que alimenta a Gardena puede servir directamente como fuente de datos para Irekia Berria?"

$sel.InsertBreak(7)

# =============================================================================
# DIAGRAMA 2 - PARTICIPACION
# =============================================================================
Write-Heading "Diagrama 2 - Participacion" 1
Write-EmptyLine

# -- COLUMNA IZQUIERDA: flujo actual (Tramitagune → euskadi.eus) --

$p_tram = Add-Box 5 20 170 40 "Tramitagune" $cSistemaFill $cSistemaBorder
$p_tram.TextFrame.TextRange.Font.Bold = -1

$p_crea = Add-Box 5 105 170 55 "Creacion de iniciativa legislativa (funcionario)" $cProcesoFill $cProcesoBorder

$p_eusk = Add-Box 5 240 170 40 "euskadi.eus" $cPortalFill $cPortalBorder
$p_eusk.TextFrame.TextRange.Font.Bold = -1

# -- COLUMNA DERECHA: nuevo sistema --

$p_inic = Add-Box 220 20 110 60 "Iniciativa participativa (funcionario)" $cProcesoFill $cProcesoBorder

$p_volu = Add-Box 340 20 115 60 "Participacion voluntaria (sin req. legal)" $cProcesoFill $cProcesoBorder

$p_sist = Add-Box 215 150 245 50 "Sistema de gestion de Participacion" $cSistemaFill $cSistemaBorder
$p_sist.TextFrame.TextRange.Font.Bold = -1

$p_irek = Add-Box 225 280 225 45 "Irekia Berria (Participacion)" $cPortalFill $cPortalBorder
$p_irek.TextFrame.TextRange.Font.Bold = -1

# -- Flechas columna izquierda --
Add-Arrow 90 60 90 105          # Tramitagune → Creacion
Add-Arrow 90 160 90 240         # Creacion → euskadi.eus

# -- Flechas columna derecha --
Add-Arrow 275 80 300 150        # Iniciativa → Sist. Gestion
Add-Arrow 397 80 375 150        # Voluntaria → Sist. Gestion
Add-Arrow 337 200 337 280       # Sist. Gestion → Irekia

# -- Flecha de conexion entre columnas (rama participativa) --
$a_conn = Add-Arrow 175 130 220 170
$a_conn.Line.DashStyle = 4
$a_conn.Line.ForeColor.RGB = $cProcesoBorder

# -- Etiquetas --
$lp1 = Add-Label 35 170 110 25 "Publicar"
$lp1.TextFrame.TextRange.Font.Italic = 0
$lp1.TextFrame.TextRange.Font.Bold = -1

$lp2 = Add-Label 280 230 110 25 "Publicar"
$lp2.TextFrame.TextRange.Font.Italic = 0
$lp2.TextFrame.TextRange.Font.Bold = -1

$lp3 = Add-Label 150 100 80 30 "rama participativa"
$lp3.TextFrame.TextRange.Font.Size = 7
$lp3.TextFrame.TextRange.Font.Color = $cProcesoBorder

# Cabeceras de columna
$lh1 = Add-Label 5 -5 170 20 "Flujo actual"
$lh1.TextFrame.TextRange.Font.Size = 9
$lh1.TextFrame.TextRange.Font.Bold = -1
$lh1.TextFrame.TextRange.Font.Italic = 0

$lh2 = Add-Label 220 -5 235 20 "Nuevo sistema"
$lh2.TextFrame.TextRange.Font.Size = 9
$lh2.TextFrame.TextRange.Font.Bold = -1
$lh2.TextFrame.TextRange.Font.Italic = 0

# -- Nota --
for ($i = 0; $i -lt 24; $i++) { Write-EmptyLine }

Write-Heading "Nota" 2
Write-Normal "Tramitagune es el sistema actual por el cual un funcionario crea una iniciativa legislativa y la publica en euskadi.eus. La rama participativa de esa misma iniciativa (mas la participacion voluntaria no vinculada a normativa) alimentan el nuevo sistema de gestion, que publica en el apartado de Participacion de Irekia Berria."

$sel.InsertBreak(7)

# =============================================================================
# DIAGRAMA 3 - PRENSA Y NOTICIAS
# =============================================================================
Write-Heading "Diagrama 3 - Prensa y Noticias" 1
Write-EmptyLine

# Fila 1: Sistema central
$pr_sist = Add-Box 100 20 250 48 "Sistema de gestion de Prensa" $cSistemaFill $cSistemaBorder
$pr_sist.TextFrame.TextRange.Font.Bold = -1

# Fila 2: Almacenamientos
$pr_cont = Add-Box 10 130 185 42 "Almacenamiento de contenido" $cAlmacFill $cAlmacBorder
$pr_asse = Add-Box 255 130 185 42 "Almacenamiento de assets" $cAlmacFill $cAlmacBorder

# Fila 3: Destinos de almacenamiento
$pr_cms = Add-Box 10 228 185 42 "CMS actual de euskadi.eus" $cSistemaFill $cSistemaBorder
$pr_dam = Add-Box 255 228 185 42 "DAM (Digital Asset Management)" $cSistemaFill $cSistemaBorder

# Fila 4: Salidas de publicacion
$pr_home = Add-Box 5 370 140 40 "Home de euskadi.eus" $cPortalFill $cPortalBorder
$pr_dept = Add-Box 155 370 140 40 "Homes departamentales" $cPortalFill $cPortalBorder
$pr_rrss = Add-Box 305 370 140 40 "RRSS y otros canales" $cPortalFill $cPortalBorder

# -- Flechas --

# Sist → Almacenamientos
Add-Arrow 225 68 102 130       # Sist → Almac. contenido
Add-Arrow 225 68 347 130       # Sist → Almac. assets

# Almacenamientos → destinos
Add-Arrow 102 172 102 228      # Almac. cont → CMS
Add-Arrow 347 172 347 228      # Almac. assets → DAM

# CMS ↔ DAM (vinculados)
$da = Add-DoubleArrow 195 249 255 249
$da.Line.Weight = 2

# Publicar: flechas desde zona central inferior hacia los 3 outputs
Add-Arrow 150 270 75 370       # → Home
Add-Arrow 225 270 225 370      # → Departamentales
Add-Arrow 300 270 375 370      # → RRSS

# -- Etiquetas --

$lv = Add-Label 195 253 65 18 "vinculados"
$lv.TextFrame.TextRange.Font.Size = 7

$lpub = Add-Label 175 310 100 25 "Publicar"
$lpub.TextFrame.TextRange.Font.Italic = 0
$lpub.TextFrame.TextRange.Font.Bold = -1

# -- Nota --
for ($i = 0; $i -lt 30; $i++) { Write-EmptyLine }

Write-Heading "Nota" 2
Write-Normal "El sistema de gestion de prensa gestiona todo el ciclo de un evento comunicativo. El contenido editorial se almacena en el CMS de euskadi.eus; los assets multimedia (fotos, videos, streaming) van al DAM. Ambos estan vinculados. La publicacion va a la home de euskadi.eus, a los portales departamentales y a RRSS."
Write-Normal "Importante: Este bloque NO publica en Irekia."

$sel.InsertBreak(7)

# =============================================================================
# DIAGRAMA 4 - DIASPORA
# =============================================================================
Write-Heading "Diagrama 4 - Diaspora (Sedes vascas en el extranjero)" 1
Write-EmptyLine

# Fila 1: Sistema de gestion
$di_sist = Add-Box 110 40 230 48 "Sistema de gestion de Diaspora" $cSistemaFill $cSistemaBorder
$di_sist.TextFrame.TextRange.Font.Bold = -1

# Fila 2: Plantilla + publicacion
$di_plan = Add-Box 65 175 320 55 "Plantilla de portales + publicacion de contenidos" $cProcesoFill $cProcesoBorder

# Fila 3: Portales de salida
$di_port = Add-Box 85 325 280 48 "Portales de sedes vascas en el extranjero" $cPortalFill $cPortalBorder
$di_port.TextFrame.TextRange.Font.Bold = -1

# -- Flechas --
Add-Arrow 225 88 225 175       # Sist → Plantilla
Add-Arrow 225 230 225 325      # Plantilla → Portales

# -- Nota --
for ($i = 0; $i -lt 27; $i++) { Write-EmptyLine }

Write-Heading "Nota" 2
Write-Normal "Modelo similar al sistema de bibliotecas: una plantilla comun con capacidad de personalizacion por sede. Problematica especifica: los usuarios en el extranjero no disponen de BAK ni certificado digital, por lo que se necesita un sistema de autenticacion alternativo."

# =============================================================================
# GUARDAR
# =============================================================================
$savePath = "c:\Users\ClaudiaAlvarezDiaz\Documents\EJIE\Repo IREKIA\IREKIA\Diagramas Flujo Irekia Berria.docx"
$doc.SaveAs([ref]$savePath, [ref]16)  # wdFormatDocumentDefault = 16
$doc.Close()
$word.Quit()

Write-Host "Documento generado en: $savePath"
