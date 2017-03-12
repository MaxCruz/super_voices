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

## Primer taller: Aplicaciones web escalables en un entorno tradicional

Objectivos
* Desarrollar una aplicación Web que involucre el uso de servidores Web y procesos en background.
* Identificar arquitecturas y patrones de referencia para aplicaciones Web escalables ejecutadas en un entorno tradicional (con servidores e infraestructura propia), que involucren el uso de servidores Web, servidores de bases de datos y procesos en background.

## Descripción de la aplicación a desarrollar

Una nueva compañía de cloud denominada SuperVoices (ver ejemplo real en https://es.voicebunny.com/) desea crear una aplicación de Software como Servicio (SaaS) que será ofrecida a empresas de todos los tamaños (pequeñas, medianas y grandes) para que esas empresas puedan realizar fácilmente concursos para encontrar las mejores voces para sus anuncios publicitarios (videos en YouTube, comerciales en TV y radio, etc.).

El modelo general de funcionamiento del SaaS se basa en que un administrador de una empresa entra al portal www.supervoices.com y crea una cuenta. Una vez la cuenta ha sido creada el administrador puede proceder a configurar los concursos de voces que esa empresa tiene disponibles en los cuáles participarán locutores profesionales. Por cada concurso publicado el sistema le genera una URL única (que puede ser cambiada por el administrador), la cual el administrador puede enviar a su listado de locutores profesionales a través de email para que estos puedan entrar y subir sus propuestas de voces para cada concurso. Las voces serán revisadas por el equipo de marketing de la empresa y la mejor voz será contratada por la empresa.

__Para esto la compañía de cloud debe desarrollar una aplicación Web que les permita a las
empresas interesadas en utilizar la plataforma:__

1. __(5%)__ Permitir que un administrador de la empresa (que es el público objetivo que se espera visite el sitio Web) que visite el home del sitio pueda ver la información básica del SaaS, conozca los valores agregados del servicio y pueda proceder a crear una cuenta en el sitio Web. Para crear una cuenta el administrador debe ingresar: sus nombres, sus apellidos, el email, la contraseña y la confirmación de la contraseña.
2. __(15%)__ Permitir que una vez iniciada sesión el administrador pueda proceder a configurar los concursos. De cada concurso el administrador debe configurar el nombre del concurso, el banner o imagen del concurso, la URL única a todo el sistema (a través de la cual van a poder acceder los usuarios finales), la fecha de inicio del concurso, la fecha de fin del concurso, el valor a pagar a la voz seleccionada, el guion/texto que deberá expresar la voz, y las recomendaciones que deben ser tenidas en cuenta por los locutores al preparar la voz. El administrador debe poder gestionar (realizar el CRUD – Create/Read/Update/Delete) los concursos.
3. __(10%)__ Permitir que vez inicie sesión el administrador de una empresa, éste pueda ver el detalle de un concurso, el cual debe incluir el listado de todas las voces que han sido subidas por los locutores profesionales. El listado de voces de cada concurso debe estar ordenado de forma descendente por fecha de creación y se debe utilizar paginación de a 50 voces. En el listado el administrador podrá ver para cada voz subida el email del usuario que lo subió, sus nombres y apellidos, la fecha en que se subió la voz, el estado de la voz (“En proceso” o “Convertida”), el archivo de la voz original (opción de descargar archivo), el archivo de la voz convertida (opción de descargar archivo), y puede reproducir la voz convertida (en caso de que el estado sea “Convertida”). Por cada concurso creado la compañía de cloud debe proveer una página Web que los usuarios/locutores de las empresas visitarán y podrán:
4. __(5%)__ Ver en la página principal de cada concurso (Home del Concurso) todas las voces subidas por los usuarios ordenadas de la voz más reciente a la más antigua. En caso de que hayan muchas voces se recomienda hacer paginación si hay más de 20 voces publicadas.
5. __(8%)__ Reproducir las voces cargadas por los usuarios en el home, para esto se recomienda usar la herramienta JW Player (http://www.longtailvideo.com/). Para escuchar una voz no es necesario que el usuario inicie sesión en el sitio Web.
6. __(12%)__ Desde el Home del Concurso, el usuario debe poder subir una voz, para ello el usuario debe ingresar: los nombres, los apellidos, el email, el archivo de audio con la voz y un mensaje con las observaciones que el usuario quiera realizar sobre la voz enviada. El usuario puede subir la voz (o varios realizando envíos individuales) en cualquier formato (ej. WAV, MP3, OGG, etc.). El usuario envía la voz y en ese momento la voz queda en estado “En proceso” y aún NO deberá aparecer la voz en el listado del Home del Concurso. La voz original quedará almacenada en un sistema de archivos. Con el fin de lograr que las voces las puedan escuchar los usuarios del sitio Web desde cualquier dispositivo, se hace necesario que toda voz subida por un usuario sea convertida a formato MP3. Para evitar que el usuario de demore esperando que las voces sean convertidas, el proceso de conversión se hará a través de tareas en background o batch. Una vez la voz haya sido convertida a este formato (utilizando la herramienta FFmpeg http://www.ffmpeg.org/) el estado de la voz cambiará su estado a “Convertida”. A partir de ese momento la voz deberá aparecer en el listado del Home del Concurso. Tan pronto el usuario presione la opción de “Enviar Voz” el sistema le muestra un mensaje del estilo "Hemos recibido tu voz y la estamos procesando para que sea publicada en la página del concurso y pueda ser posteriormente revisada por nuestro equipo de trabajo. Tan pronto la voz quede publicada en la página del concurso te notificaremos por email".
7. __(20%)__ El sistema deberá ejecutar un proceso periódicamente (cron a nivel de sistema operativo o de servidor de aplicaciones) que se encargue de consultar en la base de datos todos las voces que están en el estado "En proceso" y para cada voz en ese estado el sistema deberá: 
  * Convertir el archivo de audio de la voz al formato MP3 utilizando la herramienta FFmpeg http://www.ffmpeg.org/). 
  * Guardar el archivo de audio convertido (sin borrar el archivo original) en un sistema de archivos y cambiar el estado de la voz a “Generada”. 
  * Enviar al usuario final un email informándole que la voz ya ha sido publicada en la página pública del concurso.
  
Todas las anteriores funcionalidades deberán ofrecerse desde una sola aplicación web y un proceso en batch o cron que será desarrollada por la compañía de cloud. Dado que esta es la primera iteración del producto otras funcionalidades relacionadas con precios, facturación, evaluación de voces, publicación de ganadores, entre otros, no serán incluidas en esta fase de desarrollo.

## Adicionales

1. __(15%)__ Se deberá definir un escenario donde se pueda probar cuál es la máxima cantidad de voces que pueden ser procesadas por minuto en la aplicación local. Para hacer pruebas de carga se debe utilizar la herramienta JMeter que podrá instalar en un entorno local. Las pruebas de stress deberán realizarlas desde otros equipos diferentes a los utilizados para ejecutar el servidor web y el servidor de base de datos. El escenario y los resultados de las pruebas de estrés deberán ser documentados con gráficas que ilustren cómo se comporta el sistema a medida que el número de clientes convirtiendo voces se incrementa por minuto hasta llegar al punto de degradar completamente el rendimiento del sistema. El nombre de este documento deberá ser: "Proyecto 1 - Escenarios y Pruebas de Stress.docx".

2. __(10%)__ Se deberá entregar un documento donde se describa la arquitectura de la aplicación, las conclusiones identificadas con las pruebas de stress ejecutadas y las consideraciones que deben ser tenidas en cuenta para que la aplicación pueda escalar a cientos de administradores y usuarios finales de los concursos que van a estar utilizando el sitio www.supervoices.com de manera concurrente. En este documento se deben describir las limitaciones del desarrollo realizado y la infraestructura utilizada con respecto a la escalabilidad de la solución desarrollada. El nombre de este documento deberá ser: "Proyecto 1 - Arquitectura, conclusiones y consideraciones.docx".
