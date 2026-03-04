#### TarificacionTelematica

# --- Estudio de Caso: Aplicación con el Dataset Canadiense `catelematic13` ---
# --- Versión Final y Definitiva - Corregido error de glmnet, Análisis Tradicional Completo ---

# 1. INSTALACIÓN Y CARGA DE PAQUETES
# ----------------------------------------------------
packages <- c("shiny", "shinydashboard", "dplyr", "ggplot2", "viridis",
              "broom", "scales", "knitr", "shinycssloaders", "tidyr", "forcats",
              "CASdatasets", "janitor", "glmnet", "corrplot", "xgboost", "iml", "randomForest", "party")

installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages], repos = "https://cran.rstudio.com/")
}

invisible(lapply(packages, library, character.only = TRUE))
theme_set(theme_bw(base_size = 14))


# --- 2. DEFINICIÓN DE LA INTERFAZ DE USUARIO (UI) ---
# -------------------------------------------------------
ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "Tarificación Telemática"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Introducción", tabName = "intro", icon = icon("info-circle")),
      menuItem("1. Análisis Tradicional", tabName = "analisis_tradicional", icon = icon("users")),
      menuItem("2. Ing. de Características", tabName = "feature_engineering", icon = icon("cogs")),
      menuItem("3. Análisis Telemático", tabName = "analisis_telematico", icon = icon("car-burst")),
      menuItem("4. Selección de Variables", tabName = "seleccion_variables", icon = icon("filter")),
      menuItem("5. Diagnóstico de Modelos", tabName = "diagnostico_tecnico", icon = icon("sitemap")),
      menuItem("6. Resultados de Negocio", tabName = "resultados_financieros", icon = icon("chart-line"))
    )
  ),
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
        .content-wrapper, .right-side { background-color: #2D3748 !important; color: #E2E8F0; }
        .box { background-color: #4A5568 !important; color: #E2E8F0 !important; border-top-color: #63B3ED !important; }
        .box-header .box-title { color: #E2E8F0 !important; }
        table.table { color: #E2E8F0 !important; }
        thead > tr > th { color: #A0AEC0 !important; }
        .shiny-output-error { color: #E2E8F0; }
        .shiny-output-error:before { color: #F56565; }
      "))
    ),
    tabItems(
      tabItem(tabName = "intro",
              fluidRow(
                box(width = 12, title = "Guía del Flujo de Trabajo de Modelado", solidHeader = TRUE, status = "primary",
                    p("Esta aplicación interactiva te guía a través de un pipeline de modelado actuarial completo, desde el análisis exploratorio hasta la evaluación del impacto de negocio. A continuación se detalla el contenido de cada pestaña:"),
                    hr(),
                    h4("1. Análisis Tradicional"),
                    p("Esta es la base de cualquier modelo de tarificación. Aquí exploramos cómo las variables demográficas clásicas (edad del conductor, antigüedad del vehículo, género, etc.) se relacionan con el riesgo. Para cada variable, analizamos su impacto en dos componentes clave:"),
                    tags$ul(
                      tags$li(strong("Frecuencia:"), "Qué tan a menudo ocurren los siniestros."),
                      tags$li(strong("Severidad:"), "Cuál es el costo promedio cuando ocurre un siniestro.")
                    ),
                    
                    h4("2. Ingeniería de Características"),
                    p("Las variables telemáticas puras (ej. aceleraciones a 6, 8, 9 mph/s) suelen estar altamente correlacionadas entre sí. En esta pestaña, aplicamos 'Ingeniería de Características' para agrupar estas variables granulares en conceptos de negocio más interpretables y robustos, como `total_eventos_frenado` o `intensidad_total_giro`. Los mapas de calor demuestran visualmente cómo este proceso reduce la multicolinealidad."),
                    
                    h4("3. Análisis Telemático"),
                    p("Una vez creadas nuestras 'super-variables', analizamos su poder predictivo individual. Esta pestaña explora la relación de cada característica ingenieril (ej. total de aceleraciones, porcentaje de conducción en hora pico) con la frecuencia y severidad de los siniestros."),
                    
                    h4("4. Selección de Variables"),
                    p("No todas las características que creamos serán igual de importantes. En esta sección, utilizamos dos potentes algoritmos de Machine Learning para que seleccionen automáticamente el subconjunto más relevante."),
                    tags$ul(
                      tags$li(strong("Elastic Net:"), "Un modelo de regresión que selecciona variables y maneja bien la correlación. Puedes elegir entre un criterio de selección más estricto (`lambda.1se`) o uno más inclusivo (`lambda.min`)."),
                      tags$li(strong("XGBoost:"), "Un modelo de boosting que clasifica las variables por importancia. Te permite seleccionar el 'Top N' de las variables más predictivas.")
                    ),
                    
                    h4("5. Diagnóstico de Modelos"),
                    p("Aquí se realiza una revisión técnica y estadística de los modelos de frecuencia GLM y RuleFit finales. Se comparan los coeficientes, reglas y métricas de rendimiento para los diferentes enfoques."),
                    
                    h4("6. Resultados de Negocio"),
                    p("Esta es la pestaña final y más importante, donde se cuantifica el valor de cada estrategia. Se divide en dos análisis clave:"),
                    tags$ul(
                      tags$li(strong("Poder Predictivo (Lift Chart):"), "Compara visualmente la capacidad de cada modelo para segmentar el riesgo. Un modelo superior identifica a los peores conductores mucho más eficientemente."),
                      tags$li(strong("Impacto Financiero:"), "Muestra tablas y gráficos comparando las primas, la siniestralidad por segmento de riesgo y el resultado financiero agregado para cada uno de los modelos, permitiendo tomar una decisión de negocio informada.")
                    )
                )
              )
      ),
      
      tabItem(tabName = "analisis_tradicional",
              fluidRow(
                box(width = 12, title="Paso 1: Análisis de Variables Demográficas", status="primary", solidHeader=TRUE,
                    p("Analizamos el impacto de las variables tradicionales tanto en la Frecuencia como en la Severidad."))),
              fluidRow(
                box(width = 6, title = "Impacto de la Edad del Conductor", status = "info", solidHeader = TRUE,
                    tabsetPanel(
                      tabPanel("Frecuencia", plotOutput("age_freq_plot", height="300px")),
                      tabPanel("Severidad", plotOutput("age_sev_plot", height="300px"))
                    )),
                box(width = 6, title = "Impacto de la Antigüedad del Vehículo", status = "info", solidHeader = TRUE,
                    tabsetPanel(
                      tabPanel("Frecuencia", plotOutput("car_age_freq_plot", height="300px")),
                      tabPanel("Severidad", plotOutput("car_age_sev_plot", height="300px"))
                    ))
              ),
              fluidRow(
                box(width = 4, title = "Impacto del Género", status = "info", solidHeader = TRUE,
                    tabsetPanel(
                      tabPanel("Frecuencia", plotOutput("sex_freq_plot", height="300px")),
                      tabPanel("Severidad", plotOutput("sex_sev_plot", height="300px"))
                    )),
                box(width = 4, title = "Impacto del Estado Civil", status = "info", solidHeader = TRUE,
                    tabsetPanel(
                      tabPanel("Frecuencia", plotOutput("marital_freq_plot", height="300px")),
                      tabPanel("Severidad", plotOutput("marital_sev_plot", height="300px"))
                    )),
                box(width = 4, title = "Impacto de la Región", status = "info", solidHeader = TRUE,
                    tabsetPanel(
                      tabPanel("Frecuencia", plotOutput("region_freq_plot", height="300px")),
                      tabPanel("Severidad", plotOutput("region_sev_plot", height="300px"))
                    ))
              )
      ),
      
      tabItem(tabName = "feature_engineering",
              fluidRow(
                box(width = 12, title = "Paso 2: Creación de Variables Agregadas (Feature Engineering)", status = "primary", solidHeader = TRUE,
                    p("Transformamos las variables telemáticas granulares en un conjunto más pequeño de características interpretables. Los mapas de calor permiten comparar la estructura de correlación antes y después de este proceso."),
                )
              ),
              fluidRow(
                box(width = 6, title = "Correlación de Variables Telemáticas Originales", status = "info", solidHeader = TRUE,
                    plotOutput("correlation_heatmap_original_plot", height = "550px") %>% withSpinner(color="#0dc5c1")),
                box(width = 6, title = "Correlación de Nuevas Características Ingenieriles", status = "success", solidHeader = TRUE,
                    plotOutput("correlation_heatmap_engineered_plot", height = "550px") %>% withSpinner(color="#0dc5c1"))
              )
      ),
      
      tabItem(tabName = "analisis_telematico",
              fluidRow(
                box(width = 12, title="Paso 3: Análisis Descriptivo de las Características Telemáticas", status="primary", solidHeader=TRUE,
                    p("Aquí se analiza la relación entre cada una de las nuevas 'super-variables' telemáticas y la frecuencia y severidad de los siniestros."))),
              uiOutput("dynamic_telematic_plots_ui")
      ),
      
      tabItem(tabName = "seleccion_variables",
              fluidRow(box(width=12, title="Paso 4: Selección de Características con Métodos Algorítmicos", status="primary", solidHeader=TRUE,
                           p("Aquí comparamos dos técnicas avanzadas para identificar las características telemáticas más importantes. Los parámetros de cada método se pueden ajustar para ver cómo impactan la selección."))),
              tabsetPanel(
                tabPanel("Elastic Net",
                         fluidRow(
                           box(width=12, title="Parámetros de Elastic Net", status="warning", solidHeader=FALSE, collapsible=TRUE, collapsed=TRUE,
                               radioButtons("lambda_choice", "Criterio de Selección de Lambda:", choices=c("Lambda 1-SE (más simple)"="lambda.1se", "Lambda Mínimo (más complejo)"="lambda.min"), selected="lambda.1se", inline=TRUE)),
                           box(width=7, title="Validación Cruzada de Elastic Net", status="info", solidHeader=TRUE,
                               plotOutput("elastic_net_cv_plot") %>% withSpinner(color="#0dc5c1")),
                           box(width=5, title="Variables Seleccionadas por Elastic Net", status="success", solidHeader=TRUE,
                               verbatimTextOutput("elastic_net_coeffs") %>% withSpinner(color="#0dc5c1"))
                         )
                ),
                tabPanel("XGBoost",
                         fluidRow(
                           box(width=12, title="Parámetros de XGBoost", status="warning", solidHeader=FALSE, collapsible=TRUE, collapsed=TRUE,
                               sliderInput("xgb_eta", "Tasa de Aprendizaje (eta):", min=0.01, max=0.3, value=0.1, step=0.01)),
                           box(width=7, title="Gráfico de Importancia de Variables (XGBoost)", status="info", solidHeader=TRUE,
                               plotOutput("xgb_importance_plot") %>% withSpinner(color="#0dc5c1")),
                           box(width=5, title="Top N Características Seleccionadas", status="success", solidHeader=TRUE,
                               sliderInput("num_xgb_vars", "Seleccionar el Top N de Variables:", min=1, max=7, value=5, step=1, width="100%"),
                               verbatimTextOutput("xgb_coeffs") %>% withSpinner(color="#0dc5c1"))
                         )
                )
              )
      ),
      
      tabItem(tabName = "diagnostico_tecnico",
              fluidRow(
                box(width=12, title="Paso 5: Diagnóstico Técnico de los Modelos", status="primary", solidHeader=TRUE,
                    p("En esta sección, se muestran los detalles estadísticos de los modelos de frecuencia que hemos construido para una revisión técnica."))),
              tabsetPanel(
                tabPanel("Modelos Fijos GLM",
                         fluidRow(
                           box(width=6, title="Modelo Simple (Demográfico)", status="info", solidHeader=TRUE, verbatimTextOutput("freq_model_simple_summary")),
                           box(width=6, title="Modelo Telemático (Todas las Características)", status="info", solidHeader=TRUE, verbatimTextOutput("freq_model_all_feat_summary"))
                         )
                ),
                tabPanel("Modelos con Selección Algorítmica GLM",
                         fluidRow(
                           box(width=6, title="Modelo Seleccionado por Elastic Net", status="warning", solidHeader=TRUE,
                               verbatimTextOutput("freq_model_enet_summary")),
                           box(width=6, title="Modelo Seleccionado por XGBoost", status="warning", solidHeader=TRUE,
                               verbatimTextOutput("freq_model_xgb_summary"))
                         )
                ),
                tabPanel("Modelos con Selección Algorítmica Árbol de Decisión",
                         fluidRow(
                           box(width=6, title="Modelo Seleccionado por Elastic Net Árbol de Decisión", status="warning", solidHeader=TRUE,
                               verbatimTextOutput("decision_tree_model_enet_summary")),
                           box(width=6, title="Modelo Seleccionado por XGBoost Árbol de Decisión", status="warning", solidHeader=TRUE,
                               verbatimTextOutput("decision_tree_model_xgb_summary"))
                         )
                )
              )
      ),
      
      tabItem(tabName = "resultados_financieros",
              fluidRow(
                box(width=12, title="Paso 6: Evaluación del Impacto de Negocio", status="primary", solidHeader=TRUE,
                    p("Esta es la etapa final, donde traducimos los resultados estadísticos en métricas de negocio."))),
              tabsetPanel(
                tabPanel("Poder Predictivo (Lift Chart)",
                         fluidRow(
                           box(width=12, title="Gráfico de Elevación (Lift Chart) Comparativo", status="warning", solidHeader=TRUE,
                               p("Un 'lift' más alto significa una mejor capacidad para identificar el riesgo."),
                               plotOutput("lift_chart_plot", height = "600px") %>% withSpinner(color="#0dc5c1"))
                         )
                ),
                tabPanel("Impacto Financiero",
                         fluidRow(
                           box(width=12, title="Análisis de Siniestralidad y Primas por Segmento", status="success", solidHeader=TRUE,
                               h4("¿Cómo se obtienen los Segmentos de Riesgo?"),
                               p("Los segmentos de riesgo se crean tomando una de las variables telemáticas más predictivas (en este caso, `total_brake_events`), ordenando a toda la cartera de asegurados de menor a mayor según el valor de esa variable, y luego dividiéndolos en 5 grupos de igual tamaño (quintiles). El 'Perfil 1-Bajo' representa el 20% de los conductores con menos frenados bruscos."),
                               hr(),
                               fluidRow(
                                 box(width=6, title="Siniestralidad por Segmento de Riesgo",
                                     plotOutput("loss_ratio_profile_plot", height="300px")),
                                 box(width=6, title="Prima Pura Promedio por Segmento de Riesgo",
                                     plotOutput("premium_by_segment_plot", height="300px"))
                               )
                           )
                         ),
                         fluidRow(
                           box(width=12, title="Resumen Financiero Agregado", status="warning", solidHeader=TRUE,
                               tableOutput("aggregate_summary_table"))
                         )
                )
              )
      )
    )
  )
)

# --- 4. LÓGICA DEL SERVIDOR ---
server <- function(input, output, session) {
  
  # --- Reactives Base ---
  base_data <- reactive({
    data("catelematic13", package = "CASdatasets")
    catelematic13 %>% janitor::clean_names() %>%
      filter(total_miles_driven > 0, car_age >= 0) %>%
      mutate(across(where(is.character), as.factor))
  })
  
  engineered_data <- reactive({
    req(base_data())
    base_data() %>%
      mutate(
        total_accel_events = rowSums(select(., starts_with("accel_")), na.rm = TRUE),
        total_brake_events = rowSums(select(., starts_with("brake_")), na.rm = TRUE),
        total_turn_intensity = rowSums(select(., starts_with("left_turn_"), starts_with("right_turn_")), na.rm = TRUE),
        pct_drive_rush_total = pct_drive_rush_am + pct_drive_rush_pm,
        risk_profile_group = cut(total_brake_events, breaks = unique(quantile(total_brake_events, probs = seq(0, 1, by = 0.2), na.rm=TRUE)), labels = c("1-Bajo", "2-MedBajo", "3-Medio", "4-MedAlto", "5-Alto"), include.lowest = TRUE),
        insured_sex_male = ifelse(insured_sex == "M", 1, 0),
        insured_sex_female = ifelse(insured_sex == "F", 1, 0),
        marital_yes = ifelse(marital == "Yes", 1, 0),
        marital_no = ifelse(marital == "No", 1, 0),
        region_urban = ifelse(region == "Urban", 1, 0),
        region_rural = ifelse(region == "Rural", 1, 0),
        region_suburban = ifelse(region == "Suburban", 1, 0)
      ) %>%
      select(
        nb_claim, amt_claim, total_miles_driven, risk_profile_group,
        insured_age, car_age, car_use, marital, region, insured_sex,
        total_accel_events, total_brake_events, total_turn_intensity,
        pct_drive_rush_total, pct_drive_wkday, avgdays_week, annual_pct_driven,
        insured_sex_male, insured_sex_female, marital_yes, marital_no, region_urban, region_rural, region_suburban
      )
  })
  
  # --- Reactives de Selección de Variables (parametrizables y robustos) ---
  elastic_net_results <- reactive({
    req(engineered_data(), input$lambda_choice)
    progress <- shiny::Progress$new(session); on.exit(progress$close()); progress$set(message = "Entrenando Elastic Net...", value = 0.5)
    df <- engineered_data(); engineered_features <- df %>% select(starts_with("total_"), starts_with("pct_drive_"), starts_with("avgdays"), starts_with("annual_pct"))
    
    cols_to_keep <- sapply(engineered_features, var, na.rm=TRUE) > 1e-10
    
    if(sum(cols_to_keep) == 0) return(NULL)
    engineered_features <- engineered_features[, cols_to_keep, drop = FALSE]
    
    x <- model.matrix(~ . - 1, data = engineered_features); y <- df$nb_claim; offset <- log(df$total_miles_driven)
    
    fit <- cv.glmnet(x, y, family = "poisson", offset = offset, alpha = 0.5, nfolds = 10)
    
    selected_lambda_value <- fit[[input$lambda_choice]]
    coefs <- coef(fit, s = selected_lambda_value)
    selected_vars <- names(coefs[which(coefs != 0), ])[-1]
    
    return(list(fit = fit, selected_vars = selected_vars))
  })
  
  xgboost_results <- reactive({
    req(engineered_data(), input$xgb_eta, input$xgb_max_depth)
    progress <- shiny::Progress$new(session); on.exit(progress$close()); progress$set(message = "Entrenando XGBoost...", value = 0.5)
    df <- engineered_data(); engineered_features <- df %>% select(starts_with("total_"), starts_with("pct_drive_"), starts_with("avgdays"), starts_with("annual_pct"))
    
    cols_to_keep <- sapply(engineered_features, var, na.rm=TRUE) > 1e-10
    if(sum(cols_to_keep) == 0) return(NULL)
    engineered_features <- engineered_features[, cols_to_keep, drop = FALSE]
    
    dtrain <- xgb.DMatrix(data = as.matrix(engineered_features), label = df$nb_claim); setinfo(dtrain, "base_margin", log(df$total_miles_driven))
    params <- list(booster = "gbtree", objective = "count:poisson", eval_metric = "poisson-nloglik", eta = input$xgb_eta, max_depth = input$xgb_max_depth)
    xgb_fit <- xgb.train(params = params, data = dtrain, nrounds = 100, verbose = 0)
    importance_table <- xgb.importance(model = xgb_fit)
    return(list(fit = xgb_fit, importance = importance_table))
  })
  
  # --- Reactive para obtener los nombres de las variables ingenieriles ---
  engineered_variables <- reactive({
    req(engineered_data())
    names(engineered_data() %>% select(-nb_claim, -amt_claim, -total_miles_driven, -risk_profile_group))
  })
  
  # --- Observe para actualizar el selectInput de las variables GAM ---
  observe({
    updateSelectInput(session, "gam_variables",
                      choices = engineered_variables(),
                      selected = c("insured_age", "car_age", "total_brake_events")
    )
  })
  
  # --- Reactives de Modelos RuleFit usando iml ---
  rulefit_model_enet <- reactive({
    req(engineered_data(), elastic_net_results())
    df <- engineered_data()
    enet_predictors <- elastic_net_results()$selected_vars
    if (length(enet_predictors) > 0) {
      rf_fit <- randomForest::randomForest(as.formula(paste("nb_claim ~", paste(enet_predictors, collapse = " + "))), data = df, ntree = 50)
      predictor <- iml::Predictor$new(rf_fit, df[, enet_predictors, drop = FALSE], y = df$nb_claim)
      return(predictor)
    } else {
      NULL
    }
  })
  
  rulefit_model_xgb <- reactive({
    req(engineered_data(), xgboost_results(), input$num_xgb_vars)
    df <- engineered_data()
    xgb_predictors <- head(xgboost_results()$importance$Feature, input$num_xgb_vars)
    if (length(xgb_predictors) > 0) {
      xgb_fit <- xgboost::xgboost(data = as.matrix(df[, xgb_predictors, drop = FALSE]), label = df$nb_claim, nrounds = 50, verbose = FALSE)
      predictor <- iml::Predictor$new(xgb_fit, df[, xgb_predictors, drop = FALSE], y = df$nb_claim)
      return(predictor)
    } else {
      NULL
    }
  })
  
  # --- Reactive de Modelos de Árbol de Decisión ---
  decision_tree_model_enet <- reactive({
    req(engineered_data(), elastic_net_results())
    df <- engineered_data()
    enet_predictors <- elastic_net_results()$selected_vars
    if (length(enet_predictors) > 0) {
      party::ctree(as.formula(paste("nb_claim ~ offset(log(total_miles_driven)) +", paste(enet_predictors, collapse = " + "))), data = df)
    } else {
      NULL
    }
  })
  
  decision_tree_model_xgb <- reactive({
    req(engineered_data(), xgboost_results(), input$num_xgb_vars)
    df <- engineered_data()
    xgb_predictors <- head(xgboost_results()$importance$Feature, input$num_xgb_vars)
    if (length(xgb_predictors) > 0) {
      party::ctree(as.formula(paste("nb_claim ~ offset(log(total_miles_driven)) +", paste(xgb_predictors, collapse = " + "))), data = df)
    } else {
      NULL
    }
  })
  
  
  # --- Reactive de Modelos Finales ---
  final_models_and_results <- reactive({
    req(engineered_data(), elastic_net_results(), xgboost_results(), input$num_xgb_vars, rulefit_model_enet(), rulefit_model_xgb(), decision_tree_model_enet(), decision_tree_model_xgb())
    progress <- shiny::Progress$new(session); on.exit(progress$close()); progress$set(message = "Entrenando GLMs y Evaluando...", value = 0)
    
    full_data <- engineered_data(); demographic_vars <- c("insured_age", "insured_sex", "car_age", "marital", "region")
    base_formula_part <- paste(demographic_vars, collapse = " + ")
    all_engineered_features <- names(full_data %>% select(starts_with("total_"), starts_with("pct_drive_"), starts_with("avgdays"), starts_with("annual_pct")))
    
    freq_simple <- glm(as.formula(paste("nb_claim ~", base_formula_part, "+ offset(log(total_miles_driven))")), data = full_data, family = poisson(link = "log"))
    freq_all_feat <- glm(as.formula(paste("nb_claim ~", base_formula_part, "+", paste(all_engineered_features, collapse=" + "), "+ offset(log(total_miles_driven))")), data = full_data, family = poisson(link = "log"))
    freq_elastic_net <- glm(as.formula(paste("nb_claim ~", paste(c(demographic_vars, elastic_net_results()$selected_vars), collapse=" + "), "+ offset(log(total_miles_driven))")), data = full_data, family = poisson(link = "log"))
    freq_xgb <- glm(as.formula(paste("nb_claim ~", paste(c(demographic_vars, head(xgboost_results()$importance$Feature, input$num_xgb_vars)), collapse=" + "), "+ offset(log(total_miles_driven))")), data = full_data, family = poisson(link = "log"))
    
    sev_data <- full_data %>% filter(amt_claim > 0)
    sev_model <- glm(amt_claim ~ car_age + marital + region + car_use, data = sev_data, family = Gamma(link = "log"))
    
    results_data <- full_data %>%
      mutate(
        pred_sev = predict(sev_model, newdata = ., type = "response"),
        pure_premium_simple = predict(freq_simple, newdata = ., type = "response") * pred_sev,
        pure_premium_all_feat = predict(freq_all_feat, newdata = ., type = "response") * pred_sev,
        pure_premium_enet = predict(freq_elastic_net, newdata = ., type = "response") * pred_sev,
        pure_premium_xgb = predict(freq_xgb, newdata = ., type = "response") * pred_sev,
        pure_premium_enet_rf = if (!is.null(rulefit_model_enet())) predict(rulefit_model_enet()$predictor, newdata = full_data) * pred_sev else NA,
        pure_premium_xgb_rf = if (!is.null(rulefit_model_xgb())) predict(rulefit_model_xgb()$predictor, newdata = full_data) * pred_sev else NA,
        pure_premium_enet_dt = if (!is.null(decision_tree_model_enet())) predict(decision_tree_model_enet(), newdata = full_data, type = "response") * pred_sev else NA,
        pure_premium_xgb_dt = if (!is.null(decision_tree_model_xgb())) predict(decision_tree_model_xgb(), newdata = full_data, type = "response") * pred_sev else NA
      )
    
    risk_profile_summary <- results_data %>% filter(!is.na(risk_profile_group)) %>% group_by(risk_profile_group) %>%
      summarise(
        Siniestralidad_Simple = sum(pure_premium_actual, na.rm=T) / sum(pure_premium_simple, na.rm=T),
        Siniestralidad_Ing_Feat = sum(pure_premium_actual, na.rm=T) / sum(pure_premium_all_feat, na.rm=T),
        Siniestralidad_Enet = sum(pure_premium_actual, na.rm=T) / sum(pure_premium_enet, na.rm=T),
        Siniestralidad_XGB = sum(pure_premium_actual, na.rm=T) / sum(pure_premium_xgb, na.rm=T),
        Prima_Simple = mean(pure_premium_simple, na.rm=T),
        Prima_Ing_Feat = mean(pure_premium_all_feat, na.rm=T),
        Prima_Enet = mean(pure_premium_enet, na.rm=T),
        Prima_XGB = mean(pure_premium_xgb, na.rm=T),
        Siniestralidad_Enet_RF = if (!is.null(rulefit_model_enet())) sum(pure_premium_actual, na.rm=T) / sum(pure_premium_enet_rf, na.rm=T) else NA,
        Siniestralidad_XGB_RF = if (!is.null(rulefit_model_xgb())) sum(pure_premium_actual, na.rm=T) / sum(pure_premium_xgb_rf, na.rm=T) else NA,
        Siniestralidad_Enet_DT = if (!is.null(decision_tree_model_enet())) sum(pure_premium_actual, na.rm=T) / sum(pure_premium_enet_dt, na.rm=T) else NA,
        Siniestralidad_XGB_DT = if (!is.null(decision_tree_model_xgb())) sum(pure_premium_actual, na.rm=T) / sum(pure_premium_xgb_dt, na.rm=T) else NA,
        Prima_Enet_DT = if (!is.null(decision_tree_model_enet())) mean(pure_premium_enet_dt, na.rm=T) else NA,
        Prima_XGB_DT = if (!is.null(decision_tree_model_xgb())) mean(pure_premium_xgb_dt, na.rm=T) else NA,
        .groups = 'drop'
      )
    
    return(list(results_data=results_data, freq_simple=freq_simple, freq_all_feat=freq_all_feat, freq_elastic_net=freq_elastic_net, freq_xgb=freq_xgb, risk_profile_summary=risk_profile_summary,
                rulefit_enet = rulefit_model_enet(), rulefit_xgb = rulefit_model_xgb(), decision_tree_enet = decision_tree_model_enet(), decision_tree_xgb = decision_tree_model_xgb()))
  })
  
  # --- Salidas ---
  create_freq_analysis_plot <- function(data, var, color) { data %>% mutate(group = cut(!!sym(var), breaks = 10, include.lowest=TRUE)) %>% group_by(group) %>% summarise(mean_freq = sum(nb_claim) / n(), .groups="drop") %>% ggplot(aes(x = group, y = mean_freq, group = 1)) + geom_line(linewidth=1.2, color = color) + geom_point(size=3, color = color) + labs(x = NULL, y = "Frecuencia Media de Siniestros") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) }
  create_sev_boxplot <- function(data, var) { data %>% filter(amt_claim > 0) %>% ggplot(aes(x = !!sym(var), y = amt_claim, fill=!!sym(var))) + geom_boxplot(alpha=0.7) + scale_y_log10(labels=dollar) + theme(legend.position="none") + labs(x=NULL, y="Costo del Siniestro (Log)") }
  
  output$age_freq_plot <- renderPlot({ req(base_data()); create_freq_analysis_plot(base_data(), "insured_age", "#48BB78") })
  output$age_sev_plot <- renderPlot({ req(base_data()); create_sev_boxplot(base_data() %>% mutate(insured_age = cut(insured_age, breaks=10)), "insured_age") })
  output$car_age_freq_plot <- renderPlot({ req(base_data()); create_freq_analysis_plot(base_data(), "car_age", "#F6AD55") })
  output$car_age_sev_plot <- renderPlot({ req(base_data()); create_sev_boxplot(base_data() %>% mutate(car_age = cut(car_age, breaks=10)), "car_age") })
  output$sex_freq_plot <- renderPlot({ req(base_data()); base_data() %>% group_by(insured_sex) %>% summarise(mean_freq = sum(nb_claim) / n()) %>% ggplot(aes(x=insured_sex, y=mean_freq, fill=insured_sex)) + geom_col() + theme(legend.position="none") + labs(x=NULL, y="Frecuencia Media") })
  output$sex_sev_plot <- renderPlot({ req(base_data()); create_sev_boxplot(base_data(), "insured_sex") })
  output$marital_freq_plot <- renderPlot({ req(base_data()); base_data() %>% group_by(marital) %>% summarise(mean_freq = sum(nb_claim) / n()) %>% ggplot(aes(x=marital, y=mean_freq, fill=marital)) + geom_col() + theme(legend.position="none") + labs(x=NULL, y="Frecuencia Media") })
  output$marital_sev_plot <- renderPlot({ req(base_data()); create_sev_boxplot(base_data(), "marital") })
  output$region_freq_plot <- renderPlot({ req(base_data()); base_data() %>% group_by(region) %>% summarise(mean_freq = sum(nb_claim) / n()) %>% ggplot(aes(x=region, y=mean_freq, fill=region)) + geom_col() + theme(legend.position="none") + labs(x=NULL, y="Frecuencia Media") })
  output$region_sev_plot <- renderPlot({ req(base_data()); create_sev_boxplot(base_data(), "region") })
  output$correlation_heatmap_original_plot <- renderPlot({ req(base_data()); telematic_originals <- base_data() %>% select(starts_with("accel_"), starts_with("brake_"), starts_with("pct_drive")); corr_matrix <- cor(telematic_originals, use = "pairwise.complete.obs"); colors <- colorRampPalette(c("#4299E1", "white", "#F56565"))(200); corrplot(corr_matrix, method = "color", type = "upper", order = "hclust", col = colors, tl.col = "lightgray", tl.srt = 45, tl.cex = 0.8) }, bg = "transparent")
  output$correlation_heatmap_engineered_plot <- renderPlot({ req(engineered_data()); engineered_features <- engineered_data() %>% select(starts_with("total_"), starts_with("pct_drive_"), starts_with("avgdays"), starts_with("annual_pct")); corr_matrix <- cor(engineered_features, use = "pairwise.complete.obs"); colors <- colorRampPalette(c("#48BB78", "white", "#F6AD55"))(200); corrplot(corr_matrix, method = "color", type = "upper", order = "hclust", col = colors, tl.col = "lightgray", tl.srt = 45, tl.cex = 0.9, addCoef.col = "black", number.cex = 0.7) }, bg = "transparent")
  output$dynamic_telematic_plots_ui <- renderUI({ req(engineered_data()); vars <- names(engineered_data() %>% select(starts_with("total_"), starts_with("pct_drive_"), starts_with("avgdays"), starts_with("annual_pct"))); plot_boxes <- lapply(vars, function(var) { box(width = 6, title = paste("Análisis de:", var), status = "info", solidHeader = TRUE, tabsetPanel(tabPanel("Frecuencia", plotOutput(paste0("freq_plot_", var))), tabPanel("Severidad", plotOutput(paste0("sev_plot_", var))))) }); do.call(tagList, plot_boxes) })
  observe({ req(engineered_data()); engineered_features_names <- names(engineered_data() %>% select(starts_with("total_"), starts_with("pct_drive_"), starts_with("avgdays"), starts_with("annual_pct"))); for (var in engineered_features_names) { local({ my_var <- var; output[[paste0("freq_plot_", my_var)]] <- renderPlot({ create_freq_analysis_plot(engineered_data(), my_var, "#ED64A6") }); output[[paste0("sev_plot_", my_var)]] <- renderPlot({ create_sev_boxplot(engineered_data() %>% mutate(!!my_var := cut(!!sym(my_var), breaks=10)), my_var) }) }) } })
  output$elastic_net_cv_plot <- renderPlot({ req(elastic_net_results()); plot(elastic_net_results()$fit) })
  output$elastic_net_coeffs <- renderPrint({ req(elastic_net_results()); elastic_net_results()$selected_vars })
  output$xgb_importance_plot <- renderPlot({ req(xgboost_results()); xgb.plot.importance(xgboost_results()$importance, main = "Importancia de Características (XGBoost)") })
  output$xgb_coeffs <- renderPrint({ req(xgboost_results(), input$num_xgb_vars); head(xgboost_results()$importance$Feature, input$num_xgb_vars) })
  output$freq_model_simple_summary <- renderPrint({ req(final_models_and_results()); summary(final_models_and_results()$freq_simple) })
  output$freq_model_all_feat_summary <- renderPrint({ req(final_models_and_results()); summary(final_models_and_results()$freq_all_feat) })
  output$freq_model_enet_summary <- renderPrint({ req(final_models_and_results()); summary(final_models_and_results()$freq_elastic_net) })
  output$freq_model_xgb_summary <- renderPrint({ req(final_models_and_results()); summary(final_models_and_results()$freq_xgb) })
  output$rulefit_model_enet_summary <- renderPrint({ req(final_models_and_results()); summary(final_models_and_results()$rulefit_enet) })
  output$rulefit_model_xgb_summary <- renderPrint({ req(final_models_and_results()); summary(final_models_and_results()$rulefit_xgb) })
  output$decision_tree_model_enet_summary <- renderPrint({ req(final_models_and_results()); print(final_models_and_results()$decision_tree_enet) })
  output$decision_tree_model_xgb_summary <- renderPrint({ req(final_models_and_results()); print(final_models_and_results()$decision_tree_xgb) })
  output$lift_chart_plot <- renderPlot({
    req(final_models_and_results()); res_data <- final_models_and_results()$results_data
    calculate_lift_data <- function(data, premium_col) { data %>% select(premium = !!sym(premium_col), actual = pure_premium_actual) %>% arrange(desc(premium)) %>% mutate(decile = ntile(premium, 10), cumulative_claims = cumsum(actual), percent_claims = cumulative_claims / sum(actual), percent_population = seq(n()) / n()) %>% group_by(decile) %>% summarise(max_perc_claims = max(percent_claims), max_perc_pop = max(percent_population), .groups="drop") }
    lift_simple <- calculate_lift_data(res_data, "pure_premium_simple"); lift_all_feat <- calculate_lift_data(res_data, "pure_premium_all_feat"); lift_enet <- calculate_lift_data(res_data, "pure_premium_enet"); lift_xgb <- calculate_lift_data(res_data, "pure_premium_xgb")
    lift_enet_rf <- calculate_lift_data(res_data %>% filter(!is.na(pure_premium_enet_rf)), "pure_premium_enet_rf")
    lift_xgb_rf <- calculate_lift_data(res_data %>% filter(!is.na(pure_premium_xgb_rf)), "pure_premium_xgb_rf")
    lift_enet_dt <- calculate_lift_data(res_data %>% filter(!is.na(pure_premium_enet_dt)), "pure_premium_enet_dt")
    lift_xgb_dt <- calculate_lift_data(res_data %>% filter(!is.na(pure_premium_xgb_dt)), "pure_premium_xgb_dt")
    ggplot() +
      geom_line(data = lift_simple, aes(x = max_perc_pop, y = max_perc_claims, color = "1. Simple GLM"), linetype = "dotted", linewidth = 1.1) +
      geom_line(data = lift_all_feat, aes(x = max_perc_pop, y = max_perc_claims, color = "2. Ing. de Caract. GLM"), linewidth = 1.1) +
      geom_line(data = lift_enet, aes(x = max_perc_pop, y = max_perc_claims, color = "3. Elastic Net GLM"), linetype = "dashed", linewidth = 1.2) +
      geom_line(data = lift_xgb, aes(x = max_perc_pop, y = max_perc_claims, color = "4. XGBoost GLM"), linewidth = 1.2) +
      geom_line(data = lift_enet_rf, aes(x = max_perc_pop, y = max_perc_claims, color = "5. Elastic Net RF"), linewidth = 1.2, color = "darkgreen") +
      geom_line(data = lift_xgb_rf, aes(x = max_perc_pop, y = max_perc_claims, color = "6. XGBoost RF"), linewidth = 1.2, color = "darkred") +
      geom_line(data = lift_enet_dt, aes(x = max_perc_pop, y = max_perc_claims, color = "7. Elastic Net DT"), linewidth = 1.2, color = "purple") +
      geom_line(data = lift_xgb_dt, aes(x = max_perc_pop, y = max_perc_claims, color = "8. XGBoost DT"), linewidth = 1.2, color = "orange") +
      geom_segment(aes(x = 0, y = 0, xend = 1, yend = 1), color = "white", linetype = "dotted") +
      scale_color_manual(values = c("1. Simple GLM" = "#F56565", "2. Ing. de Caract. GLM" = "#48BB78", "3. Elastic Net GLM" = "#F6AD55", "4. XGBoost GLM" = "#63B3ED", "5. Elastic Net RF" = "darkgreen", "6. XGBoost RF" = "darkred", "7. Elastic Net DT" = "purple", "8. XGBoost DT" = "orange")) +
      scale_x_continuous(labels = percent_format()) + scale_y_continuous(labels = percent_format()) +
      labs(x = "% Acumulado de Cartera (Ordenada por Riesgo)", y = "% Acumulado de Siniestros Capturados", color = "Estrategia de Modelado") +
      theme(legend.position = "bottom", legend.text = element_text(size = 9))
  })
  
  output$loss_ratio_profile_plot <- renderPlot({
    req(final_models_and_results())
    final_models_and_results()$risk_profile_summary %>%
      select(risk_profile_group, starts_with("Siniestralidad")) %>%
      pivot_longer(cols = -risk_profile_group, names_to = "modelo", values_to = "siniestralidad") %>%
      mutate(modelo = gsub("Siniestralidad_", "", modelo)) %>%
      ggplot(aes(x = risk_profile_group, y = siniestralidad, fill = modelo)) +
      geom_col(position = "dodge") + scale_y_continuous(labels = percent_format()) +
      labs(x = "Perfil de Riesgo (Basado en Frenados)", y = "Siniestralidad (Loss Ratio)", fill="Modelo")
  }, bg="transparent")
  
  output$premium_by_segment_plot <- renderPlot({
    req(final_models_and_results())
    final_models_and_results()$risk_profile_summary %>%
      select(risk_profile_group, starts_with("Prima_")) %>%
      pivot_longer(cols = -risk_profile_group, names_to = "modelo", values_to = "primas") %>%
      mutate(modelo = gsub("Prima_", "", modelo)) %>%
      ggplot(aes(x=risk_profile_group, y=primas, fill=modelo)) +
      geom_col(position="dodge") + scale_y_continuous(labels = dollar_format()) +
      labs(x="Perfil de Riesgo (Basado en Frenados)", y="Prima Pura Promedio", fill="Modelo")
  }, bg="transparent")
  
  output$aggregate_summary_table <- renderTable({
    req(final_models_and_results())
    final_models_and_results()$risk_profile_summary %>%
      select(risk_profile_group, starts_with("Siniestralidad"), starts_with("Prima_")) %>%
      pivot_longer(cols = -risk_profile_group, names_to = "modelo_metric", values_to = "value") %>%
      separate(modelo_metric, into = c("metric", "modelo"), sep = "_") %>%
      pivot_wider(names_from = "metric", values_from = "value") %>%
      transmute(Modelo = modelo, `Siniestralidad Agregada` = percent(mean(Siniestralidad, na.rm=T), 0.1), `Prima Pura Promedio` = dollar(mean(Prima, na.rm=T)))
  })
  
  # --- Reactive para obtener los nombres de las variables ingenieriles ---
  engineered_variables <- reactive({
    req(engineered_data())
    names(engineered_data() %>% select(-nb_claim, -amt_claim, -total_miles_driven, -risk_profile_group))
  })
  
  # --- Observe para actualizar el selectInput de las variables GAM ---
  observe({
    updateSelectInput(session, "gam_variables",
                      choices = engineered_variables(),
                      selected = c("insured_age", "car_age", "total_brake_events")
    )
  })
}


# --- 5. EJECUTAR LA APLICACIÓN ---
shinyApp(ui, server)