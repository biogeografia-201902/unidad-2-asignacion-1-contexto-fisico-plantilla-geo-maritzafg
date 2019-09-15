NSt <- function(meridiano, nombrer = 'src/mean.tif', ymn = -90, ymx = 90,
                v = 'Temperatura promedio anual (°C)'){
  require(raster)
  require(sp)
  require(scales)
  r <- raster(nombrer)
  n <- nrow(r) + 1
  coordx <- rep(meridiano, n)
  coordy <- seq(ymn, ymx, length.out = n)
  sp <- SpatialPoints(coordinates(matrix(c(coordx, coordy), nrow = n)))
  df <- data.frame(extract(r, sp, sp = T))
  colnames(df) <- c(v, 'X', 'Paralelo')
  par(mfrow=c(1,2))
  plot(df[,c('Paralelo', v)], xlim = c(-100,100))
  plot(r, col = rev(heat.colors(10)))
  plot(
    sp[floor(seq(1, length(sp), length.out = length(sp)/75))],
    col = alpha('black', 0.5), pch=16, add=T)
}
