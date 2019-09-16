NSp <- function(meridiano, nombrer = 'src/precanual.tif', ymn = -90, ymx = 90,
                v = 'Precipitación anual (mm)'){
  require(raster)
  require(sp)
  require(scales)
  require(geosphere)
  r <- raster(nombrer)
  n <- nrow(r) + 1
  coordx <- rep(meridiano, n)
  coordy <- seq(ymn, ymx, length.out = n)
  sp <- SpatialPoints(coordinates(matrix(c(coordx, coordy), nrow = n)))
  df <- data.frame(extract(r, sp, sp = T))
  colnames(df) <- c(v, 'X', 'Paralelo')
  par(mfrow=c(1,2))
  plot(df[,c('Paralelo', v)], xlim = c(-100,100), cex = 0.5)
  r2 <- r
  r2pct <- quantile(r2, 0.02)
  r98pct <- quantile(r2, 0.98)
  r2[r2<=r2pct] <- NA
  r2[r2>=r98pct] <- NA
  plot(r2, col = rev(topo.colors(255)))
  plot(
    sp[floor(seq(1, length(sp), length.out = length(sp)/75))],
    col = alpha('black', 0.5), pch=16, add=T)
}
