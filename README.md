# Super Voices

Instalación y configuración

* Versión de Ruby

* Dependencias

* Configuración

* Creación de la base de datos

      sudo systemctl start postgresql.service

      su - postgres

      createuser super-voices -d -s

      createdb -Osuper-voices -Eutf8 super-voices_development

      createdb -Osuper-voices -Eutf8 super-voices_test

      createdb -Osuper-voices -Eutf8 super-voices


* Inicialización de la base de datos

* Cómo correr las pruebas

* Servicios

* Instrucción de despliegue

## Proyecto
Universidad de los Andes. Curso ISIS4426: Desarrollo de soluciones cloud

