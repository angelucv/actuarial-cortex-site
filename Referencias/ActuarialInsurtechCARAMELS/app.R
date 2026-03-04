#### dashboard-mundial ejemplo

## =================================================================
## Archivo: app.R (Versión Final - Datos Corregidos y Solvencia Restaurada)
## =================================================================

## --------------------------------------
## --- 1. Cargar Bibliotecas ---
## --------------------------------------
library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(lubridate)
library(scales)
library(tidyr)
library(plotly)
library(bslib)
library(thematic)
library(sparkline)

## -----------------------------------------------------------------
## --- 2. Configuración, Paletas y Datos ---
## -----------------------------------------------------------------
thematic::thematic_shiny(font = "auto")

# Paleta de colores profesional y diversificada
professional_palette <- c("#4E79A7", "#59A14F", "#F28E2B", "#E15759", "#76B7B2", "#EDC948")
color_cartera <- professional_palette[1]
color_siniestros <- professional_palette[3]
color_siniestralidad <- professional_palette[4]
color_mercado <- professional_palette[5]
color_comparativo <- professional_palette[2]

# ---- Título y Nombre de Compañía Actualizados ----
mi_aseguradora_nombre <- "La Mundial" 
titulo_app_linea1 <- "Actuarial Insurtech"
titulo_app_linea2 <- "Dashboard"

# Ramos reales de La Mundial de Seguros
ramos_reales <- c("Automóvil", "Salud", "Personas", "Patrimoniales", "Fianzas")

# ---- Simulación de datos con "La Mundial" incluida ----
set.seed(123)
n_empresas <- 20; n_meses <- 36
fechas <- seq(as.Date("2023-01-01"), by = "month", length.out = n_meses)
# Se incluye "La Mundial" como la primera compañía en los datos
empresas_nombres <- c("La Mundial", paste0("Aseguradora ", LETTERS[2:n_empresas])) 

sudeaseg_data_raw <- data.frame(
  Empresa = rep(empresas_nombres, each = n_meses),
  Fecha = rep(fechas, times = n_empresas),
  PNC_USD = abs(rnorm(n_empresas * n_meses, 50000, 20000)),
  Capital_Social_Suscrito_USD = rep(abs(rnorm(n_empresas, 5000000, 1000000)), each = n_meses),
  Activos_Totales_USD = rep(abs(rnorm(n_empresas, 20000000, 5000000)), each = n_meses),
  Reservas_Tecnicas_Netas_USD = rep(abs(rnorm(n_empresas, 10000000, 3000000)), each = n_meses),
  Resultado_Neto_USD = rnorm(n_empresas * n_meses, 20000, 10000),
  Patrimonio_USD = rep(abs(rnorm(n_empresas, 8000000, 2000000)), each = n_meses),
  Siniestros_Pagados_Netos_USD = abs(rnorm(n_empresas * n_meses, 30000, 10000)),
  Gastos_Generales_USD = abs(rnorm(n_empresas * n_meses, 15000, 5000))
) %>%
  mutate(
    Siniestralidad_Pagada = Siniestros_Pagados_Netos_USD / PNC_USD,
    ROE = Resultado_Neto_USD / Patrimonio_USD,
    Ratio_Gastos = Gastos_Generales_USD / PNC_USD,
    Ratio_Capital = Patrimonio_USD / Activos_Totales_USD,
    Ratio_Activos = Capital_Social_Suscrito_USD / Activos_Totales_USD,
    Ratio_Reservas = Reservas_Tecnicas_Netas_USD / Patrimonio_USD,
    Ratio_Liquidez = Activos_Totales_USD / (Reservas_Tecnicas_Netas_USD + Capital_Social_Suscrito_USD)
  )

