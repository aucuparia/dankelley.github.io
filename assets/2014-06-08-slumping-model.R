
## ------------------------------------------------------------------------
m <- 51                                # number of particles
n <- 10                                # grid width
debug <- FALSE                         # put TRUE for debugging
info <- function(...) if (debug) cat(...)
pch <- 20
cex <- 4 / log2(n)
type <- 't'
set.seed(1)
rollDownhill <- function(X, Z)
{
    info("rollDownhill(", X, ",", Z, ")\n", sep="")
    if (Z == 1)
        return(list(x=X, z=Z))
    ## Particles roll down-slope until they hit the bottom...
    ## ... or a ledge comprising two particles.
    XX <- X
    ZZ <- Z
    while (0 == S[XX+1, ZZ-1]) { # move down and to right
        info("  XX:", XX, " ZZ:", ZZ, "\n")
        XX <- XX + 1
        ZZ <- which(0 == S[XX,])[1]
        if (ZZ == 1)
            break
        if (XX == n)
            break
    }
    return(list(x=XX, z=ZZ))
}

S <- matrix(0, nrow=n, ncol=n)         # "S" means "space"
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(1:n, 1:n, type='n', xlab="", ylab="")
xDrop <- 1 # location of drop; everything goes here or to right
for (i in 1:m) {                       # "p" means partcle
    while (0 == length(zDrop <- which(0 == S[xDrop,])[1])) {
        info("in while line 72\n")
        xDrop <- xDrop + 1
        if (xDrop == n) {
            message("RHS")
            break
        }
    }
    info("particle:", i, " ")
    p <- rollDownhill(xDrop, zDrop)
    S[p$x, p$z] <- 1
    if (type == 'p') {
        points(p$x, p$z, col='gray', pch=pch, cex=cex) 
    } else {
        text(p$x, p$z, i, col='gray') 
    }
}

