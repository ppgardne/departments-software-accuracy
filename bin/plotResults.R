#!/usr/bin/Rscript
#R CMD BATCH ../bin/plotResults.R

meanWins <-read.table("mean-wins-cis.tsv", header=T, sep="\t")
#library(Manu)
#kokako: c("#121f25", "#5e89ab", "#b9d5eb")
colours <- c("#DD3C51", "#313657", "#1F6683", "#6C90B9", "#D1C7B5")
col <- colours[1]
num <- length(meanWins[,1])

pdf(file=    "../docs/figures/forestPlot.pdf", width = 24,  height = 15)
par(mfrow = c(1,2), mar = c(4,1,1,9) + .1, cex=2.0, las = 1) #c(bottom, left, top, right). default: c(5, 4, 4, 2) + 0.1
plot( NA,NA, xlim=c(0,1.0), ylim=c(1,num), xlab="Proportion of wins", ylab="", main="", yaxt = "n" )
for(i in 1:num){
      if (meanWins[i,1]     =='expertiseArea'){
       	col <- colours[1]
      }
      else if (meanWins[i,1]=='fieldGeneral'){
       	col <- colours[2]
      }
      else if (meanWins[i,1]   =='fieldSpecific'){
      	col <- colours[3]
      }
      points( meanWins[i,3], num-i+1, pch=23, col=col, bg=col, cex=2 )      
      lines( c(meanWins[i,4], meanWins[i,5]), c(num-i+1, num-i+1), col=col, lwd = 2 )
      text(1.05, num-i+1, meanWins[i,6], pos=2)
}
axis(4, at=num:1, labels=meanWins$field, tick=T)
lines( c(0,1), c(12.5,12.5) )
lines( c(0,1), c(18.5,18.5) )
lines( c(0.5,0.5), c(0,num+1) )
text(0,num,   "Expertise",      pos=4, col=colours[1])
text(0,num-3, "General fields",  pos=4, col=colours[2])
text(0,num-9, "Specific fields", pos=4, col=colours[3])
z      <- -1*(0.5 - meanWins$meanWins)/meanWins$standardDeviation
p.vals     <- pnorm(abs(z), lower.tail = FALSE)
p.vals.adj <- p.adjust(p.vals, method = "fdr", n= length(p.vals))
meanWins <- cbind( cbind(meanWins, z), p.vals.adj)
write.csv(meanWins, file="fig2-data.tsv")
par(mar = c(4,1,1,9) + .1, cex=2.0, las = 1) #c(bottom, left, top, right). default: c(5, 4, 4, 2) + 0.1
plot( NA,NA, xlim=c(-1.3,2), ylim=c(1,num), xlab="(-1)*Z-score (null=0.5)", ylab="", main="", yaxt = "n" )
for(i in 1:num){
      if (meanWins[i,1]     =='expertiseArea'){
       	col <- colours[1]
      }
      else if (meanWins[i,1]=='fieldGeneral'){
       	col <- colours[2]
      }
      else if (meanWins[i,1]   =='fieldSpecific'){
      	col <- colours[3]
      }
      points( z[i], num-i+1, pch=23, col=col, bg=col, cex=2 )      
      #text(2.05, num-i+1, meanWins[i,6], pos=2)
}
axis(2, at=num:1, labels=character(num), tick=T)
lines( c(-1.3,2), c(12.5,12.5) )
lines( c(-1.3,2), c(18.5,18.5) )
lines( c(0.0,0.0), c(0,num+1) )
text(-1.3,num,   "Expertise",      pos=4, col=colours[1])
text(-1.3,num-3, "General fields",  pos=4, col=colours[2])
text(-1.3,num-9, "Specific fields", pos=4, col=colours[3])
dev.off()

library(UpSetR)
library(ComplexHeatmap)
generalFields  <-read.table("toolsVsGeneralField.tsv",  header=T, sep="\t")
gm <- make_comb_mat(generalFields, top_n_sets = 5)#, min_set_size = 10)
gm <- gm[comb_size(gm) >= 3]
pdf(file=    "../docs/figures/upsetPlotGeneralFiled.pdf", width = 10,  height = 3)
UpSet(gm,
	comb_order = order(-1*comb_size(gm)),
	top_annotation = upset_top_annotation(gm, add_numbers = TRUE),
    	right_annotation = upset_right_annotation(gm, add_numbers = TRUE),
	comb_col=colours[2]
      )
dev.off()
specificFields <-read.table("toolsVsSpecificField.tsv", header=T, sep="\t")
sm <- make_comb_mat(specificFields, top_n_sets = 15)#, min_set_size = 10)
sm <- sm[comb_size(sm) >= 10]
pdf(file=    "../docs/figures/upsetPlotSpecificFiled.pdf", width = 10,  height = 5)
UpSet(sm,
	comb_order = order(-1*comb_size(sm)),
	top_annotation = upset_top_annotation(sm, add_numbers = TRUE),
    	right_annotation = upset_right_annotation(sm, add_numbers = TRUE),
	comb_col=colours[3]
      )
dev.off()