simular_datos_tecnicos <- function(n_polizas = 5000, fecha_inicio, fecha_fin) {
  set.seed(456)
  fechas_poliza <- sample(seq(as.Date(fecha_inicio), as.Date(fecha_fin), by="day"), n_polizas, replace=TRUE)
  datos_polizas <- data.frame(ID_Poliza = 1:n_polizas, Ramo = sample(ramos_reales, n_polizas, replace = TRUE, prob = c(0.4, 0.3, 0.15, 0.1, 0.05)),
                              Prima_Neta_USD = abs(rnorm(n_polizas, 800, 300)), Canal_Distribucion = sample(c("Corredor", "Agente", "Bancaseguros", "Web"), n_polizas, replace = TRUE), Fecha_Emision = fechas_poliza)
  n_siniestros <- floor(n_polizas * 0.20)
  siniestros_data <- data.frame(ID_Poliza = sample(datos_polizas$ID_Poliza, n_siniestros, replace = TRUE),
                                Fecha_Ocurrencia = sample(seq(as.Date(fecha_inicio), as.Date(fecha_fin), by="day"), n_siniestros, replace=TRUE),
                                Monto_Pagado_USD = abs(rnorm(n_siniestros, 1200, 900)),
                                Estado = sample(c("Pagado", "En Proceso", "Rechazado"), n_siniestros, replace = TRUE, prob = c(0.7, 0.2, 0.1))) %>%
    left_join(datos_polizas %>% select(ID_Poliza, Ramo, Canal_Distribucion), by = "ID_Poliza")
  return(list(polizas = datos_polizas, siniestros = siniestros_data))
}

