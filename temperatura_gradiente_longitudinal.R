NSt <- function(meridiano, nombrer = 'mean.tif', ymn = -90, ymx = 90, v = 'Temperatura promedio (°C)'){
  require(raster)
  require(sp)
  r <- raster(nombrer)
  n <- nrow(r) + 1
  coordx <- rep(meridiano, n)
  coordy <- seq(ymn, ymx, length.out = n)
  sp <- SpatialPoints(coordinates(matrix(c(coordx, coordy), nrow = n)))
  df <- data.frame(extract(r, sp, sp = T))
  colnames(df) <- c(v, 'X', 'Paralelo')
  plot(df[,c('Paralelo', v)], xlim = c(-100,100))
}
