rver <- as.numeric(paste(version$major, gsub('\\.','', version$minor), sep = '.'))
if(rver>=3.6){
  RNGkind(sample.kind = "Rounding") #Utiliza redondeo (compatibilidad entre versiones de R)
}
estfuente <- paste0(
  'https://raw.githubusercontent.com/biogeografia-201902/',
  'miembros-y-colaboradores/master/suscripciones_github_actividad.txt'
)#Lista de estudiantes
estudiantes <- readLines(estfuente)
semilla <- sapply(
  estudiantes,
  function(x)
    gsub('\\D', '', substr(digest::digest(x, algo = 'md5'), 1, 10))
)
usrmer <- data.frame(
  meridiano = sapply(
    semilla,
    function(x) {set.seed(x);sample(-180:180, 1)}
  )
)
print(usrmer)