## ----------------------------------------------------
## --- 3. Interfaz de Usuario (UI) ---
## ----------------------------------------------------
ui <- page_navbar(
  title = tags$div(
    style = "display: flex; align-items: center; gap: 15px;",
    tags$img(src = "logo.png", height = "50px"),
    tags$div(
      style="line-height: 1.1;",
      tags$span(titulo_app_linea1, style="font-size: 0.8em;"),
      tags$span(titulo_app_linea2, style="font-size: 1.1em; font-weight: bold; display: block;")
    )
  ),
  id = "main_nav",
  theme = bslib::bs_theme(bootswatch = "darkly", "navbar-nav-link-color" = "white", "navbar-brand-color" = "white"),
  header = tags$head(
    tags$style(HTML(".navbar-nav > li > .nav-link, .navbar-brand { color: white !important; }"))
  ),
  sidebar = sidebar(
    dateRangeInput("date_range_global", "Periodo de Análisis:",
                   start = min(sudeaseg_data_raw$Fecha), end = max(sudeaseg_data_raw$Fecha)),
    hr(),
    uiOutput("dynamic_sidebar_text"),
    tags$div(
      style = "text-align: center; margin-top: 20px;",
      tags$a(
        href = "https://lamundialdeseguros.com/",
        target = "_blank",
        class = "btn btn-success",
        icon("comments"), " Chatea con Raymundo"
      )
    )
  ),
  
  nav_panel("Sobre La Mundial",
            card(
              card_header(h4("La Mundial de Seguros: Respaldo y Confianza")),
              card_body(
                p("Fundada el 15 de julio de 1958, La Mundial de Seguros se ha consolidado como una de las aseguradoras más sólidas y confiables de Venezuela. Con más de 60 años de trayectoria, la compañía se ha caracterizado por su compromiso, seriedad y una profunda vocación de servicio, respaldando a miles de familias y empresas venezolanas."),
                p("Ofrecemos una amplia gama de soluciones diseñadas para proteger lo que más valoras en cada etapa de la vida. Nuestro portafolio se estructura en líneas de negocio especializadas para atender cada necesidad con productos innovadores y un servicio de excelencia."),
                hr(),
                h5("Líneas de Productos"),
                tags$ul(
                  tags$li(tags$strong("Seguros para Personas:"), " Enfocados en la protección del individuo y su familia.",
                          tags$ul(
                            tags$li("Salud: Pólizas de Hospitalización, Cirugía y Maternidad (HCM)."),
                            tags$li("Accidentes Personales: Cobertura individual y colectiva."),
                            tags$li("Vida: Pólizas colectivas para la protección familiar."),
                            tags$li("Servicios Funerarios.")
                          )
                  ),
                  tags$li(tags$strong("Seguros para Automóvil:"), " Cobertura integral para vehículos.",
                          tags$ul(
                            tags$li("Casco y Responsabilidad Civil (RCV)."),
                            tags$li("Cobertura de Exceso de Responsabilidad (RCE).")
                          )
                  ),
                  tags$li(tags$strong("Seguros Patrimoniales:"), " Protección para los bienes de empresas y hogares.",
                          tags$ul(
                            tags$li("Incendio y Líneas Aliadas."),
                            tags$li("Robo y Asalto."),
                            tags$li("Equipos Electrónicos y Maquinarias."),
                            tags$li("Responsabilidad Civil General.")
                          )
                  ),
                  tags$li(tags$strong("Fianzas:"), " Instrumentos de garantía para respaldar obligaciones contractuales.",
                          tags$ul(
                            tags$li("Fiel Cumplimiento."),
                            tags$li("Anticipo."),
                            tags$li("Licitación."),
                            tags$li("Fianzas Aduanales y Judiciales.")
                          )
                  )
                ),
                p("Para cualquier consulta o gestión, puede visitar una de nuestras ", tags$a(href="https://lamundialdeseguros.com/oficinas/", "oficinas a nivel nacional", target="_blank"), " o comunicarse a través de nuestros ", tags$a(href="https://lamundialdeseguros.com/contacto/", "canales de atención", target="_blank"), ".")
              )
            )
  ),
  
  nav_panel("Cartera",
            layout_columns(col_widths = c(4,4,4),
                           value_box("Primas Netas", textOutput("vb_primas_netas"), showcase = icon("dollar-sign"), theme_color="primary"),
                           value_box("Pólizas Emitidas", textOutput("vb_polizas_emitidas"), showcase = icon("file-alt"), theme_color="primary"),
                           value_box("Prima Promedio", textOutput("vb_prima_promedio"), showcase = icon("chart-pie"), theme_color="primary")),
            layout_columns(card(card_header("Composición de Primas por Ramo"), plotlyOutput("plot_cartera_composicion")),
                           card(card_header("Primas por Canal de Distribución"), plotlyOutput("plot_cartera_canal"))),
            layout_columns(card(card_header("Evolución Mensual de Primas Netas"), plotlyOutput("plot_cartera_evolucion")))
  ),
  nav_panel("Siniestros",
            layout_columns(col_widths = c(4,4,4),
                           value_box("Monto Pagado", textOutput("vb_monto_pagado"), showcase = icon("exclamation-triangle"), theme_color="warning"),
                           value_box("Nº de Siniestros", textOutput("vb_num_siniestros"), showcase = icon("list-ol"), theme_color="warning"),
                           value_box("Costo Promedio", textOutput("vb_costo_promedio"), showcase = icon("balance-scale"), theme_color="warning")),
            layout_columns(card(card_header("Monto Pagado por Ramo"), plotlyOutput("plot_siniestros_ramo")),
                           card(card_header("Distribución de Severidad"), plotlyOutput("plot_siniestros_severidad"))),
            layout_columns(card(card_header("Estado de los Siniestros"), plotlyOutput("plot_siniestros_estado")))
  ),
  nav_panel("Siniestralidad",
            layout_columns(value_box("Siniestralidad Pagada General", textOutput("vb_siniestralidad_general"), showcase = icon("percent"), theme_color="danger")),
            layout_columns(card(card_header("Evolución Mensual de la Siniestralidad"), plotlyOutput("plot_siniestralidad_evolucion")),
                           card(card_header("Siniestralidad por Ramo"), plotlyOutput("plot_siniestralidad_ramo"))),
            layout_columns(card(card_header("Mapa de Calor de Siniestralidad (Ramo vs Canal)"), plotlyOutput("plot_siniestralidad_heatmap")))
  ),
  nav_panel("Visión General del Mercado",
            h4("Análisis de Cartera de Mercado"),
            layout_columns(card(card_header("Evolución de Primas del Mercado (USD)"), plotlyOutput("plot_mercado_primas_evolucion")),
                           card(card_header("Distribución de Primas por Compañía (Treemap)"), plotlyOutput("plot_mercado_primas_treemap"))),
            hr(), h4("Análisis de Siniestros de Mercado"),
            layout_columns(card(card_header("Evolución de Siniestros del Mercado (USD)"), plotlyOutput("plot_mercado_siniestros_evolucion")),
                           card(card_header("Top 10 Compañías por Siniestros Pagados"), plotlyOutput("plot_mercado_siniestros_top10"))),
            hr(), h4("Análisis de Siniestralidad de Mercado"),
            layout_columns(card(card_header("Evolución de la Siniestralidad Promedio del Mercado"), plotlyOutput("plot_mercado_siniestralidad_evolucion")),
                           card(card_header("Ranking de Siniestralidad por Compañía"), DTOutput("table_mercado_siniestralidad_ranking")))
  ),
  nav_panel("Análisis Comparativo",
            h4("Posicionamiento y Desempeño vs. Mercado"),
            layout_columns(
              card(card_header("Cuota de Mercado (Market Share)"), plotlyOutput("plot_comparativo_cuota")),
              card(card_header("Comparación de Siniestralidad Pagada"), plotlyOutput("plot_comparativo_siniestralidad"))),
            layout_columns(
              card(card_header("Comparación de Rentabilidad (ROE)"), plotlyOutput("plot_comparativo_roe")),
              card(card_header("Comparación de Eficiencia en Gastos"), plotlyOutput("plot_comparativo_gastos"))),
            layout_columns(
              card(card_header("Estructura de Capital vs. Mercado"), plotlyOutput("plot_comparativo_capital")))
  ),
  nav_panel("Análisis de Solvencia",
            layout_columns(
              uiOutput("vb_caramels_diagnostico")
            ),
            card(
              card_header("Resumen de Indicadores CARAMELS"),
              DTOutput("table_caramels_summary")
            ),
            card(
              card_header("Conclusión del Análisis de Solvencia"),
              uiOutput("caramels_summary_text")
            )
  )
)

