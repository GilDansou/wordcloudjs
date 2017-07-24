#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'  @import shiny
#'
#' @export
wordcloudjs <- function(data_frame,words = NULL,size = NULL, color = NULL,link = NULL,
                        width = NULL, height = NULL, elementId = NULL,setspeed = FALSE,options = list(
                          textColour = NULL,
                          textFont =  'Niconne, sans-serif',
                          outlineMethod =  'colour',
                          outlineColour = '#039',
                          reverse = TRUE,
                          weight = TRUE,
                          depth = 0.8,
                          maxSpeed = 0.05
                        )) {

  data = data_frame

  if(is.null(words) || is.null(size) ){
    cat("You must provide words.column and siez column")
    return(NULL)
  }
  col = c(words,size)

  if(is.null(color)){
    data$color = ""
    col = c(col,"color")
  }else{
    col = c(col,color)
  }
  if(is.null(link)){
    data$link = ""
    col = c(col,"link")
  }else{
    col = c(col,link)
  }

  data = data[,col]

  data$words = as.character(data$words)

  # forward options using x
  convert = function(x){

    result = shiny::tags$li(
      shiny::tags$a(x[1],
                    style = paste("font-size:",as.numeric(x[2])*500,"%; color:",x[3],";",sep=""),
                    href=x[4]
      )
    )
    result = result

  }


  x = list(
    words = as.character(shiny::tags$ul( apply( data,1,convert ) )),
    options = options,
    setspeed = setspeed
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'wordcloudjs',
    x,
    width = width,
    height = height,
    package = 'wordcloudjs',
    sizingPolicy = htmlwidgets::sizingPolicy(
      browser.fill = TRUE
    ),
    elementId = elementId
  )
}

#' Shiny bindings for wordcloudjs
#'
#' Output and render functions for using wordcloudjs within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a wordcloudjs
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name wordcloudjs-shiny
#'
#' @export
wordcloudjsOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'wordcloudjs', width, height, package = 'wordcloudjs')
}

#' @rdname wordcloudjs-shiny
#' @export
renderWordcloudjs <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, wordcloudjsOutput, env, quoted = TRUE)
}
