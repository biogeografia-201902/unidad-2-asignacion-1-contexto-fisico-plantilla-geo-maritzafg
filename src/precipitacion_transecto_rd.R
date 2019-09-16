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
  transectos <- st_read(nombret)
  transectosel <- as(transectos[transectorandom,,drop = T], 'Spatial')
  prec <- rev(extract(r, transectosel)[[1]])
  obs <- 1:length(prec)
  df <- data.frame(x = obs, prec = prec)
  p <- ggplot(df, aes(x = x, y = prec, color=prec)) +
    geom_smooth(method = lm, formula = y ~ splines::bs(x, 15), se = F, size = 2) +
    annotate('text',label = 'Sur',
             hjust = 0, vjust = 0, x = min(obs), y = min(prec, na.rm = T)-100) +
    annotate('text',label = 'Norte',
             hjust = 1, vjust = 0, x = max(obs), y = min(prec, na.rm = T)-100)
  plot(r, col = rev(topo.colors(255)));plot(transectosel, lwd = 3, add = T)
  print(p)
}