## -----------------------------------------
## --- 4. Lógica del Servidor (Server) ---
## -----------------------------------------
server <- function(input, output, session) {
  
  ## --- Reactivos Globales ---
  market_data_filtered <- reactive({req(input$date_range_global); sudeaseg_data_raw %>% filter(between(Fecha, input$date_range_global[1], input$date_range_global[2]))})
  my_company_data <- reactive({market_data_filtered() %>% filter(Empresa == mi_aseguradora_nombre)})
  tech_data <- reactive({req(input$date_range_global); simular_datos_tecnicos(fecha_inicio = input$date_range_global[1], fecha_fin = input$date_range_global[2])})
  
  ## --- Lógica de las Pestañas ---
  output$vb_primas_netas <- renderText({dollar(sum(tech_data()$polizas$Prima_Neta_USD), prefix="$")})
  output$vb_polizas_emitidas <- renderText({number(nrow(tech_data()$polizas), big.mark = ",")})
  output$vb_prima_promedio <- renderText({dollar(mean(tech_data()$polizas$Prima_Neta_USD), prefix="$")})
  output$plot_cartera_composicion <- renderPlotly({
    df <- tech_data()$polizas %>% group_by(Ramo) %>% summarise(Total_Primas = sum(Prima_Neta_USD))
    plot_ly(df, labels = ~Ramo, values = ~Total_Primas, type = 'pie', textinfo = 'label+percent', hole = 0.4, marker = list(colors = professional_palette))
  })
  output$vb_monto_pagado <- renderText({monto <- tech_data()$siniestros %>% filter(Estado == "Pagado") %>% summarise(Total=sum(Monto_Pagado_USD)); dollar(monto$Total, prefix="$")})
  output$vb_num_siniestros <- renderText({number(nrow(tech_data()$siniestros), big.mark = ",")})
  output$vb_costo_promedio <- renderText({dollar(mean(tech_data()$siniestros$Monto_Pagado_USD), prefix="$")})
  output$plot_cartera_canal <- renderPlotly({
    df <- tech_data()$polizas %>% group_by(Canal_Distribucion) %>% summarise(Total_Primas = sum(Prima_Neta_USD, na.rm=T))
    p <- ggplot(df, aes(x=reorder(Canal_Distribucion, -Total_Primas), y=Total_Primas, fill=Canal_Distribucion, text=paste(Canal_Distribucion, "\n", dollar(Total_Primas)))) +
      geom_col(show.legend = FALSE) + scale_fill_manual(values = professional_palette) + scale_y_continuous(labels=dollar) + labs(x="Canal", y="Primas (USD)")
    ggplotly(p, tooltip="text")
  })
  output$plot_cartera_evolucion <- renderPlotly({
    df <- tech_data()$polizas %>% mutate(Mes=floor_date(Fecha_Emision, "month")) %>% group_by(Mes) %>% summarise(Primas = sum(Prima_Neta_USD, na.rm=T))
    p <- ggplot(df, aes(x=Mes, y=Primas)) + geom_line(color=color_cartera, size=1) + geom_area(fill=color_cartera, alpha=0.3) + scale_y_continuous(labels=dollar) + labs(x="Mes", y="Primas (USD)")
    ggplotly(p)
  })
  output$plot_siniestros_ramo <- renderPlotly({
    df <- tech_data()$siniestros %>% group_by(Ramo) %>% summarise(Monto = sum(Monto_Pagado_USD, na.rm=T))
    p <- ggplot(df, aes(x=reorder(Ramo, Monto), y=Monto, text=paste(Ramo, "\n", dollar(Monto)))) +
      geom_segment(aes(xend=reorder(Ramo, Monto), yend=0), color="grey40") + geom_point(color=color_siniestros, size=4) +
      coord_flip() + scale_y_continuous(labels=dollar) + labs(x="Ramo", y="Monto Pagado (USD)")
    ggplotly(p, tooltip="text")
  })
  output$plot_siniestros_severidad <- renderPlotly({
    p <- ggplot(tech_data()$siniestros, aes(x=Monto_Pagado_USD)) + geom_histogram(bins=30, fill=color_siniestros, alpha=0.7) +
      scale_x_continuous(labels=dollar) + labs(x="Monto por Siniestro (USD)", y="Frecuencia")
    ggplotly(p)
  })
  output$plot_siniestros_estado <- renderPlotly({
    df <- tech_data()$siniestros %>% group_by(Estado) %>% summarise(Cantidad=n())
    plot_ly(df, labels=~Estado, values=~Cantidad, type="pie", marker = list(colors = c("Pagado"=professional_palette[2], "En Proceso"=professional_palette[1], "Rechazado"=professional_palette[4])))
  })
  siniestralidad_data <- reactive({
    primas <- tech_data()$polizas %>% mutate(Mes=floor_date(Fecha_Emision, "month")) %>% group_by(Mes, Ramo, Canal_Distribucion) %>% summarise(Primas = sum(Prima_Neta_USD), .groups="drop")
    siniestros <- tech_data()$siniestros %>% mutate(Mes=floor_date(Fecha_Ocurrencia, "month")) %>% group_by(Mes, Ramo, Canal_Distribucion) %>% summarise(Siniestros = sum(Monto_Pagado_USD), .groups="drop")
    full_join(primas, siniestros, by=c("Mes", "Ramo", "Canal_Distribucion")) %>% mutate(across(c(Primas, Siniestros), ~replace_na(., 0))) %>% mutate(Siniestralidad = Siniestros / Primas)
  })
  output$vb_siniestralidad_general <- renderText({
    df <- siniestralidad_data(); total_primas <- sum(df$Primas); total_siniestros <- sum(df$Siniestros); ratio <- total_siniestros / total_primas
    percent(ratio, accuracy = 0.1)
  })
  output$plot_siniestralidad_evolucion <- renderPlotly({
    df <- siniestralidad_data() %>% group_by(Mes) %>% summarise(Primas = sum(Primas), Siniestros = sum(Siniestros)) %>% mutate(Siniestralidad = Siniestros / Primas)
    p <- ggplot(df, aes(x=Mes, y=Siniestralidad)) + geom_line(color=color_siniestralidad, size=1.2) + scale_y_continuous(labels=percent) + labs(x="Mes", y="Siniestralidad Pagada")
    ggplotly(p)
  })
  output$plot_siniestralidad_ramo <- renderPlotly({
    df <- siniestralidad_data() %>% group_by(Ramo) %>% summarise(Primas=sum(Primas), Siniestros=sum(Siniestros)) %>% mutate(Siniestralidad = Siniestros / Primas)
    p <- ggplot(df, aes(x=reorder(Ramo, Siniestralidad), y=Siniestralidad, fill=Siniestralidad)) + geom_col() + scale_fill_gradient(low=professional_palette[2], high=professional_palette[4]) +
      coord_flip() + scale_y_continuous(labels=percent) + labs(x="Ramo", y="Siniestralidad")
    ggplotly(p)
  })
  output$plot_siniestralidad_heatmap <- renderPlotly({
    df <- siniestralidad_data() %>% group_by(Ramo, Canal_Distribucion) %>% summarise(Primas=sum(Primas), Siniestros=sum(Siniestros), .groups="drop") %>% mutate(Siniestralidad = Siniestros / Primas)
    p <- ggplot(df, aes(x=Canal_Distribucion, y=Ramo, fill=Siniestralidad, text=paste("Siniestralidad:", percent(Siniestralidad, accuracy=0.1)))) +
      geom_tile(color="black") + scale_fill_gradient(low=professional_palette[1], high=professional_palette[4], labels=percent) + labs(x="", y="", fill="Ratio")
    ggplotly(p, tooltip="text")
  })
  output$plot_mercado_primas_evolucion <- renderPlotly({
    df <- market_data_filtered() %>% group_by(Fecha) %>% summarise(Total_PNC = sum(PNC_USD, na.rm=T))
    p <- ggplot(df, aes(x=Fecha, y=Total_PNC)) + geom_area(fill=color_mercado, alpha=0.5) + geom_line(color=color_mercado) + scale_y_continuous(labels=dollar) + labs(x="", y="")
    ggplotly(p)
  })
  output$plot_mercado_primas_treemap <- renderPlotly({
    df <- market_data_filtered() %>% filter(Fecha == max(Fecha))
    plot_ly(df, type="treemap", labels=~Empresa, parents="", values=~PNC_USD, textinfo="label+value+percent root", marker=list(colors=professional_palette))
  })
  output$plot_mercado_siniestros_evolucion <- renderPlotly({
    df <- market_data_filtered() %>% group_by(Fecha) %>% summarise(Total_Siniestros = sum(Siniestros_Pagados_Netos_USD, na.rm=T))
    p <- ggplot(df, aes(x=Fecha, y=Total_Siniestros)) + geom_area(fill=color_siniestros, alpha=0.5) + geom_line(color=color_siniestros) + scale_y_continuous(labels=dollar) + labs(x="", y="")
    ggplotly(p)
  })
  output$plot_mercado_siniestros_top10 <- renderPlotly({
    df <- market_data_filtered() %>% filter(Fecha == max(Fecha)) %>% arrange(desc(Siniestros_Pagados_Netos_USD)) %>% head(10)
    p <- ggplot(df, aes(x=reorder(Empresa, Siniestros_Pagados_Netos_USD), y=Siniestros_Pagados_Netos_USD)) + geom_col(fill=color_siniestros) + coord_flip() + scale_y_continuous(labels=dollar) + labs(x="", y="")
    ggplotly(p)
  })
  output$plot_mercado_siniestralidad_evolucion <- renderPlotly({
    df <- market_data_filtered() %>% group_by(Fecha) %>% summarise(Siniestralidad_Promedio = mean(Siniestralidad_Pagada, na.rm=T))
    p <- ggplot(df, aes(x=Fecha, y=Siniestralidad_Promedio)) + geom_line(color=color_siniestralidad, size=1) + scale_y_continuous(labels=percent) + labs(x="", y="")
    ggplotly(p)
  })
  output$table_mercado_siniestralidad_ranking <- renderDT({
    df <- market_data_filtered() %>% filter(Fecha == max(Fecha)) %>% select(Empresa, Siniestralidad_Pagada) %>%
      mutate(Siniestralidad_Pagada = percent(Siniestralidad_Pagada, accuracy=0.1)) %>% arrange(desc(Siniestralidad_Pagada))
    datatable(df, options=list(pageLength=5, searching=FALSE, lengthChange=FALSE), rownames=FALSE)
  })
  
  ## --- Lógica Análisis Comparativo ---
  comparative_data <- reactive({
    mercado_avg <- market_data_filtered() %>% filter(if_all(c(Siniestralidad_Pagada, ROE, Ratio_Gastos), is.finite)) %>% group_by(Fecha) %>% summarise(across(c(Siniestralidad_Pagada, ROE, Ratio_Gastos), ~mean(., na.rm = TRUE)), .groups="drop")
    compania_ts <- my_company_data() %>% filter(if_all(c(Siniestralidad_Pagada, ROE, Ratio_Gastos), is.finite)) %>% select(Fecha, Siniestralidad_Pagada, ROE, Ratio_Gastos)
    full_join(compania_ts %>% pivot_longer(-Fecha, names_to="Metrica", values_to="Compania"),
              mercado_avg %>% pivot_longer(-Fecha, names_to="Metrica", values_to="Mercado"), by = c("Fecha", "Metrica"))
  })
  output$plot_comparativo_cuota <- renderPlotly({
    df <- market_data_filtered() %>% group_by(Fecha) %>% summarise(Total_PNC = sum(PNC_USD), Mi_PNC = sum(PNC_USD[Empresa == mi_aseguradora_nombre])) %>% mutate(Cuota = Mi_PNC / Total_PNC)
    p <- ggplot(df, aes(x=Fecha, y=Cuota)) + geom_line(color=color_comparativo, size=1.2) + geom_area(fill=color_comparativo, alpha=0.3) +
      scale_y_continuous(labels=percent) + labs(x="Fecha", y="Cuota de Mercado")
    ggplotly(p)
  })
  create_comparative_plot <- function(metric_name, color1, color2) {
    renderPlotly({
      df <- comparative_data() %>% filter(Metrica == metric_name)
      p <- ggplot(df, aes(x=Fecha)) +
        geom_line(aes(y=Compania, color="Mi Aseguradora"), size=1.2) +
        geom_line(aes(y=Mercado, color="Promedio Mercado"), linetype="dashed") +
        scale_y_continuous(labels=percent) + scale_color_manual(values=c("Mi Aseguradora"=color1, "Promedio Mercado"=color2)) +
        labs(x="Fecha", y="Ratio (%)", color="")
      ggplotly(p) %>% layout(legend = list(orientation = "h", x = 0.5, y = 1.1, xanchor = 'center'))
    })
  }
  output$plot_comparativo_siniestralidad <- create_comparative_plot("Siniestralidad_Pagada", color_siniestralidad, "grey80")
  output$plot_comparativo_roe <- create_comparative_plot("ROE", color_comparativo, "grey80")
  output$plot_comparativo_gastos <- create_comparative_plot("Ratio_Gastos", professional_palette[1], "grey80")
  output$plot_comparativo_capital <- renderPlotly({
    df <- market_data_filtered() %>% filter(is.finite(Ratio_Capital)) %>%
      group_by(Fecha) %>% summarise(Mercado = mean(Ratio_Capital, na.rm=T), Compania = mean(Ratio_Capital[Empresa == mi_aseguradora_nombre], na.rm=T)) %>%
      filter(Fecha == max(Fecha)) %>% pivot_longer(-Fecha, names_to="Categoria", values_to="Ratio")
    p <- ggplot(df, aes(x=Categoria, y=Ratio, fill=Categoria)) + geom_col(show.legend=FALSE) +
      scale_fill_manual(values=c("Compania"=color_comparativo, "Mercado"="grey40")) +
      scale_y_continuous(labels=percent) + labs(x="", y="Ratio")
    ggplotly(p)
  })
  
  ## --- Pestaña: Análisis de Solvencia (CARAMELS) ---
  caramels_data_for_table <- reactive({
    req(my_company_data(), nrow(my_company_data()) > 0)
    last_date <- last(my_company_data()$Fecha)
    ratios_compania <- my_company_data() %>%
      filter(Fecha == last_date) %>% head(1) %>%
      select(Capital = Ratio_Capital, Activos = Ratio_Activos, Reservas = Ratio_Reservas,
             Manejo = Ratio_Gastos, Eficiencia = ROE, Liquidez = Ratio_Liquidez, Sensibilidad = Siniestralidad_Pagada) %>%
      pivot_longer(everything(), names_to = "Dimension", values_to = "Valor_Actual")
    req(nrow(ratios_compania) > 0)
    descripciones <- data.frame(
      Dimension = c("Capital", "Activos", "Reservas", "Manejo", "Eficiencia", "Liquidez", "Sensibilidad"),
      Letra = c("C", "A", "R", "M", "E", "L", "S"),
      Descripcion = c("Capacidad para absorber pérdidas.", "Calidad y riesgo de los activos.", "Suficiencia de reservas.",
                      "Eficiencia de la gestión.", "Rentabilidad y ganancias.", "Capacidad de pago a corto plazo.", "Sensibilidad al mercado."))
    left_join(descripciones, ratios_compania, by = "Dimension")
  })
  
  caramels_scores <- reactive({
    req(caramels_data_for_table())
    df <- caramels_data_for_table()
    score_up <- function(val, min, max) { pmin(pmax((val - min) / (max - min), 0, na.rm=T), 1, na.rm=T) }
    score_down <- function(val, min, max) { 1 - score_up(val, min, max) }
    df %>% mutate(Score = case_when(
      Dimension == "Capital" ~ score_up(Valor_Actual, 0.2, 0.5),
      Dimension == "Activos" ~ score_up(Valor_Actual, 0.1, 0.4),
      Dimension == "Reservas" ~ score_down(Valor_Actual, 0.8, 2.0),
      Dimension == "Manejo" ~ score_down(Valor_Actual, 0.2, 0.5),
      Dimension == "Eficiencia" ~ score_up(Valor_Actual, 0.05, 0.25),
      Dimension == "Liquidez" ~ score_up(Valor_Actual, 1.0, 2.5),
      Dimension == "Sensibilidad" ~ score_down(Valor_Actual, 0.4, 0.8),
      TRUE ~ 0.5) %>% replace_na(0.5))
  })
  
  output$vb_caramels_diagnostico <- renderUI({
    req(caramels_scores())
    avg_score <- mean(caramels_scores()$Score, na.rm = TRUE)
    diagnostico <- case_when(avg_score > 0.70 ~ "Solvencia Sólida", avg_score > 0.50 ~ "Solvencia Adecuada", TRUE ~ "Requiere Atención")
    theme <- case_when(avg_score > 0.70 ~ "success", avg_score > 0.50 ~ "warning", TRUE ~ "danger")
    icon_name <- case_when(avg_score > 0.70 ~ "check-circle", avg_score > 0.50 ~ "info-circle", TRUE ~ "exclamation-triangle")
    value_box(title = "Diagnóstico General", value = diagnostico, showcase = icon(icon_name), theme_color = theme)
  })
  
  output$table_caramels_summary <- renderDT({
    req(caramels_data_for_table())
    datatable(
      caramels_data_for_table() %>% select(Letra, Dimension, Descripcion, Valor_Actual),
      class = "display compact", rownames = FALSE, escape = FALSE,
      colnames = c("", "Dimensión", "Descripción", "Valor Actual"),
      options = list(
        dom = 't', ordering = FALSE,
        columnDefs = list(
          list(width = '5%', targets = 0), list(width = '35%', targets = 2),
          list(className = 'dt-center', targets = c(0, 3)),
          list(targets = 3, render = JS(
            "function(data, type, row) { if(data !== null && !isNaN(data)){return (data * 100).toFixed(1) + '%';} else {return 'N/A';} }"
          ))))
    )
  })
  
  output$dynamic_sidebar_text <- renderUI({
    req(input$main_nav)
    textos <- list(
      "Sobre La Mundial" = "Información corporativa, historia y descripción de los productos ofrecidos por La Mundial de Seguros.",
      "Cartera" = "Análisis de la composición y evolución de las primas. Indicadores clave: Primas Netas, Nº de Pólizas, Prima Promedio.",
      "Siniestros" = "Evaluación del comportamiento de los siniestros. Indicadores clave: Monto Pagado, Nº de Siniestros, Costo Promedio.",
      "Siniestralidad" = "Mide la eficiencia técnica relacionando siniestros con primas. Indicadores clave: Siniestralidad General, por Ramo y Canal.",
      "Visión General del Mercado" = "Contextualiza el desempeño de la compañía frente al sector asegurador total.",
      "Análisis Comparativo" = "Compara los indicadores de la compañía con los promedios del mercado.",
      "Análisis de Solvencia" = "Diagnóstico de la salud financiera basado en el modelo CARAMELS."
    )
    tags$div(
      h5("Guía de la Sección"),
      p(style = "font-size: 0.9em; color: #BDBDBD;", textos[[input$main_nav]])
    )
  })
  
  output$caramels_summary_text <- renderUI({
    req(caramels_scores())
    scores <- caramels_scores() %>% arrange(Score)
    avg_score <- mean(scores$Score, na.rm = TRUE)
    diagnostico <- case_when(
      avg_score > 0.70 ~ "sólida",
      avg_score > 0.50 ~ "adecuada",
      TRUE ~ "vulnerable, requiriendo atención"
    )
    fortaleza <- last(scores$Dimension)
    debilidad <- first(scores$Dimension)
    color_fuerte <- "#59A14F"; color_debil <- "#E15759"
    tags$p(style = "font-size: 1.1em;",
           "El diagnóstico general indica una posición de solvencia ", tags$strong(diagnostico), ".",
           " La principal ", tags$strong(style = paste0("color: ", color_fuerte, ";"), "fortaleza"), " se encuentra en la dimensión de ", tags$strong(fortaleza), ",",
           " mientras que el área de principal ", tags$strong(style = paste0("color: ", color_debil, ";"), "mejora u oportunidad"), " es la dimensión de ", tags$strong(debilidad), "."
    )
  })
  
}

## --- 5. Ejecutar la Aplicación Shiny ---
shinyApp(ui, server)