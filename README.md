## Configuración inicial

### Prerrequisitos

- Ruby
- Sqlite

### Instalación

#### Backend (Ruby on Rails)

1.  Navega a la carpeta de la aplicación Rails:  
    `cd sismos-app`
    
2.  Instala las dependencias necesarias:  
    `bundle install`
    
3.  Crea y migra la base de datos:  
    `rails db:create db:migrate`
    
4.  Pobla la base de datos con los datos necesarios:  
    `rake fetch:features`
    
5.  Inicia el servidor de Rails:  
    `rails s`
## License

Este proyecto está bajo la licencia MIT.

## Note

Este proyecto es para uso de portafolio y no esta siendo mantenido activamente.
