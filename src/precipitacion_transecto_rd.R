RDp <- function(transectorandom,
                nombrer = 'src/precanual_espa.tif',
                nombret = 'src/transectos.gpkg',
                v = 'Precipitación anual (mm)'){
  require(raster)
  require(sp)
  require(sf)
  require(scales)
  require(ggplot2)
  r <- raster(nombrer)
  transectos <- st_read(nombret, quiet=T)
  transectosel <- as(transectos[transectorandom,,drop = T], 'Spatial')
  prec <- extract(r, transectosel, along = T)[[1]]
  disttotal <- distHaversine(
    coordinates(transectosel)[[1]][[1]][1,],
    coordinates(transectosel)[[1]][[1]][2,]
  )
  dist <- seq(0, disttotal, along.with = prec)/1000
  # obs <- 1:length(prec)
  df <- data.frame(x = dist, prec = prec)
  p <- ggplot(df, aes(x = x, y = prec, color = prec)) +
    geom_smooth(method = lm, formula = y ~ splines::bs(x, 15), se = F, size = 2) +
    annotate('text',label = 'Sur',
             hjust = 0, vjust = 0, x = min(dist), y = min(prec, na.rm = T)-100) +
    annotate('text',label = 'Norte',
             hjust = 1, vjust = 0, x = max(dist), y = min(prec, na.rm = T)-100) +
    ylab('Precipitación anual (en mm)') +
    xlab('Distancia (en km)')
  plot(r, col = rev(topo.colors(255)));plot(transectosel, lwd = 3, add = T)
  print(p)
}
