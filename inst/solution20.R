library(adventofcode2021)
input <- read_pixels(input_file(20))
output2 <- enhance_image(input$image, input$algorithm, n = 2)
sum(output2)
output50 <- enhance_image(input$image, input$algorithm, n = 50)
sum(output50)
