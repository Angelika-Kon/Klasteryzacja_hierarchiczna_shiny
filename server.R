#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
getData<-function(name){
    data<-read.csv(paste0("https://stooq.pl/q/d/l/?s=",name,"&d1=20201201&d2=20210108&i=d"))
}
shinyServer(function(input,output){
    output$name1=renderText({input$variable})
    d<-reactive({getData(input$variable)})
    
    output$print1=renderPrint({
        summary(d()[,5])
    })
    
    output$Plot1<-renderPlot({
       newdata<-as.Date(d()[,1],"%Y-%m-%d")
       plot(newdata,d()[,5],type="l",col="red",xlab="Data",ylab="Kurs zamkniecia")
    
   output$Plot2<-renderPlot({
       df<-d()[,5]
       df <- na.omit(df)
       df <- scale(df)
       head(df)
       
       cluster<-seq(1,24,length.out=input$klastry+1)
       # Dissimilarity matrix
       d <- dist(df, method = "euclidean")
       
       # Hierarchical clustering using Complete Linkage
       hc1 <- hclust(d, method = "complete" )
       
       # Plot the obtained dendrogram
       plot(hc1, cex = 0.6, hang = -1)
       
       hc5 <- hclust(d, method = "ward.D2" )
       
       # Cut tree into 4 groups
       sub_grp <- cutree(hc5, k =cluster)
       # Number of members in each cluster
       table(sub_grp)
       
       plot(hc5, cex = 0.6)
       rect.hclust(hc5, k = cluster, border = 2:5)
        
    })
    })
})
    

