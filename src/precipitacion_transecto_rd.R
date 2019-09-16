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
  rmin <- min(r[], na.rm = T)
  rmax <- max(r[], na.rm = T)
  df <- data.frame(x = dist, prec = prec)
  p <- ggplot(df, aes(x = x, y = prec, color = prec)) +
    # geom_smooth(aes(color=..y..), method = lm, formula = y ~ splines::bs(x, 15), se = F, size = 2) +
    geom_path() +
    geom_point() +
    ylim(rmin, rmax) +
    scale_color_gradientn(colors=rev(topo.colors(255)), limits = c(rmin, rmax)) +
    annotate('text',label = 'Sur',
             hjust = 0, vjust = 0, x = min(dist), y = rmin) +
    annotate('text',label = 'Norte',
             hjust = 1, vjust = 0, x = max(dist), y = rmin) +
    ylab('Precipitación anual (en mm)') +
    xlab('Distancia (en km)')
  plot(r, col = rev(topo.colors(255)));plot(transectosel, lwd = 3, add = T)
  print(p)
}
