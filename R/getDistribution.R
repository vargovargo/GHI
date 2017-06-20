getDistribution2 <- function(x){

    n <- ncol(x)

    foobar <- melt(x)
    names(foobar) <- c("age","k","value")
    D <- foobar  %>% arrange(age) %>% cbind(.,F = cumsum(rep(1,n)/(n+1)))

    foo <- c("00-04","05-14","15-29","30-44","45-59","60-69","70-79","80+")
    names(foo) <- paste0("ageClass",1:8)


    D <- within(D, age <- as.factor(foo[age]))

    return(D)
}



getDistribution <- function(ITHIM, type = "TotalMET"){

    foo <- ITHIM@quintiles[[type]]$M
    D <- data.frame(sex = "M", getDistribution2(foo))

    foo <- ITHIM@quintiles[[type]]$F
    D <- rbind(D, data.frame(sex = "F", getDistribution2(foo)))

    D <- within(D, age <-  as.factor(age))

    return(D)
}



compareDistributions <- function(ITHIM.baseline, ITHIM.scenario, type = "TotalMET"){

    D.baseline <- getDistribution(ITHIM.baseline, type = type)

    D.scenario <- getDistribution(ITHIM.scenario, type = type)

    D <- rbind(cbind(D.baseline, vision = "baseline"),cbind(D.scenario, vision = "scenario"))

    D <- within(D, {
        vision <-  as.factor(vision)
        age <-  factor(age, levels = c("00-04","05-14","15-29","30-44","45-59","60-69","70-79","80+"))
        sex <-  as.factor(sex)
    })

    p <- ggplot(D, aes(x = value, y = F, colour = vision))
    p <- p + geom_line(aes(colour = vision)) + facet_grid( sex ~ age) + xlab(type) + ylab("Cumulative Distribution")

    return(p)
}

example("ITHIM")
compareDistributions(ITHIM.baseline, ITHIM.scenario, type = "TotalMET")
